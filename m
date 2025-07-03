Return-Path: <linux-pci+bounces-31370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FA8AF7040
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614CE1BC18CE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7682E49A4;
	Thu,  3 Jul 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNdALS29"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C52E2EEC;
	Thu,  3 Jul 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538418; cv=none; b=NJu8nRlYv/RYfBp5yONKWs4Br7/g3QAebcyOfSi/JyUfyyCiA4M8x3ZzaCFC0nIE9oDVEu9kjM7Xftu+qLG3h23Kaf6UxpA3yRHW8H/2adpX20NL5SAONyWnJSDlhPJNWD3mkKLEFyRkFKw0JW3sKdSpHEic0qHIq3II2t24rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538418; c=relaxed/simple;
	bh=x0UjezfsoOH38t7iWo4VW4qdmeF50w/ZyH4r588go9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GR1ACSn49mZ6vFN5onvbV2xkaItxaCImWL4B9F4YACYWnjKtuubflO1QNjAWqIQpRMuuau2Of3H2QxCu71UdxIY6WumMOhcb/MYBANwyJOwK3NYHc/12B3nM/6bGfkpUYSmibwKkNOcApRd+i2xl8/Uk7AuahGsZweFKqIUGVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNdALS29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DFBC4CEE3;
	Thu,  3 Jul 2025 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538418;
	bh=x0UjezfsoOH38t7iWo4VW4qdmeF50w/ZyH4r588go9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNdALS296jUJIu7ceSIkUHb/w594jhgeYc7AbnXCo+C+DQvNoNATs/YyFkcl3KC7b
	 BHR2qNYFWsrOR5tN28sL3TiLE/TXyYkUwL9DmJFiW47xLNd8rtXI9kRpz7XfxPHqK4
	 YyrxsL854AevKx+mUZs9v4ajI/rvf/dwHL5+wvoAbscLceuCkDWhbV7jAbIHDblfZn
	 C7qjFUhbWYGFf6my6/Tws3YpUc/catrk/lMdnhBMwlpYV/s11mjGZD6tZwD1vV4Zjb
	 X2VZ3RJ/TqKANflRZ3g11964g32jwdjG3IOo3YrzedG4mwYO0g41+7YtrTTggXtGoi
	 B5tKUngUIXC8g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:09 +0200
Subject: [PATCH v7 19/31] arm64: Add support for GICv5 GSB barriers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

The GICv5 architecture introduces two barriers instructions
(GSB SYS, GSB ACK) that are used to manage interrupt effects.

Rework macro used to emit the SB barrier instruction and implement
the GSB barriers on top of it.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/barrier.h |  3 +++
 arch/arm64/include/asm/sysreg.h  | 10 +++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d5c939..f5801b0ba9e9 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -44,6 +44,9 @@
 						 SB_BARRIER_INSN"nop\n",	\
 						 ARM64_HAS_SB))
 
+#define gsb_ack()	asm volatile(GSB_ACK_BARRIER_INSN : : : "memory")
+#define gsb_sys()	asm volatile(GSB_SYS_BARRIER_INSN : : : "memory")
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #define pmr_sync()						\
 	do {							\
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f1bb0d10c39a..9b5fc6389715 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -113,10 +113,14 @@
 /* Register-based PAN access, for save/restore purposes */
 #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
 
-#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
-	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
+#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
+	__emit_inst(0xd5000000					|	\
+		    sys_insn((op0), (op1), (CRn), (CRm), (op2))	|	\
+		    ((Rt) & 0x1f))
 
-#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
+#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
+#define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
+#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
 
 /* Data cache zero operations */
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)

-- 
2.48.0



Return-Path: <linux-pci+bounces-30720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62AAE9B50
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140D917CEBC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E125E453;
	Thu, 26 Jun 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilr4hTpM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBF25D917;
	Thu, 26 Jun 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933650; cv=none; b=m/Zy1ee+Xid65FXH9wxSOqOXcnHCsEmrt606vAyypTGIAt23adRuR04dWlf23ZNVlkHRug9f+JFxL1g1clQuEY0CqkJVbsIdzqWniQrjyeBVi6CU/8tJyDo2uB5+gXBbQ9F2/GfDBGn3lvtqEyjjRTW8sIo5tiJZqvtJlxFnVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933650; c=relaxed/simple;
	bh=OL8WrbmEb7QcfFjSfT9OR3hHDhu+Kp5/wSJK9kcz1CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pt+0KQ1Nv6jfacSXwfGERVSmIape0fHuk/lC+AclUap9ADalEQMFimt8VBVwsO5bfdE0VM5GOkFnmtxAszqm0i3sYMT1HwRbQnN6GTHJNXuFWkmsk3o5N+0Fc4fZEkZ8Bjm0gkGNYhyeBzCi1kcvAe5AJRL6v8N9RfHrk25r/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilr4hTpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83740C4CEEB;
	Thu, 26 Jun 2025 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933650;
	bh=OL8WrbmEb7QcfFjSfT9OR3hHDhu+Kp5/wSJK9kcz1CE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ilr4hTpM7KK5DD9bZ7Zp8D2DRkCUg1xPqBCraBeazX83M1dTgBFZhc4SgHFs5RTmS
	 ARbpTBMDTLPwaMm5tHpA2JAmlXKXNnDdcizXFjumVZN057+VAgHigNfUD8YNgUrXJf
	 6lfNMfULv1FlrTwx3lCgkaSTWmpUxYXvaKQv9MnW0jvZrPsXvn7CX22SqNF5hITaSZ
	 qBZUiT9AZuHqSd2oghN+oDKnDD8a/bexeMpRrYTG0b8dnA5tstqgtndfzx6uGoD6J7
	 4bruTgLqE6dgEdyOvqiLj6zVGiZ7NOF9Uqkfg0wcYwFmDDV3IQD4SFUjVpDltqVMAw
	 9znopjhPl3kIg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:03 +0200
Subject: [PATCH v6 12/31] arm64/sysreg: Add ICH_HFGRTR_EL2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-12-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
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

Add ICH_HFGRTR_EL2 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8be5e4af4ad6..0202b3bd3dda 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4434,6 +4434,24 @@ Field	31:16	PhyPARTID29
 Field	15:0	PhyPARTID28
 EndSysreg
 
+Sysreg	ICH_HFGRTR_EL2	3	4	12	9	4
+Res0	63:21
+Field	20	ICC_PPI_ACTIVERn_EL1
+Field	19	ICC_PPI_PRIORITYRn_EL1
+Field	18	ICC_PPI_PENDRn_EL1
+Field	17	ICC_PPI_ENABLERn_EL1
+Field	16	ICC_PPI_HMRn_EL1
+Res0	15:8
+Field	7	ICC_IAFFIDR_EL1
+Field	6	ICC_ICSR_EL1
+Field	5	ICC_PCR_EL1
+Field	4	ICC_HPPIR_EL1
+Field	3	ICC_HAPR_EL1
+Field	2	ICC_CR0_EL1
+Field	1	ICC_IDRn_EL1
+Field	0	ICC_APR_EL1
+EndSysreg
+
 Sysreg	ICH_HCR_EL2	3	4	12	11	0
 Res0	63:32
 Field	31:27	EOIcount

-- 
2.48.0



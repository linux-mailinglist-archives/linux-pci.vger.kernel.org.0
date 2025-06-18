Return-Path: <linux-pci+bounces-30029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7867ADE86E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D00C3A81DC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D60286402;
	Wed, 18 Jun 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzrZnktf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F12857C2;
	Wed, 18 Jun 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241889; cv=none; b=ra3KFSmBljvdYGjNsrrAAIOgiSBZ+MGSwoA0SuddMi+sFf3CVKT9t3fIlqh9nR31KqNio2/TSQZ+pHnL/VOn3ARD4TTSDuZrsqDDVJKr/V9GWmoQiiF7bYLT+zpcVXxxLHn2+tjLOV9rhTy7BeMHb8LLrxXHaCUfnJH0a+WWzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241889; c=relaxed/simple;
	bh=tRKFfC9HrDSF598h4BQsZtNeEtZI1IT9Ixq8S352lh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWdz+Xg7RmuZvR3L+ePnDEO2EAOIK4XlUaheZM29W7fiMJ0GBXfX40yho2t/VM2LhXu5xyPfzW1N86Fy1BWfA+b2H6Z9v/RddP9dceXL29veBnhwoGsw+2afkyzpepiOe8vLtwTORmX8GXOgSYiPkmpBcBlRRVAk9VhEtbiSP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzrZnktf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0DC4CEED;
	Wed, 18 Jun 2025 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241888;
	bh=tRKFfC9HrDSF598h4BQsZtNeEtZI1IT9Ixq8S352lh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dzrZnktf82Vas8Sck74Z+Fv4p+R+qtg1xG1JVro8ZsiU+WvvLlhm24frmQir60WTD
	 /bQ45VbvRievzxevlW/SQGayhR5qKxah1OEL31gW+vRVYNA/QNMkHTIO9DWp2R2PLz
	 Va6sA9iTUgGTOYK0+uvGLEeUyaJJ/qqe4hOf7l68xcNEZ0V5+gviA6i0l6AUrWUKfv
	 hI2ijFHGlCsCRMSj4BgOxILbdirfw/NEim290YTDAEVhC4f6ygzdVRAEbb2LVV/FCw
	 UoGNtN+s5X0B8OJAbRi7aeJTuVr40b5e93R76KTbtnHJQLz1qga7QiGY8kH7CTxC8i
	 DIRFPMnK7h6mA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:19 +0200
Subject: [PATCH v5 04/27] arm64/sysreg: Add ICC_ICSR_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-4-d9e622ac5539@kernel.org>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
In-Reply-To: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
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

Add ICC_ICSR_EL1 register sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fc17e19a738d..81b32f567ce3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3024,6 +3024,20 @@ Sysreg	PMIAR_EL1	3	0	9	14	7
 Field	63:0	ADDRESS
 EndSysreg
 
+Sysreg	ICC_ICSR_EL1	3	0	12	10	4
+Res0	63:48
+Field	47:32	IAFFID
+Res0	31:16
+Field	15:11	Priority
+Res0	10:6
+Field	5	HM
+Field	4	Active
+Field	3	IRM
+Field	2	Pending
+Field	1	Enabled
+Field	0	F
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7

-- 
2.48.0



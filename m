Return-Path: <linux-pci+bounces-31361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36657AF701B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E937ADF97
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B82E3AEE;
	Thu,  3 Jul 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXW/2FpV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C82E2EF2;
	Thu,  3 Jul 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538368; cv=none; b=mhM9Wt1reK06X5gk+ffreMOQE6CQq6N3b4F3q/D0blauIiV1F8X/s3FlVm2jtlGGtJJ19L5B4t4lc6RuFTO2a5yMKyGAQ2RVdTi/TSkyDy+aB0+lCW5FWSWuo7bi6jysFzoxoL09QzEbSAdEYo0thcDyAdmkSvcv5Bqei1Q2unI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538368; c=relaxed/simple;
	bh=CIcuhWndkg/N6GP+iqDrY1EvwebsVCnM40vCoSLVIvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bu5gSf1fG+cC8hoCbdcLH+XiWhllLxx8s+7MIAL38N95NQCuFoqA+gLjx8ovE7yZ7/ZZTct7hottpndseAgKFycOdInTGiHNpN0krDfKeiZSw0HrtIhkJuPDWxm5nIQK3bfbgVHXmUMUcB+N7r0/7sc2Y3NT36J315ibzZJhMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXW/2FpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECAAC4CEEB;
	Thu,  3 Jul 2025 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538368;
	bh=CIcuhWndkg/N6GP+iqDrY1EvwebsVCnM40vCoSLVIvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXW/2FpVlzK1JWbOg2223uqHGL9joO0Qus9O8hSnu2GRmcbn7E/L13Qy9ly1MYKYh
	 h/+9LZ0TXzcRWqyAp36U8Vg4E8QYNUIArqHqH/dtJ3kksmDjRenpl93TTaXTLieOZy
	 gcGlZrVaypUOEDV3bGHZzrLYtl9lsXSHZNT5q3i96mJC1/IGHVkAGosPFaVQvSySXg
	 UjFqTTUBAavH8EgpHZbZvXfy2JwfMOr/QvQisn7XkNEw71sYbFPo9kX0Z82hYeXADU
	 Jvs75tYfbiUTn+EmjjVxmpql3Vxlr/6sCnHowqvzBQDyUtYNlEo51SoWgv2q1a+8AS
	 cSpd2tz0MNNqw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:00 +0200
Subject: [PATCH v7 10/31] arm64/sysreg: Add ICC_PCR_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-10-12e71f1b3528@kernel.org>
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

Add ICC_PCR_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ebbb22ed2301..5e15d69093d1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3527,6 +3527,11 @@ Res0	31:1
 Field	0	EN
 EndSysreg
 
+Sysreg	ICC_PCR_EL1	3	1	12	0	2
+Res0	63:5
+Field	4:0	PRIORITY
+EndSysreg
+
 Sysreg	CSSELR_EL1	3	2	0	0	0
 Res0	63:5
 Field	4	TnD

-- 
2.48.0



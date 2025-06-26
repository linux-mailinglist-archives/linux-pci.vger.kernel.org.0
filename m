Return-Path: <linux-pci+bounces-30716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A0AE9B4A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5424D3B36E5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919726C3A4;
	Thu, 26 Jun 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKL7a498"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A025BF18;
	Thu, 26 Jun 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933635; cv=none; b=Uzfjr4v9SYKnY1rB3+HyesaBm+Yo5M/urcY3O5PI+W9t1eAkDJcO2Y+vq+mwhMPIj+DC0MvVh7Ccv9rd0b6+9sGS+kAnzitGo+n3I9CEpC/4JKfvCbguqBBWiM4n9sppvhCqA4mvVRfPE6uo/O5/NOzoXe+y8KbzCL4u+84R2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933635; c=relaxed/simple;
	bh=KhZBfnWupA8OF0aLJ5DChzI1zouMF1hlhKWMb+wixeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNQAtC4tT6is9Ld0ADScHiW0DgkiNWjZA6vyoA4CJCs0VoMgXu5wKruzNOATLSEERIkbmU/8gzhHu8/NTrU/RJ6IFduJRH4hVSHOpnmS322/cprMHnjVz+0nJs6Hb4NcoeofR4XsyUMyGx6fCUd27JOVCh/QsIK6mwnzPqsnlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKL7a498; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85A2C4CEEE;
	Thu, 26 Jun 2025 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933634;
	bh=KhZBfnWupA8OF0aLJ5DChzI1zouMF1hlhKWMb+wixeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DKL7a4988MBlLaou56ecXzN7Qnn5Rj41UZ+FFTdgMKZ0tRrDl+0xgRmCsRMddANEB
	 yBrIlKruFji4NzXkdFMCKWzZghyNOzR1U1JIJeBC7tTK7ujuQMvtfz8S3OSmrrBijs
	 licLYEglhJjQHfNppepCXUtfFEUDtb1qu9yO+YD66xmhYFv213aDwKQd2OgF3MnW82
	 vryWtrN9RODRraspyTyBkqu9W5U/JGFLeY3KJ+l10PWkJePhXY3gqIRLsd458uXjF/
	 UiJIhsog2pIkO3b4iowwvoqLTvvnUActlZNidkihMoX32/cOLY6XrDCpFIcxAbC3Ub
	 EyVypwUxyh+dQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:00 +0200
Subject: [PATCH v6 09/31] arm64/sysreg: Add ICC_CR0_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-9-48e046af4642@kernel.org>
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

Add ICC_CR0_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 78a51fbf3a99..ebbb22ed2301 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3519,6 +3519,14 @@ Res0	14:12
 Field	11:0	AFFINITY
 EndSysreg
 
+Sysreg	ICC_CR0_EL1	3	1	12	0	1
+Res0	63:39
+Field	38	PID
+Field	37:32	IPPT
+Res0	31:1
+Field	0	EN
+EndSysreg
+
 Sysreg	CSSELR_EL1	3	2	0	0	0
 Res0	63:5
 Field	4	TnD

-- 
2.48.0



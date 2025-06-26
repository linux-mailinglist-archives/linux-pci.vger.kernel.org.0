Return-Path: <linux-pci+bounces-30721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FCCAE9B62
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368DF7B6C63
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519C25D917;
	Thu, 26 Jun 2025 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKO1/asp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FB258CEF;
	Thu, 26 Jun 2025 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933655; cv=none; b=JNNJ8ld5BfuMMi0hHl2zYoxid9T3Yx8EtFIcr/QRZfCVn5YBlnscn75MviCc+z6tUphTlXrIVmuEqbMFUiFjP6FVvINi+8h8v6OI8lGP40+IzMN1o6qJT0hUc4wbmxkhHxd2YrEBbD70AW/RMsraPgS5abuezvkmVyBNx22n800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933655; c=relaxed/simple;
	bh=aIIn1sGnO2kMTD4PFFAtmvRuvCXnzwAbVE21VpeYyKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ogdb0WTi3/Qx/Z3wkInX6ROw4DqQTDKwfericFB3cmOU8LSK8wzEX/M86623lJ3YZ4BWwjllARpGcTLqkSSHDDN8h2CJKhQv26S1NzoyXoSomY6S7tyIp5ju4EWTkvYFg0OXejONOhxf9YbQWyaLhrd15ss892/xUk0l9a4NS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKO1/asp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB19C4CEF4;
	Thu, 26 Jun 2025 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933655;
	bh=aIIn1sGnO2kMTD4PFFAtmvRuvCXnzwAbVE21VpeYyKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dKO1/asppzbfxael3+LDzSdwVo9Tv0XJ4OaJ/X0DyG7PSTd4LHCwINEOKvGLXBBwO
	 XZldwadOs2id0hZ4fOn9sAjWchsoM0g5+mRRyaZnjZ0ZmuTazbiQobVXHsGJNO8qmP
	 quhnMfYeVEBiJh7oQ6XwG/jR6lXOZVt1J9fnrsAD/sNIFmaRt/lUfm/xgPWEAJ4mpj
	 J59VORElMiExeqIJZOwoxnG9s9Wt7gLyngs/+J/bHKQIQNqdFP4z/xOPi09AWO4rZK
	 Oyq7zlUvJUcAuE7Vfkm9De25jhpjfIPr+Fwj/0UdUoE8yp4EbJs8aMmXFpe26/vzuN
	 Xp6IpTX2QdX9Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:04 +0200
Subject: [PATCH v6 13/31] arm64/sysreg: Add ICH_HFGWTR_EL2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-13-48e046af4642@kernel.org>
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

Add ICH_HFGWTR_EL2 register description to sysreg.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0202b3bd3dda..9def240582dc 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4452,6 +4452,21 @@ Field	1	ICC_IDRn_EL1
 Field	0	ICC_APR_EL1
 EndSysreg
 
+Sysreg	ICH_HFGWTR_EL2	3	4	12	9	6
+Res0	63:21
+Field	20	ICC_PPI_ACTIVERn_EL1
+Field	19	ICC_PPI_PRIORITYRn_EL1
+Field	18	ICC_PPI_PENDRn_EL1
+Field	17	ICC_PPI_ENABLERn_EL1
+Res0	16:7
+Field	6	ICC_ICSR_EL1
+Field	5	ICC_PCR_EL1
+Res0    4:3
+Field	2	ICC_CR0_EL1
+Res0	1
+Field	0	ICC_APR_EL1
+EndSysreg
+
 Sysreg	ICH_HCR_EL2	3	4	12	11	0
 Res0	63:32
 Field	31:27	EOIcount

-- 
2.48.0



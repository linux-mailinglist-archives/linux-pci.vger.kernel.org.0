Return-Path: <linux-pci+bounces-30717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49863AE9B4E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB803BCFAA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4D25C809;
	Thu, 26 Jun 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAOzJllV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9D2580CA;
	Thu, 26 Jun 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933640; cv=none; b=egltPejL+cCX2gOJDV/AuLqJwqb7Z7YMidHoXbMKtj210LUt/XpnOPtDXbLjW72p0m+BmGKTVCa0yDsDyKNqwVmzpv5+0bQ6Tb3WjUJ1YK2dUWvlH6qpCSRf2QM2qS2BN9HrRsgjMVodro6+1V9Nvnre7CJJjdFl/cCf5Hno+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933640; c=relaxed/simple;
	bh=GGu0BlNfPd3BbcRNatWFSy8vlHfdSkuub7faaglQhI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9mkYM4nxKrKbjTCbRmrNvGmuFFyYHUyjuD4oTvzxffwR+v8KnTgdaTsxRYrbx9ckmCkaMcyX7fPX+tsyQxETzFhfNlfIBwsV1bwQki/mRs0gvdRFSs2sINE3/cGpeVK6TE8KrH3ZA2LtZyd/QALQGSETMF78nzSGQlS4n10S/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAOzJllV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C79C4CEEB;
	Thu, 26 Jun 2025 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933639;
	bh=GGu0BlNfPd3BbcRNatWFSy8vlHfdSkuub7faaglQhI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HAOzJllViCYWot+JHa3B0k0EHoJXl9Z+gzgwCMcC3s2jUjuNk+4aAr1W/t4ip1piw
	 lyzvUY2N8SKbGwURb92uyQX9r7TD9NVO7w6mG7lUCJfSbap7yCx7tSYlqxWBdM7gQw
	 aC1i5P7UJhN6Jh4+y0BPBp3CB3UNPWuIurfb0kT+0Fs3ognzQhKvlqRO1imv6dpFJw
	 HccfWH9de83UllAE6xu/rIHSFNlSwGG8cHlu83xbemVHl18Sibesio0J8d/neiDy6h
	 UspheVl98rbG/WS4eEMF+/LBth56e6oibgNrI+fjGKd0ehjDZOfxSjigeSPib5zeFV
	 /MR8bOt2xb1tQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:01 +0200
Subject: [PATCH v6 10/31] arm64/sysreg: Add ICC_PCR_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-10-48e046af4642@kernel.org>
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

Add ICC_PCR_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



Return-Path: <linux-pci+bounces-30719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32FAE9B4F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC804168CC0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8926E704;
	Thu, 26 Jun 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCXbIvNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC26E6FC;
	Thu, 26 Jun 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933645; cv=none; b=OddEci24CUQzbmihp0ZsolHSjR/nhUZjSE6YaeCeCupN112QraPJEC+H1V1Nm2D2U+XHhAyIfIWjeur9NJhyTUrjYfynET7roQG0GQNfcsA3WEWTe555R1MMEEJaSTO5KA5eX+X7rgDjxGp4PKLPtiiiz+s8rQXoBqcwfQXdIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933645; c=relaxed/simple;
	bh=m6O/5j1WF6mk3EuO6bOH/5Xan9g3qo+JPPYQ48OrVbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMgRX7Ug1VQ57e8LE/2NTe67Waxxe71PGRn85R5FUgRT8W9XGB6ZUXK+r1ktterhCAgZSKC2fyMQsQwyV2QJVWOvl5fIZyHLq8JhD5hsTr4fRph0i7T3aKYz7dl4uxL6+zgUIglfbbaIoDtQ9s8OX2/Ml5Y7nC988BbURxnlxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCXbIvNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529A8C4CEEF;
	Thu, 26 Jun 2025 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933645;
	bh=m6O/5j1WF6mk3EuO6bOH/5Xan9g3qo+JPPYQ48OrVbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TCXbIvNuk83qfc/D8JE//UvHhsB059hhqueiEOEYJGZwheDLZkH2n6ZmoaWzgXKoF
	 iOoEnAaCqxiMT/19pLBTtNIFaHB4rgnBQ/znYkglDrvEDppf9O7ozXuiEbEmurZ3jr
	 j5WUMbMT2X0Is/ytjAC+BffSuEOnjHyWWVHc51hxI0B15EMecDKQNPRQp4SwEZyaol
	 I0XPVAqncTyyQR68umm7sQxuRbbszyy6KrLouTROwOxBkRMvgCYd9KHtIxYjwuf/lT
	 qujmI+tjKSbDKaasXxZu1ik0Z8+04JF0it/U6W5wgsmHms+UUj+Xq7u4ex4Eh4tGJ/
	 F2fpKjnbZ14Og==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:02 +0200
Subject: [PATCH v6 11/31] arm64/sysreg: Add ICC_IDR0_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-11-48e046af4642@kernel.org>
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

Add ICC_IDR0_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 5e15d69093d1..8be5e4af4ad6 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3099,6 +3099,22 @@ Sysreg	ICC_PPI_HMR1_EL1	3	0	12	10	1
 Fields ICC_PPI_HMRx_EL1
 EndSysreg
 
+Sysreg	ICC_IDR0_EL1	3	0	12	10	2
+Res0	63:12
+UnsignedEnum	11:8	GCIE_LEGACY
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	PRI_BITS
+	0b0011	4BITS
+	0b0100	5BITS
+EndEnum
+UnsignedEnum	3:0	ID_BITS
+	0b0000	16BITS
+	0b0001	24BITS
+EndEnum
+EndSysreg
+
 Sysreg	ICC_ICSR_EL1	3	0	12	10	4
 Res0	63:48
 Field	47:32	IAFFID

-- 
2.48.0



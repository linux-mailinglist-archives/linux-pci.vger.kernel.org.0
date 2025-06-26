Return-Path: <linux-pci+bounces-30709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140EAE9B34
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677973BB673
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605825E464;
	Thu, 26 Jun 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8ftJwhn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A7258CDF;
	Thu, 26 Jun 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933603; cv=none; b=a6gEqYThDYgpUyMLO06HagUysdgO3qjjRDG/HEZwF61KskP7b3j/i0Ml61fIUpA3BSyX64xekIIc1dXmSy7dwZIH2rUQl8FS8gVt/Gf9XdBe9YnwIBHENA0la/aIIPL3kEOTzgTCU0YgiWFmD4bDfv9e0WMGgvMTcZmyKDdsQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933603; c=relaxed/simple;
	bh=kVpdI0MdT6gB3194VWmiyspHGjH3wCjsgs0CRoyEIRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq7E8cRpMi7FIzQGs3xG7Q2mFpMSI1ObFo1NZVhY7QzfK5zm5BjrLm4qJPHAJeb4eum1Tar2o7P8zhj4rtpmT16jED1qUBOc0+KQESi7dzLyFwY7+slsGxP8FNWMRkIP6z/i1sUYKZ5/j8NTPDFcSLYm2A4aVqZDz+3qhRwkSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8ftJwhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30419C4CEEB;
	Thu, 26 Jun 2025 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933602;
	bh=kVpdI0MdT6gB3194VWmiyspHGjH3wCjsgs0CRoyEIRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W8ftJwhnnNYfsf6aStnAdhfy7eC0/MBeoLc08wVhuTzHZUgtVeSB2PHQ9sIcjV51b
	 gi84pP1ODvUijJ5JYDKq1AlobguLwvwhDJGUP8ONq4So9OrFZ04MXEjuApkIxqkBJZ
	 0+sjmxBZX/nEXbI09iaOspupsZbS+Xy3T4qvBQLt5RRjbDCPbw/ISj8XhexK3n9Zwc
	 VsfUNpGBrRVSx6l3ZHFSN0ksG8fS0rwF07IBAhqy0g+IicKLWmfFKd7CfIJHau5xRz
	 FdayBx4BN9Su0RVgk5ZRcsS0rL1eWH1C6X8ZYBYDIRqSEVKCKsThudeSSHsJOnw+Og
	 RFPPVTQbDe77w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:25:54 +0200
Subject: [PATCH v6 03/31] arm64/sysreg: Add ICC_PPI_PRIORITY<n>_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-3-48e046af4642@kernel.org>
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

Add ICC_PPI_PRIORITY<n>_EL1 sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fb5bddc700b3..fc17e19a738d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3024,6 +3024,89 @@ Sysreg	PMIAR_EL1	3	0	9	14	7
 Field	63:0	ADDRESS
 EndSysreg
 
+SysregFields	ICC_PPI_PRIORITYRx_EL1
+Res0	63:61
+Field	60:56	Priority7
+Res0	55:53
+Field	52:48	Priority6
+Res0	47:45
+Field	44:40	Priority5
+Res0	39:37
+Field	36:32	Priority4
+Res0	31:29
+Field	28:24	Priority3
+Res0	23:21
+Field	20:16	Priority2
+Res0	15:13
+Field	12:8	Priority1
+Res0	7:5
+Field	4:0	Priority0
+EndSysregFields
+
+Sysreg	ICC_PPI_PRIORITYR0_EL1	3	0	12	14	0
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR1_EL1	3	0	12	14	1
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR2_EL1	3	0	12	14	2
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR3_EL1	3	0	12	14	3
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR4_EL1	3	0	12	14	4
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR5_EL1	3	0	12	14	5
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR6_EL1	3	0	12	14	6
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR7_EL1	3	0	12	14	7
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR8_EL1	3	0	12	15	0
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR9_EL1	3	0	12	15	1
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR10_EL1	3	0	12	15	2
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR11_EL1	3	0	12	15	3
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR12_EL1	3	0	12	15	4
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR13_EL1	3	0	12	15	5
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR14_EL1	3	0	12	15	6
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_PRIORITYR15_EL1	3	0	12	15	7
+Fields	ICC_PPI_PRIORITYRx_EL1
+EndSysreg
+
 Sysreg	PMSELR_EL0	3	3	9	12	5
 Res0	63:5
 Field	4:0	SEL

-- 
2.48.0



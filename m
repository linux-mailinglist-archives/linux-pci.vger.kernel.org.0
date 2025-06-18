Return-Path: <linux-pci+bounces-30030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE48ADE85D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36383168987
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266782882CB;
	Wed, 18 Jun 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQtFw+ac"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B732857C2;
	Wed, 18 Jun 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241894; cv=none; b=BMQiNHxioijQfhbS0ZNr6loSudJw6sjgF+gHby8GhqHLYwIJ/WoRaufF+WGhopVCyCN7ArGAOCbu7DMBFIK3h1kX+0Xrwpk4WUqwuAQ0NUfztg/qDGhPWXkwwmPjmkgdRPFB8PdxXclhOHXumCQWyInjD9QnosOmKe9GhOJ1rRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241894; c=relaxed/simple;
	bh=pW1PLcEl0QW4zGuR7px6M73NyMt8QabRVrQoCUspAx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjZegWRrOMSVZGfjoB1JGqFYObfs6yuKJe0oOEPcr0sKnqtdY6ljXjXG595Yp3DApH/BKt1IGD2fBg2QrqqoVWtexpN25ndm37u4+RZIXzeb+D85Xb9pSXTMB6ptlJ/DNSWqPAX98IDwgQSTUNstO6xLFt8fFWKPGE8L6nE+VnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQtFw+ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8011C4CEE7;
	Wed, 18 Jun 2025 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241893;
	bh=pW1PLcEl0QW4zGuR7px6M73NyMt8QabRVrQoCUspAx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eQtFw+acJbZE0iYAjPwBFkTMxV2IW0hMvf7Ds3MInJVg6VRtcDL/5wfCFQEWSLCPw
	 8kIYYJGDbIDNnhMkehadmD2IDKFu38/AqkX20KVptvCEc8knZ1jzGp1HqeZHja4zmc
	 YELlqcopJGymjeHEVichkCjdSRi0sCuZRwg0tZ1t5EYiuJVy5N6aeG8iKmaqF75wZ2
	 muEMxhT1E/LWLT+f/3pMK8HBE7VGGLV2vB3SVvNqlPbrmOAgQtupc4mYMrnV6VqS5G
	 IS5UTAHBasD7wn6ul2eXDug9SV8XgtHUGpjcnjoNT6WkkdesUOEKVKhgAATlhUO9FE
	 zF2eab5rpq1Jw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:20 +0200
Subject: [PATCH v5 05/27] arm64/sysreg: Add ICC_PPI_HMR<n>_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-5-d9e622ac5539@kernel.org>
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

Add ICC_PPI_HMR<n>_EL1 registers sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 81b32f567ce3..7f096efee4e7 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3024,6 +3024,81 @@ Sysreg	PMIAR_EL1	3	0	9	14	7
 Field	63:0	ADDRESS
 EndSysreg
 
+SysregFields	ICC_PPI_HMRx_EL1
+Field	63	HM63
+Field	62	HM62
+Field	61	HM61
+Field	60	HM60
+Field	59	HM59
+Field	58	HM58
+Field	57	HM57
+Field	56	HM56
+Field	55	HM55
+Field	54	HM54
+Field	53	HM53
+Field	52	HM52
+Field	51	HM51
+Field	50	HM50
+Field	49	HM49
+Field	48	HM48
+Field	47	HM47
+Field	46	HM46
+Field	45	HM45
+Field	44	HM44
+Field	43	HM43
+Field	42	HM42
+Field	41	HM41
+Field	40	HM40
+Field	39	HM39
+Field	38	HM38
+Field	37	HM37
+Field	36	HM36
+Field	35	HM35
+Field	34	HM34
+Field	33	HM33
+Field	32	HM32
+Field	31	HM31
+Field	30	HM30
+Field	29	HM29
+Field	28	HM28
+Field	27	HM27
+Field	26	HM26
+Field	25	HM25
+Field	24	HM24
+Field	23	HM23
+Field	22	HM22
+Field	21	HM21
+Field	20	HM20
+Field	19	HM19
+Field	18	HM18
+Field	17	HM17
+Field	16	HM16
+Field	15	HM15
+Field	14	HM14
+Field	13	HM13
+Field	12	HM12
+Field	11	HM11
+Field	10	HM10
+Field	9	HM9
+Field	8	HM8
+Field	7	HM7
+Field	6	HM6
+Field	5	HM5
+Field	4	HM4
+Field	3	HM3
+Field	2	HM2
+Field	1	HM1
+Field	0	HM0
+EndSysregFields
+
+Sysreg	ICC_PPI_HMR0_EL1	3	0	12	10	0
+Fields ICC_PPI_HMRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_HMR1_EL1	3	0	12	10	1
+Fields ICC_PPI_HMRx_EL1
+EndSysreg
+
 Sysreg	ICC_ICSR_EL1	3	0	12	10	4
 Res0	63:48
 Field	47:32	IAFFID

-- 
2.48.0



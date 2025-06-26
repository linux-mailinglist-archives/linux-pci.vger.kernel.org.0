Return-Path: <linux-pci+bounces-30713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D996AAE9B3D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7451C40D76
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3F26B08B;
	Thu, 26 Jun 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvXGcw1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32125B1E0;
	Thu, 26 Jun 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933624; cv=none; b=SR5oUd2YyeiYXeHnbGz4pMXYxuYXKrJ/YoP1UqV16ePfwD85igBqtVGDd+1lHVzeNmbhN9sZ7fWQ6P6a9dUDYZH8E6O9+JeMdfVoJIfx5uTHjQB0GQBO0FneGpv5Mqh/9ej61UiBj1y15dMgVwk4SF5iI6WLiKnhDN5enWTYyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933624; c=relaxed/simple;
	bh=hsjKmXt/eP98fNPU0f6HpbuTuupNb7/a3TmeOlD/5YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onRZkad9zm5eee+3pP+zFafxVqLSnEWTuuikjNNYo9QNqmjPvrg/oijk8XL7lFgcyym/xU+fBSmyAUugNmrqxyUeFqaSxH0NEuSZlALuqeQNN30JXuvXeE/npilUjMKc0hkPK8dB08t1YB7vKHqo5/XLY60SoUoVduzCanVsDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvXGcw1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5226DC4CEEB;
	Thu, 26 Jun 2025 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933624;
	bh=hsjKmXt/eP98fNPU0f6HpbuTuupNb7/a3TmeOlD/5YM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PvXGcw1SGSR6hOxBAKl0tBfOdH9gL/+KToWadq7d1hLGMPkp5JTQ0LhF19rpOuBEI
	 LzNujr5etm9SBXfLl5LA1/lKHh4I05/HvKz4KCptUWRM8W4UwQE2RmlDHgK4+aomjj
	 bAcPNm1BRpf1cQYSVY2MRYlYyJ3dwgrE8kwMPS3FbjtdXbzk+YhY+eUzUnKM9mSOHp
	 ryjlmYXiNT33LVw++CFEjDPefXy+xcExaNfuZsSAfxO4vUcF9ei2jjBiqaN73s/gBv
	 s9NE4sSXDBpkssJXMZ4o0PHWEGCBPuCEuv2AAG4cEG9/MEbMtNXGNqJeFjo+WY1HwP
	 8uDcG3dGpXMPw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:25:58 +0200
Subject: [PATCH v6 07/31] arm64/sysreg: Add ICC_PPI_{C/S}ACTIVER<n>_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-7-48e046af4642@kernel.org>
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

Add ICC_PPI_{C/S}ACTIVER<n>_EL1 registers description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 728223df482d..f1650034e348 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3188,6 +3188,89 @@ Sysreg	ICC_PPI_ENABLER1_EL1	3	0	12	10	7
 Fields ICC_PPI_ENABLERx_EL1
 EndSysreg
 
+SysregFields	ICC_PPI_ACTIVERx_EL1
+Field	63	Active63
+Field	62	Active62
+Field	61	Active61
+Field	60	Active60
+Field	59	Active59
+Field	58	Active58
+Field	57	Active57
+Field	56	Active56
+Field	55	Active55
+Field	54	Active54
+Field	53	Active53
+Field	52	Active52
+Field	51	Active51
+Field	50	Active50
+Field	49	Active49
+Field	48	Active48
+Field	47	Active47
+Field	46	Active46
+Field	45	Active45
+Field	44	Active44
+Field	43	Active43
+Field	42	Active42
+Field	41	Active41
+Field	40	Active40
+Field	39	Active39
+Field	38	Active38
+Field	37	Active37
+Field	36	Active36
+Field	35	Active35
+Field	34	Active34
+Field	33	Active33
+Field	32	Active32
+Field	31	Active31
+Field	30	Active30
+Field	29	Active29
+Field	28	Active28
+Field	27	Active27
+Field	26	Active26
+Field	25	Active25
+Field	24	Active24
+Field	23	Active23
+Field	22	Active22
+Field	21	Active21
+Field	20	Active20
+Field	19	Active19
+Field	18	Active18
+Field	17	Active17
+Field	16	Active16
+Field	15	Active15
+Field	14	Active14
+Field	13	Active13
+Field	12	Active12
+Field	11	Active11
+Field	10	Active10
+Field	9	Active9
+Field	8	Active8
+Field	7	Active7
+Field	6	Active6
+Field	5	Active5
+Field	4	Active4
+Field	3	Active3
+Field	2	Active2
+Field	1	Active1
+Field	0	Active0
+EndSysregFields
+
+Sysreg	ICC_PPI_CACTIVER0_EL1	3	0	12	13	0
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_CACTIVER1_EL1	3	0	12	13	1
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SACTIVER0_EL1	3	0	12	13	2
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SACTIVER1_EL1	3	0	12	13	3
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7

-- 
2.48.0



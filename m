Return-Path: <linux-pci+bounces-23702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC10A6088C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7EE3B9035
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB914884C;
	Fri, 14 Mar 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZFr2pdEJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2093.outbound.protection.outlook.com [40.92.42.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6413B7AE;
	Fri, 14 Mar 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931818; cv=fail; b=e/FZi5F3ReD0+fRZiRZOudN3PR0yJZ71t8vppZ30oibBxgmdXT4A3dwY1RR1DIdSuKjaQrPJeClCAEDqxc2QIJW8ebtBDpW3RFizSyCA6pd024cuyUc3rcXNnt60AdrH3G1dKEnl53mNyuJCe5wvXS2Q7kNbPb0pKO0JuI5sUHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931818; c=relaxed/simple;
	bh=0iB2EmngP/PC2zFqLpubk/Jt1Xm1Gw5EEM72KId3AOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgRqsKaaqazrfDkRvI03KnOxfKn2IK6dMl/9PbCiCBqUzKbwbA+AaGZirLNKHNV6XOdlksOZcndLNuMfr5rG0WvLr7wz6C0oSA5V76/KWpO8tc0g5IkOy3zKSO9r/qFWS68OaPmhUt9t1UCP16Jl8xS3px5ytHHYn10JNH/FKow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZFr2pdEJ; arc=fail smtp.client-ip=40.92.42.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6PfBGDF3Yt0cvVKOiZXN2Tt7CewqSGR7Y2Zd47UivrCXwdbbaZzRlE0ob339X3iVEtTMfKc68afRXzdXPE+HI0lMxuKcpjGlJPR5QQgFAkRFoLcu54wo6YKxZTZZJzLvrcx8VwrGLVaxyWUDqMSMgouBikpLdSzcnw72cZGhL3Bz+mQgwLCWmmcRQrxLEqxDgTiX3/0jNBBZKxmmISpp4hecjdwG2SDEUrw3SEaoYKbXmrTZ5MCfASwSSFbXMwVIBitORSv9XqTeYzCK62C4C2x7BDG29lrJfnqZ43CVGsYkBWBVU/tW24/UpjXrT+MUBThh4A7zHqkLVGKdPHeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSYTB0HlHKa1uCDKMWfBr2oMX6vXpaRiLFHCFsWoKMQ=;
 b=GZdDUJkYFWVJ12z/0g2g9aKio9EoZnw8nRZetKN4IQUVDhrqi9V4c4EoLhgi7t36sfk41O03mpHuAVhES0P1SDhSTq0ZeUGfK5ET/1Q+Yw/FGRz2gbHeJcdVGWEV8qLyCFUCDaYczHVzcgBhXV/q9CTNgPXXDDWAFwSBO6nHuoF/6MiXcCrVvE8IcP+Zf4IQuJu2aSqjERYG9I+eEkkaLSfi07Zt5e7Ym/7euuKTB/GVWjEDM57kU+Vz1CZc5rvvO66A4nf46FczuF4BwkPyxA9jkrfIE1uOcMjKLSJGkK/Afw5xoB/34KAPnGOz5hh3FIZJy9TaKuPmGxwnXaKmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSYTB0HlHKa1uCDKMWfBr2oMX6vXpaRiLFHCFsWoKMQ=;
 b=ZFr2pdEJZzpi/FPcYaHGfrPExxr2fdCyMLNyNixneM0p2kbaO8MfantbKgHyrf7AJLawqJ6knBVsPtiCqX4bbr8uhPKo5YbhJ/0yQgPV+5lg0OD5teQjp8uH381WLo78c8J0IHm6QwHfe112ib5UoNPhJiEb5ryjFCQzw9e0BgZzgYdy8XegYZjcGFdMsTLHSu38+N+TQ57ec+TZ+nkO/pFiDtkhs+KGcJDrCPUzzXQWZ/5Mv2DjXFSNLu9AMxls2Ymb/np5y9hq/5KGrENApsltcYjauv7sCSzTgn+5epclE5mQu1z7TytTxfP7rhCO3HXZz1rb4feToyoBMlvMMA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB7795.namprd19.prod.outlook.com (2603:10b6:806:300::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:56:54 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:56:54 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	lumag@kernel.org,
	kishon@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com,
	robh@kernel.org,
	robimarko@gmail.com,
	vkoul@kernel.org,
	george.moussalem@outlook.com
Cc: quic_srichara@quicinc.com
Subject: [PATCH v4 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
Date: Fri, 14 Mar 2025 09:56:39 +0400
Message-ID:
 <DS7PR19MB88835F541CBC60C97A818B3A9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055644.32705-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b210326-8ab6-4987-ecf1-08dd62bd058a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|8060799006|19110799003|461199028|7092599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1z5UeEyaawEe+yoz/HuLDpOt3+1DFOCPAtpkoYjhNQ5BWXKTNnav8dlWX898?=
 =?us-ascii?Q?p/gI2CUCmUpNZ1b5RNOpoMZQLR3CAhCoKq6Bu+bqiflAKPXcPquHhIGFnGd7?=
 =?us-ascii?Q?EvGOTm8qLGZ9jRFjsrGsxY2Bhs2xRSIA7MNlExjnDinqHXfXWg+LV3Fd/j2U?=
 =?us-ascii?Q?PU8+ws+LP2DtRlztUL+Tn71EN8H61q+ltYzJ4/Pa2fAU+qtBE3k7Ex3vK5xC?=
 =?us-ascii?Q?KdUa1tEfzRff/mffNilrMhanVGuqJJftYtcCOd7iOos1bE8L8Xn4TubTEiTO?=
 =?us-ascii?Q?A8OmRAuqFNWsa8kwR7beWLO4xtYXPofkSFwajty6a1CLhPxviIYTW1pNtvdB?=
 =?us-ascii?Q?nY5rN8ULtgIUPya25GWJS/tDEnXpM4C4tT9h1TxEORMTKc556C2RbEaRavIJ?=
 =?us-ascii?Q?6sTdoCP2oLNCT5TxQ+GWcH7ShlSZ7qe2awr8+2NcCTVbTqmNvrLSROtq0s1t?=
 =?us-ascii?Q?Gmnw7fz/4jKpL490nwiykA+RxN8vSa2E56u6SFr3OrYtyhlrW0jZDO+Dz5ha?=
 =?us-ascii?Q?fBrLwjlPYWnwk6YaJp7ER/izlJLMmQXNB16PicYYLTGZjFJUyszVu9iGlDr4?=
 =?us-ascii?Q?kUELO+tL/7mTn2E2llJG/cdr0AdUjChAOiwlSbExpBdnLgVO1p18K8IuS2+o?=
 =?us-ascii?Q?aTZQT7wJbq/vM/xu9Ufd6gAx09aXlvLQjUTZY2Njhydf2MK4nhLohzmAmwl6?=
 =?us-ascii?Q?q7EtztDEPerGbjKrsgc1sGOmdZHFKYkIe7S41Xa3ZJ5OsY6yoLJ1xTvoK0uq?=
 =?us-ascii?Q?sfh91U+AjqyBxsh7z1ApzruuDHbWwO7ve25vy8Tiy8OBWF1TiFhpgJpHAPIj?=
 =?us-ascii?Q?gIUipXSjApEa2PRG6EkX9moONIOI1vHNEM5n4PpRN4a0XWnQSF3So55icuwH?=
 =?us-ascii?Q?/QqDd/KzbY0pb3HFvVZRSKebDwg4t9VwXAVddduqukifouHwTW1H9b9VyAGR?=
 =?us-ascii?Q?QGe+27vZpt4+MEy/l1V2tAiuns0nw7yFtJSnhDwxQEEmZQ1ixaLMJeH+L3BB?=
 =?us-ascii?Q?1qHT4EJVhDiVFn7QgAfbcEDbjfxPXvGwk0x0HfTK+qmUHUrG0RuIn/Iag9Yi?=
 =?us-ascii?Q?gCuUmrzINiSh0rwSYy8Id9Y/DdRwt20vMZJJb13Ia6ckcqAH5Ak=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgmhk7W9cvzqO7u+BsOYT5z59nT5MUPMokwRUz6KpSRKtFDbxZxxc271qXhd?=
 =?us-ascii?Q?CZacCo9cuJn3maOKkE7fbweDXbDzI+0fzm+R1YsZzicSukJ5fc8+U8CHGHF0?=
 =?us-ascii?Q?YViGjtNOaSUlJTFjyazCkdQDhyQJGRLhPd+gkw6tT9+T6Z2v7Zm+yVbcTIfd?=
 =?us-ascii?Q?tttph7M86Ymmj4tzO+3YRv64jnrt8lKHLOLvWnb2K0RLkSVNS33KgvK1C9JR?=
 =?us-ascii?Q?P4+OPF3kd6VM0eNlztXmf4799cjs6gl5hSMEujEDAy777BJ7q0xmPp5N58DP?=
 =?us-ascii?Q?Xhi/LrtrSVBco3XMk7trDkPdHAWC8H6+Tlsn9jwVZaHA92VDZuZfpcmqbBSe?=
 =?us-ascii?Q?OGbkeQ2nHarfyrAty27OgQsA3+CSHkR5bqtaJSRiRNoIpBDZV8UMNXHqqVP+?=
 =?us-ascii?Q?EpXVIJz1n7thm9aUvS0gZV+j7uxKHKPAInIvta9bt1eAkttpMjzQziVR4xsp?=
 =?us-ascii?Q?N78MnP4yqlo2mz24DJuNhG/8sLuo6IaTKRGYcL3mKLacGCEZeGGLO50euOhx?=
 =?us-ascii?Q?oOWDNCwHJ7IC6n7eDov6E+Gce3GnGQt9KKmlpE3qhczpf/gfP/YQiPjs4Ncu?=
 =?us-ascii?Q?78VFUmwz3RFiUI51MX07bVqcdUF5XtGVdmxoWioRw48BuOCk23ucatmAdlRP?=
 =?us-ascii?Q?YIVWvJauDPdS1mvObS3ADoYR4Ls2CVyjgz3EqZjvIDrc1sCimC+Pead5+o/c?=
 =?us-ascii?Q?Y8JezxQO7b6UbxY8/1ukeMamDeexM+VHvX9ATKx9rOsHKDastsO6nr54Rbw3?=
 =?us-ascii?Q?TGCxssWr/buf0a8fhx0QoSB2gAMbTS9jX2avynUDokXOhufQ9McwffNmCk1y?=
 =?us-ascii?Q?rr40cgqtEjVdwwp1mLQ18CigHXdOuXa6IkL15H3tXaDRp+GL92HzqcfU3ETg?=
 =?us-ascii?Q?O+U6AZ1HyOyVADcYETV/ZTS7QUd/OCyxo+h52HsQaxlHutgVGDUWSuPYooco?=
 =?us-ascii?Q?uOnkm547xcq1BWyEavbwIcscDvfeF38dyDKxi7oi7//KIenlMJD/2v3PM8EN?=
 =?us-ascii?Q?Td2waEuZXaSRfizIiGLwv+2UieKG1MEjK+w/ZkUICCOpmvCFSvR+WdR1CkWy?=
 =?us-ascii?Q?Xb9SsAOgYzkgcoboL7v/Wq9SDtACdMK4agLnMZudF6odX5qTJtqh0cfnypLh?=
 =?us-ascii?Q?bBjU8yo5lW780mmKirgdjvt79XOzvESdwMHMiZxA8nqPPRfKhoiCdMEBFIyl?=
 =?us-ascii?Q?tdLMttd49i6QP1rxo5un+kV9EyeSVybF1EMBhnTfu+mve6kUYdhF0Dhs7a+6?=
 =?us-ascii?Q?11NOLghllRw2jgxTl513?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b210326-8ab6-4987-ecf1-08dd62bd058a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:56:54.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7795

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
same as the one found in IPQ5332. As such, add IPQ5018 compatible.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
index e39168d55d23..bdfa3417069c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
@@ -11,11 +11,12 @@ maintainers:
   - Varadarajan Narayanan <quic_varada@quicinc.com>
 
 description:
-  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
+  PCIe and USB combo PHY found in Qualcomm IPQ5018 & IPQ5332 SoCs
 
 properties:
   compatible:
     enum:
+      - qcom,ipq5018-uniphy-pcie-phy
       - qcom,ipq5332-uniphy-pcie-phy
 
   reg:
-- 
2.48.1



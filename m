Return-Path: <linux-pci+bounces-23706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA5A6089D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322B719C2B89
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70414F9FB;
	Fri, 14 Mar 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oZ/d7KaP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2016.outbound.protection.outlook.com [40.92.40.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCE136327;
	Fri, 14 Mar 2025 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931847; cv=fail; b=YZBmAyfbGXgDk9eDK1Hjd5Y09BODq4KDuMCt6pDK3SaJiVUPlpNrDcOB5FafNQPTYi3UrRL2K23wQokcLPLH6uGwWSdH/dD0ELoncxr8P6Skh6kDWOOL64pOyyrAmorXuFZFXXClNtnwGc5brvnHL5+wtXHNJOyyCGAxntCrD68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931847; c=relaxed/simple;
	bh=htzmTtmpJM+7lZr08VKCy9LxbCkmPrI3gV6qZ3JYuyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgoUu2RrFnzL7bf8XktIkhWVAyUdsIJD6J84wnJGAVOrzN/jhG8z2qkRn1nrNV9DlC81eBuHZ/FvyTXuNgX9D0R+vZLCKTL5I6wKsVAxSBY8y4EJztFL8KppEkUqI1zWtUObgnVJnIhZrliyTHOecIAo6yr1vxkQzA22XsnCcZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oZ/d7KaP; arc=fail smtp.client-ip=40.92.40.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHMKRo/rXZCNSS3BWiGc4O/2oU5yQr7H30XtuDS0XdXuH3f7V8CXbGIb0zQxypGX4ss7MlzY76uHhLfyizl5v0gsUYZalYAYT0jB0jt8SeMchgx1qMOT2kaMKHMxtyWzMeftUFakQlkX6cFb9l3gwaLRPsZ+9tY2eSyu1MxfSBp2baWfEhzGWX2ak0izGHFN2UyQEEFWmrLNhNvBXMlXAhFDQPJsKlxp4GxFvlVcK0LzvZwar7Y7yL8CuOa5J7H5VUfhOy3T8mdYsaR6fekZCF4vqAIO19Dx4mkRrH2WX+NCUekJt8lJREOZlKIvF+NGavz9/oskhMhqT/lyOyEdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYgfVkQlNWBrICHqERWNOn7Py9idpi0lAVF+V9p26xE=;
 b=JeoX7Q7EWaY/91im1JYkHqLI1j/YyRrKVLvLJ7G0ATxAtz5cg+O3CgWLI/Yb3aqAfL6XRf74CUguRtjEkVIwRuOQP3o/vaO0LTPUZ9tw8THLBa4VgDRVSsuRnUEDZnhnm3lL0wNXsfMNYUkjBifa6BlFovXUPwL4I95PhzqClNUXInaeltGGjtfogcuglBbSAfrw7dRl7PQ3CT7BRSv/rPy8ETKsdxXb6qvs5bm05BAQ7j6/ULEQAWBnM4fgYSnAPB2BIiWz3yYXkq0BFqFQMeXTaegrKFiTV3WMwCC+8DbJbERQY0r0gRMNHSCIE08Q6pbIUnmxb/FLp9SaKO7pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYgfVkQlNWBrICHqERWNOn7Py9idpi0lAVF+V9p26xE=;
 b=oZ/d7KaPY9JJ9wV9pp5v6CVkqhHAvJiLKfh2cXqz6wYgZe4tAKmZyo9VAdrbB/3hSBIJC3jEq4s4xkvIAFB0z8ZLVo/oqdH2x1Qf0nKuOJzyoHZ0yKVodHr/S7MZ3A/P+Pz79Vvz95+iVsTFls8pgswa1Wm28opiIMN28AcU8OH3YQIe2uzGUricQJhWeLZUwO/0D8nqOzKJfYkkShY7CW1wRWDElbJ5rkhdZT5cWf1QkL7rMIMPq4pLbjIO9XWXqqIYmAP295Jr+MQqJlyI3wgF+ej6jizMWBkcrsDBsQOWozcqcXn14XoWiPfzHhJPHhbNQjVIp/cIs1Tu+6Ffbg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB7795.namprd19.prod.outlook.com (2603:10b6:806:300::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:57:23 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:57:23 +0000
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
Subject: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Date: Fri, 14 Mar 2025 09:56:43 +0400
Message-ID:
 <DS7PR19MB888366F3BFE6262375217FA69DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314055644.32705-1-george.moussalem@outlook.com>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0093.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::20) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055644.32705-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a1b6e5-2d2c-4d34-6f62-08dd62bd16d1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|8060799006|19110799003|461199028|7092599003|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZRcR5PWBHrYp836OPYY6WJt4cDEU0S6YZDqzFbrBXLuI19sqzv2RURmWrZl?=
 =?us-ascii?Q?My0C5t5YFK856YnX0RjuIAaGnptwMzmlRIG8N8EOay0DLTVhwMTTLreFpect?=
 =?us-ascii?Q?OFhOBkaQ0Dbw1afjCBEVO3NWKAZ8Y5WEjMj5vG+svtyOGftJvdVuFOknJe+X?=
 =?us-ascii?Q?CTjZ9imoc72rkjexDZTx+wwX81VT8Xr/4YI0kozZ6i2VOi/1Ks7NuiiqhZwA?=
 =?us-ascii?Q?gWsYkes0lKFQI1QcTh0yNLHwtEwlxQtAJzvPo8MxwmSZltjh0XEY2dGntZNf?=
 =?us-ascii?Q?BObtCY1tGEmdv1VQyWC3ve2qx6SKBA2ya0eE38igk+lwE3jrPTyFJbkY75+k?=
 =?us-ascii?Q?hc4L3Ty5masJfV1Ac5aOZ4S3NdtKkG5Oucx0PrO7y9z0mO3pdrMEdtZ1OjC1?=
 =?us-ascii?Q?5cTdJCIXzE3HswWNtXFyBhMYP8S2EGGz4dEgnKptaApJ4WIY4nQvG+dM5dRB?=
 =?us-ascii?Q?xpd6NjSsdJKJ2P0H1t9sX2blaG+Kh+T6TWNZoF9OJjGZpYQNHZcR89aqNFG9?=
 =?us-ascii?Q?15LZhMlqH0DH3SOG3gwIjIb4TzGlfAAd3rqFNSbOktI+WpDs9YkglRaKqRYj?=
 =?us-ascii?Q?Q1TCxKRookslF16bCN9MVMS2jQTcdY4NtXr7I930AM9e4SBN8w3+SWfI+Dw1?=
 =?us-ascii?Q?iQK+NQPBXW3O3AHsgQdi2smwvvRt98Ikvw3gURdlkgqtv0CMgRwKmBoD9FKJ?=
 =?us-ascii?Q?IM1aAd/CbQ/jnv/nKVOvgStgr+KR6WYtacm6maI7sZJJ4b2tkb0UYOzJhfW9?=
 =?us-ascii?Q?1zWhG91WQxUJygfw36aBAQPXGdZX99S0Iys7gTZQKn8mc0xxQy7DyVX8g7YG?=
 =?us-ascii?Q?becPW5lT1GstAC5VjrTkNk1dQfIlHY8WHvjPXQb+hp4nnptCwLPMvfI4lagk?=
 =?us-ascii?Q?0/JOG5pmyH2PjvJr0gVy3rJmyuBeCk0hVctM687BNXfYto3MajQeD3i/wumA?=
 =?us-ascii?Q?vd6XnvVhKC5lkKq6TVhzRgnE1nsqTmMyISYdtS9SvTCeDV92Vnkt1NgQPQ8W?=
 =?us-ascii?Q?GOHbsaOUB9dxw8xs191t/okIlmG1jRFpHWE9r1fe5X7HfMQcnlXTtF+Dx267?=
 =?us-ascii?Q?TFOWja+1Zqe3Kf3iOlHpkqETw1Duw+QEUa6sG4Unysf9TqtfOlqtN+AIHlKT?=
 =?us-ascii?Q?XRFgYCr9Q1tEykzh1vhAZjZtWYNedzy8nA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlDmAiGDOvBadS/ZOBBedY7+fiMsJTe2+aiRDBWYui1HPhzlO4zFfNPLy48x?=
 =?us-ascii?Q?Hkdwu1A0eh4gSieEefxxbS50rIgE16Kcoliu3U1UN+4Ih/itt0hQxJCGvelB?=
 =?us-ascii?Q?0OsBOm3A2BP3ewtvM8SSXHRVDln1m/LGqG+Bje80p64yGk3GhHtT++qFiT6p?=
 =?us-ascii?Q?tutLTDsWD6FraY6f55DEH/bQffD5C5yrYFrsKUPMUG7robVwVGuswQktWe2y?=
 =?us-ascii?Q?497RRiLRqG2ZpzCbicIEVTauPWo09mrrOHpB4LDB3Ci1j/8Nj+ew9P3tYXWx?=
 =?us-ascii?Q?UhSbUP8qjWC16VloZ5TrG4DCZd+Ikg1Gf4EadU385NZewlvJEaEc4WMK0NYf?=
 =?us-ascii?Q?S6SjSkJtF1WgyP00H0jerpmDINjmhsMhLk/1OwjufuTX7D/TI8zWNT5RCBai?=
 =?us-ascii?Q?Ym//RL8A6aCn6pzaHyP2kVDUdwWi6jZMilgSmzINbe9gG8GIuWoLlom1BdIV?=
 =?us-ascii?Q?j8WGU2B9IT0iNp8AtJqyPh9AGWmVDVpfgNDzglGO3a/OH9L70vCJ34rzOv9X?=
 =?us-ascii?Q?KrNXh9jtyBcA3NrkjczEEaVBccdbjMg0Tp31q8DOMeX4TMpO+kJUgzYXVYNI?=
 =?us-ascii?Q?gYzy7f3+F0jitmsFhh254lew1I3zeI8d67g5ahwcOGY6Il//whV6dX+3EOLc?=
 =?us-ascii?Q?2ssLQ517IoPQOxO9SZI3i1Kkrms+wcPiRtVGiAiF4/3LAFN5nWSEKj5iHMVO?=
 =?us-ascii?Q?DmY9tNncYoInSEMzLKHkfrMUfHpI2ThHfjigFoECqx+Y7531K9YS5WCkteIt?=
 =?us-ascii?Q?3J2IYu+epJE5246behQkY3X4G1PKLPzmVox6unrFaNxsEM1uoY+vQuH8II9L?=
 =?us-ascii?Q?1wwcvO9vNCL5eqzlMlJIWNpNKa3QE4+vv7OwXUVFnzpO7hxqpQWNxBT51Inp?=
 =?us-ascii?Q?UtWr+GRtaINvJXve80a/JcHmxoiikgNVpMtbmkjYsJRPKB7R2ki+63ZGAIQn?=
 =?us-ascii?Q?jibbXI2sD36e35kK+EyNIhfEmUqgSGtaZ+b5AbopJa1oLYjPwuV1LTWVm6b3?=
 =?us-ascii?Q?OvFZEGRLZC6aL7lCWn0TqPVAQI5rM34iIqKYrioDitp+4pda7hexRnJ/OAoW?=
 =?us-ascii?Q?hAGRB9Tb3qQNWI1nFIkAqfCHKsBo2exCPsxDNoMM/GvdEsNY9YdXcWTnVwKW?=
 =?us-ascii?Q?8/v7vrw4Mk6pviqF9xArpY9/Gzphw9DXuSBOb0W9HhTmguwK4nsdTyyO2Rtb?=
 =?us-ascii?Q?1C2PmZ/aad3nmOEFVvUcovnZDDZItLM/dTfL4NJTxJpwuDjGStWcsEAGxYLi?=
 =?us-ascii?Q?ymWyYIvkSReAq5V34h4v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a1b6e5-2d2c-4d34-6f62-08dd62bd16d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:57:23.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7795

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add phy and controller nodes for a 2-lane Gen2 and
a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
one global interrupt.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 232 +++++++++++++++++++++++++-
 1 file changed, 230 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc4..82d3c32ff719 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -147,6 +147,234 @@ usbphy0: phy@5b000 {
 			status = "disabled";
 		};
 
+		pcie1: pcie@78000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg = <0x00078000 0x3000>,
+			      <0x80000000 0xf1d>,
+			      <0x80000f20 0xa8>,
+			      <0x80001000 0x1000>,
+			      <0x80100000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie1_phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x81000000 0 0x80200000 0x80200000 0 0x00100000>,
+				 <0x82000000 0 0x80300000 0x80300000 0 0x10000000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_SLEEP_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
+		pcie1_phy: phy@7e000{
+			compatible = "qcom,ipq5018-uniphy-pcie-phy";
+			reg = <0x0007e000 0x800>;
+
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+
+			#phy-cells = <0>;
+
+			num-lanes = <1>;
+
+			status = "disabled";
+		};
+
+		pcie0: pcie@80000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg = <0x00080000 0x3000>,
+			      <0xa0000000 0xf1d>,
+			      <0xa0000f20 0xa8>,
+			      <0xa0001000 0x1000>,
+			      <0xa0100000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie0_phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x81000000 0 0xa0200000 0xa0200000 0 0x00100000>,
+				 <0x82000000 0 0xa0300000 0xa0300000 0 0x10000000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
+		pcie0_phy: phy@86000{
+			compatible = "qcom,ipq5018-uniphy-pcie-phy";
+			reg = <0x00086000 0x800>;
+
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+
+			#phy-cells = <0>;
+
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -170,8 +398,8 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
 				 <0>,
 				 <0>,
 				 <0>,
-- 
2.48.1



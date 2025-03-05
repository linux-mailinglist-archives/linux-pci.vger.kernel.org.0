Return-Path: <linux-pci+bounces-22975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB50A500EF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBEA169E40
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92924A065;
	Wed,  5 Mar 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Czf5lH0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2053.outbound.protection.outlook.com [40.92.40.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CC24EABF;
	Wed,  5 Mar 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182227; cv=fail; b=nU99hh3wOgy7IZpyxvH7h1PEYGdX7yKGpvAysUhMLVC3X2lBdQXWXw7hUTgzt0A6znzOxFpNKnlFrvQy5vNu7S/UavB8zWPuyO6KBt35oioOjd9DVYHkgYpzJRrcefv+6L+0Hw/H+SSYjDBKWX4N+G9mRyz/CPHM0YF5SdvC4Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182227; c=relaxed/simple;
	bh=8hUrIbbGsfGEtFwzGwz/vRjW7xGBTMMIX2i/oIavXgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzpL4RFlOjINsgWsoHackqSKnEsyHsq+taKnHzfQlaCT7byHHwMEasGRZGDujMnMP7vfXGC1i6KW4FzvZIqmaW2ucm2YWbFOODf4YLRPvKf+CV3jDVy62KkHuLu7fiuIgK0hbAjVpEnEqrRDUnZ5HQ5BJcAdBQ/VKYmakwfQRH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Czf5lH0h; arc=fail smtp.client-ip=40.92.40.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIhXsWs3zWXsz2pXWsm78X+9aCGlN8Xow7tiwK8SOOs2J2M/eSEB8bCHvIzwWVmHRuuWF0vG8ecwt4vqw4E4+5JrN8shTD1inAuNVi9pYT4vjif/ULL/Lc8fHPEuRTgkoVT1g2u4iBcUe5lyIniNSug76s9Fm7/DfBAJOONy2F16/xIFLNmOtKnbbn1mp8xYGF3MvLqu61HwsMaRUQO2IUKOlV2B36mW2Qz/yFd5bzy9+Gz7BYZKoSuhzZAElP+vMuM0RGJuRBEhrILGZO3hZh66G5G6TffyTtrcIlgMZWI9sk4Fsa6//zVwC0zxNnrrF2V7RYJO+HHRnmehfQKQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV5Bvl+ZOFCXuzrsOhClukI4iHbo1bmBiqKXeOuePWM=;
 b=J5ytOUtibSzUu3mu9OJMF4DgEYUj178fKD6gl8grT6cq1R4pmSbfyyZ8fcLecDafB8E6gv3dgnvNiYDR17UphM2Ww4eFINke67Ue0lEHmD1jLqgYbVCnTmpSu9iMmmQYfMCKOccxguifwf09LaPkCLQs5IAODVAXZQpnqSa4KojwWzCQBOpJq9cnS6f6Koj8pTZfl6n4jx2tvyX7EBLgTfgJZst5sBqOfoLZDzLr51N6ewIrDvXsYXcDeirelJgcSKJl9eefwWUqljoJgu4rn912tk6uyjudfVsZlsH8NEeEubONdZRJskjuYkhvq8YVRbbtVXRZBLbl2bEiv18zEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV5Bvl+ZOFCXuzrsOhClukI4iHbo1bmBiqKXeOuePWM=;
 b=Czf5lH0hHe9UJqafNXTsqEMnMl0uNQYQpPx1D3AlkTaM4aGKL8ppeSDj+qzfSGzNI/7GaPF5Y1qr1RUvNygX7Gaa+7/jPmYSX8SZ+TYeXUnlizHvp0XnmVAnvHwR0Rf1Flvi/DedYBa9YppWGjiNd1hkOUIgBPITCsYMOpyfKWH1ESxr9Y+D7rkLWLkpcGnRmY0iiLFOCQelROmqg0329vrz0Ku5TNunl/6kr2rO+yeG1GBuJB89+w0SWZtQxcaE3+733voVfeUQyR3Sszp2Od/XhwjUBKJHhhgRiuV66uRpcS4GYK+EloUoJuTqot9IDQUH1wgE0cqEQPKnMwbi3g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:43 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:43 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
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
	vkoul@kernel.org
Cc: quic_srichara@quicinc.com,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Date: Wed,  5 Mar 2025 17:41:30 +0400
Message-ID:
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0035.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::20) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-7-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: bd133dd1-a300-4944-19d3-08dd5bebbeaf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBkjeCfeEcxhhol6WGCSPfebyZbbcXW1pCYlTZQZfsD9oXY0C7QU0tRkY5/y?=
 =?us-ascii?Q?S8wsXvCCTuPYtSNFSPK6zVrfrm8rINj8hJ/QOfvQJGVNxkSI+hzIpoouT53p?=
 =?us-ascii?Q?JtF6mfS+jJ8SuPz9NZGdcb/Ug0aS9Q9h3JQ9NLt4o3DfWG02+zSC4wTreC4N?=
 =?us-ascii?Q?xD0bYnCK0Zb3doZIKxv1g7thJCA14548huR0iWAjxJOh4pAnlH5Vt8nYs8Bx?=
 =?us-ascii?Q?derl+kI5Lr1bBHtKPF1109gP03IEAEOvHk7fwkMYcAi9nMS+mo3mXIVyovmS?=
 =?us-ascii?Q?RAW3WY/WOXeNJnZxusgRe8CWdidzgnM/NXT4UqRAjRK9ytgYg/6obcU2rt2n?=
 =?us-ascii?Q?5HyCVqZ29I72hOrKcx5wyzz3ftS0WAPLCkHUywjljHzCOPoDJ4NgKalxFg/6?=
 =?us-ascii?Q?Sgrucy8fZ7cAYs7Wm6pOB7bDTMb0FO8Fz+cIVvLUov2AuuSaHL1YjBy7MxSA?=
 =?us-ascii?Q?73LsF39LLbm+67wjs7HIp0OwKC5+0fUp6IkFK1gV9KBa9gJcTeTtc3EsjZS1?=
 =?us-ascii?Q?Vl5TzGeNARfUSyLpn+3a0qiDgDiJ+JTZd3GP2nfrbqUUXF6WK//6XJOZOlap?=
 =?us-ascii?Q?GYrz9KBhLhPpxro9MABV7hiCP8dmo0e4wgXP2XJecwtO3ZaxSbTCdWWaWCHy?=
 =?us-ascii?Q?r64LmNQ7qs924N5/z+yglLCZq1a1EWa6mR8BhDYjQ47D6xU93piuMW8bM/Lf?=
 =?us-ascii?Q?IuIP0CXaCMiLyWgAfubo6ifSY9hOFC5yHhn5mALIZIyHM8NPAtqxagBPBuz+?=
 =?us-ascii?Q?C4b+ruxovD5If5Sf/smaSiUIXv0VgMXriZsIQ4NQH4xs9KeB+UhZlCsqJ7iH?=
 =?us-ascii?Q?Dikt+6SfKHgRZUdAEc+Ly38OR2o1xZCscGMQs6SMIe54Pd5Z8j537/PLDLmM?=
 =?us-ascii?Q?K1lXkQAebgbjo9PnhOabpad5pjnegvi5oGZcXY7sMXWx2t1BJu5kCQKPa328?=
 =?us-ascii?Q?d/sSJLt0aQ26XviH6dleZILfvB3STjMA4N7zfWMS1axoLq1nmQxW+FE39nlH?=
 =?us-ascii?Q?aofw67YFl5Iv8gfAbhspubapFNrsH2j5BM9fKPgnlMeF/ZNQsstIxXayd1Oc?=
 =?us-ascii?Q?BJ7R3+qcFdhRi1FUxzu+RTELkE/qKhs74yh1ujD5Q81IuSpPr2cPxNc/sQbY?=
 =?us-ascii?Q?7bxk0PjDjmUCljHdbCTFL0tTRRDG+k+rqg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZlFINWZceqruEiMdWUbOku/fGrXU5/FyJz9+ISbMY1+rrYJEhMVK5AdRcIj?=
 =?us-ascii?Q?jvtg0MuLTxk9NLduYnxAVu1TUyQDyqOC5fZDTVKIz73Or3XaoVJxXAlz2EhB?=
 =?us-ascii?Q?z3X1wYsI9SIFrS0uVQzfVXrk3gAVOHkd7GAUqN/ZDe2vELDhn2qQ32JWxkE9?=
 =?us-ascii?Q?fGT2oRlX5ED/8Oaf56hPuQpbBi53Kct+DMUNeZpTeVmM8nBuO52ABfIkJkMO?=
 =?us-ascii?Q?uJFiPoyLIPmdm79S0Tn+vuaVNyhkklSKhTRT1lKXXfNoIReTohGeUfu2cQn3?=
 =?us-ascii?Q?wSzMaFonUrrWfQxLV8RIRNdy2ZyZCso+tjkaBbNz+HtQ4+L1BavqydXK3M+P?=
 =?us-ascii?Q?zZPvJvjAHNKZZ12pp1MCGYJlYAlYREJJ1oCFbgQg6sq1eZj+Eda1RLneynXn?=
 =?us-ascii?Q?TNzdCAJlhoIiALeEolyfkucHF4mAcwTMttbN6FA6mAspw5W5a2JfVNqHwxJ4?=
 =?us-ascii?Q?oiSmVuxO9VuhVBgKBcu78uWXUDoWFpGb31a9i7BkX7cd5eRy/c18+M0OgSj3?=
 =?us-ascii?Q?hxIhdqWIGF5q1+OMesA74CZPHwfMiHMjC42hKcA+f+cAsigQ0Yw02p3m7m0h?=
 =?us-ascii?Q?IYFSCidVgUOgZtWEDfQv7VDPLnkbnyL9WUnBnWEQ16vxTW1dlnNlJgUb1MUo?=
 =?us-ascii?Q?jr0F1fip4BY4bdk7kxNF1Pb4oDB/f0AgQE5RlpTpZrx9rLkqi6Ukg3C5kL+1?=
 =?us-ascii?Q?wZ9drfjcLAKFendu/EQUld9gn5jeuO48RuRG4y+63W1r/AKwJol0kTadZWAD?=
 =?us-ascii?Q?I9xN2hE/AaONwdmRwTj4hjEtEwEBV8+6jPlEoQYZFXAWuVF4Y43L/M0YcrX/?=
 =?us-ascii?Q?f3zG/fT6bFgVsGsfHG8wvnMq6KCmLV9fCK5xxkQNod4swW2wdnspj2GcVm0U?=
 =?us-ascii?Q?Bks4m1HLM2H2A0ZziYVhUVkfklncuXbvH7H8ReV2kbwqYyvpQc7o6r1p4GIf?=
 =?us-ascii?Q?+Ina1tsWtbcyBx/wYUk35BK8rYvz7MGHFRpvymZUy6UWAbwFdph/ISMAmBNr?=
 =?us-ascii?Q?HbIrCuMmDoKC1pfzPsC3H7TZMEGhMN7+rsTTD+th4DO1VxWZNMkNUQU7WikQ?=
 =?us-ascii?Q?CIRi+uvFzvZ7oqhW1keRcicn/Og9Dyn5OoE6VgBOz17Jj+y34vYFw30zkkVg?=
 =?us-ascii?Q?D+ORCeQwG/xYdSuZd33P2XBx2uDVEqHtHuIxsoeyWEnyzr3pxat3nZbwRFYV?=
 =?us-ascii?Q?u1qodutHsI7l9roaUU9D5NxJSqexiJsSaB5/OVhBKEBtk6Bc5udnNIv5Lee7?=
 =?us-ascii?Q?KAKQdqzaKb7wQ9wI+HZA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd133dd1-a300-4944-19d3-08dd5bebbeaf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:43.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

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
index 8914f2ef0bc4..301a044bdf6d 100644
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
+			ranges = <0x81000000 0 0x80200000 0x80200000 0 0x00100000>,	/* I/O */
+				 <0x82000000 0 0x80300000 0x80300000 0 0x10000000>;	/* MEM */
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
+			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
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
+			ranges = <0x81000000 0 0xa0200000 0xa0200000 0 0x00100000>,	/* I/O */
+				 <0x82000000 0 0xa0300000 0xa0300000 0 0x10000000>;	/* MEM */
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
+			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
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



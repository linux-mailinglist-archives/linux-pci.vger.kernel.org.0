Return-Path: <linux-pci+bounces-22972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB8A500E0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8AD3AECEA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15A24CEEF;
	Wed,  5 Mar 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gMG2E3U6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2092.outbound.protection.outlook.com [40.92.40.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473B24BBE9;
	Wed,  5 Mar 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182203; cv=fail; b=L1bpINiDG9349oMWSsOb1eEsJScdB7AeAKg7xf4ia66HjykQh9xNVMIWDbQRAlC+WtssCTHDeuNO/9S7MyFnPpjcdCQ55kMaiHv4DfaDZB0ZvGN4qE8Fz9i54YD+lz4a3Qhqx1GbCaqj3LfT1TJ81nEvy9B9VTHonudWOf86PY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182203; c=relaxed/simple;
	bh=zLP1EIGivu/ODRkpp7p167ua3zBTcq9DJ+KC/DbSYN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4CKE0ZGDCTwQCRaCy9Hc7+AJzrzYowvRCG7gTe7PwR5qccjN6f06PGaELUgNM5O2jWq61YbtG9xX7VpytNiuHaKSdQr5kkHqfb8gf/KN6Vfgon+69WFO+UuE8nkEIxj6MWMUb7Fdl/mbc7Bb5x9m3I6tnOBd0cv64YMd5jkJKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gMG2E3U6; arc=fail smtp.client-ip=40.92.40.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYGHkk9M2OZ2y7jTtwL/qJFuSzsnZbpxUyDdGoo5H9SQd8km1m693Tape9ZmkQFL29H/ijL3qQf9o9AGw8Jom18ZL5qQbkzszYjNUvhmvmcvUaneXIWks5FGdzzVJ7Ba70aZqDBcP+2T4UPv13JfjKneLC3/Ug4/lHFtk1yzsuOBdBhyOazo3Uhs8N5ZUAZmvRe4dEgy2I8nNYZbv49iVVGMxjj/os/9LFM21ejdEDsjFQdOjklc/4eaa6dPMpOnjhoM32L0+mGw+/A8sDju5ril2iq8iLbXdnprjrLMH/U02qa4HR2WHH7zwub8KIqtIoQGInBihFuzcjm55mtgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+hphoyQhkef1H8wkjSEYNSZvzlwBDM+ZZzAIxJZMKs=;
 b=IV4JFs+4cf/myOQn8zoo4s2nmgI0V/eaCbJF8//PfqZwVnldyQZAGJH1NI2vPMc6PwJiW21x66d8xijU2MXYlErZr00fDmz0P/Kj8Xmvx3hGbhOKCQmBZMh5sHJ/tfIhyaHIwA0powBV12FtqQp64W9EUqcBd/xR9/1UvnHyqNnhzWqV0aazIozw8ej89sYYuVQj4Y+4WkCAbj+FZ50Qvvmecn80NGQg3nxkRlaBurwCAFepEHkaZAh8ONMd6++6bwMBIL9mchYC7ijZTpSxfnBs3XmvdgCCKrSa1JXjNc2R+Zl/w5gJcWCS0cpCQpqFCO0b95YPENpCARIdcd05+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+hphoyQhkef1H8wkjSEYNSZvzlwBDM+ZZzAIxJZMKs=;
 b=gMG2E3U6vXypAKRTuvzy/8IGTtVywl7d+NwyujZy+jyl97CemK3kY+NZl8xPIsUuVjP4AI4cC3v5+q4VjjdXKMEDUHpP2Nr0B/RNigJk6jAtOcLNgtM1z2dJSO5meEUhWNR7pOPOW5u2Hv6PgRTjNcN3HFSGlRmOVDSfz4Q3s4bUWK0FiJcN+wiHMW2967B759o/uPLpm9pJjLARDLLcsUxmE8EWsxwAhDzpvJTrjpzwMiZm2EQNaLokdFKporQhXWoktLEBgeaknjLB9XLSr0TY635AkHlaONUIb8WHHNwquZAcWDJGw7NwizDknF5dXDMee5UFI0T938mjDzJSjw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:20 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:20 +0000
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
Subject: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
Date: Wed,  5 Mar 2025 17:41:27 +0400
Message-ID:
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0103.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::8) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eeaa52-7c3c-4813-4f8e-08dd5bebb099
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwziBH0gOCrBi/NMxnMKpLXMliQMQeZHfsfXya/gNadYKqOs1f7QmffLJcw1?=
 =?us-ascii?Q?6RJSwoDIDbZUejwo4XMTWAJQtv/xt+cHDCLrznGrYNxv6CXSZMu1KOOdur1C?=
 =?us-ascii?Q?mlNBybySBCz//L08b7trCU/UP2Yesa4XDpkXjay5ucffApuDelUdQjoYbj6j?=
 =?us-ascii?Q?IjusygSenJ3IH168wZeXH75o0po0pUu7sOILUnTmMj3MUC7Sm2BuL6mxKnzm?=
 =?us-ascii?Q?Cnzxz3qoasPDEWx31q7Al4wHCIysIkqE8t4ZpekwcKSeicMAU5TdH+M7DGyd?=
 =?us-ascii?Q?E/hKDeZAQeCo8mzdQGnLi0LJ+lqYvN4P9IQBSJQWsLi2++NITwhEt5c9bYQs?=
 =?us-ascii?Q?uaAyy1ElLrJqMCkmmK0mzwEDX4Qt0+m5fBLsD6OH4/yVJWN0AXd/eP6TcEol?=
 =?us-ascii?Q?6ducGw9Y9gdwXFOvzmYJijmgO0yY4HwJAz9GWD8UoEZ7AFbQrUXD7rsJL0f9?=
 =?us-ascii?Q?tMj69Z5FMMarqZ4QXkFSbvK/fGgWAXcjjY3LdZE1JjFC+zJ8JoiIcB2VXDEt?=
 =?us-ascii?Q?OAv1m5SsAlBiUTRacaZowzsCfAVxSXNRpl/JQqUBsuiRuSlDHyMQfkCzAxMC?=
 =?us-ascii?Q?e6P92CarkNyc4YsOpuKRi8GA6kv4AklKzGEjTluPaeytiF3A2yhmAXgPhLe9?=
 =?us-ascii?Q?k4qdDJKHu1pyathm0zqWaXbBHsO1geE1j/ESnls96vWn/+2Dmz9HiBGPvOAY?=
 =?us-ascii?Q?bAKSAyvctECC3TRGT079v2dxgfc29jdk46g1zpkFN4zFJZiV9GuF1QceXPoN?=
 =?us-ascii?Q?5Nzr6XI3oFSj5zszGv0ndjR30rFJMd6oS9ghZ5Sy1zyGdjmpsb3y0M3Emu8q?=
 =?us-ascii?Q?4J3oEcDiCM5A10h6pIVEBkPE3txMcsBs+z4Q57izVHVjWFlrbHxtAYsDnwlC?=
 =?us-ascii?Q?N2ekzunrMkUmb7GNfRMIhziHfP5eIzFyHSOZaogVVEbdvOtCmdfpDKZfMes1?=
 =?us-ascii?Q?Jvlqj1WZGFPT8ZFIYi6OEHc60fr/8foROI59UTsv1GM6FYpnWShyqq5Ynqxi?=
 =?us-ascii?Q?nEJ30YUD8P6mdT94SGyQUg5mCnzXuc+fA5nkZwZ6Aeq73Gse3Url2++LtMwW?=
 =?us-ascii?Q?nJR/mgqU/XjOoC+uBMPgV8wDbyQ9cT3c1a8lx4nyQmT8/ybc9aE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYuGaUqKkDDxr2cXoiRjXXQ3qtKELhNpNGUBoNopG3oUYFcO2KPL+xleGreN?=
 =?us-ascii?Q?JCwsfho++gjOFcpvoLxC6PgiyCybu37HR1gt58rlaJcu/aWV9idHql5wInIa?=
 =?us-ascii?Q?CykvR9ffGuxZcP9EPegXy9K1+PmTBenuIjfQ00LvOil7Go32KDhCHrgDUoQv?=
 =?us-ascii?Q?+c1YYFocVX1XpiguoRUlJQWMFnMjEyCjb/MjP9e0DMyTrsDB0wPPE1Cp3l09?=
 =?us-ascii?Q?kv2DBWjfYF4jNH9DzsA0hzWCOFNuZRQ0RhcnCNx5h0H2cNGiVCL3SiyLA5nj?=
 =?us-ascii?Q?XRvg5I2xStWXS6Z5iAqIFr/O+ANdcBy9Fu4P3kmVM7ai2EtvuVTLMQljdzQa?=
 =?us-ascii?Q?2Exr6MQynIlsN6CHktKwnxEnUy4/UtvsKkTptjDrbkLHz1OsO5E6QSw//Uk2?=
 =?us-ascii?Q?fYmnZtVZEffs2HkzFmevSofk68Aux0TxCEEyYFXDPsVjToe8a1LxLWLv2kZ/?=
 =?us-ascii?Q?uFFFWeGIyiX9zdRfUv9YEt/0owD7tjk/siE9GST+fdPbRtYNFqtao1icVoWg?=
 =?us-ascii?Q?OkzXoT5dr+tRbU1PLLdoWo2Ob+9ZqCuYwxKgql+znDHCtqeAlyNI8q4A7zeq?=
 =?us-ascii?Q?FzF2ImnQMpqz3Y9cZZ+MojAetbkyYJyBX9M1MKIUdejTax5nNaqvMUoHn1Fa?=
 =?us-ascii?Q?yCw4zE5m6+ZOx0/usJ7LYRZLeqHRaycpfCSAU2sP1hvzfsNJrWbmD25kGbkR?=
 =?us-ascii?Q?ur+e/wnqRbcXisRQK7VcuzXrDC8LwJWSn4A+8eKD92APkBiyEBOnA9LatDt0?=
 =?us-ascii?Q?1D9OYtqnYt7GOj0eODRyCxhmWarXeGEgnaIpV2/p9VgaxvbvaZP5QLn1xIqO?=
 =?us-ascii?Q?9owKoK8oKExSN3kC+D5/m21nOXVRX4DA/3j3oJEhT5vhPj0YIcml/lQoml+u?=
 =?us-ascii?Q?7Biz6TXjhWD4Qjx8dlChCPsUcfAkMC4FnV8qBoVT8mO6noyVAaMpl7MNFdLC?=
 =?us-ascii?Q?fTeP/1Dp3A9cOoK1dNvgdkq7xh+c2XEQ9hzFve/LyCp93a97BckewevPxImN?=
 =?us-ascii?Q?UZED0Sp/Z/G6+ctGkL4/lgONtnsok6unmMTs/tZoXOOoxdeIksWiuaKDvf9V?=
 =?us-ascii?Q?i3jQYzkG8J6+ez6/Z1/6nop/CdnB1K0LP6ZDR691K+I5rDVKr7FNFpo7Vwfs?=
 =?us-ascii?Q?Id9VIIpU4L4EVKUYYQmHZ54B0tI4MhWep6L7/lbfx5PbqHDAGgbJIcfIDf9R?=
 =?us-ascii?Q?/T2PPu3AihkNkE9ok/PU42SAGpPsBOTEhIJesF9H2h2rFjSvdygsH2MTfloa?=
 =?us-ascii?Q?MOY+CiDRh+a7ku+EtcI7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eeaa52-7c3c-4813-4f8e-08dd5bebb099
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:20.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

The Qualcomm UNIPHY PCIe PHY 28LP is found on both IPQ5332 and IPQ5018.
Adding the PHY init sequence, pipe clock rate, and compatible for IPQ5018.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
index c8b2a3818880..324c0a5d658e 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
@@ -75,6 +75,40 @@ struct qcom_uniphy_pcie {
 
 #define phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
 
+static const struct qcom_uniphy_pcie_regs ipq5018_regs[] = {
+	{
+		.offset = SSCG_CTRL_REG_4,
+		.val = 0x1cb9,
+	}, {
+		.offset = SSCG_CTRL_REG_5,
+		.val = 0x023a,
+	}, {
+		.offset = SSCG_CTRL_REG_3,
+		.val = 0xd360,
+	}, {
+		.offset = SSCG_CTRL_REG_1,
+		.val = 0x1,
+	}, {
+		.offset = SSCG_CTRL_REG_2,
+		.val = 0xeb,
+	}, {
+		.offset = CDR_CTRL_REG_4,
+		.val = 0x3f9,
+	}, {
+		.offset = CDR_CTRL_REG_5,
+		.val = 0x1c9,
+	}, {
+		.offset = CDR_CTRL_REG_2,
+		.val = 0x419,
+	}, {
+		.offset = CDR_CTRL_REG_1,
+		.val = 0x200,
+	}, {
+		.offset = PCS_INTERNAL_CONTROL_2,
+		.val = 0xf101,
+	},
+};
+
 static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
 	{
 		.offset = PHY_CFG_PLLCFG,
@@ -88,6 +122,14 @@ static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
 	},
 };
 
+static const struct qcom_uniphy_pcie_data ipq5018_data = {
+	.lane_offset	= 0x800,
+	.phy_type	= PHY_TYPE_PCIE_GEN2,
+	.init_seq	= ipq5018_regs,
+	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+	.pipe_clk_rate	= 125 * MEGA,
+};
+
 static const struct qcom_uniphy_pcie_data ipq5332_data = {
 	.lane_offset	= 0x800,
 	.phy_type	= PHY_TYPE_PCIE_GEN3,
@@ -212,6 +254,9 @@ static inline int phy_pipe_clk_register(struct qcom_uniphy_pcie *phy, int id)
 
 static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
 	{
+		.compatible = "qcom,ipq5018-uniphy-pcie-phy",
+		.data = &ipq5018_data,
+	}, {
 		.compatible = "qcom,ipq5332-uniphy-pcie-phy",
 		.data = &ipq5332_data,
 	}, {
-- 
2.48.1



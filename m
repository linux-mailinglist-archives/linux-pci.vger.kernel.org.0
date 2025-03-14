Return-Path: <linux-pci+bounces-23703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ECFA6088F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1526C19C2853
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0FF14900B;
	Fri, 14 Mar 2025 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XyJt5B2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2065.outbound.protection.outlook.com [40.92.42.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1A1487D1;
	Fri, 14 Mar 2025 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931825; cv=fail; b=DTu4xUHLzyY1wU70UiJduIhCmB0SnQv1DOwkJCn6up2h3PR/CNsfE8Qaqg6eCNkrBTO+Y7OUWVW8cdR/IcqYQufFXH1LLp4czT6IS6d6K1Cpk0EJGZP5GjoPMR80YwIlhIs4k0sgXXNWssgQaDrBwAh5j6acQyEH4XJFq1DDazc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931825; c=relaxed/simple;
	bh=GWCOZ9rcNI1AJM9h62bURuAJSOOf4qg4mjUUYbeDA/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9ovEQTmkEKW+onZ+06RwLJerZQQy/uLluzwr9G7WsFPZbFXUQQ+KEqCIjy+NgKp+nFwWwfMe1pyI1E3kC8avrc4AhhqGyHDCbSuylQPcfhuffGJ4QNy1TOwypgGYmm6DUgzRa4+tBv6bIR8iYJs/oNji85g27+GqvffO346xUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XyJt5B2L; arc=fail smtp.client-ip=40.92.42.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8xT/T69DmyUCNdagxhwg3LObnWg1u3aw7O+++ZjKWWUZKeLfLPHP7TNDIFc4g2HMRYCBvMtBrhhKdH8KeaPrU8EQrxqK3pC5N5SCl71cFsFKOboyfhO+fhLps+Hmm18J0i/DPvfYbc+yCLo/fN4cyFLTu7BxNG3alcrvTS8tc0TtkcU6gNmyWiwKs2Xt+Rzyhpm7Q4QaKClEvZcmpdFpjO92WzPPGmFdvcqkQLv8s7c/sM3trYhDdupNmv/dqzCpfgszR416xz9E/fH+Rg7weAKOJiRPMztiMvzMKwJdPBIKWglzKr5W8lXAMj1gGsCKCKha7pAikWkLnY40d+ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rb4Fz2eLhjsOK8TaETEHiImaJpPwH1MFsiLK9uFQBY=;
 b=Z4ot7MksPvD34JlsyTlzqtb9eatsO0qFRGVq5/fqzj1zR2wGthP9M4/q4KGr1Y6Xpl9HVuPmHDxDC73YNx+Y9Q6uxqaG70PqzfNgigvSrWdMwF931Lc56ycmRf3Htuew8MGcGTy+fLgL2Imp3USnI/MmL2T1Mrsb+gx26fmEa4SODkM2d2sYx2SMLcQYsDkJnBPpGutMUFz15G07GCB7sHdQEWEqWkj1sOUKykP2jelrApix4uo0FsnYaY0zFatjMjecANLAnGkovyJEOpk5KSdNDLRuaArAQhclBhBROXw66+B1FsCVOkALDZZjqno6Nq3qyfidbEGSvapwMBdTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rb4Fz2eLhjsOK8TaETEHiImaJpPwH1MFsiLK9uFQBY=;
 b=XyJt5B2LS/xC+dLW3F97gRB1c37vro0bKQbDqaaJ8sXc+RwQ+F63Gk1EHDGOmQnyApgM4dnceX8rdXzGA2Ee7eyAhgVAqV4QiPLDRVWDzDFm9BLvd/sQPkrQYT+z7xw5lNzao1Rkq8kwwyv7zMtBjICNnXn4f+phfya0iT6WPxFnRdP0RPpIow7SuHpIs6VRfFQebddqgSCLeie974t8Zj+PCpXinAp7ydCySUBpvQCoZC3xgIf3zU3OvpeEerQqe0ljaMQuSZco97esf2Ex+Et6WacMl6jWU4Lk+a45sFWO+kIERX8gNoHb+ucS3BVC/nWftZzKq3ju2Gcga+UM+A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB7795.namprd19.prod.outlook.com (2603:10b6:806:300::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:57:01 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:57:01 +0000
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
Subject: [PATCH v4 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
Date: Fri, 14 Mar 2025 09:56:40 +0400
Message-ID:
 <DS7PR19MB88838E65D078157F28A110FD9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314055644.32705-1-george.moussalem@outlook.com>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055644.32705-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: efff2487-0ef0-46e0-a0db-08dd62bd09c0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|8060799006|19110799003|461199028|7092599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AD7Byy6fmkCgmEFwEU3PggeFp3EHVzzXY3CPMdRPkS2j+M9Zj6kkc6iYYpR?=
 =?us-ascii?Q?n6gcPHb70+tSQtW5GnUEZitKEmDRnfbxy8UY2/tnwuoqKwuvvGfpaf2JyopL?=
 =?us-ascii?Q?uyt/Ek/7xZAu1TUIU3nahG9fhnT7Sg8ETtoyLUnOSqSYujTbP/5ihJeBp0+U?=
 =?us-ascii?Q?Jlu8yl3X4E9VCFSq75QKinRYag7ju+/4X0QAPQZQb86uZ84S2GKddi6WYw8r?=
 =?us-ascii?Q?ykgl4beqQB6/9viMWiW+nXYNzZirnP0nlU+0UiibiMuCVcJloo+13JurKFRv?=
 =?us-ascii?Q?wkVim9QgS8uDrxEZu0wam9AAapd/giXUbfF/MIBgryS7RDI28tjDP8O5DGZf?=
 =?us-ascii?Q?hiWBAN1piep2il32SfSdz9wHCCeG1kCBT8fruFCrdAH6Sva3eyFPNEw3aWli?=
 =?us-ascii?Q?WI8Ujx54yQn9VGLWqiMvmkUxrlrCNTrMWDshdy8Fu1fSA310DLKyCMBcpFy4?=
 =?us-ascii?Q?QkX8uMN/g6s66WrIO5Td4QpXahMhw2nUPSAeGwTMT9so0NEWikHKVX9duT18?=
 =?us-ascii?Q?R+eNUTCjYTSq+66nye9sJhBxZTq7iTtOqmGtQUZx9pzwbe/SenGYlj/p3W1q?=
 =?us-ascii?Q?XQzw8sdxQ6rxq7+6mvoMEZ2fYmfOypKjiCtt12qbuliUzhwZqaAM2ujifH0V?=
 =?us-ascii?Q?sxNMzdNV9MIp2hPxcUTH6wfCg2koGVEPmonXPGasVf7sFzwp6FTdF/XkFhwi?=
 =?us-ascii?Q?inPqVmZJB5jO9cdlMmftMtsE/uwfM+cDgxDpo9Zte6hiquc6SPWTOZDey/ty?=
 =?us-ascii?Q?wMUkoz0gAGZknnGSrsV8JB98WZpNs4JIHaBMCeZN/tX5JNY5IaxvL1Hrxo3p?=
 =?us-ascii?Q?xN8Ib6C+OeashBZjXKq9fJyqCcTa8xHj29d6Tku+78PMDrwv3XSa2Drmmril?=
 =?us-ascii?Q?bhtNs2U4LCzoKrMjh4lzK97XJc8qSZIDsruhXtVlY67bqQ18oA9EdgXn2lU5?=
 =?us-ascii?Q?vMv/7ATjFIq1VOVZkcZKg5zWUTHcT6wDnj0FTkfxLWoKsyRIS9W9ghXBMPzd?=
 =?us-ascii?Q?38o3CfBM6t5xRjANKwy35oRtVuVJYr3CMhoR/2ffsNJpIEPkEdQy3jYPvBBn?=
 =?us-ascii?Q?1l1algQfSrVRMmv4h91M4ZonlqR+l+uFoJv5VnoDIonWO3gemak=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzEud1HrngZ1A/10K3ZKiDAJgW5pzAjoHgoDvK7+NmaRyOUukP7999gW2JuA?=
 =?us-ascii?Q?IW1zM+lLtWSltwOBEGFzhXQ8DHsBEt1DnxoX4VV/Rf2+E04CFpsq68Jn8gde?=
 =?us-ascii?Q?dGkT6gA11YX+yjoyuzVQsIKW775rJ5e5lmRRixBk+fJ+b37jMPDYkML9kONq?=
 =?us-ascii?Q?KdTB5IhPBxApShwtTIuOsJyajlldY24aTOTbfG7Z9xYn2ex5xfqyRb0wdPz2?=
 =?us-ascii?Q?X5tgtDyG9+fqmM1KhSjVihdpMEoQ2viT6BPu+ugJ3Z7igTmqrVg/Y7TvzaA9?=
 =?us-ascii?Q?r1RrxtiU0r7g3m+heU6jFTsJgkNNteNQZ/m5/JAIt0gUtnVHfXzqbkRVABoZ?=
 =?us-ascii?Q?a+JcVtDjHw54T5G+ANOkk4sXiyHigbP4UOPutAHR27ms1hkNhsG5BSfvuN5S?=
 =?us-ascii?Q?ZD5pkZuVzle9hXl84KjVEaBVBC4UKjoIAGHAe+CCaxn2afLUt7bfiYSTaCEq?=
 =?us-ascii?Q?o9mfURhCNpo13yStE2Swt6V73m91aezrNdRtWFp0VQJGNMgQyxo1u1PqNEZy?=
 =?us-ascii?Q?z/7LboX3KDCm3bn7KmtdwZ/fUV7Km2jkPujmVwQRGliE+UV4mprRZFvfQyZf?=
 =?us-ascii?Q?upExa4pGnVMqLNx7hk+pEzWs45ydcdUHMHXNGF30ajZA6gqDukd+iQLxiFx6?=
 =?us-ascii?Q?gWzV7pD+QFgfVs7eHou5CHj4jxcRKSo7dRiRiOqfZiEBXJuYy8dcZ1NeO8pE?=
 =?us-ascii?Q?/5Wc2nXNPdAhuQ6iWu4dGBmsY15DuNPSI4TFTynCAdaepsU48eVqc7xj8io4?=
 =?us-ascii?Q?Kv8BYfXORbWK+xA1KlJETvjPZKxjcC0DdF6+wYUwg/SmqNeIkfAOhEkp92Yo?=
 =?us-ascii?Q?8xrl00g071gNf1Y5dGfZAuYCcn4sVLkWAkeD+TgrF73bd0pF7pNq+N/ZVFTe?=
 =?us-ascii?Q?xBK138wKsV0nmi7XLt8oOtXYJQ7iyHCs/n8CS8IykHAbiTct3txDOcRoHdmc?=
 =?us-ascii?Q?5UbjJplRhZyYcWCGPGLOViV+9G1mC2x+lke6JUizxAXWsaGxduQYNdAE24jX?=
 =?us-ascii?Q?g14ScuQnUG/ScSLtg69gvdfRjUdq6+6QJQSEfXk5jsucIFsRC2umu26IZr9A?=
 =?us-ascii?Q?MjxgNHYi+PzTomF+9MuQvKbNmyTI7Ue688fcM+e7N8WaGmTkClvoIaYFqypN?=
 =?us-ascii?Q?N6S3N04mHrgYsnXF4AD+h2xW66YtvqzD5WnyIzeaiVHtMurwPXAHgwx54Yci?=
 =?us-ascii?Q?qdobiwl6er9096i9LaRTv2mRDqCGHtavveVCkW6KIQ0DO11VtPYiWdl5kOFU?=
 =?us-ascii?Q?Sf5YMS+Si3SlM5V5wYEG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efff2487-0ef0-46e0-a0db-08dd62bd09c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:57:01.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7795

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



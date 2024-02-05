Return-Path: <linux-pci+bounces-3105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94984A0FB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DB81F22F68
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09447F78;
	Mon,  5 Feb 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qWV4//gQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FE4F5EC;
	Mon,  5 Feb 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154499; cv=fail; b=JBTFTWzaCAT0QL/zKApUTomlGO8z0Fv7C/+wdPkjjEcfbXuA7bvvlqKV1pLby6hZfkmJ5kGTHLLvFhtXyfY+V+PdvZAECK93q1bWmtqWvxp2iv8tnYYx145UGTjoBjZS8stnmNGO8lnU3rQLBg5DZLXMjIFiz0mPRFc5eKVN/HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154499; c=relaxed/simple;
	bh=U4fPGuaonwc1q7SR6fyoX+BCgidWsaHkqGMyrk+5UTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xflw6Zd9FQq9MMNZiKGZPfKyFoFjmLtLWrMwz7vor1YkRej2rwN++dVKale412pKIN2mZCsQE1Sabt4eivMJMs8F34QAy8+MT8c7tcUdd6Jvc6JEEcA9lF2PDl5cUChd21gJLONMRkm22Sibj7oKjUKQyomeG8waHxquA06DRUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qWV4//gQ; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcaT2C8xBYTUJoaX4pwxyEtw7bYMA76ifnzSRYaQGfWq9ihMMOjOaZ3OvX44Zs00cNoEXjKgW6hy+o7LZXYd3pTZ2mJuMhw7lGIYFED/jOyk0UntxRFIaA0t1M58qcBaJAaE+GSETIOO/p2Rh0ur3gmRZTzk/z7VLPLVP7WdckVrhlYdd5GPS7HjjtHgx6omvVhoZ6gR6YXdi+i6bcJIo3c8VV+8Bu7RnsW+yhFaKDseSqikyXmv3KPSZ0hxQ1OdjX7yg1H+CcJByqaKthbFhWqb05NZ5DB7CllEj6e9EfpY6tUq4NedeSOfvWH4gWPMplM6yxLjmSF4wZzN3twprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kModxHT6HUPysSsRhFfDdSKhswX7YjVQuobBIlS9jWo=;
 b=oX13sNc50kNMbeNlW4h33Fsgei29NgPj6xr8pPgNnDJPJWN46LfEEcZ6y68wq3qFM/if5fZzNRp4Nwv+06fiaYMahQm2hKwFVKnwY9PRfsgd6T0GWNjS3TK9ELghPtf2EpIcDbSVN3MQYn5dZs42Xd0INSjZdwDTt+OVMk/ygtnVlwaNGDEWXV5X3Wz1uE5SsGObhv8aGhv5Fg8eGRr7jFq+nbGBKtpUX7WeK/3jWGYaAb5Pqjcqq8OGUOBCVCAAN2ltA9XSkVXjloG2wbS4cwuDStU4C0sxx1eQFXAIu8uDPiLI+RUrgmY0k1PmrtdAVmQpCfg1AIaQb3XT5yt/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kModxHT6HUPysSsRhFfDdSKhswX7YjVQuobBIlS9jWo=;
 b=qWV4//gQ2R8kPP6fqmM+R6TneVPvTWAdNx1/oTMKnocyAz/bebzO79g2R+0Q7jJOR2vTx0xU3jjBgduKekkKvZigApoWAiFRs3idFR9vhfvGZWIu9+eGAoqsIbvwrxzGECXQBLWNHR+qv8L01zFwFy+bj0pFJKL+Vsvj1wRrOpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 12/14] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Mon,  5 Feb 2024 12:33:33 -0500
Message-Id: <20240205173335.1120469-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fc01c6-6955-42ee-ec4e-08dc2670c3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TchHlhabAAu9zH7PnD0P4p5GWGv0HDvY2/2EIJ2XFmz3nxtxnW6Rbk3KWzpsrNcMw+fOkPqX9P5oxOqZlmpiZxkMwPeI3ueWCdD22vdkC36PcLGo3gELr53XSzM/b6Hcx+hRgHMW1wP3loLK5IPC7oDDHgGtISogOtrMSxYnQf0QdNR1zzW34hGvmpWnNAjqA8P3JWxWSLHZ6qnn9CHynfsOUJpI/i1oPHCZf3YQfbOF/ZowPEZlSDoSvs4uWoizfs2KcZ8ff5V134Xln2rUWccwPPoO2L0qQoSobBDiqCZyTXmBt1LccNe/qClnI1KOR9/EskRKAeSD/jmVdnhEgr+hrbUsk0tgYsrtHJAZNmz/yVHsb3BBMeHFz58CwjwNWA0A8wR2+bc2L/nMvxa5IVWaiXj4/DIyBtup4kxuJmf0EHLI37RgbhA6Sx17iSdTSWVuuS/f8Xp8mAGCP1wNNuDlprOPmpyjmaRsWd8mfx5yNjnMolDGLhnl9sfyDYooKYW+GysCn5dNaB7jx4yQSfRZdIhJOyTkkWWwWCvtCKtOpJu5McCwWcxCZ9f8QzJFOHmrXzIYWmyCFTUtliTEbELewa4iJOkW/7mhR1BPvdHXNmmc3nUn/SR2UairI4Xc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(38100700002)(41300700001)(1076003)(2616005)(66946007)(478600001)(6666004)(6512007)(52116002)(6506007)(66476007)(2906002)(6486002)(4326008)(8936002)(6916009)(316002)(26005)(66556008)(7416002)(86362001)(5660300002)(83380400001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMvWXUT0GDA9wAyQBUYphxFTwT1e2UANsDqWHRNpD02sBFXTuzUsv9hDqNXJ?=
 =?us-ascii?Q?rQHVBwWHTvx7gb9t8+B77bPLcxisuZjEwNvJyCU+rgBuhqYDB/Kq0ThtlB21?=
 =?us-ascii?Q?3oMFOuPidf9T+a/h7KQ9uq7y2uKXDiAjtKhC82oDc70GcYXFPMWdHjh8s1EA?=
 =?us-ascii?Q?sk6tR9f4GaW0wKZ3s+N9qiyMN9elST1xpF9516Ta6Vl818xhqYe0R80cySDz?=
 =?us-ascii?Q?Wlqu9jlCLArTZp59uPQEvVjs3Rqpw7GnUWT24Aqp51iplMUsv+Vy8DWl1P0P?=
 =?us-ascii?Q?NozD/bvcyPzVYwz0fBiBL+ZEyk1d7hbQIAMfItp4OXOw0IqbpdSFkcTERMkv?=
 =?us-ascii?Q?VZ0tdFVNjYdaNj2vYyRtGBiqzMY8ai3am6BOxFH3Ssv5Mh1wnJmZGmYiZiFb?=
 =?us-ascii?Q?Grt54hMv8ilftrQvHqF2JbOgDX0xq4StpIbDM+6lGZY25FJNsLL3FiVHKup2?=
 =?us-ascii?Q?bOoMU3Rcteo2eJ+x0K2jE6clWH3VtGPCrozmU0zuYZAU4skmQS0kJ6TJ0ZRE?=
 =?us-ascii?Q?hrhhmpujVwLBSIhRdBQ6SkF6R/noiNTx2kjBPZ0mnwpEV+mpSiGdXa28v7ee?=
 =?us-ascii?Q?0R25QmV4pX1O1SZ7Ru0Z0Grvg43qaw24PVH2Nq87XDvnfgwihQJfbNw0X6Eq?=
 =?us-ascii?Q?Kn3KEfCe6zTnAzASG+xmOdqTY9fAGEdBvYu8rNj00IC0sNWRQNMfr3PUnIQN?=
 =?us-ascii?Q?Y7OqIOz0VS0OnuONpuBQ4B1VZMn8afPoltQmLKDVHS1w1rbRn1J99o6C1Kj+?=
 =?us-ascii?Q?zJWFJd7sF045L9GCFYKZshXIB8Ln9r+twDAxjADxACw0wxrpp1BjMGVDiQmf?=
 =?us-ascii?Q?ybgEe13WUOl1gSdd1W8hgcBIuej9cMxulQrd50S3YUPMRyYQLxIbh92zawnw?=
 =?us-ascii?Q?ts2FXoZO82qzPrmMkuSce2ksmeEJoQ+RRkCOUltMbVZYjbOa9j9JpKJtcX8j?=
 =?us-ascii?Q?3XB7O8xdJw1isFTh9+295Rg3xk/5kEIZEu0N8R6uIOaBH3RpQ+gZAsplA0i4?=
 =?us-ascii?Q?FtuLc46ilp3ozjxIXIZnwc0Atsy1Ev6btcsTnXpuU77C+H3x6aQAZYw59DDU?=
 =?us-ascii?Q?c+ZpIR5eFUXAVIfbrL/UVR7TSyNbZHK+jj1iprfcIPj3MsfIAvFP9uf1VPJh?=
 =?us-ascii?Q?QV51pMJYPxrO865+okUapgXKWthzaiFz/RAb90GY48qnGRfHUN4e8dcnNlqW?=
 =?us-ascii?Q?nWpikIQ6OcsQaeDy9c3HsGA8NWuvyQ5JvGm5LdF9vC/oFVbqcyLz3EFoS1yy?=
 =?us-ascii?Q?yaCzyyqoZvx2zWPp8jsi262z0axpsEvW7nnfZX/++J9OzTG0tbsIPejmS3B9?=
 =?us-ascii?Q?sR28anGmpGVSTY3oI/T5v29i1+ol4MkpijQ6i3imKMPGHf9O6FKdffzcBoBc?=
 =?us-ascii?Q?Mvp2GYTapIkfaMhDfT9ia6GQBobiPjFSOGQXQKRnPdxgD3MR0C4mBX4e4l0h?=
 =?us-ascii?Q?O+qIvNYe+khKSGol9sZVtKyAhKMYy7KpBmscMUAEEMVmgadDhAz+1Y+6Cu7L?=
 =?us-ascii?Q?6joLw7vL0GTyDNbqyCSFH8Q1xt3exXApv29Fs5D98iSO9eJ3l63j4CPDGoLC?=
 =?us-ascii?Q?FR+zN/DsmBNg5Q0n/Z22/WbYgLuV+gNtUvW02ABX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fc01c6-6955-42ee-ec4e-08dc2670c3bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:54.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNECFfGCcGwYCKze7vv2BIqPOae+8gmAS0F2hqQ3NJS9/T6NYoO3YnKqTqa34UP5jvzaLqN7lVY00n/s/RN3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Added  Manivannan Sadhasivam's review tag
    Change from v6 to v7
    - none
    Change from v5 to v6
    - add missed maxitems.
    - add comments about reuse linux,pci-domain as controller id.
    linux,pci-domain have not defined at PCI endpoint side.
    
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9cc6802e93641..c2098e59fde1e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -105,6 +105,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1052,7 +1053,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &imx8m_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	return imx6_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
@@ -1532,6 +1536,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1543,6 +1548,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1553,6 +1559,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1



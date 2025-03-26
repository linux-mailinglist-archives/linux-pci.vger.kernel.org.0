Return-Path: <linux-pci+bounces-24735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90135A711E9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E537E1734B7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508721A238A;
	Wed, 26 Mar 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mDKHoKA4"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DB1A3172;
	Wed, 26 Mar 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976051; cv=fail; b=SbhRWYUWQPBgpvzDoLMf0IQLt45NoCxHVGsxXcl9fK1V//vuRbR164mLxp5kReSEPAjvrSm+SuQtjLXxtC47Kl62/7kyvW1tKmFDhATdaVNEZgqEo+mZURmP2k4e7t5g8fD1hWH5RmU+Jo1g3fgQsIt0ycrw3djOQEYL4KcYT+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976051; c=relaxed/simple;
	bh=KkAvKpRx04Fwhy1nAD6QnmSxegrk24Nz7IuvZTLyrDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tb/dN15m72FHsi1DeaRZVS3X8DeD9+KC3QTyXHSHDNKwVxtWEzG2yqnMEqaVf+1Zajsa9gU3ST2kSUBgG/EImoNJKrZQu8qQFKiGNqvbodFWfk5jZxTxbllyX6inNNgqBQUVtxoS6X+SuF8fdTPYS9u+qirvsXyipFX5Wf3Ew/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mDKHoKA4; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxXQd5MV/+GqKxC3k/tILfHArkGJORjSCpIkFxci6yiMEI+wDuVZrFC+wFT4UkiHFSt0QJdtWn6s/I9ft5CZOXuLX4a9ef9RLWZToYeefcfgAlsZF6oq9p4vdxtg8581p8XpljOwr23uhxqT5wL7LgPWGkLs2sJLxX4wM+fPq0C06bU6wKdExExcxrO1gWa2R1/Rf2CH2wev26rh0G6Eu4BtPybWEgSY8AKQVBlQb8l0xmhffNslhly3gVpp7Xa1qJnIaPkmB3UZxW7fS1zUMQbO8xcvsqiIjkvOZFn/duhmbnfMz2QnjRFhp3A/zteKZjekJtaSs+2p9wgdZNCA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOEIwg7INvyRztMhsQOiqa0ncWqXo6oUqnagiAMoxQ4=;
 b=CQyMZVNTSPWITeJIOJZi+jjc5pD9OcyDTVeAE5yNDYX1Ns8T74qJMSyqHorQTUuonGAK9ICrvMwhuxMMN37Km8x8Bap8Wk1Y1KgO6L50bd9y50oMpcASlsBhgrTmVBT508ADdzW4AC4nndxi88aVLSyl0EYPswMB6tlDCjnu5QLqwPXiiPW6TYoo8wZPYYe6tw4gkOG6fZk9Gwjh7UBODOiliPxz1z6g1UWpG4674aMCu4T0pcCEvNwo2CbQYbU89LhW3uZn0hiG6b43r0WAOUnGKIIZq0Az4IEGIdA30nePbgPD65jBPt4zpqQDVSC+9FaEr6lsKGbjxd47PbHXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOEIwg7INvyRztMhsQOiqa0ncWqXo6oUqnagiAMoxQ4=;
 b=mDKHoKA4kJyl5yAe/uSBlaU6mzb5OJmpjv6BfzcpM+HWZiLiYR8FvwUhbD0WkJKyEGI5XJ3a9g+np/Kd/s1TC+tblyKOnhvFQ0mw1MixJNt2gzJ7gJdGR2TkwdDXYTKOm8NQMZa34IM9mvUgrkEdZKDa7jM9iyLuG5mWC0uNIMJhDR6h8RVB4zt7qe64x+mFlfh85mx0ZwCQs04ravJg6Rth1Er+Zj89NV9Tjzpp+UGNWdaHowS71E5R+e2FCJcPYPaqR2gp58/+6g/X1rdsRQovs34U0DMOSGTdf5fk6y88fcHutEnFlhGDFOk89ygFR0R1k3qcg4QjGWFiTHjvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:00:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:00:46 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Wed, 26 Mar 2025 15:59:12 +0800
Message-Id: <20250326075915.4073725-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d556d6c-8f4c-4de9-412e-08dd6c3c50cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfryXl3TMyrKlUb4eWXyz+CPBQlEJGEoQxIUhx3ohZW5H8rehjxMNkrFDoas?=
 =?us-ascii?Q?XoCMr/g6d5BhiD5c+K29wo5Of93GKofs637XIxMH3g4ADIMl6OaaHTpP5h6w?=
 =?us-ascii?Q?/YBvPddVkkj08woihBivHW4+H9QPzRcPtx4Kee44YQDQqtlodze6mkvVbNL1?=
 =?us-ascii?Q?V9y2XVJ3uOwfIB9yhpjEf68ex7KSg6CZPpqZIsgUReZB6XWBhda3wwzaa6Sc?=
 =?us-ascii?Q?tKafOi6dz4ZH+AuOACcu6W2FHUmDVa7rtG9D/s4OPVyVTcCNnKnyMTrAkLCy?=
 =?us-ascii?Q?9XcyeYpsbJhwg/WRmJn1nQyFG6K6t+4jmOIuj9AY9G/2gzmdtfV/N3XzcNm5?=
 =?us-ascii?Q?AH3N5qk440jXXVzALARCXF32m+tDM1iA6WeBZiML1Zfg/rMUrYNOsnTjEIe+?=
 =?us-ascii?Q?j/w0lLjfVB6yk4hqdv+bnXy32UMsdlQquJKqHEFsT4kJfCAaJx4lpjfdFfQM?=
 =?us-ascii?Q?OHfXrBS1A+QFDCfWgBQWADfIOf+xkpnHjS3Q2kBAfUA4F/4Geili6w6nAfFA?=
 =?us-ascii?Q?2edoYmWWFKaVAHPTFVUSkYhPq6IE9XjC3FUQ4gskf69KBGcR+pFZuT41ctYh?=
 =?us-ascii?Q?BHLYu+Q9becvGb9gqVRXi8aVX+4qscNrMnzqs1FCsy3LauoMTzkMVCVI32Bj?=
 =?us-ascii?Q?n1kFliYGPa4seyoarqZvVy7LMCD8QVvNuy27tdl4cp+NA+lhlWxk3/Pbce8P?=
 =?us-ascii?Q?CY5/mE2nYjkezp4piCpfAlnYRFDnR3zOSFZPYiv/cBtfHl1JCKsm156lcu2+?=
 =?us-ascii?Q?659pVJ8zWM53eaZQyufTuLCKGFqBYxeCKXNOEo71eYuqdXr3R4TAj5tRbsiP?=
 =?us-ascii?Q?nWDfAJs1JJgWm5NJPWc/9lSxcm838Ztg+6BFIrF1o0HTIuiYDLdVU8fKLgfC?=
 =?us-ascii?Q?b14Ofxo/p3EVC3f97cV3FuimiU7pD0OjYwbBKmUfumZCOSZvn2UGv/jSXLIW?=
 =?us-ascii?Q?fCbcjnqAMd5IRXVt/FFIVh94MDrcuZEAD0vpGn4jUqxJCCFFVxTXmW+mTq3x?=
 =?us-ascii?Q?35cMy3vm0FGKMwEDQZVRUji71r3vNVFG/2TkqknydN9bQsa7CPTXlTTBeu07?=
 =?us-ascii?Q?JYEFVvVcCrl31N5N8E4HXFXXJwjP186zAH6gPPXYMoeoWaW5Glsb3A79UDvY?=
 =?us-ascii?Q?/wuIhcS4NuW4Us4BRL1CCF+1BVqliuaaeUowLjGUXHMfLd7IOh5T9ll15FL7?=
 =?us-ascii?Q?lH92i8+r5ZPV9s7Z4hotT/oLnqCHQeCeFwwKJnyRFEr57uZfUua/SpWFtrG2?=
 =?us-ascii?Q?E/0Srzr9SELChiEJVqQVQr+SyN8P881sA37KGzUoqoYVWzfCA2iKXOAMJ3DF?=
 =?us-ascii?Q?avQPUkNxCXd1wtwpVua6oxBzQKYqj+ogL/uUJOac5w39fwbv0yyN+nK1zWpa?=
 =?us-ascii?Q?BY7lOwSC74W9l4Z5zOZukl/3vDyz09OgNunHGExoUGO4OgRbq8mumwBeKnHs?=
 =?us-ascii?Q?t1Dr8p7C+2bbvC7J4TgwMk6wn9HmFQotEl0NIjMRSmlQ67M3jArGFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hp4hVEO75gr7dzSAsYCofSlkoh/HaBMapb7M9LLe4ZcvrlG5yO1waicTTT5k?=
 =?us-ascii?Q?eDCVBdkG0bWCAx4evSjB16TOkYiBefCFMQJhHFETR0cVu4i6SeZaDh92xVch?=
 =?us-ascii?Q?UlWYHD0ersL3NMO98h8XT6BZ7ec771Qwg/YIQCTAgMexrg6D5vY/ACN8T3R/?=
 =?us-ascii?Q?R4s6uEjMR7ZnWEnssCJi8305jiohI3Ot2i34mNhfKBtkeq8/N0bnhkrkYOm6?=
 =?us-ascii?Q?DnNZ4kbAaynIcGXNW2LnwfXmAVKB4xOdK7dhOayQ9gTu/wdvXyW6Iwt91Nai?=
 =?us-ascii?Q?I5K2GyJjDWBLOKYl9ukchtggASGV2YQeDgcE5Fp+Ngf6S0v91r8WBpmtrbD1?=
 =?us-ascii?Q?zUAzBSI4Yn5496YmvS4f7Tre0qwv/s6X6gThFGNYNbAaRglyX5N2k7PBZimR?=
 =?us-ascii?Q?G112IBpvlvQWyJBcR+K/h3i54RL8wPNORLRqTdNC5+UGwUSw9lOxSMuQFBf7?=
 =?us-ascii?Q?acvqXwaQhDaMMJjXRC54XmKpL4PwNm0GwrFUdpbFCqklHj75SbwVtbrzhiPH?=
 =?us-ascii?Q?A2YCdYKhiEZYX2CIJ+64tlf2/OLCQq5A9rUUWAHSM5z8qIfO3Iw1rC5oe6/t?=
 =?us-ascii?Q?CH8RQIG4vvfzYl/L+wiuC2Sfr31VVNkO49wsG/gqpzhmeu7FEB/Z6EpbeOpR?=
 =?us-ascii?Q?0gbmL4B/IB9dFKHkRTrL2sOQ+0NN3ffobuVKwa02udl61Sv19+REEC2Te44A?=
 =?us-ascii?Q?Jby0YumE6tOFDx5GVAbyqzAtZYKr6+zt/ujEVgNbyhdlzgQ3BuFKBBJ0+hoo?=
 =?us-ascii?Q?183Sjegx1ZJBJTRrtM8TwERDg3MqQ9zzBXLX9Mq6FgJbVVmJi8DoiJh9pQ7p?=
 =?us-ascii?Q?dj54dVDEKVNunnsMRRK6n2T5k/cIU0VVkgm9Fy3lDS6zYS5tCWYMqH77GjAn?=
 =?us-ascii?Q?fNzHqQseYRSbuf5kLYMGmlP9BbCYjOSSHucnf3cFasO3ITRtBaAYgc6/mJ6w?=
 =?us-ascii?Q?Vebd9p5h13QnmTOmMagZCvX+0shQwFpjv7cZ51KdwKKyrQLk6dr45fObTJoy?=
 =?us-ascii?Q?h5FDcgEc8tr8vcO8MLEePEaZQvfKdrHUf1H/LD8u1ihG76JsuqwysVMRSsD3?=
 =?us-ascii?Q?KRyef4IuoHzDmP3WCTkzopRwfTMBUf30S/CrT06A5Hmo1Pj04Pqwv59yWQw1?=
 =?us-ascii?Q?68lvVFchZ0Fi9loWuGz+vvw4QOUUEvsRPVAhT63U4xyL9PgodBepdyrtHzi7?=
 =?us-ascii?Q?FbTH1EwaApj458gR+VgfpBX25COxRZeS812foiYHNzobltQBW43sHdC7pf+2?=
 =?us-ascii?Q?4RuScLcaKtY6E4q7BQ9cENEtns3L3e3TEfIPf2Xa0KNWU8lrPWMyJMy9ErGl?=
 =?us-ascii?Q?PksKlqVPwl5nwG/RQZGutZMhDwku15BW4eX0x1EL5ZFC1TdZgZVV78dbZwya?=
 =?us-ascii?Q?oYy7X/lD7yg4nqkKpil7zav8m/8BrpGlN4j7zzKMdPJ3qeTntLjLICfuXUjr?=
 =?us-ascii?Q?O9BAEuhOo2nIikjOG2h9XNDdZxq0XRotiWqLS0BHFdEM+ap/xnWnLBxX0bQV?=
 =?us-ascii?Q?+dv9qKWiAZqvbrrmVTeOvkAPrMtVQICZlq3ZX98FtSTi0AK6U9/gkE4VsCUw?=
 =?us-ascii?Q?MgtNNdxU7/oD7YouAEgIj4PETLZvS/maWrvLi79V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d556d6c-8f4c-4de9-412e-08dd6c3c50cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:00:46.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd0se8B9MovpIsgcJXiy7av+lZFBx8RTzPWpD/QaixRnKXGKWHRGiH7ZTBDaUq9DfTRpi7UystVxiUfkIlcGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 13e53311cc0e..fbab5a4621aa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1



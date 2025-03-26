Return-Path: <linux-pci+bounces-24736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2CA711DC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37617A4BE9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7EC1A0BD0;
	Wed, 26 Mar 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bqRWkRCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013009.outbound.protection.outlook.com [52.101.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE101A2645;
	Wed, 26 Mar 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976056; cv=fail; b=BZorzPBjQkbLP7YvihdoKJeuAE2sqGuut78lmaG463NIxcQqMd5daVKGWQnxo4bYsWW9ME6LDZ41tg+/386U0w7zIoA8t9t6MnuZ01eXsq64e9FlbSH8+TggRtsKa2Xby1Hbw28cE+jn+IDuK3Pi3uKtnCAMvtPPqZmhfhl0wnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976056; c=relaxed/simple;
	bh=ugp4iFwRoR65G1JtWKRe7g/oXdlIVn1lxp29MtFdNso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9WI8J4EHY/SmE9/BFAigQV9+vZzZxbNLuxKqoOGA3SOo8GbNJOM8kxxFAMwJUD25/t9eCWqq8WzeqbheFGafc4TZmWQrhA3AyglCT+ba32vc3r5upswjW+il4H48BtYl4EHFz9y8jV+kd36NxPgaT/kpy0ERP5YXSB/SH4HTms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bqRWkRCr; arc=fail smtp.client-ip=52.101.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHZSCin8ej8xOD6/XSHM5/e/lXHWNlUT4I7Xd6i6or4a41YHdXr6fU7Zo6SLZgitDv/P+uK5ouSYqUyCT2TkDn20oRreTht5LajRSJfwFwQXt8WTg+cSaAvFKLTg5IhA7cJ4c3txHfpgJhqxja0+Eg9O27IundfvtEStj4c6KYQmlwFLABYe2RgDyectfFgUnE/dsyXDdyseToTitPlmAb+GJJtwMNwMiPQpx8DA9cKBYNn2dcdNRTLU/Txtm7PgvrEIUu+Q4OdFCvbNxnZ4q1SMX6GbU1TG/xozDTkbm4jNcCi4qT0YhzFssXOEplyr4EOJBMnpQL5wwZV9v+bz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlgxNsObpDiEWZ+wlblsAe3qlMrdX+CyJfWuSHKWzEo=;
 b=O+6K6mWZQqRol3ZI5DW6utdncfVBixc53N4GHGdxO11EMqoPUGmvc9eUX4QD5NF3url+tLmw2SAUXEfprHDryKFsyaA3NhKhR01k8C4zYJxPO1S1J8bCrY3h3Wh1nc2t900i+wwmfQJNLED5INBGdWC0lLM0cwDcnZaEL50CKsa6F7xf6FTXePkX+peQzboFndxLPlru4MiI8I8GyQKJ56mSYsFnoLneQOUxQtvRha+cK8tH9GqnX2eLuWKUFeTrV74TBSApPK2NYl/MY3nbOyqwvulHywZLn3xozufd/M+Mg1bWClVNB+EJu6v/HIiar+ukY55YhJYbUhhp+IbK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlgxNsObpDiEWZ+wlblsAe3qlMrdX+CyJfWuSHKWzEo=;
 b=bqRWkRCrUWUokGe4b6O88dUxaUFQJgHgXbq4lKNNpVXHk6ZWhVggJDBZ7qPMtlazV0MKbXm3KeQJgwb5GNOzMwGtfEsehLjDj6j4zL9QvqfU9OFeAyF4TRvRHiQYn8o6FZJhuGQA+Dm8slX6Aq2wHtHMFdGfkLxFYyH3wDkaQ5tBU4y9NqAqgiOU1vwuZvE3oxhJnrv453G6ooxGHZjmPJ1HtPDR5pEB4KumI0726D/5utBDg7Cq2m9EDf+bftnUc7PorFF8BkUgcWxFd6tNMTTeK8DcAT0shyXQkGM5v7GAGzmIA8oTjqNE+VzEYQF0hxzF9Hs72A4mJ6htwlLWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:00:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:00:51 +0000
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
Subject: [PATCH v2 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Wed, 26 Mar 2025 15:59:13 +0800
Message-Id: <20250326075915.4073725-5-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59302409-e97b-40f6-eea3-08dd6c3c53ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqGh0qzB0kNqjSrunPUAkN9YhZjG7TlDTr3q4C5IlmnrbVYRDGJl9FnV7bpm?=
 =?us-ascii?Q?4W3qvFZ8ZcjEzeVBBuqAKkgt7QZnU3ZCm9BsCSrMTTtE8wAUqxvirfRcw9OB?=
 =?us-ascii?Q?PSvPgxDO6BcgvDlZIqoEUfNgSkhpNSpyQ4PZbSKm+WZxKio7ZuOdhUr2C7zT?=
 =?us-ascii?Q?8ZsH4Fo6MM+QCAGBJBDAdsAY1McgxFfXyoT+x98ioa5gtJbkKoCWdTU21bIP?=
 =?us-ascii?Q?wuG3rbFU9yunNqjqyJNwegn7U5FhQJs97ZQGpsv2II3L3Z0layhhNeS5M6/x?=
 =?us-ascii?Q?VYlJbg6pJzAJOSyZZdkoZRxU9GIS9ecI4aW87nRswCrRPInIYEMd1VkECkEY?=
 =?us-ascii?Q?Bv9rP8QMUPMJvuMwHZBHS9GCOwJsiLrzzOdQ+hDBdlP/xyrcCbF+2h+oIuXs?=
 =?us-ascii?Q?YAFbDWcFOemJn4IyPoTaN/Gge6JW0sysM0b7+eAoT18rizvtaL0vMrTwJSUA?=
 =?us-ascii?Q?o0VUKufii0Pr5vdTRnMTFK9LNyCQflrSCgF5F2PA8U3Dpnn+qiwIyEt9Mm2R?=
 =?us-ascii?Q?P4YKLA20KGTdwREBKls/BcHOKQxkfcMFehVszJMZeZGDT/G8wSzk5ZCylBiJ?=
 =?us-ascii?Q?ANOxpxbsOASDAniFw18a8ck/miHy2JxQDrid9YpxXxITzGkkW9rxzEEXllUM?=
 =?us-ascii?Q?7vpXvZsvotcyL5YbniwJSgk2ejpZcHur7PXVE334ZSfDwptq603GEynxAcBf?=
 =?us-ascii?Q?gmsUuXowZkWA2OzZ7BkmQvq3J0rjxaNeo2emxDLgMIhoutf1wpTJ0SoWJE8J?=
 =?us-ascii?Q?02QkcIvqMevBVzsAG2txpSA+yEKryQ6oD8SwT4O9XLFtDGDy9HccbGuiyK31?=
 =?us-ascii?Q?GtdhE6kS7fGJkoJG+w2/dSuKCi1y1H2o6/N84bEqrupp5+DkNE7qZEO2jV8V?=
 =?us-ascii?Q?qVKp9X/939Qj5t+ylGLZi0Er/dMdg79pIj3u+Xrx+UocMY5f11RwvpuDVW0d?=
 =?us-ascii?Q?xWEv+ta9MxdQCia7YxkBcUSnG0EsM5DDNcA8RcxuUeAT5tu/yiVgSCQLIOk2?=
 =?us-ascii?Q?40aZ6gFqUfcu9ki7oc/TnyCJQP0oj1ZDnbZfuhI+5gKjXil3h+IizfYKH7uw?=
 =?us-ascii?Q?KjTHZdbzS1wQrrmQVo9RUMgPhZ4GOHFEo0I2Y9P5cOpVWaPQX0KokepzUd7o?=
 =?us-ascii?Q?Meq38JQaaBWKByMB+VOFj0xRmTD5GspouoZPG8bAj3rSeNjd69qpKVcnWQ1k?=
 =?us-ascii?Q?htQsQGxAS31flZHW0kwSUeCRfvo8DLCuxB/S4O42RnEQ80viVHlgLArBsS+T?=
 =?us-ascii?Q?jdf93DWBTUSM5zPDvWoMMZzawiValxwRhmDJ/F958iTUEzfe4nksP0IamAaI?=
 =?us-ascii?Q?drw5ZTTvqL1jJvGIh7N2c5291CT1Iwb4m8JsTh2z31hnhr4aR++lUJS/bPvS?=
 =?us-ascii?Q?xMJV4yAEfZEOTpAzGf8MNFVWN/VXMZmczjt40FIEGYhSbj7vAE+uc/j5tkPj?=
 =?us-ascii?Q?FWHfCNQLtS8cM0psEzDiOq2dAIcel4xM9Y8yEm821tBU+aeFahd+eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HR6obf1XkJt6SKpvpIrUQ/2188gOylex23zpt38WcURdnNEyTL1Qyco2lNpw?=
 =?us-ascii?Q?4cjVgxt1opfywhgWD2FFcZjYeFBQ3wCjaBlEiIq0bn1ujpaItTAqOhHZOT2H?=
 =?us-ascii?Q?OzlZB7XKCf0JXa2cAiTRlSmE6NgDFxUGiEn+ea74jbs/9DZlB+VtfwgRZpbn?=
 =?us-ascii?Q?F4XRtI3D5q+AFhEogdWl2cpoNJsMTVk86qwhUaRXdfMMJM8/05r5TcAfp9sx?=
 =?us-ascii?Q?Pa40aOPeH/WxcfciE6D14V0hgd/6OamR8Y/astBJbWVD0AgioIqRnu0n6FIz?=
 =?us-ascii?Q?xf7iWyOiOXDypV2KxCLCqGUSnAFMwBU3KaxpPJwJFqa7/40dt7SJ8ztjAp12?=
 =?us-ascii?Q?T0sLVv208VjPrdLsM82HecEJgr3UFvqRdpBTzxXuAL2Fvo1IU5VHn8aoQ+6L?=
 =?us-ascii?Q?GOpHCbbyJTiy+M7g5UnNBi4nfN6fdM6wvTQJXHSmeQBWgW60a+e7qCKqPJnd?=
 =?us-ascii?Q?dkI5I6idEvWpX81WBarq9OG7ErmodGNlDUnhAayXtElVG/JaLw3xghjC6vJG?=
 =?us-ascii?Q?vjAVqB6Tv94fZYYlAQySAriBXBPr1T+oOxvUzOj27gpdFYXfOdTRPo07QL0v?=
 =?us-ascii?Q?xtPaCnTc+Z25+7zQ+swXW7Q/aCF4IQppLT8LTterBlknbK4pTaH2XP64e9Hd?=
 =?us-ascii?Q?Q0Kz+69NWp27L+M3pytFyQ3DLsW9g67gqS5nSer9IRNU08Bh1pkWchYypCiu?=
 =?us-ascii?Q?vLz+z0M4cvliZfED7OwuQ122p4vllpu5YJyGMSK/5O3fsZDlKbQhY3oGXEiw?=
 =?us-ascii?Q?S+UYHhOD1hOW4HfxB+fKv43YDTGiDILGN/Dk7WsRo+IxFB8+vhR6KAUOhKuq?=
 =?us-ascii?Q?AaUeOz1UGu9goCM7WwnFiBgayh8GIRX8MYhgTrVu+ub0JYFFYeyDWOXuS5v1?=
 =?us-ascii?Q?RP0U7hL9rFiGee2YKONA0iAJj94C+kyQQlERSHue/o7didSlgGeX2emQ+Z/p?=
 =?us-ascii?Q?mY+CZ3u5im8LTj9mEqHwO3XwPaB+vPhVqgOo8tjsbUMUTl+FvIfcGXWLB2sD?=
 =?us-ascii?Q?aWkhRA/g2VRBdZCrd/976v2tG6Mz/2heZwWBwQGHD5l693OodIDAg60vetg6?=
 =?us-ascii?Q?o4qObmTbxQdfzPvrm/7xTBzqiFafbwz3fRPY/Zzyx079mKv9GusGmNqIvRX5?=
 =?us-ascii?Q?7ynAKqW8h1qlLbqeMDLEDIVcgJTrsyvzG4DrUpwLV6cM5D9ftzHS8koH0KNN?=
 =?us-ascii?Q?9g7+mSBpgj37zfkjr/w4BRxJe6cnzMRyp4rCRGV9lhBgmOa+Ppozjp2QvYj5?=
 =?us-ascii?Q?crcfv+coI1K3o88VbIVApaTUx37ia5t0zL3Km0YvcExvdA1fSy/7nJgDOdIk?=
 =?us-ascii?Q?qr0lsMt8kv33l200UG8pL2Q6p+6JkHjsZ50o+c31eKA0xveIP6KH0PCIrKkg?=
 =?us-ascii?Q?GPeJspiINgLTYBH2YrV0dy3C+qjRuZrpxwRMPcZ/wA2r/TMfNvL2zHaKasGp?=
 =?us-ascii?Q?ojV6g29EzUkvhhE3KzfN8ZGznpJLt9SpqlxzanXdvp7zLUWanKWAc7P6WKHQ?=
 =?us-ascii?Q?+x+kI+yGSrb5P5zwgpwI1IbO/DNAFpT+ADiyQFmsWJsBPoumxoXL3KT92avJ?=
 =?us-ascii?Q?EAqBKehyEVI9Br/HY3W9NOI72lVBlXinkcXoXZG8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59302409-e97b-40f6-eea3-08dd6c3c53ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:00:51.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkQyCzJejQrUdifHRTU3wkOWEJtaPqbGmM1CUKnCyOK6MZE07/LfDw3hd2gtX3Z/DUsLiIi9PDyF397sUxUxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

ERR051586: Compliance with 8GT/s Receiver Impedance ECN.

The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
operating at 8 GT/s or higher. It causes unnecessary timeout in L1.

Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fbab5a4621aa..42683d6be9f2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1261,6 +1261,37 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	u32 val;
+
+	switch (imx_pcie->drvdata->variant) {
+	case IMX95:
+	case IMX95_EP:
+		/*
+		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
+		 *
+		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * is 1 which makes receiver non-compliant with the ZRX-DC
+		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
+		 * It causes unnecessary timeout in L1.
+		 *
+		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * to 0.
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+		break;
+	default:
+		break;
+	}
+}
+
 static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
@@ -1302,6 +1333,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.post_init = imx_pcie_host_post_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1401,6 +1433,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct device *dev = pci->dev;
 
 	imx_pcie_host_init(pp);
+	imx_pcie_host_post_init(pp);
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-- 
2.37.1



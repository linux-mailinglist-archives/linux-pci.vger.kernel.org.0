Return-Path: <linux-pci+bounces-30170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E7DAE0179
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C947A72F3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379C229B02;
	Thu, 19 Jun 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="APnhX2pb"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012027.outbound.protection.outlook.com [52.101.71.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADC265CAF;
	Thu, 19 Jun 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324465; cv=fail; b=hSyRVpObEe2+xlxJ4ub98hjcVQKavWCjdjs6RNXjAGhTd/c03oeCAmEAnju64RsO0w9lSSOrp/6XPNH9QkoauFiAddlAwSOwyXrlKZiXgaVIAA4ETDgR/l16KdR7eu7k6wnqsqIVPryuT5yuUz8Dsng7FAPUpl65OWOGHr3XkZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324465; c=relaxed/simple;
	bh=+kWgDC/aIY7HcrJSs29GJD9pSPwQmCsCxj43vZf+2DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkgtnNbUI+AKhoeVOhg00YepX3Vw53mNqdr0kKtuailpxv2d1Kn7RrsoMvKXsg8bq0bcJRHL0FeHdXYelFO0yv3wuEGtOgd4cmPfPHnjKumChjSuZBBtIgKZt7PQwdd/ft5RlAH8JS+o02Wf0L2sMe/Ek7YqJHiVSmAWshoZO1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=APnhX2pb; arc=fail smtp.client-ip=52.101.71.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is0fkgOUSI5eHgAf9z1kuXAGIm79GxCy2zr8N5WKSABl04AQH0wZe/nR8e0M6docli2L8JjXvTrNkywclmD3+zY9cq4z9HQrbwX69fCjG4UHw8l0faWAxi3q/yjCrFgtIzshXt+C+lz91E3tpD299AVXOwa79T7TN5j79tav/FhoObyRr/1a+SuLgd1AVd2AbFWiqhgRu1e+TLJ5Sgc3lry0wcJ1HhbFFeOTXdi9flf1OOck27BpZko3vFoKnoAweWmWDt3b/JzKw3cajBTfXKDiPu9mpuKGe7lkveuVpyWLbYrrjf+vigZKhQPcfzG1U2NYejDatdvuE95HfgddKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvVLufjuDVUtzX9TsNciLHzPlZJQnZSZVGgAP5m4mLY=;
 b=lcX8xG1UqtrecBUFUh/9oDKF15tgRR5GQl0ktmAmgzBcHw/SA3ka2gfXyjxu6oKjFq+ZhSUfLEajiKyCjRQlCbGaLYkXojuMFUfnnRNO7Tj9tv2jRT41IIrVPSDVRLhf5KlTcgb37bnsxdjMoujjpbktxsOh+cew1UJp6quzCIhy8jeVFw1JP9/358PfQpZ7+SM1aAtVkjTQfYCNU6QH0Va1YydNJ8ALHbH0SGl5vviRXMbn8Bk0gmW6H7PolxIvRvFLPf0bek3zdVTegcQoqbYa9FH3Y8+vBLGkg+FB67OYzVh2Ev+3MruAMObOgEsYZtG5tdE8LgvP6WzM0zBXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvVLufjuDVUtzX9TsNciLHzPlZJQnZSZVGgAP5m4mLY=;
 b=APnhX2pbK+LgbBfX2DGiDMk/jxbcl1wV7I6V7EtlgRS/NZb4hbsBDOaD0a8kjS7USpAcSGf+xlOGGf5MmNI269u3aHlpnVcqh7Earff9NgRWywHSTRNr5aqlQvDBDWEEHKmKqpqQtEs9ZqWBckJldP/s8VD5XlLKy9KL/Sxg3xiSwM6zpxKsaxlbAHPWRiVsElaQsWSo8p2+QRRJkFJRTGqIXeuniHrsby9z6E7PgyAoC776NWZXWcoNg1lHMfC+fzwtOfLQnaajF0hTMPbVysMXdx/UClUp+zOFzPpxAkTTC65vEKf03KSzmnt5A6yGsOwfcSUJ0olyYNE7J9xEDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 09:14:20 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:20 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Thu, 19 Jun 2025 17:12:10 +0800
Message-Id: <20250619091214.400222-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091214.400222-1-hongxing.zhu@nxp.com>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 6917d9dd-7b16-4c27-a932-08ddaf11ac91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utUI8L7sN+CAS/jDjCGL9O8SmSZJS4j7vC1AmFaiazcGzVwFlnd9UhR1B6dB?=
 =?us-ascii?Q?4vCzJzEmhDb/MF41V0aeJylNWn9Yhlj9IctvcDzfoIf8RoWYkovsbZFiPZ+Q?=
 =?us-ascii?Q?qHlPfvA5lHRWwlsyQrJld4KA4orDDbxqFNr3N073IHgdDoSzQnVkKCyz4xkb?=
 =?us-ascii?Q?iaijfCrMyTxpbgDoGeiqTHlMgh47EKQSdod5yfmKZBKTfxCOvpNwte0DMv3h?=
 =?us-ascii?Q?Hut5kvi3lOq3gt9g5DmwKQfSAHuZL5kHGFwp9qzwwFCGVRIcKzNAs6UYOSwm?=
 =?us-ascii?Q?f+7vEoTidcIQqLALcYdgIPEEmjsdeOTZ7o2rXhtO+yZ8Kp5kyDdhegOzTb4Q?=
 =?us-ascii?Q?sL+SHJOdGzWz/CaC9cteqVKU0V3mO5GM+O5FsmdYCyhcNxbMo/s3RoG9SduP?=
 =?us-ascii?Q?/eRvNTs4htLBVCdfharK3OlnNQ2ptDEsEvlnPgjQmLZBWhHWXYieEEPyQMOe?=
 =?us-ascii?Q?/3B+OxmGjGGq9CcG9qSeyx5u6mB+wna0b758ImdP7aIymVHI78ZSSXyq3ZGL?=
 =?us-ascii?Q?wBs7FjFZT/VdM76FfeFqUo291ZPYn2E/rz1s6LJGtH+I/UMykk489exZNO93?=
 =?us-ascii?Q?Z2o6Gj8J3mz9I1eLvqs6V0hgBT4Mh9V4CH8nnXU48AuoRQwoqTBvyjKwUIVG?=
 =?us-ascii?Q?ywHeyf1GVY+AUjdJkiqxvsvzKvIexc/FzIR2eXxs0Jd2yHGU1JLPci1K2WSB?=
 =?us-ascii?Q?P4Ukba6kyKPSTTLTM3Riko2b4/8/6Y9FfG7XEd3A8PZflwMq3qxSeBixxrag?=
 =?us-ascii?Q?2Mj+4LgUbQV+ObGnBBxmRk4dAkTXYFpvT0CWQkDaZzc9f3a9VdAGR9r6SWyX?=
 =?us-ascii?Q?1Xn58mzvkx2JiobvHLkmCOiQhY2FQx6NPwZ1udzphGaDpe4NZJNPR2sYTV3F?=
 =?us-ascii?Q?dC6oH2PfWT8+7ASiid/kDtBgocB0cm+KG1FrO/5Thv4Gl9k0flcchIhKv+ce?=
 =?us-ascii?Q?2Jjhh+BEd8dCRfj78O5bvi1jKUQuhxNCnGT55NH7wlizBJ0rpRl1UwCp26cO?=
 =?us-ascii?Q?yMaVLdMNcBrlRBr/MB7BWP2fijXRBMbABXtYq4AaJQnDzt5trqynnVonBKlr?=
 =?us-ascii?Q?lYzyYPpAhqqqAhb4hySQGFMtUjDsGMpf8Y/5HJj0lXDTDZrH6ussd6BDwOb0?=
 =?us-ascii?Q?4NA1d5Cnh7j4CJkloL1jMJU/VCs6HNOqfrLvREel3NbOdpzbx630G0AGWJjB?=
 =?us-ascii?Q?gFyEzQ1fbxsO2Sx1cleJde+YMJ4RMmy6/d1XZZ7ltiJTtpa0HG3e6/A8sQm1?=
 =?us-ascii?Q?/q5BydsnWpsnPtiZ9n3GGDR4d7UVTK7qf59Ttq5dk+1rGogKg4uTT7esBSQx?=
 =?us-ascii?Q?v9dx4cEdg3aJOJz8OR8DqwRurTiVeqoc4nYg8OUWF99gU7MXq253QZuLDrAo?=
 =?us-ascii?Q?JJQYbvP+hXtkR9CSadKvXCRN5JQic1i3KW+SmTQJ17hhCPqUjmHm8HO2KXqN?=
 =?us-ascii?Q?XhCMUQiC8Bjn699DLJdCrf2gKjtm3MEujv/+Tbax+5JHcHACTOpscRmiHTLK?=
 =?us-ascii?Q?jvA6h45Qe2N/Cy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Fjgsy/ivPLwUk9j+54WObIF8b3yGgYjF9Z2bR31kNf1DdxTHG5fI06JTQbU?=
 =?us-ascii?Q?MaPY1OCQcBnVjYXClZycX15ZgFAhMgO3h6TePKpPbUJ62zCZV3FqZDB3khfi?=
 =?us-ascii?Q?09qF1rOoWeQIOYcQlZH15K84XilJpbXIytqIw/9JgNH6Wm7DM7Zu7gJqXhpM?=
 =?us-ascii?Q?B2W3obwqjSA5wWRRkZIDMm12KDSrUGps17ZUbizrRec0g/faPEjbXjpm1fM5?=
 =?us-ascii?Q?cC9KVvnmHfGUCqrR//XLgXdzyfc0+ydjKBTN1VywbCE97Q+D9ng1fYMxOIy+?=
 =?us-ascii?Q?8o3UglloSOOx9TC0DsZa0VfQ/w1DBSzSBqlX4CcgrdSPP98wQoXamhui6aLQ?=
 =?us-ascii?Q?Rpo1/YLWBK21YtsD/SEwg1IRWDZbnGXzJOyqrBsb5Zv5Ov17w/HBFRs5BxTm?=
 =?us-ascii?Q?Itl+17snPI04ThR6CfcMCE5zSAArjKoO06SHBN2tMjVNLxFNsY+Z+yliLXMx?=
 =?us-ascii?Q?PPDdyalxeSAkiNszGy5GhjtYF3ZKzDL+Mlqq7qYMfJGHcqzMcUfZgcFIqzqA?=
 =?us-ascii?Q?yg9nMqXYF1L3Ucd50HjOKpMs+jmqRdGMT0ubE6Rqe6nvB1i/y2VNfYr7ymSa?=
 =?us-ascii?Q?rQmmXYkE3DHv6MgwhaVPC6OiPziedqwd+cwYrtBszjcsESXjeZCJtI5us+cS?=
 =?us-ascii?Q?bXc137x/YcJmVsyj/nlE3BViIhqUkLUaQeufOBu9hbDtN+u5BlMeflhWHjFD?=
 =?us-ascii?Q?BjOR/ucJ5tr3ghOqxuvgm7nnLH8mFo99a8vZ/BcXeN894Rx6xjU8XoXTX7et?=
 =?us-ascii?Q?rM5PjrLMNhTxnqabfZQGVWTQt3SOmSTyqFvpx+zRAOO0FsId/rrpk/KQtkoz?=
 =?us-ascii?Q?45zOVMx6lBgDSv0nGjTwWZoicmqbQjs+iai3dTEb8RZOWUsFTwid2yRMNRBL?=
 =?us-ascii?Q?Cvp3eH/BxMRfRgqzP5zy+txZ9f2sxONhsZeyyjdcOLx8C0t0iWRxtVO7jHyv?=
 =?us-ascii?Q?8ONAOMsgzbJ3t/U2WiCHEwPxjV9rbwBsu58XyITWhN95KOV6JtitbCRWGK6U?=
 =?us-ascii?Q?i9eNeJmb/xTd/86lpSMnTKTcbKDH8jyPOuzBTLOj9N5rmNFa0iyoM5JGKxT+?=
 =?us-ascii?Q?MnTTTWxMUBiT252O3GwCeUdnIc7AIA95Tpn0cx5suTdKbp2HPjT3UBah9G+z?=
 =?us-ascii?Q?D634nqIrH7GQ6WgV25pWmdH8w2Gz0uIRH/lUtsQys+Wjvi7ppSWyDIu8n1By?=
 =?us-ascii?Q?3Ws3jmztESP64qh+AVJuzshGRx2IbiACQl90XhNRiomlnFC+4/3Gih7NtfYS?=
 =?us-ascii?Q?y/KiPRSu8KVVbpNhsktxhF9sgydfHGy9g2nirjoRsLq7TSMQhJnYomB4QpN6?=
 =?us-ascii?Q?9VVLZtwN9/r2xuj0KYY3/iydJdpztuvUvqaUKmrMDPWrrCVj4Z0gAcJSdHZy?=
 =?us-ascii?Q?XoS7Y9rzbscK/rbvgtP7RhB4raVl7fSGTOKnogXp/LPQ8Uvh/oGEJh40RV9U?=
 =?us-ascii?Q?zo6pW5MgkKfUYTDk+3SsZueqcNMkseAmmFtaq2njIGI2TfPy1CC8k5M/S3z9?=
 =?us-ascii?Q?1/CVAPikvUPwLprwF4VP3h1s82zQj8pFZ/nHRaTaDWkZBPJd1dlh6qZycQsi?=
 =?us-ascii?Q?JWP9I6/e1LuuOfptV5a+UOMOswcXvcoPu811raL8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6917d9dd-7b16-4c27-a932-08ddaf11ac91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:20.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cz8h2g0YIj5nrAN8P5yPwhkD0m3garkEsY5dfWaj/8sYgowdgHuiy8u/GC4JYLHSukLUTAa+EbqjR9T8GIaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 906277f9ffaf..2d58a3eb94a1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1026,7 +1026,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -1043,15 +1043,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..e35b19cbd8bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -509,6 +512,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1



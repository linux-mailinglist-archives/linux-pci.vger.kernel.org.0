Return-Path: <linux-pci+bounces-36610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB0B8EC9F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 04:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B902189B01C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4D19C546;
	Mon, 22 Sep 2025 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TA6H/bmp"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25A16CD33;
	Mon, 22 Sep 2025 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508711; cv=fail; b=sNB/oWVsU3/Evz7LiqnG6+RzQXbsOdhbPVh/YYDt+17RmgDD/zGQ9ACUXkJM0DiI5msF9XLBIOdRFZzuMolVv4hR4dt20dLmohUnzo4Odijhu+/JWOp487JW2GCog4BEM5GEvi+Neik5mR4kzG07DMZ5GWCuAl/WF/q0A878OxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508711; c=relaxed/simple;
	bh=TSVW79j1v5l4499ecDa7brpL+zjIoqo2EkUBBZ4UOks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkOoTbitzXABfblBYYMHevGv/GUoSKACZmfUeSxlP1fCastNns0tqFXQd0h93cCnjcprDGb7JSUnUP2AdWzOHwAfF3rPk8hhRFXi8WRxfk9R91MjsxIlDFwP8jMCLRhYnQ7CmS9PCqpvFwjV5DJSRgOvlRV/YwMc0lpScA3t0yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TA6H/bmp; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtVidNcUeFrIaUTHGJmx6vGxo9Q1rhu2pKKGA6sTf93RCrCmpUs0fcrDDmgDa9SIIYE5EO0WVOT121iKRHjIb9FSRtcPHhDoxutKRZ0Hqu+xueq0grWfuCalNjl5MfG7CILrUvJVXcuGBXevgX96hfi9kIQb/1paPt89QwleroUHZo8ZwLr5uXtIiuIDCmPmn9B32V398xP4YvpwQKzdwtNSuGM9n+IhUI/XkEupgNly36aDeSq1HFpykPZOYpS6CqQe32UhTKlI5YMUwVDz/KPpnWKrQqMKFS7R7h9IKaXC+n3KqZsIGecuyyD3IgCOQHx/imHb1tMRqSoFsP011Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLlkmXXpA+5ELy9WF5k7XckUssFg+ELyXxs3IUdn+yo=;
 b=HB6EUntWqTiXFp6CHOZTYrrbAKBBUm5AEg+WJitw4QfVSpPse6js7+oWSnTLHvvMEP+sWDMREhOo366HUykd1jpjozCVIHCmaiTFSBm+zepcoM45aDyHd8Q1WibPDEWKzPrD7Ca10UQpqr0CdOQbnp3EITF6piEWl5E41IfbQP0g7K4SNrEYvu8Ql9e2gzeQhjas22tYA5h6JXZbRCMaurdEN59PUVBK8quIi61X+0H3VlbZtMoRcrlP107faw78bbNGrVXw2hk8ezSd5Koytfj25LuAXboSezMsdQgQ0WJI6jTSTKXH9J6kO80cDrPn7+SrRUEGwEVTdOdS+95bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLlkmXXpA+5ELy9WF5k7XckUssFg+ELyXxs3IUdn+yo=;
 b=TA6H/bmpwxltvq4TvMZCQKnfFpVHIbeTSqL5e5+QrHHxoFyHbzR4OrLW3b3abWNesofVjlG3oTFG9ivkOAWC3gUrJ9CCcY7m6PHObccuIYYHuKNDIRRnBZj+5NRvcyuKX5+cz7VMoO984jzi2xA1oPedW+I4Ls+MXgcwH954cB084SnyjXGlHaW3MCTDTowuuqMNa8PFtn3S05F5llV2l6VpxdY7tWn47aS3j5996PYrYxo9H8aaKGPkZ9zGueW/A5PkYgMWxDUf+VLXI1J+gfWkBXEc+StbHs7lqjV0fMqNwvd15VJ95rwZQipkrR8XAnCQiB5r+gWq0ulCznFIIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB4PR04MB11280.eurprd04.prod.outlook.com (2603:10a6:10:5e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:38:25 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:38:25 +0000
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
Subject: [PATCH v3 2/2] PCI: imx6: Add a method to handle CLKREQ# override active low
Date: Mon, 22 Sep 2025 10:37:41 +0800
Message-Id: <20250922023741.906024-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922023741.906024-1-hongxing.zhu@nxp.com>
References: <20250922023741.906024-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB4PR04MB11280:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef16f64-5d9c-45f9-0942-08ddf9811aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gipF4s9Zn35H1ocvGSc9Q32B1jAL1RefOZjJ2hhV/4edvxJQj7wbyW8boahI?=
 =?us-ascii?Q?ygCjbS002SnHpi/1gxAPZ6dnArMgYpQsb1THKYjY4cnHjyI6tTM9V38jKovK?=
 =?us-ascii?Q?srGTII5MaAVotalUWTkskHonuyOtXP7NpdZrY1lWuPJKzreH5QE1XVzP3mhw?=
 =?us-ascii?Q?Ql+c9uPG+JD6+EAmHnEzGJcuVnvJhNoi2dZwoTl9qFXpxNe0ZVsPCEGJ+TC6?=
 =?us-ascii?Q?4iwyCLAt96BXDOsW2wYbgtgiG6t1qru7yp1SGqwBrIgBLONguVQMDNBaBPhW?=
 =?us-ascii?Q?8bnyA5sOP1vzwuZrxX9OucgJf+PUS6O5GvCzdLLTO+oSciMc3nlFUvcoP6l3?=
 =?us-ascii?Q?pgsd7h1peW6xonyA22Z5k60a+uKkQiqGO6fiGGR9FQmPbuz+bB9gzbWNHi7A?=
 =?us-ascii?Q?CuVGBihkFJUMVpd97CSnfF/m8OuOh0qW1nm5qPbh5xNWC3va3yS+UsrYM1au?=
 =?us-ascii?Q?jwNgzd91cBElegXMtvBE2da+FRaYbEBpN3hIOye5KD5zf9XikWqcTodzjofE?=
 =?us-ascii?Q?Ec8oKtGSlJFs6dKTuhLXXn93ih331jI5rL1ZPPii28VLLawY1vKYYpZoXmzA?=
 =?us-ascii?Q?qDxk5fI6tlfeHx47Spyo0H20USFv29RncgH3oKfHCWXdPs2vx8BHQKqkZopw?=
 =?us-ascii?Q?Q5sHL/4DK1KunknaodI37Cme9udr2YsY+ws0M9qmPkzU5yKWmeioY49gJdyo?=
 =?us-ascii?Q?nKB16nzhHVK5f67wsIm612TovuYehsiKFqr8pbKVWkU3ajjM3wSp/1XGECUp?=
 =?us-ascii?Q?CXVJCxiXkTOLvSpZQg8Sl0nb1uyY85WcquB/hFrXOAFEQLWup6E+3FEV1/ny?=
 =?us-ascii?Q?KJqxy9Z4qLdtU0UNzS4yUzQJecdT9ShroiVEEp7oIfpMYE96mavPiQcEw5Zb?=
 =?us-ascii?Q?4yTMfQQfz15X97s5mDJxu6pJcDD3LKUolGGnNKncmUd4B/TtRJifz/mZXI/z?=
 =?us-ascii?Q?jW5WMRe3PmZZaJVM74oHXFTP7nv8K8niK18urTJu6IDJps+J9I9KGJlscbCj?=
 =?us-ascii?Q?SCgz6mM02dVwOqpKKbx4wyJC7xUxRCVdpNv1VJOtN872X7jk6QKB0xXKA+aA?=
 =?us-ascii?Q?+ojIEy1PWaCQWmAdzJPldzQXumDYfur2DlcINH87T2N6wFNrJ8CdV1dttqxF?=
 =?us-ascii?Q?RoYRIG/6//ApKivDFY5R/MnBnOKGaK2gWbJdB0xHsfP6yFfnVwt+Wefh6RTF?=
 =?us-ascii?Q?x6Hax+4IE4hk1G1m9e+noZiIVIdSWfbbV+pZl7IJz+ipTFMoz7k4+asFvT4G?=
 =?us-ascii?Q?6vsfnVy51G9gpV6CPH74yfZxpCyxCKm2klCRhtnAc/gb0n5rPMC+Q8sealAo?=
 =?us-ascii?Q?tQX7d/oXtrPm3v8SAfgs+mV4GlP/NaKNXUEDk2fhuq0bokMwbIono8twEz/u?=
 =?us-ascii?Q?QoDpUVl3wjg5jHk7jOOC+MVGPCLPJttDgwVhgEY1vyDOb+YoCwMgScI1t0eX?=
 =?us-ascii?Q?PgNGmq00s7o7itaF0EAo7wh9WOXptGIHD8VMh7YPh5hGPYTdGT3tuVyKp5wY?=
 =?us-ascii?Q?5NYDzKnsLa1293U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGMwNYMKkwFRXkaEOZjWmGt03i8wH21eV6jeKSJ+w3PZrSrjNE/tLeMrXmrH?=
 =?us-ascii?Q?TxqwdMkCfulHJsJTkj461Gu7omYjnghvo8O2HUt4s3zOHJvOoBHAP9qJnCAs?=
 =?us-ascii?Q?xry1RBuHf6XBIHBQgeVIuk1b60pv7I5YHKgd+j593InPDMbnq7pcGFluf244?=
 =?us-ascii?Q?5Uh8hMdFeQEkRmARc38kknjRfG03KoN2nPHg/KWnG/n12QUXPIpwLb9Nx3HN?=
 =?us-ascii?Q?rnrktLOTuz17sliW2KT7srk2mbX6SjV8sgVRTzAcejKoMPSQWH2iEmvo/qBy?=
 =?us-ascii?Q?fUGSvlGaXuOE6sr9igqGDCtk3+omx111v97Jj3iyfu1HwaQgwMQxVzO+FvZ0?=
 =?us-ascii?Q?95wB9QX6cmu0DrTT0Pw4+tA/6lA9sYWrLgTcCVNl0Lgq+s6ximGq6JkAB/Kc?=
 =?us-ascii?Q?MW5Yj92fLIVEbZCK/nydgC5igAGoAOxxcLkDNEEqxTzQ6gBi6DAKeatHrMl0?=
 =?us-ascii?Q?UjEn/Rmw7kCB3TJjGs52JnzMeCfg52DsFxW78j7iRwqm3FkYN1t7+Xla+iy3?=
 =?us-ascii?Q?FEJXe0x5aJuyXS+U+2smTFTgTlX/NVaBG8R85KnVJ3AE4ucGEUGHE//LQWbN?=
 =?us-ascii?Q?ojbAMadE1ywofwWf0m8CihD52p1EKXo2tSwF06EHU1gZ04avEBzoRZzNIBd5?=
 =?us-ascii?Q?Ostvg6q1j5/KKvbLduV38RphaQfVQ4Ja9VILK+QPXaLKFPY2z4AOzKBJ0TN+?=
 =?us-ascii?Q?gPv5fhghzhDwh6Sjc+myNYsZh/3GzDnw1kZmt/Y1flgaCuXyJ2ZS3wQTViUJ?=
 =?us-ascii?Q?AuTCiggYl4NCy3YpsnQtdv4RIMAJxqy7mm3nc+RqfkvdTeMDL/sHD7Qnou2M?=
 =?us-ascii?Q?CZ1pxtIxlOdba7E8RxhY23cFFoifRlQHYFQSh7/CVUvlhmJJYwx7WNwirj6M?=
 =?us-ascii?Q?0Y1n5WOMMYdnQu7kytk7TXUCEQq4i+vf2ALZp1zcyUHkjVI678Bi8iXZnNkg?=
 =?us-ascii?Q?tS0XaAb8NLRtm4bI2+rbIE+05UCUszEy9K2v0hLNgUI1e10mAGelr5UM/leb?=
 =?us-ascii?Q?tmI+WOhkV7IRVtaxO+IRAKMVSHUHdf7MlwoFJwrNUXxB1W+IeEe9a7sEVPk7?=
 =?us-ascii?Q?p2PCueMsNPUwirbZfNnLlcbP4mwGTQfs5sMbpob+jYzQH16V86UgGgZNVTsW?=
 =?us-ascii?Q?C3pU3Xs2gdvAv+XBMb7VIbN/2QO9eRMkG95NsBxwtnSiOuNeRXNIkvW7loBp?=
 =?us-ascii?Q?M8Frq38QjcgWjS/ffXbvgnH2Iedtj1LVAE0z+MKTOj9ZFzLjUbLXRUZAKduf?=
 =?us-ascii?Q?TM3aTJtONMUC1lo5O0QucBe8Unr9GIu0YzTRFY6/r1cXl5YZf0hu8rLGXnlt?=
 =?us-ascii?Q?HcHYM4dlZ2zxxvfRq2iF3up/5+DspFJtOkRQyz4lMz/tw+bVk7EZth3knJM0?=
 =?us-ascii?Q?AutamlihrdOvzKXWx8+Uu9Stds1GpRBBh5YNPyhWSQliw5yko/RYJQbha3Hg?=
 =?us-ascii?Q?erVa7mxfmgSL6m54i6veBE6yGTno/HFEpq2TFHKScBAGEcf13Sjmo4g00ze8?=
 =?us-ascii?Q?c1tDZqbBcfOesxBa5gyr97eC9iohB7wHthlFbvN28es25uIYQgAWySV5LxL4?=
 =?us-ascii?Q?Z+IAmqJe3wV7Vedz0cJCVKGB65KdBZvGcW8MUXSx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef16f64-5d9c-45f9-0942-08ddf9811aeb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:38:25.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtnOq/1DJ4T00p2JZG7wwZiG2gnmmfXjPcNtd4Esm3NphQAV2lzUPCALFYcv4rRfzc3kIvAvf9jDwQCqegURhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11280

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..a73632b47e2d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -149,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			   IMX95_PCIE_REF_CLKEN,
 			   IMX95_PCIE_REF_CLKEN);
 
+	/* Force CLKREQ# low by override */
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
 	return 0;
 }
 
@@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	imx_pcie->supports_clkreq =
+		of_property_read_bool(node, "supports-clkreq");
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
@@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1



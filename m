Return-Path: <linux-pci+bounces-24899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A2A742AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF163BA48D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441020E339;
	Fri, 28 Mar 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dHhNEDDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499D20E018;
	Fri, 28 Mar 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131018; cv=fail; b=GvLc9GwbCFIzAkU+jLYuMONzmo/ftIgkNjKAOMV8Vj0C/sXLCR1a76N+Q7icDemG7pRbdmPc1sY5bxu3fh26O+zZauzcQtCy0BnbnEHNdPwECKT+ljnnqffz4YZhms2ZR7jOSV6DgC7/nJsgvIIEqY6J+VWrPjNR8fcfh0EV8cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131018; c=relaxed/simple;
	bh=LEwjl3A0OPdGveMf2ks7qoqTDzB5fP4L8yKcPl4e01Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdL/ccV5+dd1rAQKxN6/0gOHHIOIAHiE6UYbGmYvg3ENnFi0YbGHzQsea4jHi8S1x81f+yKDMm5u/tJCiMjutuSv11uWa8IPTcBEj3X+1W4qgfZ/xSertR54wAFaNPsZl65KHb9StNE3OXvfHJQNUGj6fomQwUhuGmsyjT8m0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dHhNEDDl; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCJryuMADG8DeHjtrDtMfjQE2COkEtOYWwVZRwsDRrFQWJJqqBBJ9zY637CJ9ysTAqyHVFAuE8/hiohkXTTnMudepISfgwJIzjBG+vRKeXxWs9aqzZCBuVRNX9KHDNAQ0eU+vScTChdR+0WVX0LfMw9BCZ2qRUJNK1mV+5Bs0FIUq1jZNYXf88WH63LBlptiPYTSAsn4k0cEaAhCtKethFf8O6UoarikC3KldyUI7JkcAR4m4mOGThMUgoTpgSto4Uj23PmJtUGcG6f0ksQtvhRtHNrST7cD4QlMkxZP4ETWjQZXfl6QAlbsKstyDaG1zZMnwtJcSa1s4hfiwsXz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w85Arg2OjRBZPur+WTYJDhVtQFvjoNOh/Hi4YXciWlU=;
 b=T3qyrzkAHHJQ9myxSqWETPjgcwKS+ssGC9bObMnoW0ac1x4r7Z5JYXJyJkXm+LMMGVlhH7x4TDW5NMwyUvbxrZ1qlFNYnGC+zMu286Omhxe/85ZlVEEHwfE6NdtclPNEf6tbZQwjYD6Tzy9KrmubUyS/OzId4WVhTunm34je/DiMwh1HpK+M92qoCx49tT1bdpX6kTKBXyXcPROfRnhcPjrClHIog+zmQOjAjSMJ8griQbIporK07aXrz+rD7WmYZvVN+l1AcipsrhDIv1AIBbGqqaSFPVUbRL9Qh+qSLIHOUfchQw1zmuYYQoPMJfQWjkInIOY1zBPKR7/o5DtFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w85Arg2OjRBZPur+WTYJDhVtQFvjoNOh/Hi4YXciWlU=;
 b=dHhNEDDloBfUTq/xRq4c5r2HKHL5B+OEzMYeYna2UWlhuI92FfLY9lutbJB98Q1HKLJ63tOjeig2tCwJLadiiHa6n7e3ZLH113asM0xD+dt8F5lvwahjqZdNjbPp2UxCa00gSDFpZUg+RF3AlUIQvnemzbpwUrDQl2N2/59hggdhMnGgPw1HhKTyCDaRqfhP3v3eezI5vjvo8EhCbnFe32H5o1M7VF319nE2TY8YEi2MM7qtYQ4yMuzvjWpLaZGidXUH5ZxIj5xfhs4CUvfEWUQuqTYkGDneWJ2z78PrNlWLZ+0ENDpMhzxL868AR2iX+L0e1OmY5wCbVIn7LLByIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:33 +0000
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
Subject: [PATCH v3 1/6] PCI: imx6: Start link directly when workaround is not required
Date: Fri, 28 Mar 2025 11:02:08 +0800
Message-Id: <20250328030213.1650990-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fb64aa-36b2-4b67-33f0-08dd6da5204a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3ckK0O7lgQCy8Ujabo4jWga0aINXcGEnyJxOjZZ3ul9kN4W8e2tzpwqB3Wd?=
 =?us-ascii?Q?amFC3JyR+OUTsW5HL1ap+nLlQ+lnOyjbrje1OxKp62TPW/zWwXg+UV4UJlkD?=
 =?us-ascii?Q?9icvKmfRgKzscN4sUQGwxkFr2CVlaCMh8z58HPWZ4+PMX/kfmbomFryxggpm?=
 =?us-ascii?Q?qXTudlP0QIaV+W7YiAiChIFbAx2ONZlXMUwwP2eQ0h3xpkWYz1RPL1CPNp+d?=
 =?us-ascii?Q?1EhtwOgy2DCQbzQmmbxBNvhwoPyBUhv/vu4Rn3+EqK3qWItu6XnvRR6oANIh?=
 =?us-ascii?Q?LgBA4+gkhQenV5qmZRYYFeY1Bhw9hSU6lHN9lWocQ0s9E20oR6aNoJzdD8Cf?=
 =?us-ascii?Q?YN8qMbLsD8XbL5qKj+7+hCKNTGqEx3UY+TnxkR0euwZcgBzlTILkttnI37wO?=
 =?us-ascii?Q?Z/X3E+PA4GYmAUy0uFSsdB/jaaENO6qS1UpLKzU9BX/9uiADsylMwPfeXRaK?=
 =?us-ascii?Q?073Ow4U2vzJWvMbjxNLEGVqeZl9Osf8zXucjpsN7IOIo3/X8fpzztSCcfXGM?=
 =?us-ascii?Q?fKZYhnGeLfnyoPyqira1sXoTYkrMRKvERip2JLTecR2nKRUFl5+5mS+8xilQ?=
 =?us-ascii?Q?NAIMMNv6KZek2X9m1Owr/IP40eXCfYLdRRSmOnUR5lXJCzH24HJbe4wpeHth?=
 =?us-ascii?Q?w+L3GozdLX49eQ4D7Ai2i10N0erlhTpysJ/aMrU95fmO6gbogOukIb/n2GdL?=
 =?us-ascii?Q?0LMLXMV+J+l/63gewrC/OFPGHmf4uRCFGp+3cjgK8cie7b0foDH4FNTeX+BY?=
 =?us-ascii?Q?H2FgQT0jcqhN1DjiSvALvWxaZZK5EbgMFLPYFxHVIMmZDaw0pZBVw2MF7KZ7?=
 =?us-ascii?Q?i/vZ93RdFWx6OByPDMUiahICCT/597Z/D7L8v3zZvNwytBmGAHt6uqX65X4I?=
 =?us-ascii?Q?RvZTzBULs4R4ISO31Yyzp5kETvUSBpgZ6nQ3baNllJuOCrT2yPdJOPNKly5R?=
 =?us-ascii?Q?DA7umnS0aczu38kTm7b0oRiosI9ahlgW5ngPqXQBQy+gfKXJz+KrT8x+59c3?=
 =?us-ascii?Q?Ez0AbK16A8DYH/lXxOg8pq3n95Ria6tjLAF/fKRoX6HtBkCoWBznZNXRjY/Q?=
 =?us-ascii?Q?fEozOPs7AECXCY7mkp6FMrl6+eiWvT2CU24Vxyet4St3jOe8/WguJ1Ahwn75?=
 =?us-ascii?Q?R5A1IEo1Qp5rkvyHuZrbxeYVqBTERfEz91uAR8nai73Kvmp93Rx3VFyGjq/Z?=
 =?us-ascii?Q?MKtBYKMdbUKA2/wUKDXus78LHOPlA6YR4EXQJeaNFQ/XzoXxQcw1Gzh8Dh05?=
 =?us-ascii?Q?vBP4LOj6mRtl6OtlJM5Qh41RVtYj9VOzKwMO+O/j8NY/3fEyi29kgYO63fld?=
 =?us-ascii?Q?Xj3TYqie0kbNJWChrFu05taBEzfczAF4JdzIOpp+MC2WLLAzvSfSNcl+FMRh?=
 =?us-ascii?Q?hUg3Gy1PSVS90BbUnh0Fzso0BWH91k2dEAZdNI0zXiCbyROavWM0XpSlY+uf?=
 =?us-ascii?Q?fI7JkH1KULca3iPz0BQIr7JdAtQilom1DDE1hEkdapihcKc5RQQVVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGFq8+S4MDFjuR0dcncnWPOfM2GY8bd97g6rsPLr8rQ04Y3Dpr4WB7+l6G/6?=
 =?us-ascii?Q?loPAquHYRZOV4B3torKeBtsW1Up0J+w3IZxwPwzMy7R1hWMZQbOdiQq5SFRl?=
 =?us-ascii?Q?FsC7Qu72HzIKw+pApIf55FlQqiamAFr3gGjLhNiPSGLH/BnKW9OK0qBhoGUs?=
 =?us-ascii?Q?aFrPGhcQkLqsJfLhalUy9H/OhOAKFnFUosu8G89QlsiWSKTYjsMbdHnj8gNY?=
 =?us-ascii?Q?ezY6yjaypeO8S5ajLCeMQTi4wLKlAPhzycaoDy6NvvuWRRB5eHuxxKGOhg0i?=
 =?us-ascii?Q?VVu/fOwTplN9l4AHsHoPyhLgUR8YXyeXeC+AyzD+DQPtdmxPhRQgFQIpMziW?=
 =?us-ascii?Q?6RcwMe5KSlmNwPBBr0x9pMjflZmPKLeE+eza4jK5Jn9dXMSBIQTXSruNjJiG?=
 =?us-ascii?Q?hY/BP/2HCcLx7yCWs70ZWowH6pj8sth0qAklvrq5f7tNsX9Ak099elv6rjU0?=
 =?us-ascii?Q?X++lN9xpzciF+xEPog5ss9zDjQr103SFjbbyKkP5sLuul+H8tAkNNUYYW80C?=
 =?us-ascii?Q?u0yymHtcLkqgDCxWHOY2B6HwDN0SX+rotP3CqtblO02MfDm0Hf3LuPiRqWKA?=
 =?us-ascii?Q?ad1rNoh9MVxRCQSpxwxy8hjV+2t4JoeBz0zQDxUOAPr+IAiGSuQaCsLfPsvI?=
 =?us-ascii?Q?GAH/GqrxXZkPj38jl0TxJ+6wbdwA3yN1xm6QwTH6MPstsZT+H6K96aDytzVB?=
 =?us-ascii?Q?BPOX/yeDHa/UD6fbAPN4ADhk4gPTmmizrqIz0YcPbxgFkwjbmQk2wTm5Fd9g?=
 =?us-ascii?Q?MbfVPESvT1J9P+6qAqhgcN2PO90VvHna/74D/bjE19BWr4K+qHp5NigiNTAo?=
 =?us-ascii?Q?mRDg1mSHSvYeFpRy1utazoismIGlZ1r5lY1X6mTSA+oMtF4eV9snqrhFfoFY?=
 =?us-ascii?Q?/zxQp0Zh0Zd/PPRk1qiOaGQMa6xOZ7qIH4C3Esg3U/SjxiJCTLXoyQoA3ErO?=
 =?us-ascii?Q?6ilTeUGcZpCu6pT6LEsuBd39F0QYcGnXIvBYcJD2H6cCKPiJDpnPqmrMqPFy?=
 =?us-ascii?Q?CYa2XjEx5lD59vnpvpDNLouKxJki5t77jG1j77oVOSyEDTYJup2mNFF8Bmv6?=
 =?us-ascii?Q?QeTf7kZnMY4Vgw6oSb7BXdQ31ZSjkNR20+QbJDRkOKUTy4GDgbX6ssz7OvYI?=
 =?us-ascii?Q?+HcMSPyuSWofCD50KJN2wqhi5OZElJ2lebzvER9O0VrxBkTn8gFxFmT6zR26?=
 =?us-ascii?Q?xeCoH1GFijzC9f48TB0EUbZhdZRouV03lxDEOHt1nDDRRVoLEynZxpsnRHfC?=
 =?us-ascii?Q?kReG2Qi4vrJGh8vZ6pQUT8F+lzm60eCRfaZNnYOWlLA7VHRUAqGBU9L9hjZv?=
 =?us-ascii?Q?fHPr1K06cKgr6LgG1rwBI28u6g3P/Oh0QkCqC9rkdAkM1NWnqmqixdZvc3gq?=
 =?us-ascii?Q?bfrjVpbK8YBuU798eqxlWqyX2D+2zcbjMS/4vNGueZtKa10lp8cfaF82EWxX?=
 =?us-ascii?Q?YGUXv8qfP5ZcKe7uMtzenUz8j49tG8evkrmyE/fnsCi4/z63UtMiy8JMNjY1?=
 =?us-ascii?Q?ItWI4O8eN+4jRcPmP+skrGwDOU8G33PEqjzWMI7IQ1s1mvqvCKHpxniMXEdA?=
 =?us-ascii?Q?3pCjyFM1QRIGDLg30auidNuro5CTA0lqycyistaK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fb64aa-36b2-4b67-33f0-08dd6da5204a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:33.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9NP6+Xfmc0LFks92IOjNo4ReeWZsXH/Z0N1OeJN5olRve4dJW7DF638DnUUX6V56ALktv3axBmWjPJzhBXI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

The current link setup procedure is one workaround to detect the device
behind PCIe switches on some i.MX6 platforms.

To describe more accurately, change the flag name from
IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.

Start PCIe link directly when this flag is not set on i.MX7 or later
platforms to simple and speed up link training.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c1f7904e3600..57aa777231ae 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ enum imx_pcie_variants {
 };
 
 #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
-#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
+#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
 #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
 #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
@@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	u32 tmp;
 	int ret;
 
+	if (!(imx_pcie->drvdata->flags &
+	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
+		imx_pcie_ltssm_enable(dev);
+		return 0;
+	}
+
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
@@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx_pcie->drvdata->flags &
-		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
-
-			/*
-			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-			 * from i.MX6 family when no link speed transition
-			 * occurs and we go Gen1 -> yep, Gen1. The difference
-			 * is that, in such case, it will not be cleared by HW
-			 * which will cause the following code to report false
-			 * failure.
-			 */
-			ret = imx_pcie_wait_for_speed_change(imx_pcie);
-			if (ret) {
-				dev_err(dev, "Failed to bring link up!\n");
-				goto err_reset_phy;
-			}
+		ret = imx_pcie_wait_for_speed_change(imx_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
 		}
 
 		/* Make sure link training is finished as well! */
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-- 
2.37.1



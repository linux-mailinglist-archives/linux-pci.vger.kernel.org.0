Return-Path: <linux-pci+bounces-29515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDBAD65B4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EF2189E37A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F691C861B;
	Thu, 12 Jun 2025 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FM7ycA0p"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4531DF751;
	Thu, 12 Jun 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695398; cv=fail; b=PUpmeC/346aYXEVa7Xq1JdYvCbR3hb2nZ7OiNDGfdw7AbQ9Jnaj0v+KVPwRGKNN6e7kfL57YQCqR0s9sO3tUMpH8kADaF9fX1S2Uq9DLn86JGB15or8BI/1l+lj7YlEJJtT6qXNq3ahaEG3XSKL4EwgA78r3cUD8+532HYQ4kao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695398; c=relaxed/simple;
	bh=4wFVDf35KGpkPbHDTmIXndStRv6mXIum7Ecd3iAE59A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HS4uU5gwd/4fCu31lMYedhqP0oVMfWQmw75CZIL5WhF1WU0WuFLfUH25MGs+MGVbYDWcFMN0FURF4x/Xg8BM5yEoiUgBNjQZHbFDUGIqkiH0QWmjW7WZcdOR/czf0RFtAdI9dfCIIwcC3yNvDr0uTlAztrMwmobKYwHiinSMjOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FM7ycA0p; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0g7NpirlD6fq182TwBjb/jkWv37lquERHfkYHAwLvcNrLbjqlKiSIw9qVYw/GJXUcE/kDPrzHiCAe6W1og+0NUOahg9IZbqRG4qmP+3I1/t+niumd1JvbYczx+sz+BzLgauwMmwIKHL+Y50WwV5Pv0C26OGu/f6B1njuhaBIQMNKxpfedXpVu08nVDdSG9dzz4fkhQrwYwcd5+vx3OJNh1YhOwMaLgkDETq8BigQPMbIRxS+4yrYgiiMs8YXifCAt+zrI+pSB/u2Je+fOpv4Vdrvn3Uqnpxn/IKLud9QHJ8e5UZiPDR5us0u3ghz4jkvwFzdwKvuZop2CXFmUOcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w8zJjNxtkK5pNPNshK4HqlD0IRIECQff9Lg+NWCoXg=;
 b=iuE01uDpOxe073K/Kh7W4g34HVEPd1LEBZmZ01/0OpTKPAYPeVR8PTYp/c1OYFIXbFLsXSdRp+TPB8VdwJtpkJ3AScZc2fjexOP1XmJOA/7Uh6iKz8FxeLHLjYN2RFQGYlBdXfw9gSbCSt/ehGCFJCItL/ZadubpmSnZH1WEYizQXYtciLdXWNUR+0z3dv65j/Pd5sM/vrxGtC4JOCsRZU//UWYHS8UlHI/L/FTDSqd54puR/h2uqo5pG+58SPLgRC0BLM3/ESn7F6kyTzaqq8Uf5wdL1B4NRKPHA2O4wYgdAxHEYaiafQA4cIoM+hAEVdyrZaQoPFoOqY9TBtqk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w8zJjNxtkK5pNPNshK4HqlD0IRIECQff9Lg+NWCoXg=;
 b=FM7ycA0pNqBmdjCdVwDg1ji3QF74K/vOsT3lgiUDwVoEHvQZAkSvcCWCOj934BWge0YZOHDtRCRoWJ+0CpDcjSsuU5Au2Oren0/K/UhdWhBB83An0TMrXdyUn7c2zN6qKpS0odqmyHz8JZTbiXRV1OZW6/n2NMB7H18Vqq8YgGVxsGXUeFnoGDUkTP7SfqnUmBZLM1lImD+1yxZJ9rUlNQN+LA2c4tSoYHWFmEk50rYEzDzxzmK12xWKjhC2kRCUmvb+6Qv6+Xb0u8MKw/7HC+CmXvBw5dHm0xoDi70f+3BP5saQn2qrVBpmAV18KqEr4mJDrS8zBLYtcaJfSI6K1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 02:29:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 02:29:53 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tharvey@gateworks.com,
	frank.li@nxp.com,
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 2/2] PCI: imx6: Align EP link start behavior with documentation
Date: Thu, 12 Jun 2025 10:27:47 +0800
Message-Id: <20250612022747.1206053-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250612022747.1206053-1-hongxing.zhu@nxp.com>
References: <20250612022747.1206053-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: cba2af37-bce8-4a84-7efb-08dda9590361
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?jjnBZ1bZk5SXDvoGAj8HNFk+Pf08TM/78zpHxpV6Q0bNcoIAKkoTqXPioXWK?=
 =?us-ascii?Q?fVfvMLzQP72UlUIMNQbjb04RYfnYsHB8JAFhCtxCpgvoGXA9/J2cREAW4x8D?=
 =?us-ascii?Q?V9B8f/BQB5YP6rHDkf5uTzY+3PM/XLQ4ziBPnwV51WykxdeWwpJBA9ymybLE?=
 =?us-ascii?Q?mXmlVn/mDbHAPaUyC9yiSx9YmI7NZX4QvfbFjjWVdsrsSwyzaWc/xaHW8maB?=
 =?us-ascii?Q?waC/x6YvLQ79vKjYHkiL5RFitabdxzKpLU/ssAmVj9eEiMFk9eUVvw4EbMOo?=
 =?us-ascii?Q?vnMTiOSBqS4s4fVRbuvYIZqh2MZbEAy4zL5c4svLYCqUL5J/irC+aBOjlUUY?=
 =?us-ascii?Q?q5YhKBWwkyuaL0vdlOyXk7ZdTyvI1ezqEhtApEeDc1Oj8fK8dELMxe7m4v+2?=
 =?us-ascii?Q?ouJxaWH36mpeqi7l7G7LRdbLbGswDBB850W73iT3O/A0XlsI6aNPwdAprZuI?=
 =?us-ascii?Q?mlBawdRttyLAXuWatSKfuegt0DQUAk685OJ/a7jwt9awgF7ZprnYdymTpPjX?=
 =?us-ascii?Q?+8YmJR/2j8ACDROigOfxZQfHV5TibMIMJEiczwIKHbCduTPtm8qAufl3pacY?=
 =?us-ascii?Q?nmXRimeB9QuIPIv6KtefERBqnb5kc2m0vuIFGKfZDW4ouuSKM4fyyYSs+M2c?=
 =?us-ascii?Q?Q2UpY2MYpD0jROXJv4ZkP/SfWgp32KPLwgaysWY4g1PuFeWToAWkEaS3a2Wy?=
 =?us-ascii?Q?voZhfCdA5rf02JzackXpYOaMj+zzSUuRyoucqmwvgP5MLsTv5rWa0BFGor2z?=
 =?us-ascii?Q?hoJiWeIFCg7s5kQfT5jEBNt12MC3iFJ+1Q4albUAQDW6j6e05MFoydU2OJXG?=
 =?us-ascii?Q?AfMdwBDG02InWkBMdbYpyOA2yf90hOFvu+2BzaNnVYPNHvJuc+GP418xOk2X?=
 =?us-ascii?Q?8VquhDTeeP3N8LiExttnVOg5hTnsKjUjTzGyrzLTPEtYg7xNIi84wQlCYGvn?=
 =?us-ascii?Q?5FaGw4NlwAa5jH5KDW1BJiUgvlftqhenXWF/QZdgZfw4+0Zh1C9RvqaYho2M?=
 =?us-ascii?Q?iENDfFP+5Uyh8RhcXfv2TZn6Jsi6wkHQmmYb40Vr/99GWK6dg78Tq/2Pvagd?=
 =?us-ascii?Q?c3DzPNTdJoJcrWZ0QnKWrVeaDj7QZpN4bykTXye8o6c/Kb1OYuNCtPHc+edz?=
 =?us-ascii?Q?s12+Puvw/3xuxKWGOYpTzQSEU8i/s1ogw5BnWx6uhz65XT7OwjNUL1ab/QZk?=
 =?us-ascii?Q?gBvcrAclYpmo1CZZ7h0gbC/dXi7QqjBM1h9G97/hZ6Dwigibyw0Bl4A+4uxc?=
 =?us-ascii?Q?NRSQi+pFBtR+LqKiIFDobTJGcdaHBEhGV+WjGeyWusGXxlembXAk65Kmi9Ze?=
 =?us-ascii?Q?j4z25Vov48cLCdVdymcU7YpmgvIAoz7orfIHl1GnYasX+qfpiz5W3BK4q34L?=
 =?us-ascii?Q?rAvW6XIj57lbhxfpeYb2S252Fm5BRduUUL0QPEjIJt6sB6H7cd5WjTPhwcir?=
 =?us-ascii?Q?6fslSlZnYaYVEyA57sv0Ja1O5Ygkhp7RiBvv+wy3X2fsXAl6GI0JfNaMcRPf?=
 =?us-ascii?Q?FGwHplx31/PKeXQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Cwzi1hIbo2XfF+WY/o7UClHM7i3KWZCJa51Y+htuJb8CdyNj0h2vnQYnF8x0?=
 =?us-ascii?Q?BLDRWUiBNtJ5tRaUy1kgbML/Dt6KTP3b+nA6qKCEFZM0jcT1Wn3jF7IoRirl?=
 =?us-ascii?Q?eY+cD+OsWGylvkmS+Z6Z1bEe4Sybq+ydoCRdupWdwFHTH1Gta3zFIOKMfHN5?=
 =?us-ascii?Q?pb3GhYVd0VMrE26eVwPyOZf32Bi+C9tPJAu5W2cRMNNcP6YGbmb1csjjsRe3?=
 =?us-ascii?Q?irr6FJ7o9kvLluO5ll6MNdHYiKPaQY5F0IHE+DDfP02lp4kBuViZXyKuSh1+?=
 =?us-ascii?Q?FcqtnQ+uwEUqbYGrcYXwX7hID6xRaFn46AV8qDwLAgn9Sn5XNPhgCBQqTsDC?=
 =?us-ascii?Q?IZL/HIR5mFZZqz7qSjdBqR8nfjZpUOQWwtYpM7DBancw0Dn//ynyzg26in19?=
 =?us-ascii?Q?9B8DwFHaj9MB4IVtalEPfWKvkMzxSYMB6U7bc3SlquUbigXSSX6XueQtp5/r?=
 =?us-ascii?Q?KEYyvVuEUWG74U/HLIucGShsSsBpkVApmMfHbd5qq9qSMK0kjnChUHAR3mX1?=
 =?us-ascii?Q?mfzZEPXfD+589n6tCxAQ3bQQtGT55+qWzXhDUKAq6g3ORHuIkDmlQ3dVCE+Y?=
 =?us-ascii?Q?d/5M4xRSeuORgeSPz1kaYpf92IW4NJKYoFu+Ge66bO7x5nm3cgfjX+ztM5BU?=
 =?us-ascii?Q?OAMf9a9ZIU+awq7+2Z+gN0OczEmIy/s7WSrm3Bb0q1TJdCJQKsr0LXVjO2OZ?=
 =?us-ascii?Q?3kyFIwZIBJW2WcFkN2r4C1zdOcL43ogG01fssWNCRKkb4KvOQXLau1WYaPdf?=
 =?us-ascii?Q?hUNHN0O9Y+xDvw96fcUr9Qrcg65+qzN77rcFGLMXztNUTeMjIuYFrj593ONh?=
 =?us-ascii?Q?peFnBC/Wz/REEc5LsF0cRJXwWQsHCXoW2mn0dur8pOCuI1vX1wCqRB9vw232?=
 =?us-ascii?Q?FowTVQculAteCi6++T08COrK7Ri0XzNDiEJoQhNepB7t2IKxR0EwTffveXGx?=
 =?us-ascii?Q?pPmP4B+dTdtFllNViUbTfYIoPfNJZbwjsrMExopDYIE1UnrM2U4wTNguBdIG?=
 =?us-ascii?Q?1lvFvgxVf8wOvApY/h5ZEE3XsHDoQ6K9PLOvebxncqtmTqkZPXzf3voxeepu?=
 =?us-ascii?Q?OvG3yn3zwRku9bZa3xBPWtlVAmr1+1Zvksveu7YLLqLs8Xdl59ivCssR5EgR?=
 =?us-ascii?Q?aBdfoON2FRQlzsj7pW4WDev93fBxZGwz39MjZCa2pLkaF2fVNua2LSB8XNYX?=
 =?us-ascii?Q?w9gajZGzqniKzK1CR3FUTK3pYH2njuP3uZHtS/03+yBUrKH6Z/AgUVIRgpQE?=
 =?us-ascii?Q?tcGrFxmmsFZp88hOeUSjavCFoubcPWVbOLmFnIcDepTQbdK7HBmDnnN1CL64?=
 =?us-ascii?Q?TQ5JEqBnYsdbW1ODgJq0CHmZG4HW1EuEczc2SXWOI1a4Vj7LmTvTbsNR1ezL?=
 =?us-ascii?Q?n+nV6IjzA8lsWCC6NC8YRaOdvJGp+aB4boRfzKYfTHFuJqbH5FuzdsKEVOwu?=
 =?us-ascii?Q?JgG7MTVpU/3SKbSzqT3L/3vpXAPUB6v6H54iAwbLAlop0tEsEFXM6L0ZYFvh?=
 =?us-ascii?Q?9OB2LNQEcc3IHYycYUlKtGqFQf7ZytVVCJwnu0VGIZJ0JgsKYyX5OWMKj6JO?=
 =?us-ascii?Q?OBILyMGIPgvE9LIUlVG3M1EmioW65+M3R7plLpUq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba2af37-bce8-4a84-7efb-08dda9590361
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 02:29:53.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ijVSJ7C+rU9sIPuAIHyD8DxRiD4GoUGVZKcSUUDjHmLJXHdZCyi6CaNtkmBADZRQzXT8a1ku9UVoTFSl9D0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430

According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
only link up after `echo 1 > start` is executed.

To match the documented behavior, do not start the link automatically
when adding the EP controller.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f4e0342f4d56..668b88bb7c95 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1361,9 +1361,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 
-- 
2.37.1



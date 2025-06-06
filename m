Return-Path: <linux-pci+bounces-29078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E8ACFDD9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC9A1704D0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0860284B50;
	Fri,  6 Jun 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9Mle23s"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC33284B20;
	Fri,  6 Jun 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196768; cv=fail; b=ivnaRvMDlccGjJiARH10eFL55772FDJctWONb4K5Toas+uygAys63dZtbWBaztoooaPPLLCq8rfg/9swWO0Dw3O9rlMSLIP94toe0DgVmZMo2/ug3lL2dJpFkgYujCKjpmwYy5IeMB2zwR+Jo/+ubJhTGqYg8m49FKH5G6Dxs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196768; c=relaxed/simple;
	bh=fFQhwQGl6lJgycxDXF0ZzeIIk8XMsx4tASoMkOX9BdM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dJ+8f0cl6rrp9LsQBRZoY78074coeVtPdvdmd743xCl+vRMegj7zMdAQCrvB8g+ndoe+uIYKvQy0HELs6HOitFLE+45aJ6F6T6CNPIlV4MV3J+/DzpANEEQ6SqeHGLPh+b+LRSjekYptq4g9N/Wkk12hJ1T1HG745e/ULyV2qto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9Mle23s; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbdtpdEKE+uDd1x0PDQLhQqEOtjDZnncUi5iH2Kq0xcncTVuYEBPVR/09vtzLpi5Mn7um6KLq39sEav88RgN7kN3UjUQwjc0Ipdt/GmsC9fCABokLt6HgT90kY9w42W6xGHzkoImaCRMkm1aKqxXDfc/6vTySZW8bY1yg6Ar+GqTN8hK9m7Y3Kp/BIQXpnuO5cc3IoBFb+DLPfCjvtZs4AdAShtEOpFQ5vTYB4xqjnrkJhwpLTY/CI8eJczwz+2+/jHgOJ8H0yK/fBXAMxXv1LbImFMWPb4tR5F8jy0jD/FpnZQFZErAyJ1E9FlvYIBVtMPeDUaIiZPKKz+QBuRbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsGFLonY0CFbqF6N7MSgoDgXhUyVrzodYvAiUNCte9w=;
 b=VXblqBsSZc+jiHw8YdERgxAmTvb9ZcsBtM8nNvo+RX57TcvbvegPMFjsg8lpJ/eXOrRPxMxAmoJLkZ4GgTx0StVjx/SsL6cHcr/lUJR4EUzxaGp6CZqrDQ8Ku9v8Hc19HF2/yxH2riXi3Y1Ba9bz58ozgkQ+15xkDIEzTyPkdwL+hBEswx+bXu1R1gMDfcnzJ2cBmXk3hnzkpln0Z6Iq5zWARL8zk7R3WwjLAVnUkeSDtjgzbvrfS6CT4DE2wbJb/EORZXG1y94gqvBukpxvB+AwR3xnw1dpxeKs9ybPTL9IMN/yKwa9chAPXDx0/fTwE94akFCJanMw/Zge2tsp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsGFLonY0CFbqF6N7MSgoDgXhUyVrzodYvAiUNCte9w=;
 b=N9Mle23sdrJ8UJsVNVYyEJzKimWzFrpiTOIEUfYFb1cFTGnEjU/6sX3YuLavt/SDmrEJO/1CTGtTEf9zgPCvx7ygzkf29bKMcmMjP62AZnFU2ziMzEmFx+gS1ph2rh3VOb9Q40OCWX6JRRY/Roe1eXJANj9jdo4NJ1U58HeedoReCIgxDNXf8qRUbBZVtiCyqYiWgeQ24QeuULwHmZwNu0diaUKfwKIuK5NkURX0EOsrA4bCbLCy/Fvmtpd3VumCnL7nzOXObAhraPNqZrs5ckAHIsx4zDndjOvaA6U3M2d0GBHWGLjs9N9BGxPAMjoSrKNgQLof9XMQYH2AX3vZAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 07:59:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 07:59:23 +0000
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
Subject: [PATCH v1] PCI: imx6: Align EP link start behavior with documentation
Date: Fri,  6 Jun 2025 15:57:29 +0800
Message-Id: <20250606075729.3855815-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 19297ef9-73a2-4c48-ed5f-08dda4d00c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIKaOs9Uj5JZU43LJAEmZLJBgWiv3A4G5TF1X8vvRrtTD3Cuj8ikfN0KGMRU?=
 =?us-ascii?Q?aPnvakoRQYitrrg098udhSgCO4Xa6R6m16QacnH56HIhdj8UeS3Bgb1n8jJi?=
 =?us-ascii?Q?56FS5lMDYq0jqQxGQfqaJoea2GRtDU57KvVR9T53/J4A8+foFaz5Bhj3UXvW?=
 =?us-ascii?Q?vI8k9Dr2tatzw77ekr4kBoxIs0+zowKmHM/tE9eGB0ukgEeNvWNXO4/vtD3d?=
 =?us-ascii?Q?A/hJN3cjovc5o6ifoWQUixEIm0B+Z3HVpIw1nbBoTB2TBLLtvL8sUjLto8KZ?=
 =?us-ascii?Q?8v9SDvSvYqaO26gnCKpbEsrKL+ADSwjZf8Tp1E2HU5969qP0bfFLuiiw7ioH?=
 =?us-ascii?Q?INfieuUBwWHMZgX16g0gux4FY6HgIiBqjZg2Iz8ZhT/IZIUSpjODAitH+IyL?=
 =?us-ascii?Q?eSo1vP4x5u3N8rdW7BoMlBrZzKylGZpGwp3bUS2hK9IM0w+aKyS7GPwjdeXU?=
 =?us-ascii?Q?p4i2xlBOWv8kje9imj0DhY5zZj2NTZ75bf3oLEzUFd4UERZIU1rSb6sWhxRj?=
 =?us-ascii?Q?lhIxqCpyBM3q7C0SR8XDKsSflyNBe8ZizWidue+IAMOXWt7H6OvNSenEr0wO?=
 =?us-ascii?Q?cW74mpToKrboOjxVc5rOlPPA4yIdf+7iNL7dWA4o6saHa0eX7VVbJ0czhSFH?=
 =?us-ascii?Q?IZ9Hi40Ia2pdA7bRfGX8I1eEYYAG+0UAEdo45etdiWIIQA2xm6VSV73E9N2v?=
 =?us-ascii?Q?JJkWYyfKN1aIvFwDMEhI1vjGTAXOXMjOhMDtiiTygX7a7hz+fVB2CDmGkrYH?=
 =?us-ascii?Q?PWHlkaNAqDWHpksXn8f23Qyg+T2RUqBuxX/aBE6poKAcOqFT5fWJ050TeN0P?=
 =?us-ascii?Q?sVXK4nthwYzf617KaIOOWlh4yt3aMd6/bT5LaLJ3c//WjntjpZP9Q2uBOLJN?=
 =?us-ascii?Q?vSnRn8Xc1XtHj9h+W5CDxZzDMsJNN0GTYIYkq99Aub7XD1WaseJqUQ6LjuD0?=
 =?us-ascii?Q?jqyLxbMGjld2Pc1J8Vi2Lzq52MB1+SGkzSKpjVPMrPD4mcZG+cdm8a5zMbZh?=
 =?us-ascii?Q?Dy3zOnQuNkZAYdgE6ADqI58bruAUdgrbv/IkSglAgHcH7Oc+IYeRmFGOrGEr?=
 =?us-ascii?Q?EKhBeICLexj4AM4s6sqzXSaqQruHf4COtg4GHecUHkICo/YDvD+BQrqXYGbM?=
 =?us-ascii?Q?zFa0q/Bi7osWBx+LVaVL8fV9QGNSx7k9j0HS6nw4WpXi4/IzX51oBOHs+Fu5?=
 =?us-ascii?Q?YIJytrmNcrwRI6SC/6fx0ZO6zcslaSaq+vhwtTI0SD5GHDWv5OQGaECagRi7?=
 =?us-ascii?Q?zYRvg55od0FV9hXwB6dGw3nXkRgv1zgpFjJVsd36Rz/lB3Z0z+nAuzoDRAcB?=
 =?us-ascii?Q?encW6KUFnlIywYnt3LuHi+bQQc6l4axqjvd4om6eF3t8yDNYSqxjy9n3DsHg?=
 =?us-ascii?Q?SsHyrAfdvyv06XLuyQi9/dNWMsMXLilZ1NjV46CmvG2KfMrRB+aAysfY+AuV?=
 =?us-ascii?Q?IJQr2D/PHBJkwtydZUMz6YD5A/zicDXPk2eLOTkDM7FFjyGdM1qGVLrEfoZV?=
 =?us-ascii?Q?L8X06DcK2486Q4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jjv+nAmEhX5qF5nNBJgkIgecD6iFPMLuKSzatP6/iXwp2CL34S46ZcgX7R/Y?=
 =?us-ascii?Q?yTK2rVnDfYhLAG1Y8aZe0ql/qXL2N39rbVexZP5zmoHsezTFR+aHqIj63KYg?=
 =?us-ascii?Q?wE7Nvlnis5+1R42M+Lml3YbX4J3luKHaubkcdmAd4xS9NOIBJa4SeLf1PrrY?=
 =?us-ascii?Q?AQeZH992dej/nTP+TK+xfrabYV4SCTMnACUcJ7Yd8GUUYJAcrOCuBZern/sH?=
 =?us-ascii?Q?yR8+r5VUlxrlUdAKzE/MGjdn3dS9GX3xbd012IWlO+X/O6cxq9tZHgIe/u1s?=
 =?us-ascii?Q?0G4RrF3VxuJwNXSLmh6GtaHogar7wfSo2vq9XuY2DX3bZO6kKWcHfLsATWH3?=
 =?us-ascii?Q?ou+FzEX46UFAsREjhtbMK68WrKq3lUb1uZ77EV0vDQ1V9LsxNNPz375FqpA8?=
 =?us-ascii?Q?GpYRibq99wiW+KXAul0AjHS0zC9it4fNBGOj2onYVh5AZZYEfGNdJ7QizG1m?=
 =?us-ascii?Q?vNgKhfFTJW6glJvkfy1sL0RPdYdOVWdXFfzmXOWQH9zDYUL/a9evMgkqr3ac?=
 =?us-ascii?Q?XPJFngyNswH/7Ker7pZscppanwmQIbnzlR+Pds9PbQt0tyNS0AEpipWZD4vD?=
 =?us-ascii?Q?IZBBnc3lEN+9xqxChyaTqCtUDFrxj/CFPDm/DVNlTLIZKnqmbNacQmEutBWz?=
 =?us-ascii?Q?BybwJNAaaPciempv61Etnx0UH077VvAI6cja2srGbQG/LryTM41oaxSqPZRW?=
 =?us-ascii?Q?hhP61ifeJlpvo0WaoLE07rgbahVqEDkx09iIIt1BLpCcXuOqOzj7szWTkUK8?=
 =?us-ascii?Q?RwFGGLAnChQHXF+xWTzwxNx0y8mUiFHulGipT69j7wBxIIQZjlcoVAnyx1V0?=
 =?us-ascii?Q?ZzYY7tDte9eTPVihfBE8K7CGnTH4bM5v2FUWA322G5kodK0HiFtSoujvGjWn?=
 =?us-ascii?Q?3+9wqkfYSE6Z589vOf/8OWx7+0kMrLitlyq2SAxMkAP37ZzwwKq1wS4rpW8B?=
 =?us-ascii?Q?VG8tiU0Pk/bVbz3GG//r1evH6Ul5v5uCVDKli5wl5YrIN61AhBwwVVHXUjQF?=
 =?us-ascii?Q?4jE8snLodshdzlamthGOmx22ZbjFibolMrTwrjZLPR2al/SjcTR6p5n7NMe6?=
 =?us-ascii?Q?6IQNOgmtNcNalJFDqAhKzPTCeMqGwiA8anrr4rSTVRmfMhsl6OYAzEUKP4WP?=
 =?us-ascii?Q?kFBoNfBo5XOBUl3QcD+k+5Du6aFY/clalRBc+OVWG1gVNQIO4pr3UmHjXmVq?=
 =?us-ascii?Q?OeZnupBFy5Fba9ETKGWByaxgW122WGig3HoxAfai9ZBfYQez6B8UjbO7JGSd?=
 =?us-ascii?Q?+RAe1+gCcfH6Kh1FWrt99UhUiWOc6+3Rd4NsB4nff0MyEjPggI2xLK7l7kS0?=
 =?us-ascii?Q?yAMrj9QECNuip2XIun5Q/PijgU8Q0uChjbLtQ/R6+zL1ZJjNuB5+qLO33U20?=
 =?us-ascii?Q?wbP7E8hOmyIO2yo0wnNPBKBucMhmom26OB1kjL72S+m9wLeUC7AkIzYP0Y5e?=
 =?us-ascii?Q?WfKqc0frdQ4fbSNktCa7XTbmilAJOf2PGQGZZPgqZDlslpAMLHsP5vkyZdrO?=
 =?us-ascii?Q?RCZR4SAZY0pXMthiVrGYYkcCtBeXFys7Zh/HBiEsWYld0UMyS4pH36F5zvI0?=
 =?us-ascii?Q?CogDXZNGbjqX2F2jGncQGjrmSIt8We38W51R3kVA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19297ef9-73a2-4c48-ed5f-08dda4d00c96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 07:59:23.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWvMtw/AAgeIw0JLSjVNcl6lqt8yFqYyWOR2BKVxg1qMP6LU1RhyibxIDvRz6vOK258brHrsG6lJZtQnM+MFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
only link up after `echo 1 > start` is executed.

To match the documented behavior, do not start the link automatically
when adding the EP controller. Ensure the LTSSM_EN bit is not asserted
to 1'b1 by default.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b5..69825e47d2d4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1337,6 +1337,10 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct device *dev = pci->dev;
 
 	imx_pcie_host_init(pp);
+
+	/* Make sure that PCIe LTSSM is cleared */
+	imx_pcie_ltssm_disable(dev);
+
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
@@ -1360,9 +1364,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 
-- 
2.37.1



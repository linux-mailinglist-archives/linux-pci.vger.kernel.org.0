Return-Path: <linux-pci+bounces-12181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40895E66E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDCD1F20FA9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F32F43;
	Mon, 26 Aug 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AENTItZ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D91C27;
	Mon, 26 Aug 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636753; cv=fail; b=oN/p7f7kZy726V3XFO9PMFbgt2a4peZZyqN7bo7Dwvc2RzYxoOGOstI6RZs5xapTOTvOBrluYWMY1BMRukJmouoGqmzzN2l03uJzSGnIaxyUIb9SmbWL8umwksMsoTHhpytUbkyXcJQ9YLn0uf2oRKVmGwDiNXrllb3RounMQYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636753; c=relaxed/simple;
	bh=fFYlR/VPpC9MC0MQ0o7TYCWX+3wtIMZjNI2NrBuypWg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UU3fMEiO/Tg9HcLDFa7Sy10l5uKqz+97jPkIi1m0IusUEWmfAy93yF6iny4WlA1BxqRP0JuXrYQQU0Ol+3hVJkQpacdp8TId4rRff5F/ykiXsOm2zO2nWDj6Zga0DMSryTh7l1goeI5EYJL81bcQPp5iBrPyIfHc22Azy3ro88o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AENTItZ9; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKPoE9tfY9A/EevhCGxp5EeEWObColAUZJN9RfiejbRlkNE6tZoJSw4aaZRhp1sBcUps3ReEKfYwxiRIiRuRzPpfYW4fsQo4VytI73AEhBxcb0Qixmhij24o6ZRxGX0HS8Fq+RkgKtmgEGuD8FNQZI0qN2AfMb4rYBIBYb0w7b8ui4CgyiO5X88dxfvIKKhTth/A3xI8I8v41k9RMagL9dg4xE4kCn2HoNbVJUpF6BVq7r32UmUgkc5x5B8sdcgj8DCHAIDEPGkshah6yGRd84UFWJNv6LkxCd8qlp5DH4ioCSB9NZsL050xj3AbkVLyJG2Np/TJvQjVHn4e5+Up7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ9m2rc+I2JzJkVMOhTPvVfDbwm3w0VS6fYoAUeUA+o=;
 b=Gc5zwFALozKFTL1SkhW4w00d4gZzvMr3+UmDPsz+wRwNJZvCQvk6uGkrspGnrfGnVEOzEPsFISpbmVKtw0MnfHoPQ4mhP9M0onhZOnZfjHpgW//2/2MzaMNM3SoikM6XaRhKK7pkN2kY7d6jxrbFutkwf/jTVH8sY6D6uuFIFhsQ2FDIAAML32juXGHb9xPcgPdeqeli3ogqX4OaPwIbRl1Ls0fkiJLPSLB/tcubiSxL8ceru/SzkRQS6OpR7vlgatKWGYynQOMSV0h/2/cn1olfwVvBGM581CyXMRLOihV+exk0ANy5StOn7t2Wx4Lj5CRTSP+j8FWaBtQesxsYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ9m2rc+I2JzJkVMOhTPvVfDbwm3w0VS6fYoAUeUA+o=;
 b=AENTItZ9YOepGskTb925l7dznjZymhDTtEAoq5aiHQvJAu0YhmpnxkMEV1JMIsiSqrITl4cvp2wESUagnI1QtpFLY2EkKxXARYXVfhkPcctjYGJoHkhdbViMANAj7SYfIZ4QzN8/3GKAXBHlG4wK454skn6ok9xjETuFmFeKcxU74QKtuTyLyFYAK9PK8RRL8TitrDG7+NGQX3br0nH9o86Bw5eKaVq2nJFDpHg2AMjBRW0VNaNHtxCJC3drR5O3M/88ST4nX1PVpvlgJ0UFBPbvZkhJ4STpwAmZR/IXwrCuCYLxy/UFqWRsXwlYOhBsCNWl7pzVJT85iNHuSq6wIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6478.apcprd06.prod.outlook.com (2603:1096:990:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 01:45:45 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 01:45:44 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2] PCI: armada8k: change to use devm_clk_get_enabled() helpers
Date: Sun, 25 Aug 2024 20:00:38 -0600
Message-Id: <20240826020038.2205146-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: e630cc8a-3719-4c97-1e5f-08dcc570cc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6axgs7dTyyjiTsKwHPaz28Mg70Nf05pVL5EdyvE+uFH35KlMS6rR+iROqbwn?=
 =?us-ascii?Q?QHwQmaXfUf0JMmzRZImW40Fpx6GlbCqVMH29qy6AHBxAbwrojdltobaLj9um?=
 =?us-ascii?Q?kd/pMqLYi6t2TRK2d90ajCBYEc3VRmWGEgOpXiLKz7HX+IGJ1cZZ9yCkDIgZ?=
 =?us-ascii?Q?JXqJ7fLKTohOWO9eQ+v82o7qz4mhANVlt4tD+zlKuH/IxseiRWClGn70/mrE?=
 =?us-ascii?Q?dgukvB3w7CLTFY6cS13SM3uuhk5CYwaBawHUos2+BmhD4MV5c3mC8y//XxWx?=
 =?us-ascii?Q?bJfz12w7GFtMFd2b9s/uzivRzBJ2whqpWZElG6hlow78Po10p3Ly1ARU2Rtb?=
 =?us-ascii?Q?z7jXRHD2dShtRJrMQyoWqU/k18oBCzFTQA+jrzTvCmmhD5tX7Ulq2icHxCu+?=
 =?us-ascii?Q?7gqmeKuDYjeql0jthXKku/LFYTOmzVa+yY7QorrivkpvmrduBbJKvP82sPbf?=
 =?us-ascii?Q?geSi5w5hje7konaYqObywbeRKNpBemaWGuEqlqHktlDX5Vq+QDFKupFlpZ31?=
 =?us-ascii?Q?085XawUcLt1tIUDN4DkZ+R7x1pNsD1FL1wEU81StGQufQxbJ633Py6dhVC/a?=
 =?us-ascii?Q?x9jIzHk/4vNhoJ1x5PmYXGVxQKuiMNIwcWNXFWLLBPNaKrrhxDsTpGBjjl91?=
 =?us-ascii?Q?OuM10jzuqFvWTcjw/r06lAcIoI+IR+QKI80swgTkbDx7TopFfXNAZe+Iqp9s?=
 =?us-ascii?Q?uggr52C1lZwlHL3+jsHRDRpFpwLgtZsSwhUUtXQnNtRx6T8A6ncUdgDl/UX/?=
 =?us-ascii?Q?II/KBfMDT8W4IdRxivzBl8vpAzTQPXbqsTPsq/VcnvLVZj5Bycz/BLpc4ah/?=
 =?us-ascii?Q?a4bfict+nRTt3c/EIBaAlB1PJZW+fhTJdc3hI9V7PNEU+dQib2gWmF/XCecr?=
 =?us-ascii?Q?7NfAIgDffxQWaUGx0IO0ZMAAKb2tsPo8LA62jrGRaP2FhoPxwoxS5j5Qq6AC?=
 =?us-ascii?Q?Hll6KHpEOFECtRG49jeA/EocVpmxywig1/OvoFzAQ/6S5EwsAgzp+0mCSTB+?=
 =?us-ascii?Q?UeRpw3QrIVp9hY1+EI5zckDzYnEKzKm2MHEwHZcgZdFhN8h9s1y7tX5dM7s9?=
 =?us-ascii?Q?/7G0LitAKim+DTsLKgvkJa4ZW0HGmIJYaSESlKp15vSCNPznunHAF+61oQbL?=
 =?us-ascii?Q?+vmAIn3OdK+mZnpT5a6C9hpscZP5n0N6vYPzrY9EI/fT01/14seDZTZ/mbXK?=
 =?us-ascii?Q?jcfbRNo+AD3Ww9+KFwVO59CzQmFd0/fWRRqSpdxYn2/9XWEofvq+xTi4JElx?=
 =?us-ascii?Q?2qhKYSZIoDNhtXvWPM3tFUm4/uFHHhM+B0paufBpbaEZKZ2kco8X4zfzjYLe?=
 =?us-ascii?Q?faJDSl2qVPTCztr5TfDNFgEUgPdfdnDIDLdo2DoaEaNyJrTEKiQvWjWAhE7l?=
 =?us-ascii?Q?fifVCbSvv7UJ6TlJEwezaZK5izSpPu5kg4wmGrlaT6gt6MibEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ytbU/EaMfL334+Az87DcdZLxy1HFk78hPGxxZJ6uj+0hbjGMBZg3sY1L6r2m?=
 =?us-ascii?Q?AxlwiVREeNrEzeDIZjc2ZlAWLF0MJMaxOnvcjp4iCfVNcJna6UVKTGnoLlhE?=
 =?us-ascii?Q?2AW6kTetq2w6Er9hKJVPEFlNtDgDhOKMk4SvpmFzkKS4WaTgfIjGsyiyNFxG?=
 =?us-ascii?Q?eCeTcsBqayXL0qzEIoLEXua42AbhDKXOLCgP7YCEzaIDeRNNfw89i1YtMobE?=
 =?us-ascii?Q?eRUvZD/MFgZRsdunWeQMzGj/pfBKVZvpQ0VHoXEfwLETRq0zw3gTPCe23Zju?=
 =?us-ascii?Q?5Y0M5jyvJRXaNWOeE3Hp9/TnYIR+axETeOAi7z+wjNgHysmEcK/S5cwNIbjx?=
 =?us-ascii?Q?7Iz2p/NgdxGw+7xcsZxC968jLo89AgSo4nJVuRacsU/WG4S4tpTQSX1yDnwY?=
 =?us-ascii?Q?C1YkNBLPSiRk82nTTJXRmcZfrYhMwxSo+S5j42clBKthJtQ+f+z+VR5I69x5?=
 =?us-ascii?Q?aFIzJe5p9YhRaCGyyGliQKGDqAGw/gcOVMAn91H1gEgFnHvjxyVTLNAW2bMG?=
 =?us-ascii?Q?kcQwqSNPyOyWcoVvmOfQJII+2u0Yka1OrvfG8bodb+nogJHJ5yHKra+ffD5k?=
 =?us-ascii?Q?BcpXvzkq0IleBIHeBdhOMzv9EsnokCSC0oxnnjmSbwj7aPr5vrGXETEyl1A4?=
 =?us-ascii?Q?JGDX/ci6cdtyLb503pVOiNWAz15mnzw1Wmqyl4fKF6o9e/PLk0mwHUHm1LC2?=
 =?us-ascii?Q?KGHvj/h8cK35+CYwJ94mp8qjSqUs+hn6xoOa2is5vgf7MbqPs+tXd31eJEfw?=
 =?us-ascii?Q?DLWjj11el7seMMluxmLczk7gPggNGbtGKfZTb3RQhbNLMr7dAnn8dGe/1Hmq?=
 =?us-ascii?Q?5zKMFWy1IKcFVlf9nazxPL8kRl+0gY4W68eEWQf+S87f7bJ/wAjEyrOcy35S?=
 =?us-ascii?Q?+ZafF6s0zqFiyCqDz14qsRdmDp5x4cw6h3PeJ9ENjX4KKd8dX6swP0HmULqz?=
 =?us-ascii?Q?vqej+Ioexp7AJ0SxBwYgyp+jv5tkJGH8y/uSlZOPm3FcDLfsPCVP+6ImWb8A?=
 =?us-ascii?Q?Y/Em2hwewQn3HIkOYt1va4gHL4JAaz854O84YTlcE62vhlvT42rHGa81U3Qw?=
 =?us-ascii?Q?x2KNzfABNOOP+8hypiMGKOGUu26pW3lfxu/e0PwAsxThSqaUi7NuR5i0zWJR?=
 =?us-ascii?Q?dgC2WFg9BnH+TmzA6lPH4GDffBFVyTyE/lnZNpKiPzHyAdQRkSqO+MxIpfG7?=
 =?us-ascii?Q?lQMNAV3DJTzk+deho5ljc2OoTuOzR2P/YV0FysC8j19wwrP52nTJk+PcgCYz?=
 =?us-ascii?Q?nOe1qOZgVU8Re4aMSxTiihlgB6ppj+T0h9zHpvY8+yo5bEXNI9xSWu68Ikbj?=
 =?us-ascii?Q?YCJzkluVq+7U+pkj0oqcWFaN+vyZLVCk7DttQCmp8AaZW61snlf0CU+ih25p?=
 =?us-ascii?Q?NOQX+eQgzpOdO5KcT1X11GbcvsNbmEHsgpbhVKbSIUtzQqjRg/jvLPE2Ew2o?=
 =?us-ascii?Q?L9L9ao3c3KPP2tgVFMRhZgJjpbktZ7Wzpr1L6JdJBnavC1eQILZK5dygkJBV?=
 =?us-ascii?Q?FtHRBTclnnV0knni/5h002l2qcxT/PNzrW5rZxWGIuGt8TJ73qMjfAPBla/u?=
 =?us-ascii?Q?gc0zjCXFBEyDw8ELhDGSDIfZdL8BBeuEw3xZDhOv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e630cc8a-3719-4c97-1e5f-08dcc570cc8e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 01:45:44.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjzc4aPy5tAgg/jVYKRU99nZakcyQGCcVEz+iYwZ14Esd9RVuFNWPNt8Kln3atxpZuhumOBJN/0kJCCw74nkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6478

Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
cleaner and avoid calling clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---

v2: use dev_err_probe() to handle error return

 drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++--------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..9708a6fde545 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->clk = devm_clk_get(dev, NULL);
+	pcie->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pcie->clk))
-		return PTR_ERR(pcie->clk);
-
-	ret = clk_prepare_enable(pcie->clk);
-	if (ret)
-		return ret;
-
-	pcie->clk_reg = devm_clk_get(dev, "reg");
-	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
-		ret = -EPROBE_DEFER;
-		goto fail;
-	}
-	if (!IS_ERR(pcie->clk_reg)) {
-		ret = clk_prepare_enable(pcie->clk_reg);
-		if (ret)
-			goto fail_clkreg;
+		return dev_err_probe(dev, PTR_ERR(pcie->clk),
+				"could not enable clk\n");
+
+	pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
+	if (IS_ERR(pcie->clk_reg)) {
+		ret = dev_err_probe(dev, -EPROBE_DEFER,
+				"could not enable reg clk\n");
+		if (ret == -EPROBE_DEFER)
+			return ret;
 	}
 
 	/* Get the dw-pcie unit configuration/control registers base. */
@@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		ret = PTR_ERR(pci->dbi_base);
-		goto fail_clkreg;
+		goto out;
 	}
 
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
-		goto fail_clkreg;
+		goto out;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 disable_phy:
 	armada8k_pcie_disable_phys(pcie);
-fail_clkreg:
-	clk_disable_unprepare(pcie->clk_reg);
-fail:
-	clk_disable_unprepare(pcie->clk);
-
+out:
 	return ret;
 }
 
-- 
2.25.1



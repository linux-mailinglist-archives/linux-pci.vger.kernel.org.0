Return-Path: <linux-pci+bounces-5345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32D890499
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E5A298925
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13980020;
	Thu, 28 Mar 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p3uTm+VK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314C12F5AF
	for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642017; cv=fail; b=hnDO9nlza5NSd0A+tk7IzeH9XVvaEDiupoJaZ6UzGMHvR95DiJ8Akr+mInvted8TgmCEoZeRciMObewLuSfoHVJHORiKzMrNqquSXmZFMgr91LZZVvRkArtn5uY3aMLQk3y+xzQywdfxdI/0RDEdl1nQ03wSwhl7uI+boQ77JXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642017; c=relaxed/simple;
	bh=bZHaWFUIC68f03oyjjsKCv/JGGSaWImXG69nOdyUFoY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VggdBl4z+fxna+ug7YbkdxQ0iPxGmLySKTx4WIg+XpJeYgGsZ1WGH7GXT8bTlAegsYzd1Ylluwi+B+rgaJHbd8YPhOVMM/SdWA76bIE6FCPfV+XkrNA83ep6tN4v9wgQutG+5sa2njFw/lJJuXrkOig+f8bN6Glboz4rTFBQeGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p3uTm+VK; arc=fail smtp.client-ip=40.107.6.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMVmt6R77/T64UWKdO7h9YXgDyMbCukun/ZEgRiTpEgNGKT+FhLlAzwgYBe4yGlMSjmF+yJZVCjvgKPmlAnXvSbL6kjnLvohsNIj0SzCTmf5xl3pX2R4WQsIrpO11BNtte6H2gVUgr8x334+TcT7Fj1s6+p59LW4WeU9JkPSE0jbIvI9+giPRvHW6kgMwfgFvtwNQoojqyZeaDZTQ8w/pdcI54tv6TpvTalcfQ5bA+8tg4wuMlrU6aWNbofuTlSl09K8R5Rj6FAtNg8wKLGZ5Or+JYTn7/xWxrMsTNd0xqqbNZkmGya1NF0hgRukjlubqkh+qkWuSCRSanoL81fdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRX5rkuo9U8LNv72G+bULsW+Uy7YMhbwb1DXsH/ZoXY=;
 b=Qf4usTwcEDg6T6I+nFGKhwYrtSfnZIglLD0IrmXCCQQiOvC9AnYz5LbvOy9DWGbsGfyTtIv9xiDE3TLJFFSsavP5XMBR3xuyV2QvbAvYIdfBraUw7+WT796LYu/8mPXOZ+AOhcxz4q8x1Vk3XOr/8IudBOJRb3Mnt1lQ9TgG9GUSWw4fKZIv69uKAiH8Gr9AWE447iqwqbJnuhRc8NviRiYc5a3rFrDefuzjRAm6dmA9ced/UJf+2cIMMQ5R7NqNYxCm6n28gX8GdmdMLIZcN6nR8/PJf/8jAKqQ7+taLqb8+wXNFXRpD+We0mTul2apChFzxHtDa1MxNDOJbKQVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRX5rkuo9U8LNv72G+bULsW+Uy7YMhbwb1DXsH/ZoXY=;
 b=p3uTm+VKNNM9oJHpNYjsmAm3nYKKg8+UTiOiSaTwFAygvz79BgZmOsl+SSeJVb3n/AIl3QL+sBoId+wBCdNqrBCa4mdFfcHrdvBFc0EGO55FpZoifu7LSlgOwdXtoIQZbF6nP1XHYnMIvQt7+yTZ4EJ7SijvRwLsdgSN50QgLeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Thu, 28 Mar
 2024 16:06:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 16:06:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: cassel@kernel.org
Cc: Frank.li@nxp.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	kishon@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org
Subject: [PATCH 1/1] misc: pci_endpoint_test: Refactor dma_set_mask_and_coherent() logic
Date: Thu, 28 Mar 2024 12:06:32 -0400
Message-Id: <20240328160632.848414-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: fe329af0-c21f-413f-b74e-08dc4f4112e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JCIoHVlzcr4khgTLtPUHMydNv+AHBcideThKD5WcAAR0brgxRucsbTGgmqULzzUBk0Yi8kTDnjWl+DvWeNlyAjFrSVX9LVfG5eOMBK5zXwpl5qRSNW591KlmDim3PphDSHyIMD1mEj6wc/nwb1cpgVJ3//owXXiuljM3s5+ExFsdFcF/ULrC/+q0EymZJJkubpTn9GuOHkKPNlHTvr5XSorC/MrirIsitl4pNZ0yRbCzRwgR+/H+OvIXSiHuHJqJkCJl7zGGGmG0LNDApuqLbCs4nEBvZHxYDYAvsWil6BF92hSW1+PlMgceMCcFM7JYtOfIOISChDc7/GbJYvaeyjbAiNkj4G7iTDx/0mNosaKZeOyTPd3HraQmYLh3IZmewH8jHqQTq+qFVIlBbK7EotOGqkAnpgpa7U+yIcnUx6n4dtEHu4n0p3/tZOrMvnMI5kehbBOmvyhikz42EYcb/EW2aPTJJMeuJDZnV4usYOU1TZmVcfwcFGe0OPMlCyaAg2PmfjVufckYrF0iwyXikCVH+oIn0w/R+YEWxmWHtBoNC5rot8yHVgyCXnHxig/EDQhZBxaQS5Nrld3d5ANPtI7aEYavjUa3sLxu8x0xLXY+I4sPfXwkPUbqkQW4Oz2CE6bl10hDvSK2EUwqNPhGGzDu7xGTu7XJIwmF71RcXmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1zHDJEPCoYzHduj3cpXdKjtPvjNOJHaXM4bjnJwz2FugYct66mQxpZR9yet?=
 =?us-ascii?Q?8kPnUx4uXRi7qKtNLc95NcXhp1n0TlWrzDiZ+h0lN12y0/5mmn8Cgp/r9gmv?=
 =?us-ascii?Q?GMh/9V7WDhqeuxl2OWj1iTKIwTVi2uadFcJqcCH3+gNpsjXBRNA4btMkFImO?=
 =?us-ascii?Q?oVQWDnDemWLkg37BsU7EJkHCfzgjWpQj7kxTRIYXIKnda12hrf1h4bm9fcoy?=
 =?us-ascii?Q?5pf8Opn+nkcfBlikwIEj68kyaqgYb6Q0u1gJGBjWiG5RWc4pJgAQ9YHp2dv9?=
 =?us-ascii?Q?sRjGeTiob+Y7IJI75meXNFlIou1D0qGP0LvifNlkekxPOaaaJbpNKfa3CvHC?=
 =?us-ascii?Q?juIzlOKoeh9I4Nf4Fp+hqEe/9G1oXZv0bSIxY4edWcxbgDl6NnKxXaG1ffVF?=
 =?us-ascii?Q?r51apz4VInCRUFt0tNq0eKZUJ43QPhgvC43z5hFcQ6prqY9LHXU66A74vTC0?=
 =?us-ascii?Q?OGWQfAlLccCnZMilarzeq83qjHbyxfhbWEB0fUIYr/6qQwj4PMPfICDX4i4c?=
 =?us-ascii?Q?P73MYficJcoo9Z18rhFmbJZ4fzgzymV366TNNXJ3pjIiqj1xS0NO/3b2RkGY?=
 =?us-ascii?Q?IhIGz1Q3RwQVzNg1ARfPrdMyOdc1PYTFLb6WiNo6uCHraguP4cH8Y0EXY3+o?=
 =?us-ascii?Q?AF7xFGJtJEQeu6mrBO+Q6tpbq3a7CdsM51Jl5GTfcOLQlvH2O9SKjyRHQWux?=
 =?us-ascii?Q?QQs8qSPmd1d4wM/B8T3AfJMvX3mmDJQX2jECpJlfYb7yPK4a+keHda0+3qzf?=
 =?us-ascii?Q?laQkJNjey/MeeMdQYTY/G+TuD9gTPXckIyq1MiHUA0l7o6J1CTOxZbOJvxHJ?=
 =?us-ascii?Q?ciU8NhKVnUmUpUk021wg838rWIdsz9R3OD7cApgEePs5f7JExJD/E+mpHbqG?=
 =?us-ascii?Q?WyNGni65A5ezqh6aJsvC371pcLyOuQ8gWjQIv4WGGTIvonQsArbCIZ/r/8e5?=
 =?us-ascii?Q?pvI5JqwHLq8I6CVqzrfvQDONg6lLbO0BnjYCaBC4NNhKKYEzFaUhXeLU3JZk?=
 =?us-ascii?Q?sUWk4yuhbj6J0vXVW7lQ186U/By+Fx/mlxmStVUR7L1PCFIZIkH0h3lwRJ+k?=
 =?us-ascii?Q?jqOi98Q2CbxPjCcIX7RFap71rD0Saw8Yan6B4Sj6TQ6Kj66Cr0ZtdsuRZmfV?=
 =?us-ascii?Q?zgeemXNRENvkwkb6ju1vmAABTrz0eui5Y3D8lXwTTeSeSg41SzMSuVLM1u1r?=
 =?us-ascii?Q?4ecwhYO8d2mQR5AUlaizA30yDa+wM2zavd2Np5XYwIvQJSMENYaWGBdGEzQ9?=
 =?us-ascii?Q?pE2avvFZPYQCY22WWZvsjKFEYKabwW4+rOgQWqc3q4uNIRtQrA6guXUFk7u8?=
 =?us-ascii?Q?6LMihVAssrNdL4MyV7mZ9cs7CzqB8x9gquqJOoj5GIkxxYpjkLfqZ+QGnlC2?=
 =?us-ascii?Q?KgRpmnHeatBeolvJZO0mX/64YoQKcA6/78EKJbsJgmSMYgksJq+VLdaA72Ah?=
 =?us-ascii?Q?K4ywZxRjIze46WqfR9A1By6DenTSXXEMG8LRd92dmGrrMa0smQ8C+tMDIvWt?=
 =?us-ascii?Q?RBGAlDTSI65Ouv2Um40vxuZohPqmfQC4oFN4We24nUpR+lTvz2Pa1Fc7/npr?=
 =?us-ascii?Q?ZSXXuV6CNqz/q0SnOqPWEK/i7H5cu9j/cTx+sG4o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe329af0-c21f-413f-b74e-08dc4f4112e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:06:48.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luj0IubnGS7+spJFKgWrSTEVwaQHwFLNnJ6VMPcUSgFM75tDunQA6UHRE1G5xPOl8t+4cMJJQIAE8rkzpR7eKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266

dma_set_mask_and_coherent() will never return failure when mask >= 32bit.
So needn't  fall back to set dma_set_mask_and_coherent(32).

Even if dma_set_mask_and_coherent(48) failure,
dma_set_mask_and_coherent(32) will be failure according to the same reason.

The function dma_set_mask_and_coherent() defines the device DMA access
address width. If it's capable of accessing 48 bits, it inherently supports
32-bit space as well.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Ref: https://lore.kernel.org/linux-pci/20240328154827.809286-1-Frank.Li@nxp.com/T/#u
    
    for document change patch. DMA document sample code is miss leading.

 drivers/misc/pci_endpoint_test.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a73..56ac6969a8f59 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -824,11 +824,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
 
-	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
-		dev_err(dev, "Cannot set DMA mask\n");
-		return -EINVAL;
-	}
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 
 	err = pci_enable_device(pdev);
 	if (err) {
-- 
2.34.1



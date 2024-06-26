Return-Path: <linux-pci+bounces-9322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FF9185EF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCBB21595
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403A186E28;
	Wed, 26 Jun 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H95uvPwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2081.outbound.protection.outlook.com [40.92.98.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E8A92F;
	Wed, 26 Jun 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415989; cv=fail; b=BD6n9Ju7fqH8R2xAM6U7STO3h94owo+EBVP1aySidijoiArC+r2JumjN9nKxWrCsZ/zAkgrjKQ57yTVn5+30wfc5zfcF8gx3d3YyPlPRCWHYNQYrQdSKxbCEO3htAA8//jxk0YBhPBLCgh5g8fns3rVUOjhEDy8BaSrBBOsaP9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415989; c=relaxed/simple;
	bh=dNihwMZwaLHdAf8sigYpMaMG+J4T0vcLn8L4VoPA7CY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QV8NOxp3sn94kh3udU1c8n+vVefSoFScS94mF04sjAG5mhoSDBjq3WMDwkbmhZtdft4mK7nAyPXRR0XaJ9qQRuVQs3k/ckswndcK0+f0g9ixNTJZofWcYuxG3CTMXeG0OHk6miNptZwi+yxxxcPIsTgGrcj0OQNcN5T60JnDa4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H95uvPwO; arc=fail smtp.client-ip=40.92.98.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4iCbu9OMVRLMlVK2/gPa42uOIN3AAzOhmp9BT/A9V2haq8Aumx/ukdPcvicQ6NI562wXND0iNvs9AAbbWt5h30Ku2vcj90qg2egb2lMziVTBh+Udl3SYXeE4t48MHfN7UyRCo5w9a66EZGQ4IlRqtjh+tgNIoYhnfGMhr4xQhFvYglmEqZikrMmlTL3BYI7RIHoMrIsd9Yjr930hwCarP4Nr/TxKLtrDz2IuHYlcts50doR88KKOaOCNMGj3ES96s3lYJXxQ1KeI9zTyjveGVMUFXI/3r8j51zOshmBZDOJ5OfeMJQ+EchR6IX4usOCYF3z/baAVyd5yw9RAlw/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIu1aLMx/43/STFkKMCFChSyAHmP0HDgAsOoNcneNF8=;
 b=grxp6SVR/FLpYHomyek17ffegyhejTfgku1bpv4+aVRQMakqeCimgzPCY9A62fUrp2/XgXJlqseBbADt50BzbT+Aex5/teDvyv3UQCS5OsEYXwH0RfdGwhux9rwN08upbYjX/GswJjcSE+GY+zl2ienFRiUyKConw6iSJE6KwJnIgKGz5ylk7Vr3S1xZUl9F7Qsj02tTQIFXdnYdDS5fzvAMNIjncIvaFIGipA2y/c+TGhNutoXR7lejC2Ey8Gn9/XsVEibvBNnA9R/Q35845ZaQCekDnofLB6WSZxSZvEzRP/H1DgoKvB+u7UNEzTiEg5aEDl3Lfet9F4xutytB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIu1aLMx/43/STFkKMCFChSyAHmP0HDgAsOoNcneNF8=;
 b=H95uvPwOgWICMeJpCd4YI6Gwn5E3ncPQ4rD4Bs/9pS6Ayi2n7u4nDaAHbxgsubovE7+z+jMkwEOikK6l0KBjk9r+UGf/8FHG6HHPJDmiRFi4UeTlnyOm4So3l89RCQNYOZ7MAdDV4WN1EqYStDOb7wLgLzDb/CzZOa8gJHRHmuwfuW9BilxWL5nxEgk4cqRh29joJZVHpgo12IiWKdHIIeGQrmNeOXJrligkz+VpMesawfSNkblj9Q00wOOBMByXjtMmMFGkxG6yhdyhuO3ytORBHIguCFNudOWoBdUt9UbbSKORUZpeQ9ATErDV/EUGvcdsmc0C1D1ehNzOKKiLDg==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by TYYP286MB3441.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:33:05 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:33:05 +0000
From: Songyang Li <leesongyang@outlook.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leesongyang@outlook.com
Subject: [PATCH] PCI: Clear AER uncorrectable status according to error types
Date: Wed, 26 Jun 2024 23:32:30 +0800
Message-ID:
 <TY3P286MB2754DE49E4D1CB87C9256D21B4D62@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/jDDApqGfZ39y6/VnohVUU4Yuvzzr3ot]
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240626153230.21590-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|TYYP286MB3441:EE_
X-MS-Office365-Filtering-Correlation-Id: 72802a6c-021d-4e02-4f22-08dc95f545c1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199026|3412199023|440099026|1710799026;
X-Microsoft-Antispam-Message-Info:
	swwDWH0b1PpFl21NIL4l4/osV9+4ZE5ZS6u2nlntUjVqCa993DDXhlx3ZcrZ/Uyvs2zSd+pvzP/QsoV73BDDaQnn69fFhB1hAHxjpkB/NTMmETPmIiP42d7OlpSt+l3gmJJA2VAqO+TC9M3IF6NtD2C5Iak/+xufS7OxMP83Pt2uiF1lsFcdgHYy6JSP6phQKqZ4+b+yH/+nl1617ajcQl8QVUJM1GUYnKPDZQffwGOjQCBmNkNvqefg88uytE0hYWvkKaMCfdM8+HFmpbbc+okCeUkwh8vTYkhD9PJGO4qW3DNRZcc1sgh7MW1LWkqxqLX+cBdCGHoAJGPgsKaxfoboqHGjf5+afWT5YYSPw+4RYUPDtZRzPaJYHXuNr98ewCtsMQaEPMvypVUsT3BaIfFfjsfovasLyGC+i74+w84cCPjsGnYLUOF1Cvq8uXIBKz2M35Lngkg4lPgYmbqXwGHQpjPpodw9JMK0q2H2E3/gRrxGgwokbQeeZKDkquO2zd0/XdzigOsm9X5xZWZfck+XANzVQR9XHV6LySzTfHureTHi/7/JG/HCQGu3MdyEB7CfgijDUJm6Cy3soJVzPfa6Np6iN7Yvjc4f08KADHyQqkycXESqaui/59hvGcs7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNFkG9f/uEy6kLcNfpnihbFUhXJRgFtHD9/76GMEse3Ganvw2chGka+EM99U?=
 =?us-ascii?Q?KUQGTRzj6/tJq2OGeYQ2/ghh7lQQtJfNzbJoMSxfC/2mp3MvnrW82H/vk/2F?=
 =?us-ascii?Q?7SkcJDSIB8XTKZBXzXv4slJW/zy6u6Ogbq3LkwWxFoU4wBQnwRbDzJaMqjHy?=
 =?us-ascii?Q?m+hz1UwADC6sMn1vg6x6IBtEjxb8Nlkrnld9XhUsFJpKk0nFqGK2UXcLIGQ6?=
 =?us-ascii?Q?22AiUnCtN1LJKI6VU6LS5x1DE+utnIpD25CedbSG+zA4PzAKw870WCRpsAKf?=
 =?us-ascii?Q?1kSHIoYTKU6RZqbLxiGrN7DhDtun3z9qNPMzOKTnk5L+yicXh3vQQ7yMVv6N?=
 =?us-ascii?Q?+c69VuFVKk7AlLwcwBJco2AemAtiOwwekJzJPMSZjVffdZ9k8yyT8CpT1/rX?=
 =?us-ascii?Q?Uthuex5A6mUeKq5vCQyyutF0lig7CmRcqfipWQjfC3o6ELCMTaYqPXWXP4DS?=
 =?us-ascii?Q?YRYNeccNYUW23gCv4BV8VEo4Wp3wDZO0TgdfJL+B8/teYbY39JYe8LU4/akU?=
 =?us-ascii?Q?7hd6qsE+VufGppdB/zu0n7e9IbSB9FbDS7kqOa44/Lrv1NfCe0NeSsnSYT82?=
 =?us-ascii?Q?rZ8VUXi5mOD7IGxcXn1khMZI8zlZEBXxFU/9ZIoN8gR3hRqI8IkygWfIe4yx?=
 =?us-ascii?Q?42p9QoNgb0R5hIWu52xEW6I6lWi5cjkl410rRyr0Lay8dtyaDjYKmtesnf42?=
 =?us-ascii?Q?zGQT0lYJP2dwr1R06eXtfgaKNkoAzlATwhMmeKTaIIFwnqvHEMkZlOJ+hNbd?=
 =?us-ascii?Q?gF532Qyt0aOZr1FqVH66KZUS+JTASPG/JVnYL+waEclTqZqumGYPpwNpNWu8?=
 =?us-ascii?Q?fRv6GFHiTR9SkpuHl7eIDiLza7BlJlcchBCl749w5EXkZet7sAWySQLRZEOV?=
 =?us-ascii?Q?g2j5Vq+k/UehczGlglSAzVgMVgw/YJ40GvQNxBjmiE7unCOsnyrTRnS2DDsh?=
 =?us-ascii?Q?XVjh1WLT2g7A9Rvgt/qeiTepgkn6Umqdz9YKF0dibU0hYNy90gVFHFydFKHW?=
 =?us-ascii?Q?QKqbLXDx35yyvRXJZPVCisqInDQWQGOJ2aP3s4VyZ4cLoK1t5UI1oKY9FCdm?=
 =?us-ascii?Q?78HxoAXjGUcjIvCh5djEeu04r6sgzNF4B6uKjKT89dKXhgA2lA4n1DoYC3tN?=
 =?us-ascii?Q?by+fCXKzwOWyMXcr53afrekCgZ5ckkNwcCImuL+6pnwITp1QlNJpx0dQ3QSA?=
 =?us-ascii?Q?jAbgrjxrsGnDoef1VERdcGnUxCV/xNM66i5f62lxRtUIaOTb4IDRwdNB+ScT?=
 =?us-ascii?Q?ytuqGqwPu1fivbIdwhWr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72802a6c-021d-4e02-4f22-08dc95f545c1
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:33:05.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB3441

The AER recovery process use pci_aer_clear_nonfatal_status() to clear
non-fatal error status after successfully recovering from non-fatal error.
However, the fatal error status clearing for successful recovery of AER
fatal error was overlooked.
Therefore, this patch wants:
When the error type is non-fatal, use pci_aer_clear_nonfatal_status()
to clear non-fatal error status.
When the error type is fatal, use pci_aer_clear_fatal_status()
to clear fatal error status.

Signed-off-by: Songyang Li <leesongyang@outlook.com>
---
 drivers/pci/pcie/err.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/pci/pcie/err.c

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
old mode 100644
new mode 100755
index 31090770fffc..14e1e0daecb8
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -258,7 +258,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
+		if (state == pci_channel_io_normal)
+			pci_aer_clear_nonfatal_status(dev);
+		else if (state == pci_channel_io_frozen)
+			pci_aer_clear_fatal_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.34.1



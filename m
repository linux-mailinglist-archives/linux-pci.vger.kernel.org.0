Return-Path: <linux-pci+bounces-44245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24266D00BAC
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 03:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794F5301D67B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1022E3F0;
	Thu,  8 Jan 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VXVK5f1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020127.outbound.protection.outlook.com [52.101.229.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63789272E7C;
	Thu,  8 Jan 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840521; cv=fail; b=eHfxHUG+XbwbzU/gaWcweYrrff6jy6+Zqi5+Nbq3LGn0Jx2/XhsoooehlKyqKC2hZpF+CGE8oA6+yAF1nEJJcl+huwZU3AU6wcNwai3hxlUbKbLXz7TnH59dyE1yjMxpDST7I47vft7xiZK52jBZzk81/Lhy1woQk4iD1Wqw8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840521; c=relaxed/simple;
	bh=dib5nD5PhWyatgleAGjNwP5Q7ghCRpRC5zsy/cfM/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZxotG+DwIzR7OWIfIvFRdQj/UdBcRtTqNdlSt4HwM6wquQ5/TM5qGd/Y7npSWIeIlzgZj5jU3tYfHAOMoGmDrwt7+UUlLrbyjXiAhzjYp0ytrASEAj52xVAQ3RcrQvAEjVlyIBjk3qyhxnMTTVYZWY2yiIhZwjOmczO8zMEP9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VXVK5f1z; arc=fail smtp.client-ip=52.101.229.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6Ae8iIFMDbbLMQVwNLDKmqei5UG3IaAAmw1qD+8ZY2kB1bgtwCiUFEjfga/TtIZcwNPrzWAEoKiMD4hR51g/7YknVTdwHCqWlsF9KSPX16eHkicGQn4ZhLFwPTYI7ELuH+4lQEUlhGH9lsqjPsTBjtGLiJKXPs6i2USiBE0OGCQc66r4Y4XKos9h0VifO33cg0Tf4T17t5nGgbKPD4Y8RsZ/v93NqijC7IQZfa4MgCSFug6aAn5OT52dges3ywDnjwIChDJ4ezi7ZSofGUOZaP01chAj1iNbuaJOBsdy80zKLvhQKkIAn1IaYG0jUIyrnEF9nlZVTF/pb42zSkqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC8iKsW2LQbAWC0sMLS0a89/T1dojsvk8x+hBDidKyc=;
 b=KGd2sBRWmRHWTrbugB/8FOmHvRVdZlezp58LyGmB2/RFvGkuPMfsUPUIajTHRKYM2jisl46d67Fs9Pk43z2Fn3cp4Ya9OlRFlqibr6ivv2KUyBWIm64CM/m84qKCuY12gy8BeO0vc+2CdH0gE+iPKzZgoTuwZz2+lK0KRdVZ38GLmvKhoPit2ByOg4H/6i7hgXLThBBvIWsJbiIRLDbqRhpWiwSBLc/bWeLzQ/Xubu0dH+uwZ893RGG0cXgCMh/v/bv9qB1ky68sX3sWYGggJ8veMatYHgjBehJsAuEMYnTHFzylhA1q7si1ZiFJ9Omld/IMTzAc7CYiE7FgohGBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC8iKsW2LQbAWC0sMLS0a89/T1dojsvk8x+hBDidKyc=;
 b=VXVK5f1zS88tSH58QniX6nSN1yic7+pNPDeLDIULfUN82Edof7Emx386JCkh04Cx3MHC5XxmoaZhGIXNA4yvmp7soPx5mzdaDWFjsd9Eq3PvGXAtBieEon1a2sz7uUaO3HEML0pzXOq9yEGoCW74U1SjTs5+RPh/iSxyrKfUS8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2688.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:247::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 02:48:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:48:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: endpoint: Add BAR subrange mapping support
Date: Thu,  8 Jan 2026 11:48:28 +0900
Message-ID: <20260108024829.2255501-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108024829.2255501-1-den@valinux.co.jp>
References: <20260108024829.2255501-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2688:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8fe2f9-dd0b-4342-020f-08de4e606aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCHUc6VV2St8PVgODVhZJso0YOXuONNZ/bpBJL8/C2JEj9s1QgPsdvHXfiqX?=
 =?us-ascii?Q?SZtNQ4pdMSrH++sXIGoIW7oVf/JFhbTWxM41h2ZWaHxLF11DHvPCaJMVpObK?=
 =?us-ascii?Q?Y6dWJwjdwqXGWVPdLU9UTGKHnuhXT4W80HKxt3uY7oC9GsiGIBOX/puD/wad?=
 =?us-ascii?Q?v+G/Kl6TQ8lav/rHf6IO0GDk1Rn8J6c3E8tdyy34hKLUCRd9PIbZ1E1J2JiT?=
 =?us-ascii?Q?8etpVcgZ3raqlmRGbGrRdbwa4K9thclUGUH5yQz+Eyw/9KKv1zwINgIn9B8u?=
 =?us-ascii?Q?aJiw84nDg4Wb+4MLakoRFSAhZdQyhCL1jPMKYYou6kap8enDq6h2T/E4MiZ/?=
 =?us-ascii?Q?puD5ranqxhkXhz/aGx0qU2pvu/zObA0TODA0ylbZky7IMh/D6Djd2k5srU78?=
 =?us-ascii?Q?6bi9QRCw/DhUzKdVad8DSdeMg+DlpchxSlE4nx3xeyw290oBKjiXPTxeBvf8?=
 =?us-ascii?Q?D+KLhT9+A6Nc9+SK8a0eObfznHIm0gETPwSiHG81ZjxHZm8iBDCh1euBZoi+?=
 =?us-ascii?Q?87BTKmI94mqGkSzgXErG4176phuL+DLHGrVYv1/K+Jarf5M4y8F02re1nf5v?=
 =?us-ascii?Q?HfONPANETUsOD39nil8WYsx77tYLsIgQ1fQmev7kpC+Hacr65dCNrg/H9Abd?=
 =?us-ascii?Q?mNZ3/pBAfnatnq4nTwH2aUJLu9FZp3OpKJTQWXZOX83EqiGZyTZhrYkfNgOI?=
 =?us-ascii?Q?QimyGaN2lrmxN+TcPk6RQPpjCfj7tdUwGUoEJEFEb0SVKjY3G5wmR9IgGby6?=
 =?us-ascii?Q?miRSRNoFpLw2T5IUCcvdo3Kg65fJMtgnp+PRWBLvgxZfMVk0kgp0j0/lk8dh?=
 =?us-ascii?Q?rL5nh1uRgioZTTYfnQxnSFJ7tcDF1hAHJmtc1vBr8tmklbNosB1sN6zfvPea?=
 =?us-ascii?Q?WtSV6ZbphO4CIpIXnyQ0ljMONGrKyXOERVHLwp6uRol3j6dKUh5LNt8ToYsj?=
 =?us-ascii?Q?CaZw4KiuOwQeJrq+NcqgoUd0RYzo8kzFbAapw8vsb77DgGIOkFYfSfbmlauV?=
 =?us-ascii?Q?ugmC+dk8lmqIk2o1KxqOFmP7iqf2mNG3qD263YyZnSrqsE05sJFFuZFrmaHf?=
 =?us-ascii?Q?SL4XHDbFr0uQNjPAyC3AOG9izxxIDDVOQhAk325xkZTwkcgC4WSkPO7M3098?=
 =?us-ascii?Q?0ldzriUIfBW9ukfpuALlsX1UtQBUBtpzT6UO2AUSsCsr6JrFFGxrqtGljkQG?=
 =?us-ascii?Q?SrNEyCgAUmIUufq2xykqJmNIAcXidLZWUy42b8NlbMSdCbohTQLkZykWD0gv?=
 =?us-ascii?Q?+WenK04J/7Gb4mArudD9DaISPFGIXzW1w+/IXtQinj6Nk2rw3M5hFh0dx0fY?=
 =?us-ascii?Q?YadhYF9FH5P1edbmguoyc4afGcQZ/GmoUfRavDTNG/aIGJ/gCz3eF7/vV88M?=
 =?us-ascii?Q?196wjBuiYzX3Gv6JPvRbCOEZcoXNLNp/BfxkUikDTQunxXeQdezFhdWTG5NU?=
 =?us-ascii?Q?uJCt3ph2kA/KXGcffdMs2/J7EJNfmqQS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CN9lVmu2mHPwb1X897tf7zVVB/kjLrjbfsNUWXuOQYUHgD+6D0NO3B3Ac7Li?=
 =?us-ascii?Q?RA98al2UVQmShNYBkD99L6A67Qyz8gaK6JKfU0ZfAg05rcExqbG++e8Y9aZt?=
 =?us-ascii?Q?UBCBgyuF6ySxO24lN8ZTgpW2cjGqJZgN/5wHR1rO5I4NlqZnIOFNYoPfVYkA?=
 =?us-ascii?Q?d1aHhs3vYevFkSedDU1Oa6KoEDtDmsfZuqGT2dHuoH9R6TRhcAVsqTGgmoVa?=
 =?us-ascii?Q?d1/zpJn54YtybDtPHTFVhsEpoNVeGP7Q9r4XLf/fKO+7UMQJ0M9ZLH6NRXyS?=
 =?us-ascii?Q?gbdQUfEiqKluzq9nhT8dMyZTw0B9Z+ylf/Hqkb6WPS0yU6VJmOdAeuM31Ck6?=
 =?us-ascii?Q?gjvTZlEgPkHWGoxAv5MzxhH+YlArDPC41WHfAb0jN3dnqKP0o+Ia4V7d3DRq?=
 =?us-ascii?Q?yx2sVCrp/s7Iq8TbUnwdcT5hdfSlPPgVGIdyit30Tbgd7iSHzm0xc9j199Kb?=
 =?us-ascii?Q?b3hzGkny3dBn21NxLaeXdxKn886rB6WmERHbFJv2E916Ep7MASevsV56sDpT?=
 =?us-ascii?Q?RdXSE3Kq3q+eWTer7MEnkJHwKziJkbkz8eK7mUnemwhRFyuVhoQiN47DBHwv?=
 =?us-ascii?Q?biXmcMLvQOSsbDOE3BwLPJw9nCPHmKfj5l6dufb9eEf8b7/s0DAsErcKJMXU?=
 =?us-ascii?Q?9w2qhWu8x1X1YQdYu9aZJ3prJGKhOgJUqiwa7tHWPXMtInpCokUZcudDMhyX?=
 =?us-ascii?Q?7SIl6RbDimrbJkoDg//rTUDr7F8DGfbD8pqB1wdBLc/BkzPht87Lz+Gk3pX9?=
 =?us-ascii?Q?A2/f1Ezng4D3FRhN3iCg6F3/I6u4aNti+EAeqr0ALzeSQkKZuPJkdbkkNorg?=
 =?us-ascii?Q?rYEA/8/oTTUftnita7p3W/WmI6o8Fg246autO03eVMjyoik+a/ol2fOOITB5?=
 =?us-ascii?Q?0BgGEuxe3WtpBBQ67qMLCKwB2tK3spCCfUuBJY4XFRv7DhzLYnIFPknN8ZCG?=
 =?us-ascii?Q?ODz4Wkb+6yFFxpFg+66CGkd9ETtis3h8y82tiqhRzd/4yeU4KXbeJIi0kd2t?=
 =?us-ascii?Q?NDahnx0w9C900hh24k6T/82l2bA4Tq8eu7JRaehqauaHKpjjJALox4H+VMXp?=
 =?us-ascii?Q?jf/6O7chHS2fp9bx/MIQ+4NhPx6Jf/yvfwv2IAMmlrjHjLXKP9b+fzMu0q6k?=
 =?us-ascii?Q?nQ4YWj8o8dj9r6I8e2Y1nJa97jxWE/nZohbmhfdwoD0HLpvHJEjIl1K6GtHG?=
 =?us-ascii?Q?pzNNCZb5pNdbbdb+7orNN9CswyG+fWPykBEaltap9sS60FzjMvTKu6PuaUBC?=
 =?us-ascii?Q?wYijZktsXz+cFJuWTzAAnyYXP4qG3YP6ETojYvyJX3yZobLfaycrPLLSjw1j?=
 =?us-ascii?Q?5SWTk70s1W+u4alX5utAFe45OAxYTkok6fiove0L3tHphBYLkQ1G/or5ZpsN?=
 =?us-ascii?Q?k1nbdq5HHbXxX5NcAhm+c3pCkAe9eYuL4CL2UHJKHc7ma+fMxRKyxCumePu7?=
 =?us-ascii?Q?0Itxr+44WK2UJr2r/fGJWqWHNbvan6DgfmxlQbRq98JpIVLf5CBrq+ssCmrs?=
 =?us-ascii?Q?6Cj8LKvsoaiSLjhcJ2jFmxUu33wUaRc4535P6h7cid2g3xnvd5U2zqDP2oE8?=
 =?us-ascii?Q?OD9fw6xqyEzcmuJ1oG1ARLIyukyt6psVQslhGEpBHYTyCWlAEDIwTLul8iNz?=
 =?us-ascii?Q?njvlhMLKVo/aFTD4eevNYvHgT0fcd/nD1BF78qsTmd2Z/OZmD1Z+6gMAWnwf?=
 =?us-ascii?Q?CRBPgmZB5eYStUbmTXinDebSB5aW/8S3lp2ZQDDtEK6JwWY3MHwTRrODT82K?=
 =?us-ascii?Q?ji/ixKa8eb1AJmGN52c0Ozt8Xa5L+U1BD0vKC4vSlSNP30Y4naxW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8fe2f9-dd0b-4342-020f-08de4e606aeb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 02:48:35.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czjIdcQZXnsiT3id2Pvy4rKR/9o54w1AbM2VmfeVpr9RxkzIQRAw+hc44ltYn1f6IffG4jPoUMLtGS4dOihEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2688

Extend the PCI endpoint core to support mapping subranges within a BAR.
Introduce a new 'submap' field and a 'use_submap' flag in struct
pci_epf_bar so an endpoint function driver can request inbound mappings
that fully cover the BAR.

The submap array describes the complete BAR layout (no overlaps and no
gaps are allowed to avoid exposing untranslated address ranges). This
provides the generic infrastructure needed to map multiple logical
regions into a single BAR at different offsets, without assuming a
controller-specific inbound address translation mechanism. Also, the
array must be sorted in ascending order by offset.

No controller-specific implementation is added in this commit.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epf.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..91f2e3489cda 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,28 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - BAR subrange for inbound mapping
+ * @phys_addr: target physical/DMA address for this subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: byte offset within the BAR base
+ *
+ * When pci_epf_bar.use_submap is set, pci_epf_bar.submap describes the
+ * complete BAR layout. This allows an EPC driver to program multiple
+ * inbound translation windows for a single BAR when supported by the
+ * controller.
+ *
+ * Note that the subranges:
+ * - must be non-overlapping
+ * - must exactly cover the BAR (i.e. no holes)
+ * - must be sorted (in ascending order by offset)
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +141,10 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller. See
+ *          struct pci_epf_bar_submap for the restrictions in detail.
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +153,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	unsigned int	num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0



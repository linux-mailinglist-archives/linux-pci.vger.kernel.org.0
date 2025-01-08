Return-Path: <linux-pci+bounces-19511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52BA054E0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D55E7A2AF7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8A1B0420;
	Wed,  8 Jan 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="ZSxlgXT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2117.outbound.protection.outlook.com [40.107.237.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAA1A9B48;
	Wed,  8 Jan 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323046; cv=fail; b=D9rbtlgG3m3vGOGf8IwJKlNvWagP8txTTeE2Gx4R53Hx1WNE8ANh0qy873lRxZA5iMJ6CuogJTi7xdzTcRCJLVSIKddx5/r9t6Nuy1hJVKuCX2mCXGVkeWF7YtXeXgG0juBAyESYo6WSKZjoopOkZ0DlA2t4K2srr8WcOgFgrUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323046; c=relaxed/simple;
	bh=x6aUds+imnqkdL+UsskxJpdGXrxMkpXs88wxEwhpLuA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qKcPbSt+ubQ5QIEDrh1W3noQewYMgAEzUB4+g7v+tsI1tORUhT8zq/Klp2l87H1EcAXqJ69IRAIcDydnhWIbp26BwtPlEdif8w2W1ctTJNDFDm3gaBcHbqY4cGd+przpbi4dCTpVFxcJm2x/DEC67v7JYlUQmicSZ3DESnyZ8f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=nephogine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=ZSxlgXT3; arc=fail smtp.client-ip=40.107.237.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nephogine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrbxKEXeLou1sh0nwv/e2I2xqMABvaBs41v35tTvuASJzdNtobaFIafg7UAZXxxGfV5/IuELxOO/NZh+Jci/rIxKViYcGYkiGmROyRArde9JyvpqIym3NhbzLhzqI28E/DpqjvITvE5n5C1CPap96HAat+RwsAP++c6dzcDmvCDt4qlV4LOf6kKkS+Ud+ilkIGhEIsRMPKNVX8oQ9SmsV/YN9zdbXLFmeSpopQZv/MZSdAhpnfibG3Jj7LyQsXzlKiwk3a/gDOxw8k9Vzyg5A9yNdBJEBfo1fxunJpHJRMcfGKvZP+VzeQ22uCDT2wH2uajmYdKDnXJru5DQviMfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFCqgyY68b17w7CNKXux6FJp1PUHbra2FysB8lRBS8g=;
 b=SChSI6Uhw+fA15zGzuYxlfwzclqYmqYNCl4PDhdYt02eGdy355ZwSZTWfmK3+lS82X81yoUP/LRyYWxwR3h06a9/mKv/a+7cptajbIX3772KFwXGr3Apw/Ks5IN4sjwwTCWApbdYsOgDaj2Zm0THauJw9kM/xQRQUL2UZ6z6mh3qNVUd9M9Wj7JTFbD+H18BLEtHnEPL+7we+u8Qu8akmAxIoh03mJ1l5W3E8DNwJPnk8eyBpHhmHxnMx+GCwj/8cqJTPFPtQa1hDCbaFWUrsUkixFUyYtSSg9bqLa3qlEPrJZh4AJt3CHy2EtwAyu8cxpgaLoefPYpHdm21NQ++iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFCqgyY68b17w7CNKXux6FJp1PUHbra2FysB8lRBS8g=;
 b=ZSxlgXT3KmsVyI5xgECVbQsyVfLMtrRgdETL7tUiDmfYNqh/Et0YgGyns9tqI4XP7q8cgVrWTiFAhv2pOi1YsQlKcpOuz1nt0xErnU58G+aXkfmEkboD7UuvvE2EfNwLafYzbaPBiiHjUzvv4Ks8efVUBFF13Cnsir9MtQt0E64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ2PR13MB6402.namprd13.prod.outlook.com (2603:10b6:a03:556::19)
 by LV8PR13MB6448.namprd13.prod.outlook.com (2603:10b6:408:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 07:57:16 +0000
Received: from SJ2PR13MB6402.namprd13.prod.outlook.com
 ([fe80::b60f:7bf:db6b:5bba]) by SJ2PR13MB6402.namprd13.prod.outlook.com
 ([fe80::b60f:7bf:db6b:5bba%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 07:57:16 +0000
From: Bijie Xu <bijie.xu@corigine.com>
To: oohall@gmail.com
Cc: bijie.xu@corigine.com,
	mahesh@linux.ibm.com,
	bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Add kernel.aer_print_skip_mask to control aer log
Date: Wed,  8 Jan 2025 15:57:03 +0800
Message-Id: <20250108075703.410961-1-bijie.xu@corigine.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To SJ2PR13MB6402.namprd13.prod.outlook.com
 (2603:10b6:a03:556::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR13MB6402:EE_|LV8PR13MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3cbbb1-4c93-4c14-4d41-08dd2fba119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9ZZrhkU+4mRqlV6F25kr3R7Xbvr7W1rjXuqotNLczx7MPzqUq0F9aZO4XbP?=
 =?us-ascii?Q?SHq2TEakcfihiSeuH+9ceV29D5A+sXPbdPAK7lgva0mQD12RGW6j9QU9JJv9?=
 =?us-ascii?Q?wKk984AqgSuDvKc9UvIx1e3ghG8bgCk/6notkJzHNrwPkXqFOj5QDwQH48vS?=
 =?us-ascii?Q?er4i+pxnuQRBR2NoDghkkG03XaR9Pa+QkqORf8BKs4hqSHgdiXAtUtXRW5wp?=
 =?us-ascii?Q?4rcpFMZkQRZcHoBuJmr40DgETQY/ybEUDUUiVZpTdrR7/jEnPlb4abxuCEws?=
 =?us-ascii?Q?c90O3NdRZbEexP1y1kNPIR93AMJOa8m+Y8WVxAzVLFesqmlhPddweP1oJUum?=
 =?us-ascii?Q?QIPwtUpExBjr2AMVbx41C89OlDeKHuzI05Rv5taVoHwl3ZsqKYX5hJrqh+ll?=
 =?us-ascii?Q?oe81mFGfRva1aysCq2zKdnYw4E0Ek1yQnMoSwNf6UJY8iyOtKa4gn5ngVUDc?=
 =?us-ascii?Q?puxRrDqqtVser+QoYJ1Kpjqg9sOhZE+S3atG19g/+OvUKMiWl0B5giq/hOMD?=
 =?us-ascii?Q?V7T6YN7K6wRNvVQjgHN7RyAj7kdkiQpTs7W71ZrEDuCQK6cuiDhjrK4cg/8X?=
 =?us-ascii?Q?DeUT0KGoXw4Tbj2RbgAJrJ/xcuASBA5MbtvCVCMThskAeZC9ujXfnnZBJxkZ?=
 =?us-ascii?Q?IsuuiX/9a9WZA6+nNe3kY/BY7VZ7RaXXcglna4zkGnBqbb2OM0DI4hGI8/pz?=
 =?us-ascii?Q?RmvyWPQR3OOaigncVNy6DZiAaA2saIRDW0YQeyJAFjkfIr08hpe2EjcdauLT?=
 =?us-ascii?Q?4BF/5EJiY1yG0Qplj0u65PYYHoHyGyfH9vJSbd9LYey66E08jR8sgFtYHVyh?=
 =?us-ascii?Q?06iZTt+zGJwHXKBRpJEZGghH4r8ljbJaeDwnHmYW5kTM1Oas33FpHP8TpGWq?=
 =?us-ascii?Q?4AirG/VNBryE+0hSKowWzhqm1l1hl1ihEgb/LndjeE1XQCDd6jq8/4YOh1cY?=
 =?us-ascii?Q?2WzZzARlj4PSkeDPpXyUolVOskhj5gHCJUJ/EVj7FYehzOppgFJ9gmMbltZU?=
 =?us-ascii?Q?EwENtQO5UHDbPltidcahDzuht50mhVi+7vsBJCnuLYJUtnnQZBwt2j9oFr8m?=
 =?us-ascii?Q?jr20cXzJlIXrmvn1QKG9qPQJV/2qqIvn/BN0a0vg4RTbh1UkPzFukqeoqU1c?=
 =?us-ascii?Q?x3K5x04MZ45DcpqvYEinAaBcRow8hjIhKu9661g7IGVBE/A0OBVwXtg8/A1S?=
 =?us-ascii?Q?mAor3K6a4IiN4ydaxcqgvdnZqxjZJfD9EfOA6JKZSgJP5Mrjw32BwLKSvTr2?=
 =?us-ascii?Q?sWLPFwFgAIbuoJrRpW6jWV6pkz08qWHxduuneS72oZVlg8O0cV9cRbUuHEo2?=
 =?us-ascii?Q?izjp/g+ixMx+yHDrvNxbVzTHzg1Kps8OZLcVzN1iWPBAEO82QxeKtpu5JdaF?=
 =?us-ascii?Q?kSYBDiqSe7HykxM9AEnD0EJRaje5iGzXmA0gsRzudijB8Cb0wwWwI+I/bf+5?=
 =?us-ascii?Q?fl4u4XHU3sQhcNye8Z/aAyI56LjCfuz1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR13MB6402.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0c6ZvDa0t86MmQ+hry3G6+H1r/ZNegy658LBCVfZkQW8Jf4hNKZTKyjjwmA?=
 =?us-ascii?Q?XHkMgh8ZCuLxharY+r/SGJPWyFDw8JxTr1+ggFeMddm9mfQkvFdXK7KZbxY1?=
 =?us-ascii?Q?dyqd/+TuubRt58o+cQ/7MEHdqVat+E042wE5mZC1MBxCQpwHvsFyXgGroFQj?=
 =?us-ascii?Q?jkrfCnFe2L1F+lW2tM1nMBAgJc0VnXL+vsTZT6bMQZkp5QPNzh4vbW6LZXi8?=
 =?us-ascii?Q?e/8jA/Fq1YSne9N64f4anNOXzTSbcB3yMsTE/uqjikhQaGpGABqEuDsVQOkG?=
 =?us-ascii?Q?co/caxi24rsXJA3+iWK7MXQqtgI+NoCta9K5OoN7NtSd5I9iqrCPGJF1LOUt?=
 =?us-ascii?Q?5tsMOB2VuLj+3Bmn8Mm0x2UzLarScN4R9Oxso8fGAV2x023i1iANxFDNnWlR?=
 =?us-ascii?Q?WSdpSJbaQLdUxxMfb/6JRusVQBZ4ldH+N+wrnF4Wd+UgJR4pUpZQaksdeeTq?=
 =?us-ascii?Q?FvdIBdsSgTsje3iEzfOagfqKxKGPRgCDZNrArwaqAGxy6YY4rF2+uBb5wgqE?=
 =?us-ascii?Q?Y4/ub2QNfloDfMua76cTbG3wgT5AJkiapkYQW2E5VlC7FX+qiP5DIRx3BXk2?=
 =?us-ascii?Q?10KyvfpXuI6FeP4BRNmDzQixvjmiPn2hQtLn7jQYc9ePmBY2tHmU4v7MXd/c?=
 =?us-ascii?Q?5wr1oxUPhiskaiFGP6re5YIBe6L9IwEVrq3DEiEbh7iv12IMGxRrNjAmLBKY?=
 =?us-ascii?Q?KbYVUndLBbIFtcH0bHctnwM7ysIDFia4Lqnwk7Nh60whoKQUpxVpNlcBZvLM?=
 =?us-ascii?Q?PAtJcVkB8OZGTOSOHkzDQ+SPmJINm5JSOJWSzqaSQhJ/C02xNFqobLxiIsnS?=
 =?us-ascii?Q?8xbzXV/DZSAQkR1Ndn79xTJ0setC3l+jqLIbfD6KKQHjRQqVfytd6xhVamIq?=
 =?us-ascii?Q?4zborsvDb2THeYLP7uSyMltPY6tgzgvyl1q8hAo6hM8eqUUPJ7SNP4H/gaxB?=
 =?us-ascii?Q?Elgv02DLTKXmOHmNWcAnhghDywb8YGpc0Ph8L/I65NMKx2WBSNDa4QMaVBGI?=
 =?us-ascii?Q?KVPBI7qT3vLLkXkpg0Cdc+F9eU3xQSzN6Jy3CU6OECpI0rCfhmXAbWcxIoBY?=
 =?us-ascii?Q?mKzqjpYo1eX/P5t2EIa1j2Vp4j6aUzMa/cmRIIDqiTKN5UPVfR06S4SvYly9?=
 =?us-ascii?Q?f5w06gnOrj4ozkTSEb2s0zv88AClZUqi2ryd6qhKuDXiaQAf4DbuKHUJ4XCh?=
 =?us-ascii?Q?koTItjKrAGtKNUUbJ3+QB6ScMOM1XCNO1K8SICDGhw75I3t6A7aSFmVOrkH7?=
 =?us-ascii?Q?NZgjKM4QSKeP6FFf37wS6Ghbz5HqFeYP7+vPr/O9h/1m8cR3U/oWPrN7V8ho?=
 =?us-ascii?Q?XyKEecNk9+lHskGFITbPItUv7DmzW5RWzrx+IgTSJEy2X4gmuk9fu6CdmfFB?=
 =?us-ascii?Q?LqkgyOvt1VIDPg9pWX4e9VkugS+g79ng+BpegmIGoPw49ChRe/W+dAdHNLMS?=
 =?us-ascii?Q?heCwfUE/Cx9TPYVhtLWPm1hlYlH/q/w4kqd6oqT1jKmA6iRXEsHA07Rqe/ly?=
 =?us-ascii?Q?oUS1Jx6BGNRtLj9Mez4p5YyqT1FI/4EnBCa3kEpt13DYmkl2y6ndP3T0PIPR?=
 =?us-ascii?Q?1tS9+MTfU921eGv5PN7G2nSzR4zO7XTSADEBp/c3wC2Vjqe3IR1hpEDtFCrL?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3cbbb1-4c93-4c14-4d41-08dd2fba119f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR13MB6402.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 07:57:16.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y14LaNg5g+46dfZ2gbewWyv8/r71nQ9KSHznHrLcVHQWWHyWAEHv2SYZWe8On3w/dCiOYZC1K5DPpFagAjpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6448

Sometimes certain PCIE devices installed on some servers occasionally
produce large number of AER correctable error logs, which is quite
annoying. Add this sysctl parameter kernel.aer_print_skip_mask to
skip printing AER errors of certain severity.

The AER severity can be 0(NONFATAL), 1(FATAL), 2(CORRECTABLE). The 3
low bits of the mask are used to skip these 3 severities. Set bit 0
can skip printing NONFATAL AER errors, and set bit 1 can skip printing
FATAL AER errors, set bit 2 can skip printing CORRECTABLE AER errors.
And multiple bits can be set to skip multiple severities.

Signed-off-by: Bijie Xu <bijie.xu@corigine.com>
---
 drivers/pci/pcie/aer.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 80c5ba8d8296..b46973526bcf 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -698,6 +698,7 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
+unsigned int aer_print_skip_mask __read_mostly;
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
@@ -710,6 +711,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		goto out;
 	}
 
+	if ((1 << info->severity) & aer_print_skip_mask)
+		goto out;
+
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
@@ -1596,3 +1600,22 @@ int __init pcie_aer_init(void)
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
+
+static const struct ctl_table aer_print_skip_mask_sysctls[] = {
+	{
+		.procname       = "aer_print_skip_mask",
+		.data           = &aer_print_skip_mask,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = &proc_douintvec,
+	},
+	{}
+};
+
+static int __init aer_print_skip_mask_sysctl_init(void)
+{
+	register_sysctl_init("kernel", aer_print_skip_mask_sysctls);
+	return 0;
+}
+
+late_initcall(aer_print_skip_mask_sysctl_init);
-- 
2.25.1



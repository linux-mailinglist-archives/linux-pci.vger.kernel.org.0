Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F43546780
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiFJNmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiFJNmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 09:42:50 -0400
Received: from IND01-MA1-obe.outbound.protection.outlook.com (mail-ma1ind01olkn0170.outbound.protection.outlook.com [104.47.100.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888963A72E;
        Fri, 10 Jun 2022 06:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsm0iBl+0B6581qMC+YTmn5DNg10t9zXO8uRQ+FKL1ry9kbnlE3S9CFJLkj9Q3WNLbUUGkVJigOFsIfnBNvOpJZE6IJZNAtKsSnelW+oM5bdrSaiUrPVrMlYlyLhHyaouMGNEIeBWMLYSshtIvrXdSrrEHfhQRAv3kHAi5WkIdFmaosVzejKyVOYefv0/rERHnU1Pn/feYD2vuPGNHU4pyma2Brros91ZjQvefHCMa+qo7iitADyTnJaJ32FmpkMH5jLI8n+7OTAvVBS0UQ/1VzAeEjQTkYbyggDpDdoxGnry4wqDKpSupIMsdHbZtyrbgLn6iHUjjyxXITbYJxw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acyhkprnAwRivWOU7DfK1HUoobxYDLTgTCg2dHagbmA=;
 b=HX48VlCfLONgd64LtA+1HyHdKakbmJhdSndMcVWL/gmFKpYeQVg0ccE4hAJ4f9Uzr+IcjjvKncNx77hwOarFY5RMZRg9xc3GOrOTVM2I0BBQz/Y4uOC0CZtzKbbTPt6C6RU/DNsAJQxlmGaaI2cSs+VodCq3O7Wxamxf2FVNJsVl38glAltN6VWaV76gUltbLN0GVvL2JG1u5Mi9FTXY/kS8EK3WxZfBTF2Zzds4z5LhrGY49C8dc5EoVT9Qn6bKKROhJFEH46AgjEsMbSS+mt9PQOB1EIhyHVX4fmdlm61mPtEK3/hf3OLbCwnTrU42ojTQe0FTUDu5BQZjZSyqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acyhkprnAwRivWOU7DfK1HUoobxYDLTgTCg2dHagbmA=;
 b=crBLlUY+S9Jthn6yaaP6ThJ+59BaCd4xFMwcj64l1bG/eTv17whWyq69MXaSP4ZRG1LNr1U8MbnFggk/un31Zls3eVmbDvOkRIndjbJI8vdrYHo+y3v601fmgN8+vVz3ZuTGkPNk5Fg25goQVnk5KmdSSZjmUa5ILgHY+0bKfjplYTV1gDU0HeIqNXX5xjzityDB1PY1Ig1/9iYWshxU2IaXxvmtAUgAvBjFvEifY9JbLSavZ7UKMx9XD/W3uVceC3F7D5rnWFhYQayB7TuImyHQ6ydP6fPXoIVpSKb8hBgsQ/jstpvHR4U/BkO9O7bRjc7ooeG7jQ5aKu0SW9H8pQ==
Received: from PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ce::7)
 by BMXPR01MB4551.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Fri, 10 Jun
 2022 13:42:35 +0000
Received: from PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1ac:6386:9aad:ed03]) by PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1ac:6386:9aad:ed03%8]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 13:42:35 +0000
From:   Wang Wenhu <lonehugo@hotmail.com>
To:     lonehugo@hotmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        bhelgaas@google.com, gregkh@linuxfoundation.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, mdf@kernel.org, trix@redhat.com,
        yilun.xu@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, wenhu.wang@hotmail.com
Subject: [PATCH v2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c files
Date:   Fri, 10 Jun 2022 06:41:54 -0700
Message-ID: <PN3PR01MB7725A0E10A2460E52EB7EBF1D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [U7qcCK0HBUJV+RUYOr4p8yYMCTEulD9H]
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ce::7)
X-Microsoft-Original-Message-ID: <20220610134154.465343-1-lonehugo@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e979b2-0c7a-4861-17f7-08da4ae712fc
X-MS-Exchange-SLBlob-MailProps: GBVYZS+v7b2Pv4YEtwLqbMQTCCikhSryBlZIKr71xFkWJ6qCy2H6U8ujs+ozAN44YDzcMqupm2m7Q7k1imi9eQutgAFmDT5MDY1lp3XDvbsqp68qMUNYiOPtDmBXFo4qcGOzCCxnlWR+lBWXqsURAOiO9kECGe+vwCWqAzMtpJhk1gTCECZQJSE2/fmjCZ3ExTiHW+8MoozCAMeXF6lXLYDVeYYwKovVKVB0d0icUp9CrMQJ7t+QWgYPMe4iIN1o7WOm1GZSgIwPmxbqwZ/mcQUh1LROmFvjw8l+hfbr4Y3xLtzKEYL6mjb2y9ndsfZZDU46BhSzbyD6segD5uf2zk7ApmFrEwHb+4RlmtvZvYuXmQizmExKn8TcH9fJ1lAXYcSaW/xSnV6R4S0k352Am3YQZGOaO9TyxXuBcMvpx92+auLQqYVf4vyLrgfGrZcoGdXW8c0eq/S4a9tj174y/6sEHDh9RXu8H5bjEHdqlx/K3sUcR2fL6c01Z9xB1YXB/g9qjdcM5SfwZP9Gu7xzIk1k2sDdjKZ5SpaZBRm3kcbp6meZ94yh0oatj4yVNYGv8QG+zWBDcKr7ps13aO5GltRs/WhG2qbxutXey9QyKUiZU1cWfB5Qx29iWn2T5QM3aaDv0ZcZQfJmuWWannHzKFl+rUvTs9qlpFIbnWJUGUBOZKmaqVy+gDm0H/7vI423iHgKwLFwfQjnybtYuWhr0aiAUGszHQBEwrFpCSXMy6cDdZvaOOfyubPzcyVHe8uk/SvvdEXm01gmKpC914ZrB66yN1x12gJWbBiZGR8WaPxN1LkgGQH2ks9PFV+N7HRKGbN0tsTd7lk=
X-MS-TrafficTypeDiagnostic: BMXPR01MB4551:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdIfZOybtkli6FAEkScxL1rAOp81LOAgts2CTi1I4Za/81ucZ/h/cIXUpGeJmZGm5dF8QNuOwR02/kYQmCYWaY9EBm2hotC0hJZZq7FBUKu9jG31lqEmYzirvKeWpTW3MUjdMC/9n00dJww6DH75unoscXHbmqWhNmIp7153Vc3ZIk7j48OsgSI9ljfr/OMVS6NNsZDAo78M2/kulqtHXbrhvNyLz2voSwlSZbh1e4nsLeWneBRmOV7tpKoSS6L49g3Z8srdFpaMMo/ilnktn9ZBQoRg3vNbgHUQTQTip0LTgy6Jw/qFlElhk2rwcvDAhQuCnsXh8wxs1GclA4a7VyX+0y9gpqt2YScsKxnMfUOARt4IHXALyJsf7qf8EzYPIXb6KZNmWanuPNy+uohSKQesuR+Sj4olcnxS6Ic/22FxnEIteR2Kjx0UuASHB8PVCBTGfTv9CkzlGvns++j5VwLUk8Ts+0Aw+JNWzrXzYfwXH8tXJnqMDCbt3lbXs6JfMO4yTHG5a40TBgBFcXBiTdR+3IKJ0O0KqZrwmLQzDbci8OKbJDhp7hFNFjFRVyxCTeWarYx9MFQWqXomkDD2x+HC8YbG/V5WsG3YFo7kwM0oEut8AeoEukF531HthvNf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FQ4AabuE6sY3V0IPfHoL2C7/ovpDTWO5zK2SbYIKro+nAgmDTpLeAn4aAIw?=
 =?us-ascii?Q?8wmljyHfdvKElZjvw8y7NeAtY2gD9AzHZf6jVdbPX/1dT3+MtST/9UK7WeRR?=
 =?us-ascii?Q?NzKWMUU5GaapOBp1VNvR/dGl32nS6RIrRe4qFoJ7IIAZ9WGGI/wCb+Kj6C2Q?=
 =?us-ascii?Q?l5x4JMY5zQKspWzehxa1yXETEsi++2Q0/rERgj1bMOcbGM32sQFZ2FkKOmYB?=
 =?us-ascii?Q?Mo0mWpbZP8tg53UasFDWl95NA5+ScL78FXdhjUe4Ht67cl97zIz5II3jy4nf?=
 =?us-ascii?Q?FK1B1EsdrU1NLGJ9ISAYjf/vS7TgzVS+4oAcPv5PNv4AHABDdFAo9Z5yGLwk?=
 =?us-ascii?Q?FaSXmyAiP8d4b6ckffX01h1oaWnvn3oeVnN5BdtLT3LXnNp8DfOV9aWo7NfA?=
 =?us-ascii?Q?g+Rxd9a2qtY05FoFvAuMH0aKLRReHYiF/SdMq6JcWIRGbU0JUIgmkIT5SQzL?=
 =?us-ascii?Q?9E3pSZpLY47tffd5+qF1IclXQNQkZekPx+cU4XEVoX7+5fe8t0K3akkBVNGw?=
 =?us-ascii?Q?GllxKRbHQVakg6CXMHjQj3vPrxBlMxATACy0F0uNzjzBc08arzS+5Yp2bWkN?=
 =?us-ascii?Q?6hXFoY5MKZ75yQ84nAT1Xvu2nqMFtvjsgW9QJtef56/45MA9FSdLsWoEdHgd?=
 =?us-ascii?Q?/yvF+i7EdcctxJu6341Qqm/FH0crivEH73ld8faSgWbIMb+PZYy1CFEdK9pe?=
 =?us-ascii?Q?jhtc39/TTz2aezJkuc03LjEbwZFv5yiWQKj+pvGkDt9vLwpGgIX/6f8Mc2fT?=
 =?us-ascii?Q?D+Nqfl1Ndbyce1TX5aSsP8nasQU7ZW8ziE4OWtRQaepBWJuh1+6grjCCiR3D?=
 =?us-ascii?Q?gatN+i25N7BbTNiQZ/T4/Sw3rs99m5Hral9kTaoyaQcsdk6Ae92q1OjDtZub?=
 =?us-ascii?Q?3uOQf1gvfXlfsbzCaT248698LKNacWc5bg7sXJXF3sM2hVWrlEL/x3/3TBDv?=
 =?us-ascii?Q?dXj9Qq1fb6Ku/8FStfap7lT43bCpTDgD6ro7KpspmLbM3Lnl7hC7ol+o9NKD?=
 =?us-ascii?Q?OZkntjFg39MGMudc6a7n4+pSttzlgIxQRbiB/OSl68Wi2PA2DrIcJ579lzuY?=
 =?us-ascii?Q?4M7iZL5VIHMAkJ8X3FAl1BbImEoUmfQB/y5bG2cU5yzl5LNLmbIIbMSFGebv?=
 =?us-ascii?Q?80AGRJRSOo0JUTYSSlJ0Ri14eZZL2Ilar2eqHKrtej7t/Es1gBsFhiGOGqtf?=
 =?us-ascii?Q?nHDpfLT0AAM7k1FklmVfsOxkEsPmybhCvWvTkrVx3NO+YBpBiIoQJGhfe0vd?=
 =?us-ascii?Q?gwrtugGNi9upTO2ggKZKtEuz/zVIHfD8V4+A6z8PUJ8LfanVHambmWLmxOWh?=
 =?us-ascii?Q?LeTd6bANKsRly0RZ/pvUHDq718SRczPHbGkaXc5ULtyCvNO3fAh2h3MpgBdk?=
 =?us-ascii?Q?j1jL5Z4qD2PMzdjd11PnjCNIrZfKGsCmRigNnm5hElG+77L4vdcE6o6x8fkQ?=
 =?us-ascii?Q?9ujxFq6WZLY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e979b2-0c7a-4861-17f7-08da4ae712fc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:42:35.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB4551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is recommended in the "Conditional Compilation" chapter of kernel
coding-style documentation that preprocessor conditionals should not
be used in .c files wherever possible.

As for the micro CONFIG_HAVE_IOREMAP_PROT, now it's a proper chance
to eliminate it in .c files as we add a no-op function defination
in the header file if the micro is not enabled.

The main trigger for this patch is an UIO driver series and as Greg
commented we'd better not use such preprocessor contionals.
See: https://lore.kernel.org/lkml/YqHy1uXwCLlJmftr@kroah.com/
For there is little work to do with the UIO driver, I try to push
this commit independently.

Signed-off-by: Wang Wenhu <lonehugo@hotmail.com>
---
v2: specify no-op function definition with static inline
---
 drivers/char/mem.c          | 2 --
 drivers/fpga/dfl-afu-main.c | 2 --
 drivers/pci/mmap.c          | 2 --
 drivers/uio/uio.c           | 2 --
 include/linux/mm.h          | 8 ++++++++
 mm/memory.c                 | 4 ----
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 84ca98ed1dad..40186a441e38 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -354,9 +354,7 @@ static inline int private_mapping_ok(struct vm_area_struct *vma)
 #endif
 
 static const struct vm_operations_struct mmap_mem_ops = {
-#ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access = generic_access_phys
-#endif
 };
 
 static int mmap_mem(struct file *file, struct vm_area_struct *vma)
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..833e14806c7a 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -797,9 +797,7 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 }
 
 static const struct vm_operations_struct afu_vma_ops = {
-#ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access = generic_access_phys,
-#endif
 };
 
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index b8c9011987f4..1dcfabf80453 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -35,9 +35,7 @@ int pci_mmap_page_range(struct pci_dev *pdev, int bar,
 #endif
 
 static const struct vm_operations_struct pci_phys_vm_ops = {
-#ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access = generic_access_phys,
-#endif
 };
 
 int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 43afbb7c5ab9..c9205a121007 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -719,9 +719,7 @@ static int uio_mmap_logical(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct uio_physical_vm_ops = {
-#ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access = generic_access_phys,
-#endif
 };
 
 static int uio_mmap_physical(struct vm_area_struct *vma)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..60c183dce5ea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1857,8 +1857,16 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
 		unsigned int flags, unsigned long *prot, resource_size_t *phys);
+#ifdef CONFIG_HAVE_IOREMAP_PROT
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
+#else
+static inline int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
+			void *buf, int len, int write)
+{
+	return 0;
+}
+#endif
 
 extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
diff --git a/mm/memory.c b/mm/memory.c
index 7a089145cad4..79b94db1bd5e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5437,9 +5437,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		ret = get_user_pages_remote(mm, addr, 1,
 				gup_flags, &page, &vma, NULL);
 		if (ret <= 0) {
-#ifndef CONFIG_HAVE_IOREMAP_PROT
-			break;
-#else
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
@@ -5453,7 +5450,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 			if (ret <= 0)
 				break;
 			bytes = ret;
-#endif
 		} else {
 			bytes = len;
 			offset = addr & (PAGE_SIZE-1);
-- 
2.25.1


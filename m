Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4157546214
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbiFJJ3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348964AbiFJJ2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:28:03 -0400
Received: from IND01-MA1-obe.outbound.protection.outlook.com (mail-ma1ind01olkn0156.outbound.protection.outlook.com [104.47.100.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385814CDEA;
        Fri, 10 Jun 2022 02:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZtMlR2zaIc0sfPIWHGjbm1cH4jWP9KRFbzkA5e6PCt+6I5wzzU4PmOk5OB8xbGi5LgPMlX71wnp6E7NgBfw1bD2/RI71qVggkL4KBDvrci2QeEjvylfsyKqfT9lwIP5xPYn2Vrlhmrxbb2WF0QnrbBn/GM5rpEnQYv90IaaD2X6+oazQFV23bcfVf9jewPk5VQm+IobeVNhI0e1teW+fyi3CojR0BBoh1kluxLELGEDr66h0GQzVSBi1qr+mJ6JeX6RKY2P/Bd76ZsxLQMQU9NwZZc0wdGMcwPuUObuu+5BkTgvE9Em/zCp0lVHI7UlasGZSuAFeMEd7zuS2PIjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TdZBuflicFTLYNBf2sjs0BVt01Va59/J9D3D1NDCN0=;
 b=JzT2XFRaepzLXbK15dx0IjWg2Ca4t4PeJzzOxldQnrq0lmhFvM9eDykNRkvvjA5bLZxqRhY/ufg1D3nHec6mbhWieMesDIvLcs6VPIkubMXrj7GTbfWLv51I3q59Ij12i8zE/FAPXsXhPD8Ubxyb3bShQMgjmMFqQRJ2407pSn6RJj8kiHCOSl4b8w0OhdecXK8txd+D1rR8PoiDKS1oH9qWJbBU8jFYk78Jro2/nm8UEFhdb1AnD/gqOaRG/PxDtZnpPEtMwv6QTdwVQyag4F3UFWdhQZIrvHC/qvcevonj1Lxh5vNy9gi69ELZUH19v0rB1eJqtYR1Gz0FW1dAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TdZBuflicFTLYNBf2sjs0BVt01Va59/J9D3D1NDCN0=;
 b=ewJuYhUuMcww3nlZZGblbkZv8g32+ZYVh8CsuF1Kq0P35UXfjliDUL9bIKNR0KNAH7+3ffWWK5VjE49zUBL9+W3cou0caO7ercdPRjNzZuWXkNsbhtrxOtB5Ca31TSVQASJvfkBIeDK38go/3BSAQfyjH1Pr9AvajkqyxlPR5KDo581iDbJNLjVlTdg2iTrZl/aZz4os+P77qAGsdjsnmj2mkyax/kdfjnzETPUjECudBEGpxThGawwbM/HDKJtZbSrjCBC3AXi0v+jD2UsnaHTpScsLXgfzpU4i6XdvrpZLvfkZJpTz187ul5AuVmOupuPK+vEg5UIqvHesT4zVJw==
Received: from PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ce::7)
 by PN1PR0101MB1934.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Fri, 10 Jun
 2022 09:25:41 +0000
Received: from PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1ac:6386:9aad:ed03]) by PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1ac:6386:9aad:ed03%8]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 09:25:41 +0000
From:   Wang Wenhu <lonehugo@hotmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-fpga@vger.kernel.org (open list:FPGA DFL DRIVERS),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Cc:     wenhu.wang@hotmail.com, Wang Wenhu <lonehugo@hotmail.com>
Subject: [PATCH] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c files
Date:   Fri, 10 Jun 2022 02:25:18 -0700
Message-ID: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [zQ6ziTVMmX4xb/X+yEgUKuoJJeq1mzpb]
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ce::7)
X-Microsoft-Original-Message-ID: <20220610092519.346264-1-lonehugo@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98476aa9-db13-429e-e0ea-08da4ac32fd3
X-MS-Exchange-SLBlob-MailProps: GBVYZS+v7b2Pv4YEtwLqbEhkEDSZsWZfdla8BXNG/YmlgR5gH2pAxsgGeo9hPpfPrBBkdkSD3sYZbdcs+PqduhkJYDlhUoB00LK4CIMt60K9hxTgRR5k5grgmJWlXbqI/rE1HBrgbWpokqc9e4P4pWjyxLlncA1LO+ufB8wvaOEVyO2maLfgDQSaBxgzlLg1HTQU4N5nnhFgABgPIBYx4YUspsCWgGesPMXkLQzLAaEvfEdE1R1snMSroYhx/7zcJ/5ua0f8kQfObLMEPz8PhG6PeXxBk6qPHD47FiyZG4Qx4fW5HCY3eogHtBR7tnYmdagRL/cpqIi7LB2qAMeyizQKbtetcydLBpLw/qBJjjw2+iQI7G5qekxe/DD8HrIGeeR5czfcMbXaPgbR65Lm4FBlVWRkKc5jpMPtWz7a+LJqhRX3Mg1U+y+xNWMW+Qtt3RwvPKTfR/3ITtkw9gIKEkvK7zzO5irhVgSqzGp9348QjP6oogjKiv9Mx5VuSmY1kSbZKjtvaWrHdfHRnj+oskHJ7M+Yp3lf7zmW8dUzULAasYt/CENSUFpQNnPCaGgdbEozoewUutkxry2qhCPfC+12TSEbmffkhIpZfiOOTLHgvNpPtozsYMP7hEMMoNl1SjwK9bDST1dvyioXUd3t6ADWgm7xAW3Tw3GX3q9AQa+xFgd01aXzqKCAzbI3/sMaivhlcZQxSIWJu7mwBKS58EoXDUmQB2xW2VKQZFZ/QeXraZaT67y1vSOS1o+XbD7pFL+i6K/4ZB4rGdZDRiPlvkgq+555vY9IZMmhgxcxC+p8Xveibdlo8aHTXZ6o0LmnpIGx6XON18U=
X-MS-TrafficTypeDiagnostic: PN1PR0101MB1934:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JODbfPBfcm7O45RlMcBHh6SFVhwSdpLFUG1jIMTLS72Yj121vrJanPLx9FQD0ZTjBfjCXOJkNtiDVMKZgpAmQLNbNsBZGRH57KapU9+Tdmk4AhfP+cU8TFOeYpbEGhHCDp4gG30xUUO1vKbiCQRZ/GMvWOvLXZJf2uSJTUz9pUBufaFH3/EA1mjIUUhcCXfsPgCwQ+vAMSWDr0danQgnpu0/pr0IX/DJqRDORphW/7VG1RSoFy7kkmXrdAPA0Hi12NSVQ2ogfcs09i0KYClAdwHQ8moQavJe4H9FCOMqOdSwfpdRFCUoTFd+JAr7VYwDNncqp4oWMdXoqDXCnQznCIzx/peoD5Cf1BHELpDe50tA8p7OdUoT4vIuhJ9lsU5kO3ECIGwW+lI9feCCq+a6/u+fMTPics/5PMZlXJTAB/l1gxzHryedwzjeqCRO3L7/6RSEVXwSwXhFcxmXFz5X8F265JZBIyL0AFKMaYcdCiQJJTLsnmhbwrp31pvHt+jfBMhspvZOupbdGY4F1m9QbcLNjyFkXJFLIEYDwHcBYrI+my9nnW+g7P5Sh2I6XUZfJKmoaBoKD+2XR9WQYJVk36CCoLrQ3auh3Yjlql9nfpgfBQ66K86Njihy/oL/wi9P
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keS3ciAMZs4QXo2pFSBBeX1oqTumsX/V3w6kzwsouyJPRctOBOsLG74Y/VER?=
 =?us-ascii?Q?UeO9M6SKRP6eF75I9XgoW7HjjfqQ1mbR4adjG3ZOkeYOcjajjYufPVDP+DG8?=
 =?us-ascii?Q?SP31rrLTLlhram+b3ZcHj9szLa/geC2HSiyKdTCXATOxNajHsWPWjaVsu7F/?=
 =?us-ascii?Q?L4s9gilzJsg/UxuOLZY6VcpdEOGpWtR2SaYUbEwe/ImZVEajyLOKjR1YQSkZ?=
 =?us-ascii?Q?/XlidFHcyoKbE43TfK9A6nut0o5lfRzl54QJlCOTRSKd6dmwEidRiRbXa9iF?=
 =?us-ascii?Q?gQUpeWYcXNNnLsC1vVoIs+x16YYwCw8RGKEHA1qJir+8+pP4CG2N01xadRbc?=
 =?us-ascii?Q?jmyFJ2H8upeNzvzKWmuujTdGvelTK7MPoB3yQ1tIBbFYqNGRgEg8w09C9+7e?=
 =?us-ascii?Q?3v/1o77g6dx+XRyTXgsy+FOn5xdYszc2mmYqwQQX8pWvhKmqgH8wE3AE920c?=
 =?us-ascii?Q?T2i7dyipHa9HH72luSWd6/tkuOQ0ZbaFd7ShtdOOcLW6XteUaZXIVSh8ZIW6?=
 =?us-ascii?Q?cEIZ/MAAaRNj7lWgmZfq/GCY+X95WrsDstyGZ4HILjtuQERnX5a8aQab63Fd?=
 =?us-ascii?Q?lwE9RXkjmCQ7tinAN3AxblP6DFAgwgj8upuZc/rBmahA4v+VPd1T3LfpMMiz?=
 =?us-ascii?Q?4yC6pn6WnioTnNp95jNuZxyNMDA6x+WdNXRNOD/7Qa3NaxTPtxTfESPqR0OR?=
 =?us-ascii?Q?/0+BaPPHbzWAUCZrv9w/Xv9acS+lCsWrMNcXgAu+iYPeVvEZsyZ/WtcE24Eo?=
 =?us-ascii?Q?qvkXJGOzVCpA2pWmqMz7FBlh79fxJtsv77CXbcRUtnymPTBVArD7qhCXyL3Y?=
 =?us-ascii?Q?BVvpP9bzt9tu8xv2CU3nDOjdTuk8rqu+foH/imlVGix3sZGNnAPQjZas3FYX?=
 =?us-ascii?Q?u8W8ZqgU6OcW2+w8d4MSUnq5AJRAs/UoSBCLN4i4mdVkPPBg3hSNU/pZLy0E?=
 =?us-ascii?Q?R6ERNPj41UvhG9vKi24RXUYwu6Luun9IvgHQJMYmBy4CqHobRIVQXeODXinZ?=
 =?us-ascii?Q?5+hMXE12AtCIo7tkIvR6p5V/Kf62Mi7BErTOLafvH1W9E3s6hyfKtcofOcMn?=
 =?us-ascii?Q?gbxNCUsew9k0aj6hoS3h7sH71zhyGbkt89QEKm3L2PXcFmxDETP4KonmvhCS?=
 =?us-ascii?Q?xRG50NwpISp1T1AZnhS6wkctkaUcMh2ZdopEec1vAxtYG8oXRxY2P8cza4qh?=
 =?us-ascii?Q?sSeZG009/sJoE1OXjctvrPZSMweBxt8Kym5TOqNkPoi/X90hBNpOc92lJvhQ?=
 =?us-ascii?Q?IKGBc3mPmE2McRSTuGdTVPUlyYphBh5jXiBGP4OeYBXaHq6JETjTFF3y5TIB?=
 =?us-ascii?Q?WxR3CmCyrd+aZR+G9yrzLUTQGyP1wkOMZPt7P+5kl5CWv4vBqVgJLWf3D/oe?=
 =?us-ascii?Q?HJtZxUWNN8BU+/dq5iXQYSIZRgA8kHlsZeiZthBT0d8Om3n13GJHp5V8Ouii?=
 =?us-ascii?Q?ypAZnO8lpDI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 98476aa9-db13-429e-e0ea-08da4ac32fd3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 09:25:41.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR0101MB1934
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
index bc8f326be0ce..66d0cff6054e 100644
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
+int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
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


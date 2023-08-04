Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6876FA61
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHDGrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjHDGrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:47:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4A5244;
        Thu,  3 Aug 2023 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691131610; x=1722667610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p9K9edwregzUhDUBhwKOkviRf4+2FT7ek/znin6wgKw=;
  b=kkOHTtfFTBd6rIJDnGil+tQhcNN3HYMTGCDXDnsxVX7zb8hWRW6s589G
   p25M1upJPnPSiTxZTx0QbrCsaRWeE+qxr0/CR1FcmddMlDVN37Z5roXEy
   okh8QaLaWJCwUL29QjBMoLb/9jC/VuxF/P+kLnNYC2gYwuqqYsnuxDwEX
   sxsbz+WMo6guA4boiI3ko5c+lIPCNmAZy7bS8mZPKYyYxL9zYhCy3z79I
   YbzRbEjVeKOe13EFac0y/Qlo7rdFDeReueyrjFIGUBk1D5h6VguEhr1nd
   Hi7Z7/JuZw2YVNeRylkpp2drpq7R4Up6m5gen1zqOwHReUVP3sceJyxkE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349677291"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349677291"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:46:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733091085"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="733091085"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2023 23:46:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D858214F; Fri,  4 Aug 2023 09:46:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/1] range.h: Move resource API and constant to respective files
Date:   Fri,  4 Aug 2023 09:46:36 +0300
Message-Id: <20230804064636.15368-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

range.h works with struct range data type. The resource_size_t
is an alien here.

(1) Move cap_resource() implementation into its only user, and
(2) rename and move RESOURCE_SIZE_MAX to limits.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: Cc'ed to Andrew to pick up
(I believe with Bjorn Ack we are fine to route it via your tree as it
doesn't change any code behaviour)
 arch/mips/cavium-octeon/setup.c | 2 +-
 arch/x86/pci/amd_bus.c          | 8 ++++++++
 arch/x86/pci/bus_numa.c         | 2 +-
 include/linux/limits.h          | 2 ++
 include/linux/range.h           | 8 --------
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index c5561016f577..1ad2602a0383 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1240,7 +1240,7 @@ static int __init octeon_no_pci_init(void)
 	 */
 	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
 	set_io_port_base((unsigned long)octeon_dummy_iospace);
-	ioport_resource.start = MAX_RESOURCE;
+	ioport_resource.start = RESOURCE_SIZE_MAX;
 	ioport_resource.end = 0;
 	return 0;
 }
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index dd40d3fea74e..631512f7ec85 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -51,6 +51,14 @@ static struct pci_root_info __init *find_pci_root_info(int node, int link)
 	return NULL;
 }
 
+static inline resource_size_t cap_resource(u64 val)
+{
+	if (val > RESOURCE_SIZE_MAX)
+		return RESOURCE_SIZE_MAX;
+
+	return val;
+}
+
 /**
  * early_root_info_init()
  * called before pcibios_scan_root and pci_scan_bus
diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 2752c02e3f0e..e4a525e59eaf 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -101,7 +101,7 @@ void update_res(struct pci_root_info *info, resource_size_t start,
 	if (start > end)
 		return;
 
-	if (start == MAX_RESOURCE)
+	if (start == RESOURCE_SIZE_MAX)
 		return;
 
 	if (!merge)
diff --git a/include/linux/limits.h b/include/linux/limits.h
index f6bcc9369010..38eb7f6f7e88 100644
--- a/include/linux/limits.h
+++ b/include/linux/limits.h
@@ -10,6 +10,8 @@
 #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
+#define RESOURCE_SIZE_MAX	((resource_size_t)~0)
+
 #define U8_MAX		((u8)~0U)
 #define S8_MAX		((s8)(U8_MAX >> 1))
 #define S8_MIN		((s8)(-S8_MAX - 1))
diff --git a/include/linux/range.h b/include/linux/range.h
index 7efb6a9b069b..6ad0b73cb7ad 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -31,12 +31,4 @@ int clean_sort_range(struct range *range, int az);
 
 void sort_range(struct range *range, int nr_range);
 
-#define MAX_RESOURCE ((resource_size_t)~0)
-static inline resource_size_t cap_resource(u64 val)
-{
-	if (val > MAX_RESOURCE)
-		return MAX_RESOURCE;
-
-	return val;
-}
 #endif
-- 
2.40.0.1.gaa8946217a0b


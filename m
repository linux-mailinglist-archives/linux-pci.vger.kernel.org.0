Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8C74D71F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGJNME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGJNL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 09:11:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28EB194;
        Mon, 10 Jul 2023 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688994704; x=1720530704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJgY4ciUiCYZnuYn9MihHuASvS84fRZSA2ENwfBYIiU=;
  b=LUorezlukmWp3Vh4ech/a7g+ulF1IxEc7VJO5c+BGVmDUff7pA9Ukgwn
   uGkuz3F/rm22RAmzHM4vCHPV9dLIQ4meXDXdIaujYCcF5+tCUIgNa6dGV
   D0htRAFM887s4Xpu6e6pDt+Ply7H+EAhVxR6jzxmY2icYrnBITrvNAJzW
   SeUR43FgYoMxeqprniKUa+dV2dRp0Q5lFgO6xqRW7Ok13DC64PtjBDK4J
   xMxQIL6gJsLp2fQjCd81XyQlUjyPfJM/3EtscKgpPh/qT36BFj+jiXE7v
   xUW8m48FSiiaKlv5VwSgsCIcuAm7ioB8/5YzpVCAq/VM0MIfx61lf/w+i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344665577"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344665577"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 06:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="697985342"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="697985342"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 06:11:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1152F1FC; Mon, 10 Jul 2023 16:11:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/1] range.h: Move resource API and constant to respective headers
Date:   Mon, 10 Jul 2023 16:11:42 +0300
Message-Id: <20230710131142.32284-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

range.h works with struct range data type. The resource_size_t
is an alien here. Move the related pieces to the respective
headers and rename MAX_RESOURCE using pattern ${TYPE}_MAX.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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


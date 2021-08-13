Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0023EB952
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhHMPgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:36:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:14269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236719AbhHMPgx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:36:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195162702"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="195162702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 08:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="422253373"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2021 08:36:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43912B1; Fri, 13 Aug 2021 18:36:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] PCI: Sync __pci_register_driver() stub for CONFIG_PCI=n
Date:   Fri, 13 Aug 2021 18:36:19 +0300
Message-Id: <20210813153619.89574-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CONFIG_PCI=y case got a new parameter long time ago.
Sync the stub as well.

Fixes: 725522b5453d ("PCI: add the sysfs driver name to all modules")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pci.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..1ef4ee6a8b2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1740,8 +1740,9 @@ static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
 { return -EBUSY; }
-static inline int __pci_register_driver(struct pci_driver *drv,
-					struct module *owner)
+static inline int __must_check __pci_register_driver(struct pci_driver *,
+						     struct module *,
+						     const char *mod_name)
 { return 0; }
 static inline int pci_register_driver(struct pci_driver *drv)
 { return 0; }
-- 
2.30.2


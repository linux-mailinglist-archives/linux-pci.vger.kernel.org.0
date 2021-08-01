Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5232F3DCCD0
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhHARGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 13:06:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:26297 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhHARGB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Aug 2021 13:06:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="200541867"
X-IronPort-AV: E=Sophos;i="5.84,286,1620716400"; 
   d="scan'208";a="200541867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 10:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,286,1620716400"; 
   d="scan'208";a="478213629"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2021 10:05:49 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mAEuK-000CUb-UD; Sun, 01 Aug 2021 17:05:48 +0000
Date:   Mon, 2 Aug 2021 01:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [RFC PATCH] PCI: pcie_has_flr() can be static
Message-ID: <20210801170501.GA141152@1c36740427e6>
References: <20210801142518.1224-3-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801142518.1224-3-ameynarkhede03@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

drivers/pci/pci.c:4636:6: warning: symbol 'pcie_has_flr' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 338c98bb60968..dba075bd11114 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4633,7 +4633,7 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-bool pcie_has_flr(struct pci_dev *dev)
+static bool pcie_has_flr(struct pci_dev *dev)
 {
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;

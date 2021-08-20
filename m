Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D53F35DF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhHTVH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:07:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:29559 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHTVH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:07:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="216569438"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="216569438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 14:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="680433247"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 14:06:47 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHBiw-000VCF-9U; Fri, 20 Aug 2021 21:06:46 +0000
Date:   Sat, 21 Aug 2021 05:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Cc:     kbuild-all@lists.01.org, Wendy Wang <wendy.wang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [RFC PATCH] PCI: VMD: ACPI: pci_acpi_companion_lookup_key can be
 static
Message-ID: <20210820210610.GA23698@ef1ee8e5bb1c>
References: <11834551.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11834551.O9o76ZdvQC@kreacher>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

drivers/pci/pci-acpi.c:1164:1: warning: symbol 'pci_acpi_companion_lookup_key' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 pci-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 535f43034a073..c8718aeafae5d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1161,7 +1161,7 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
 /* ACPI bus type */
 
 
-DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);
+static DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);
 static DEFINE_MUTEX(pci_acpi_companion_lookup_mtx);
 static struct acpi_device *(*pci_acpi_find_companion_hook)(struct pci_dev *);
 

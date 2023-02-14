Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F0696A42
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBNQtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjBNQs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:48:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915CC2CFDA
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676393337; x=1707929337;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LpJkwBqu+AEArmI0yOR1MQF5+OmBMTHfoxtuQGyZIJY=;
  b=I/N94U46IAvqNfTowp6wzR2+09dmCLmKM4nnmH4MiR20YQaJX9PTxzA8
   DhobfTLsBTA8ZwbgQFiz6y4IS0o09EY4L8GhF5OuXEaPdGLzcoxaCI3/m
   nkItKI3EMSZOj7o1ssgUNT3eee84W49M9nWpKZBw/Oo9FGtWAeUQTdBoc
   ZuFzkRwxB0/8faDcY0C5xRsJvsqyyC7DIUjzINsyJVUWWmfBzogXHGpss
   dlYZpKwq5vfEkDI9TLhKc2BZNksDOj0+wJBSDIP3SAGFgFUrzlXeKw7B1
   KoHdA2dl63ylT2z54aC3jQp0RG+LrSLbO1uA+QvjX+I+5oOr2HZuNBLUM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329830810"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329830810"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:48:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="914805607"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="914805607"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.93.192])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:48:56 -0800
Subject: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
        lukas@wunner.de
Date:   Tue, 14 Feb 2023 09:48:55 -0700
Message-ID: <167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With commit [1] upstream that enables AER reporting by default for all PCIe
devices, the documentation for pcie_enable_pcie_error_reporting() is no
longer necessary. Remove references to the helper function.

[1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/PCI/pcieaer-howto.rst |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..a82802795a06 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
 errors because device specific errors will still get sent directly to
 the device driver.
 
-Configure the AER capability structure
---------------------------------------
-
-AER aware drivers of PCI Express component need change the device
-control registers to enable AER. They also could change AER registers,
-including mask and severity registers. Helper function
-pci_enable_pcie_error_reporting could be used to enable AER. See
-section 3.3.
-
 Provide callbacks
 -----------------
 
@@ -214,15 +205,6 @@ to mmio_enabled.
 
 helper functions
 ----------------
-::
-
-  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
-
-pci_enable_pcie_error_reporting enables the device to send error
-messages to root port when an error is detected. Note that devices
-don't enable the error reporting by default, so device drivers need
-call this function to enable it.
-
 ::
 
   int pci_disable_pcie_error_reporting(struct pci_dev *dev);



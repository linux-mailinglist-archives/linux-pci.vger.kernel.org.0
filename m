Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228BB7A36B4
	for <lists+linux-pci@lfdr.de>; Sun, 17 Sep 2023 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjIQRFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjIQRFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 13:05:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9A12A;
        Sun, 17 Sep 2023 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694970311; x=1726506311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YZiKFoODHxdnQkLLIgx4lfTMyfm0cr7/EnJtVlQMPo0=;
  b=dMBCEcKGvYLgL+ZLLhmmKUK47FChmy4c2PKcSR5sIEFa3sMhQ5grG/Vg
   zQ3ccSjmol465zSkx7g/rNil18xWagy6ZXtoNQm3kcnzvhwSnmS/UgC7x
   zW9fBWp9bTPlkoSdw6u4a0Tw6U9jqY/EU0T1s0PKbuu3wLFT6SEJjNZ0g
   DQol6BoB1MeNlEE97wx1056FohQphNZX3jCBINz+GnGsQvgszI1l/fa9w
   cLk8LBdtWr9UsUJ6rzKTKSnH9exfYU401ykkkdWj1rFjdeFDmvmgEdYOh
   FKIHWOfX5e5z/B5lMKgEndSv1eNA4oSEDYc5ejnwvXZwyGMYU21IJ5G7j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378419205"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="378419205"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 10:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815770737"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="815770737"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2023 10:05:07 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, sharath.kumar.d.m@intel.com
Subject: [PATCH v4 0/2] PCI: altera: add support to agilex family
Date:   Sun, 17 Sep 2023 22:35:44 +0530
Message-Id: <20230917170546.2097352-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913125946.GA429409@bhelgaas>
References: <20230913125946.GA429409@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

added new callback for
1) read,write to root port configuration registers
2) read,write to endpoint configuration registers
3) root port interrupt handler

agilex and newer platforms need to implemant the callback and generic root
port driver should work ( without much changes ) , legacy platforms (arria
 and startix) implement configuration read,write directly in wrapper
api _altera_pcie_cfg_read/_altera_pcie_cfg_write

changelog v2:
saperated into two patches
1.refactored the driver for easily portability to future Altera FPGA
platforms
2.added support for "Agilex" FPGA

this driver supports PCI RP IP on Agilex FPGA, as these are FPGA its up
to the user to add PCI RP or not ( as per his needs). we are not adding
the device tree as part of this commit. we are expecting the add device
tree changes only if he is adding PCI RP IP in his design

changelog v3:
incorporate review comments from Bjorn Helgaas

changelog v4:
added below callback for root bus
alt_read/write_own_cfg
added below callback for non-root buses
alt_read/write_other_cfg

D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platform
  PCI: altera: add support for agilex family fpga

 drivers/pci/controller/pcie-altera.c | 313 ++++++++++++++++++++++++---
 1 file changed, 280 insertions(+), 33 deletions(-)

-- 
2.34.1


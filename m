Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14879B428
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbjIKVkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjIKKOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 06:14:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9FE5F;
        Mon, 11 Sep 2023 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427273; x=1725963273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8cErPzEwXD3qIbTswHx7PcLlm6oqRfL3GjzcV7/9D1A=;
  b=eYszJ6MLBmjj+HDB2YsjXojPS/4LH3tT4wOSXjcyWQb7y2+/pw4KBoBJ
   kkr7l9WPvhoFN8ZiGPUYVgZMfIZUoWP0UjlCj/Dp1YzHOIVZ7Y+7BrcMd
   BXGAgv/77WRi6C6pxyFi6BeSK50/ms41fVYi/RsPV+WOECuqTvoXWSmI6
   hxHsPHln06SnaMh0BNcS3oxmMwX9EHxoFj9s3HzS6Im4pVAdDBL7AvjK6
   XrDaxtGmZdZCCfH6zsKxoNfI1coTw29xM9FpAltjCBP2VeuxvzhQySwoO
   HQcYsyA7pEbYTKvDcFR5dBQsdgnItWADQaJ/03km+GxFJT+6Dq+m86rHt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380743863"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="380743863"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719939076"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719939076"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2023 03:14:28 -0700
From:   sharath.kumar.d.m@intel.com
To:     sharath.kumar.d.m@intel.com
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org
Subject: [PATCH v3 0/2] PCI: altera: add support to agilex family
Date:   Mon, 11 Sep 2023 15:45:03 +0530
Message-Id: <20230911101503.1769696-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906110918.1501376-1-sharath.kumar.d.m@intel.com>
References: <20230906110918.1501376-1-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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

agilex and newer platforms need to implemant the callback and generic root port driver should work ( without much changes ) , legacy platforms (arria and startix) implement configuration read,write directly in wrapper api _altera_pcie_cfg_read/_altera_pcie_cfg_write

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

D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platforms
  PCI: altera: add support for agilex family fpga

 drivers/pci/controller/pcie-altera.c | 305 ++++++++++++++++++++++++---
 1 file changed, 275 insertions(+), 30 deletions(-)

-- 
2.34.1


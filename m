Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CD793ABA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 13:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjIFLJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 07:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjIFLJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 07:09:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F9CFA;
        Wed,  6 Sep 2023 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693998553; x=1725534553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DHZZ8GymiQdwzaUeJ6/yCdM87n/6nPufNjhvZmV3ebQ=;
  b=TGlfu+qVJnaSzTX3weMyeT5J7j4JOf7P1XS0Ev061dNhz12A89Eb4e0x
   +YnS+ub2oXIEWtbNquraUgTrUEGDSd59cC2qL9QD90sc5LOMsDdyryRiX
   Dt7+DjnH6UHnixvdKjfVgQ2RF40fb2zXUCGsaJn7vkqyGwbahU3Lo72wa
   DSr6NUv8A/NSgWWuiLxCqEg9cHwVjmRE4x8QFz0/LMh7zyVvPqaBIJuC0
   yQ5OPv6QpWA3eU+cgIexugK3BC7OxjBt9Wu3fTSb1sRQJHBZqRI8/WkcA
   4raGlGvwJYVEDbCrX3juDTxM7Pc2zkrhiGKGZaMTnL4sB7uqJCHhE/dxn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357349291"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357349291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 04:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884650722"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884650722"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2023 04:08:59 -0700
From:   sharath.kumar.d.m@intel.com
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH v2 0/2] PCI: Altera: add support to Agilex family
Date:   Wed,  6 Sep 2023 16:39:16 +0530
Message-Id: <20230906110918.1501376-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
References: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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


D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platform
  PCI: altera: add suport for Agilex Family FPGA

 drivers/pci/controller/pcie-altera.c | 313 ++++++++++++++++++++++++---
 1 file changed, 283 insertions(+), 30 deletions(-)

-- 
2.34.1


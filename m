Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5384C8225
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 05:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiCAEU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 23:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiCAEU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 23:20:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DF2C112;
        Mon, 28 Feb 2022 20:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108387; x=1677644387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gz0E7FcXfjbcqwaw9bcufLle5Xp8B6zhwo30z/ZN+Fo=;
  b=ORzT0+sRaLD2B1oZYgPOt24EljEmjYuG+3gwOsxvS2NrVK73jTANBFoJ
   Bjse0DlhRzOos0odj94W8QsVGUk4TOynKCj+JcEYHalPiG8CsRKicjhBJ
   mUAopVN4TZrxLmDBsuo3bwuQB5Zfhp8VF/acM7cQYSU4h++iYR40c0lSo
   q1FtBpq4OyLS4lgEyAJ7qajzPT+7F3r+3eI/r/3fYqtb0UTGyD0ClQmnb
   cq96TGEQ2IIgWes+Ex9f6gk+ChMp5zPau5qCP9LFtvkkeDW2Hs0ilquju
   m34aeCWU4iF9/I7hS9xPqPJSptIx388gdFdjllxY3mMMrlGbu4ZIyv+3y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240463930"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="240463930"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="641123500"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 20:19:43 -0800
Received: from debox1-desk4.lan (unknown [10.251.9.202])
        by linux.intel.com (Postfix) with ESMTP id 852B15805A3;
        Mon, 28 Feb 2022 20:19:43 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/3] PCI: vmd: Enable PCIe ASPM and LTR
Date:   Mon, 28 Feb 2022 20:19:40 -0800
Message-Id: <20220301041943.2935892-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for enabling PCIe ASPM and for setting PCIe LTR
values on devices on root ports reserved by VMD. Configuration of these
capabilities is usually done by BIOS. But for VMD ports these capabilities
will not be configured because those ports are not visible to BIOS. For
future products, post Alder Lake, the hardware team has agreed to do this
enabling in BIOS.  But this will not apply to current products, so this
work around is provided for them. Without this, laptops running in VMD mode
will not be able to power gate roots ports, resulting in higher power
consumption.

Since V4 we have more information from the BIOS team as to why BIOS
needs to program device LTRs. This is something that should be done by
devices, but there are many that don't provide LTR values causing them
to block SoC level power management. BIOS sets an initial default LTR to
account for such devices. This SoC specific value is the maximum latency
required to allow the SoC to enter the deepest power state.

David E. Box (2):
  PCI: vmd: Add vmd_device_data
  PCI: vmd: Configure PCIe ASPM and LTR

Michael Bottini (1):
  PCI/ASPM: Add ASPM BIOS override function

 drivers/pci/controller/vmd.c | 134 ++++++++++++++++++++++++++++-------
 drivers/pci/pcie/aspm.c      |  54 ++++++++++++++
 include/linux/pci.h          |   7 ++
 3 files changed, 169 insertions(+), 26 deletions(-)


base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
-- 
2.25.1


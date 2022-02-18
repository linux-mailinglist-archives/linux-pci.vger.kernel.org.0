Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1477C4BB0E1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 05:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiBREvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 23:51:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiBREvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 23:51:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6982BB11;
        Thu, 17 Feb 2022 20:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645159869; x=1676695869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+hI30xsMkjVG9jgQ/JDpiTuyxMaaUgT4cUIZmZlwJo=;
  b=n6YBzEvB1YFqyH2nvdEn/iIxBXfMPRIyu4HuxO6LrU4MhalEFFFndTTm
   dkU+9CgmG//hd+8zMUKmRiks2inxvYDB+iJpA6fB66XhVCdym2Rij7ul5
   qn/+JuG5zxpqQZjVKDGnSYmVgF31DBX66Hb9DOXJFy3B5qgFOTBvxAyKG
   TMnzvZlfSakPizKENmCL7n9IeRaPH+RytOcr0c2v1YtKicJ/rynTFtKTT
   BdNKspL78yJHqCHeqeGPJdXrpyzfDdq9g/uPc4WJy3kQ9TKd7P5u2BkEm
   29nLOQSvXPvxs331MtoJTfAjQa5y/5Z3NmMaDJkRiEQE9nqLpRLzmIe2P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231033856"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231033856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="682353755"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 20:51:09 -0800
Received: from debox1-desk4.lan (unknown [10.251.23.8])
        by linux.intel.com (Postfix) with ESMTP id 12817580AA7;
        Thu, 17 Feb 2022 20:51:09 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/3] PCI: vmd: Enable PCIE ASPM and LTR
Date:   Thu, 17 Feb 2022 20:50:53 -0800
Message-Id: <20220218045056.333799-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for enabling PCIE ASPM and for setting PCIE LTR
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

 drivers/pci/controller/vmd.c | 104 ++++++++++++++++++++++++++---------
 drivers/pci/pcie/aspm.c      |  54 ++++++++++++++++++
 include/linux/pci.h          |   7 +++
 3 files changed, 139 insertions(+), 26 deletions(-)

-- 
2.25.1


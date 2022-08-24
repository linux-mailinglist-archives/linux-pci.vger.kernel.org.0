Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587C5A0492
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 01:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiHXXYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHXXYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 19:24:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6224F31;
        Wed, 24 Aug 2022 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661383493; x=1692919493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eJ8YUYE0KUuxnWEswmWESNkqPfeWZ5Rhr0ubNvs1qZs=;
  b=KeKzEoJPdoq5gh4Lwedoeo5ThaxT9bN2fvHVSiLU/9reNibgHYsddA6D
   +AG4wJrnrSP7bDQI2yJt116PhxyRvvDuf7Bn0SB0+vHM8xs55VNJmn1qm
   NlZDs/EHcU2YkAiwptYWtxtIL8zzQBWwr7vEHyHqp9G6vkXuct94LcDB+
   av8TIFmibhfuXGqT/PcoNiK/tiEVEGirxd0KQW/vqGFiEaxTg/naPKXJI
   Gtia9W1nEGnz4nkBuArnHjjW4xCPUz6BhfPxQOxWHtHhs0l825ZePmkYJ
   PWoCFlGfz08QQ4i69N45npuiN6xwnG+HBtOf5vhfT8s27xlpB8sWSTyaB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="380391307"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="380391307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="752265584"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.42.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:24:52 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V2 0/2] CXL: Taint user access to DOE mailbox config space
Date:   Wed, 24 Aug 2022 16:24:48 -0700
Message-Id: <20220824232450.723179-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V1
	Incorporate feedback from Dan and Greg.

PCI config space access from user space has traditionally been unrestricted
with writes being an understood risk for device operation.

Unfortunately, device breakage or odd behavior from config writes lacks
indicators that can leave driver writers confused when evaluating failures.
This is especially true with the new PCIe Data Object Exchange (DOE) mailbox
protocol where backdoor shenanigans from user space through things such as
vendor defined protocols may affect device operation without complete breakage.

Even though access should not be restricted it would be nice for driver writers
to be able to flag critical parts of the config space such that interference
from user space can be detected.

Introduce pci_request_config_region_exclusive() and use it in the CXL driver
for DOE config space.

Ira Weiny (2):
  PCI: Allow drivers to request exclusive config regions
  cxl/doe: Request exclusive DOE access

 drivers/cxl/pci.c             |  5 +++++
 drivers/pci/pci-sysfs.c       |  7 +++++++
 drivers/pci/probe.c           |  6 ++++++
 include/linux/ioport.h        |  2 ++
 include/linux/pci.h           | 33 +++++++++++++++++++++++++--------
 include/uapi/linux/pci_regs.h |  1 +
 kernel/resource.c             | 13 ++++++++-----
 7 files changed, 54 insertions(+), 13 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
-- 
2.37.2


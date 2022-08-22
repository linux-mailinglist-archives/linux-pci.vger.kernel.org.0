Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9859B71B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiHVAxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHVAxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 20:53:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E65205E8;
        Sun, 21 Aug 2022 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661129582; x=1692665582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vAVd2DD6t9I+Xtmsril7vUCCDTiDliFF7Nj/PCNMHkc=;
  b=fuP2Arglkj/rrQtGKf67SibUIet0qRKeKRn1TD4oBkD8ukzGnZjVHxtP
   1LWFzd0CCmQApoh2H/SmvW4/q2yYAHS9SFPEKROTbaDiamkzO69jNlN+4
   Qeu3ysQM1XhJ1BR8D5dCifbS+PPr+8UcZ8pZL7nssRxDC7+lOz823x8iB
   R7/whcXs22UTrTEcPobKWyCXwIj9lza32H491S3dVBI89i/H+ihalysgC
   AE0/CUmRPmh2J8O3dyFbCMNVFGMitTrULcvHkco//yZH8Anu2uc13xlyh
   23B/EgkMVfNHEhrnAHWEOV0XC98I5U4zqdDYIxik00GTjYhy44PY+5laO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="294574753"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="294574753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 17:53:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="669297118"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.163.128])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 17:52:39 -0700
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
Subject: [PATCH 0/2] CXL: Taint user access to DOE mailbox config space
Date:   Sun, 21 Aug 2022 20:52:35 -0400
Message-Id: <20220822005237.540039-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

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
 drivers/pci/pci-sysfs.c       |  6 ++++++
 drivers/pci/probe.c           |  6 ++++++
 include/linux/ioport.h        |  2 ++
 include/linux/pci.h           | 16 ++++++++++++++++
 include/uapi/linux/pci_regs.h |  1 +
 kernel/resource.c             | 13 ++++++++-----
 7 files changed, 44 insertions(+), 5 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
-- 
2.37.2


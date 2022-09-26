Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD95EB3AB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiIZV5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiIZV5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:57:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC85D4327;
        Mon, 26 Sep 2022 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664229440; x=1695765440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVMWunYPM2+IIkAGb+SLwB9+KCfT1/0NI6xHqBaLML8=;
  b=N2xvYHCnYqxeIv2I0kDIj3t6MHcbCy8AldWsG9zdJjA/el2B4y//YIrz
   IJ8J0BeJkvMzAmXwqko8MR1ythV7KlMl9mzGeFFwwUaR/Dt/a+cDaXysG
   YEyPGxcUAI8fMnae889ftOx+20qaHYt9v/d7UpBQPx5ycDI7TpGxc9zEj
   yossYGVCZp6cBofU4RkDfuMo6NOsd8vhYz1sicSzMvGRnJd9t2I3X18z7
   79vZ6N8fcnoYnoQtwlwXMsCDxV87vPNz02F9QZx+gQm2lry95bXFvgSnj
   E7IjxBHSYLotDuEdk6YA2dL22f6a7WnDksDHppPUcynqSEqbH/3nzkPYY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302057556"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="302057556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:57:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="598911424"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="598911424"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.209.75.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:57:19 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V3 0/2] CXL: Taint user access to DOE mailbox config space
Date:   Mon, 26 Sep 2022 14:57:09 -0700
Message-Id: <20220926215711.2893286-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V2
	Incorporate feedback from Greg and Jonathan

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
 include/linux/pci.h           | 17 +++++++++++++++++
 include/uapi/linux/pci_regs.h |  1 +
 kernel/resource.c             | 13 ++++++++-----
 7 files changed, 46 insertions(+), 5 deletions(-)


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.37.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163C64993C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 08:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiLLHGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 02:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiLLHGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 02:06:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D62647;
        Sun, 11 Dec 2022 23:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670828792; x=1702364792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nEaXrgycA1rsCThHCMjC1JksaZH43yXXU6+fyhJL6Ls=;
  b=lxVddOnqErk9TVSDUJ7I+CYjraNOgFbQ4esN0UOq/AnDxFcQkhOTZ/qe
   TQY8Q1uEesCexERLSdH90Z3wPvEfDyxV1eIoARva4yd8xPSKHQ/841+Q5
   Vu+6K0A1B8b6Ih6G9mzQJEZvhD2B9o2780Krn2Bv9uCNdQqpRsuNDosU+
   V3eA2wo/tskNTlHiqqEn7+rLx5e+wLb0OPSDvWiClFlMlW0G9haDYvjS/
   jQ0b9dCYqwjDCaWn2xg7giiUE2ADbDfeN4Hc6hpauYBmJMvS1aWIiBXk8
   nLBhrY1M4nEpUTH/cQAY9tV9G3BmSUdtAVEoceeiCKNMKGkKySrjWpLlt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317811819"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317811819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641643030"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641643030"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.168.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:29 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V4 0/9] CXL: Process event logs
Date:   Sun, 11 Dec 2022 23:06:18 -0800
Message-Id: <20221212070627.1372402-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This code has been tested with a newer qemu which allows for more events to be
returned at a time as well an additional QMP event and interrupt injection.
Those patches will follow once they have been cleaned up.

The series is now in 3 parts:

	1) Base functionality including interrupts
	2) Tracing specific events (Dynamic Capacity Event Record is defered)
	3) cxl-test infrastructure for basic tests

Changes from V3
	Feedback from Dan
	Spit out ACPI changes for Bjorn

- Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/


Davidlohr Bueso (1):
  cxl/mem: Wire up event interrupts

Ira Weiny (8):
  PCI/CXL: Export native CXL error reporting control
  cxl/mem: Read, trace, and clear events on driver load
  cxl/mem: Trace General Media Event Record
  cxl/mem: Trace DRAM Event Record
  cxl/mem: Trace Memory Module Event Record
  cxl/test: Add generic mock events
  cxl/test: Add specific events
  cxl/test: Simulate event log overflow

 drivers/acpi/pci_root.c       |   3 +
 drivers/cxl/core/mbox.c       | 186 +++++++++++++
 drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h             |  16 ++
 drivers/cxl/cxlmem.h          | 171 ++++++++++++
 drivers/cxl/cxlpci.h          |   6 +
 drivers/cxl/pci.c             | 236 +++++++++++++++++
 drivers/pci/probe.c           |   1 +
 include/linux/pci.h           |   1 +
 tools/testing/cxl/test/Kbuild |   2 +-
 tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++
 11 files changed, 1452 insertions(+), 1 deletion(-)


base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
-- 
2.37.2


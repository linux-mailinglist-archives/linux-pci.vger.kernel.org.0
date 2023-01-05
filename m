Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94EA65F7AC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjAEXiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 18:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjAEXiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 18:38:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E961A81D;
        Thu,  5 Jan 2023 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672961884; x=1704497884;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ERsIP7LqaPV9arMxZigY0Ynxbbh/lqB5dmaVofVmm/U=;
  b=Twoc7TlqdxgnLJ8RAUqTtwTsbQqDkNeOjmrkZHmyTRtASJv+Nrln3TUV
   xJkTrn+B8HhUityzMVxJ9KQzcc49VRBTuNVt8jVUjudelqpljQT7FaX6g
   LOGALGVNewykaqteAO7w/buoBAf8K0vAmnWFywGDgMnZDKFBliFez4bZV
   B9QWvRQfIwxYrWC8UmwdmLJv0psN4OuFfEdhROCuf8/trjNbiPSqvqejT
   l4oV/Yyz1fdDOcHl1vCRlPF4sllT1b9aQGdtFU0UmRp47GiQDWkmYkZfu
   td3rskpd3/W9kjZUNUM5Dkno1wbQo5whV7f0QwpSCTx4/tGjOg/Cfe6o8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305871972"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305871972"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:38:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="798093019"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="798093019"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.87.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:38:02 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v5 0/8] cxl: Process event logs
Date:   Thu, 05 Jan 2023 15:37:51 -0800
Message-Id: <20221216-cxl-ev-log-v5-0-180c618ed5d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9ft2MC/zWNyw6CMBBFf4V07ZB2eKkr/8OwKHWASWprWkQI4
 d+tJC7PSe49m4gUmKK4ZpsINHNk7xJUp0yYUbuBgB+JBUpEhaoGs1igGawfoJd1cS7UpalKJdKg
 05GgC9qZMU3c29okX4F6Xo7CvU08cpx8WI/grH72/42ykTU2uSoaLCWCAg46/xC79cZuIpsb/xT
 tvu9fKz8gZbYAAAA=
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672961882; l=2364;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ERsIP7LqaPV9arMxZigY0Ynxbbh/lqB5dmaVofVmm/U=;
 b=hrp8OO0tb6rLWEl+gAKRgXXBC4IvpDkNBJuBcTBXVZL1W7eo9HWjSXGzQqts95+xSVCj7JHnW39g
 BWG9JfSLBkZ1uDhelyQvN+VatXC7bfc/BaRRf4LL1ub1Q1kPt/RB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This code has been tested with a newer qemu which allows for more events to be
returned at a time as well an additional QMP event and interrupt injection.
Those patches will follow once they have been cleaned up.

The series is now in 3 parts:

       1) Base functionality including interrupts
       2) Tracing specific events (Dynamic Capacity Event Record is defered)
       3) cxl-test infrastructure for basic tests

To: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes in v5:
- Drop patch 1/9 as it was already picked up in CXL next
- Johnny/Jonathan - base clear event playload length on nr handles
- Minor clean ups
- Link to v4: https://lore.kernel.org/r/20221212070627.1372402-1-ira.weiny@intel.com

---
Davidlohr Bueso (1):
      cxl/mem: Wire up event interrupts

Ira Weiny (7):
      cxl/mem: Read, trace, and clear events on driver load
      cxl/mem: Trace General Media Event Record
      cxl/mem: Trace DRAM Event Record
      cxl/mem: Trace Memory Module Event Record
      cxl/test: Add generic mock events
      cxl/test: Add specific events
      cxl/test: Simulate event log overflow

 drivers/cxl/core/mbox.c       | 187 +++++++++++++++++
 drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h             |  16 ++
 drivers/cxl/cxlmem.h          | 173 +++++++++++++++
 drivers/cxl/cxlpci.h          |   6 +
 drivers/cxl/pci.c             | 237 +++++++++++++++++++++
 tools/testing/cxl/test/Kbuild |   2 +-
 tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++++++++
 8 files changed, 1451 insertions(+), 1 deletion(-)
---
base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
change-id: 20221216-cxl-ev-log-f06383197541

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

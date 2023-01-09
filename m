Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319D36630B1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbjAITnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjAITmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:42:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCD6CFE1;
        Mon,  9 Jan 2023 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673293359; x=1704829359;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=t0KtIDqmaJYRE1NQYpq+S3S1qQTjDdQlFxzAXzrQRYU=;
  b=guKMXeEBx+uGo8zRBad8KdfPXBXrrs6CLSM06F+btBlUEQe1PJSWh5r8
   TkadjJ/bsVjnfGZH5basmdM4kVeT5UXoPhcV02yrjyYfoeIbfc2tev9Pw
   tg6CQxxAGpthrKZh2CsF9RgGk0DKzUFCPuiMAlc9J6NrflubXv8pg3PsN
   6Dw1shNgKybzJVkm/Ogm1GkfBBjS98Z8TfoXMSkDdLYItXfU/XUU5Iwbj
   aQliN6dmoJ4Sl517Tt3yuhMuxnrW6ttAl1i54Yn1mPnfX33BsEqx+OghH
   5MGibWrRQAm/Qc5UrVlP2y839mlcTzox3ZMI0vdzssUdphe4cQFtsMX/S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385269859"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385269859"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656783487"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656783487"
Received: from cwchen-mobl.amr.corp.intel.com (HELO localhost) ([10.212.45.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v6 0/8] cxl: Process event logs
Date:   Mon, 09 Jan 2023 11:42:20 -0800
Message-Id: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxuvGMC/1WOwQ6CMBBEf8X07JJugYKe/A/jAcoCm9RiWqwaw
 79bSEz0+CZ5M/MWgTxTEMfdW3iKHHhyCfR+J8zYuIGAu8RCSaVQoQbztEAR7DRAL3Ve53ioygJF
 EtomELS+cWZMirtbm8Kbp56f28L5knjkME/+tQ1GXNNvt5KV1KrKMK9UIRUgsG+yB7F7ndjNZDM
 zXcXaEctf7+9TLEEC1tJorKkrO/xVl2X5AAHSxbvxAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673293350; l=2483;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=t0KtIDqmaJYRE1NQYpq+S3S1qQTjDdQlFxzAXzrQRYU=;
 b=Mo2DCQbXFcnT8uYCAtepvwGqxQOa0nqdlTARb74mU+RfuKxIJ5mIGQ2yGFB9ohKcO7QEcqZZa/Qy
 oaftH/DyA5hvzPJ2uleeohuUaO1jInr24clsHqBFEVcCNvf1wTQ+
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I accidentally missed some comments from Dan in my V5 that I sent.[*]  Dan
asked me to do a quick spin to pick them up.

[*] https://lore.kernel.org/all/6398dd6ed80fa_b05d1294fc@dwillia2-xfh.jf.intel.com.notmuch/

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
Changes in v6:
- Dan: address the missed comments on V4
- Link to v5: https://lore.kernel.org/r/20221216-cxl-ev-log-v5-0-180c618ed5d1@intel.com

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
 drivers/cxl/pci.c             | 241 +++++++++++++++++++++
 tools/testing/cxl/test/Kbuild |   2 +-
 tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++++++++
 8 files changed, 1455 insertions(+), 1 deletion(-)
---
base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
change-id: 20221216-cxl-ev-log-f06383197541

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

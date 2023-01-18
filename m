Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957C671372
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 06:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjARF4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 00:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjARFyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 00:54:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74E582B3;
        Tue, 17 Jan 2023 21:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674021238; x=1705557238;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=8hCE29/rAv/KePGjVVbATlGPXJKEr6j4vLKWjkF4hUA=;
  b=AKBt24qU7Mk7MeVyIQBP7QbFU2XIm3fkIyaFfuiLXXTB+oRJBGq8NMK9
   Ol0nmSjy6DsuK6bR5sU80VkZSllehvrsHPZ8sFpB9jYhe2xbJuRoL7oyA
   hrFywp++9hlo4GvVmG+VbN4q6ZkCxYy9Pe0xIzvWZ4h1aYQBmFmKY1tuZ
   pdQcjDEsDK24aBkwOB+tc6MsyR8q0hNlKgTv2tlgHwVwXXKcKscU23tGI
   5aLWHURcNpDgi3L06tTkQbgI/zolDpWea1q6PJ6Wp7dxhp+rKAhDMHmz1
   RU5dHrkr1w4wjtY8RGlgz1X7Y20fRcg+48n9jm0Qudir3buEXBJkEl/3k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308469098"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308469098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="722953495"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722953495"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.10.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v7 0/8] cxl: Process event logs
Date:   Tue, 17 Jan 2023 21:53:36 -0800
Message-Id: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGCJx2MC/3WPQWrDMBBFrxK07pgZyZLcrnqP0oUtT+IBVQ5Sq
 iYE371KoJAWunwf3v8zV1U4Cxf1sruqzFWKrKmBf9qpsIzpwCBzY6VRa9LkIJwjcIW4HmCPzgyG
 nr3tSTVhGgvDlMcUlqakzxhbeMy8l/N94e298SLltObLfbDSLf3p1ujRad+R8bpHDQSSx+6LJV1
 eJZ04dmH9ULeOah+9XzdVCwg0YHA08Gxn+qu6/1XXVNM7235COxl8VLdt+wYIpO0DLAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674021228; l=2371;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=8hCE29/rAv/KePGjVVbATlGPXJKEr6j4vLKWjkF4hUA=;
 b=nbukHKPG6a3viQFoKvaOKYkcRCRvMpEtDxkCMxcpbwM5kkzO9bI8t/sgHyYf0Q/q68B8BCysLaHa
 cVU1c6quDGGbiViW3/7KxA9d5/QAgnjuvSNGjUgEIFfiT1FCDqFh
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

CXL devices have multiple event logs which can be queried for CXL event
records.

Add event log processing and cxl-test infrastructure.  In addition to cxl-test,
this code has been tested with the qemu patches posted here:

https://lore.kernel.org/all/20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com/

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
Changes in v7:
- Jonathan: Address minor comments on V6
- Link to v6: https://lore.kernel.org/r/20221216-cxl-ev-log-v6-0-346583105b30@intel.com

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

 drivers/cxl/core/mbox.c       | 198 +++++++++++++++++
 drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h             |  16 ++
 drivers/cxl/cxlmem.h          | 166 +++++++++++++++
 drivers/cxl/cxlpci.h          |   6 +
 drivers/cxl/pci.c             | 243 +++++++++++++++++++++
 tools/testing/cxl/test/Kbuild |   2 +-
 tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++++++++
 8 files changed, 1461 insertions(+), 1 deletion(-)
---
base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
change-id: 20221216-cxl-ev-log-f06383197541

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

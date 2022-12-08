Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9A646872
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHFVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 00:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHFVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 00:21:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB888B69;
        Wed,  7 Dec 2022 21:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670476879; x=1702012879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4anARoAcZ+FMWx+rU/JO2ajIw8NyiGsHus+CHa4WuRw=;
  b=c6U/npNmxwBCt3qWygl8Q7QxsVVJMQLS4snCKBW90hVVrQAP2QprQZK1
   rFG2nyEYXGbzbEJTBa44zyFElQuZhtth/5lzGJsR30DxAoEZ2EciDZNsv
   oqCi5XKHQdBxiEcZygceU/rdfZy+S/l4qpf5qTCCfuKer3r3fMDSKxGZn
   cfH+ZlkZI8TxkcGKBxX8MsopxYVqjIZD01Di5ukD54l/m85AgS9qYU/Hl
   5nFnJ9sTrUybj3evTJXG3E4mheu9CMkFeCuNbWSfKbSCZVVAsG/FUmVKS
   kLS4UHQAkN0Bn7gxmXcg6m4LDd7hI2huTZgBtM/EFSv2jGtpZryUG3pHG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381367216"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381367216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710324444"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="710324444"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.25.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:17 -0800
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
Subject: [PATCH V3 0/8] CXL: Process event logs
Date:   Wed,  7 Dec 2022 21:21:06 -0800
Message-Id: <20221208052115.800170-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Changes from V2
	Rebased on pending 6.3 changes
		CXL security patches from Dave J.
		Moving tracing to cxl core from Dan
	Feed back from Dan, Steven, Jonathan, and Dave.
	The series looks very different now with a lot of the patches squashed
	per Dan's feedback.

- Link to v2: https://lore.kernel.org/r/20221201002719.2596558-1-ira.weiny@intel.com

Changes from V1
	Address comments, from Jonathan, Dave, and Alison
		Main comment was to allow for a full payload size number of
		event records to be processed on each Get event cyle.
	Pick up tags

Changes from RFC v2
	Integrated Davidlohr's irq patch, allocate up to 16 vectors, and base
		my irq support on modifications to that patch.
	Smita
		Check event status before reading each log.
	Jonathan
		Process more than 1 record at a time
		Remove reserved fields
	Steven
		Prefix trace points with 'cxl_'
	Davidlohr
		PUll in his patch

Changes from RFC v1
	Add event irqs
	General simplification of the code.
	Resolve field alignment questions
	Update to rev 3.0 for comments and structures
	Add reserved fields and output them

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

 drivers/acpi/pci_root.c         |   3 +
 drivers/cxl/core/mbox.c         | 233 ++++++++++++++++
 drivers/cxl/core/trace.h        | 479 ++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h               |  12 +
 drivers/cxl/cxlmem.h            | 180 ++++++++++++
 drivers/cxl/cxlpci.h            |   6 +
 drivers/cxl/pci.c               | 130 +++++++++
 include/linux/pci.h             |   1 +
 tools/testing/cxl/test/Kbuild   |   4 +-
 tools/testing/cxl/test/events.c | 314 +++++++++++++++++++++
 tools/testing/cxl/test/events.h |  34 +++
 tools/testing/cxl/test/mem.c    |  33 ++-
 tools/testing/cxl/test/mock.h   |  12 +
 13 files changed, 1429 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h


base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
-- 
2.37.2


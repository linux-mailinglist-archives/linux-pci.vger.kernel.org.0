Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29B35E362
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 18:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbhDMQDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 12:03:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2842 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbhDMQC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 12:02:58 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKVVj6s28z689HQ;
        Tue, 13 Apr 2021 23:52:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 13 Apr 2021 18:02:34 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 17:02:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v2 0/4] PCI Data Object Exchange support + CXL CDAT
Date:   Wed, 14 Apr 2021 00:01:55 +0800
Message-ID: <20210413160159.935663-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change logs in individual patches.

There are several options for how to implement the DOE support in the
kernel.  This cover letter will try to assess the main decision to be
made in this series.

sync vs single threaded workqueue vs delayed work
=================================================

The DOE works via single input and output registers + some control
flags. Protocols are of the query/response type with a short standard
header in both followed by protocol specific data. A given DOE
instance can support multiple protocols, though individual protocol
specifications often limit what combinations are allowed.

Constraints on DOE queue handling.
1. Only a single query/response can be in flight at a time (*)
2. Need to handle timeouts on interrupt, or polling otherwise.

* Not strictly true. The DOE ECN allows for interleaving of multiple
  query/response pairs as long as only one is in flight for a given
  protocol at any given time.  However, the DOE may use the BUSY status bit
  to require software to not write a new request to the device.
  As there is no defined way of knowing when the BUSY bit is no longer
  set other than polling, such an operating mode cannot sensibly be
  used in conjunction with interrupts (which indicate response
  ready or error).  Given the current usecases of DOE and restrictions
  protocols specifications place on what other protocols they can share
  a DOE instance with, it seems unlikely that this level of interleaving
  is worth the complexity it would add.

Let us term a query/response sequence an exchange.

Approaches investigated:
1. Serialize using a mutex. This either makes exchange operations
   synchronous or requires a per caller thread. This was the approach in
   RFC v1. Long sleeps are possible as the protocol allows the response
   generation to take up to 1 second.
2. Use a single threaded workqueue to serialise exchanges.
   Each exchange uses a separate work_struct. Long sleeps can
   occur within the work items.  Note that one of the original stated reasons
   for the introduction of single threaded workqueues was to cater for work
   items which can sleep for a long time. This approach is naturally
   asynchronous, but a trival wrapper can be used to provide a convient
   synchronous calling API (I have code doing this, works fine but not posted
   as doesn't avoid long sleeps and discussion around v1 suggested we
   should do avoid them).
3. Use a single delayed work item to implement a state machine. Queuing is
   handled via a list to which query/response pairs are added.  Any delayed
   action or timeout is handled via schedule_delayed_work() with interrupts
   using mod_delayed_work() to immediately advance the state machine.
   There is no reason to use a dedicated work queue, as here serialization
   is handled using the exchange list. The proposal in this patch set.

Note I was unable to find any sensible way to combine 2 and 3, that is
to use both a delayed work approach to avoid timeouts in work items and
a single threaded workqueue to handle ordering + synchronization.
Either such an approach would have ended up with one work item just being
responsible for scheduling items on a different work queue, or it
requires the ability to insert work items at the front of single threaded
work queue (to ensure the next step of the state machine for the current
exchange runs before a step of the next exchange).

Relative complexity
-------------------

1. (mutex) Very simple.
2. (single thread workqueue) Fairly simple.
3. (delayed work) Most complex (particularly around abort handling).

Fairness
--------

Fairness considered to be work done in order of submission.
1. Potentially unfair given simple lock being used to seralize.
2. Fair as first come first seved.
3. Fair as manual list implementation of first come first served.

Sync vs Async
-------------

Whilst it's not clear there will actually be any async usecases, lets
consider how this works.
1. (mutex) Caller implements - either long sleeps in sync, or long sleeps in
   a thread to which sync operation off loaded.
2. (single thread workqueue) Async is natural state, with sync implemented as
   wrapper around async. Effectively same as spinning off to a thread in 1.
3. (delayed work) Async is natural state, with sync implemented as wrapper
   around async.

Decision comes down to trading off complexity against advantages of naturally
async operation that avoids sleeping inside a work item / thread / caller.

Cover letter from v1:
https://lore.kernel.org/linux-pci/20210310180306.1588376-1-Jonathan.Cameron@huawei.com/

Series first introduces generic support for DOE mailboxes as defined
in the ECN to the PCI 5.0 specification available from the PCI SIG [0]

A user is then introduced in the form of the table access protocol defined
in the CXL 2.0 specification [1] used to access the
Coherent Device Attribtue Table (CDAT) defined in [2]

Various open questions in the individual patches.

All testing conducted against QEMU emulation of a CXL type 3 device
in conjunction with DOE mailbox patches [3, 4]

[0] https://pcisig.com/specifications
[1] https://www.computeexpresslink.org/download-the-specification
[2] https://uefi.org/node/4093
[3] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[4] https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/

Jonathan Cameron (4):
  PCI: Add vendor define ID for the PCI SIG
  PCI/doe: Initial support PCI Data Object Exchange
  cxl/mem: Add CDAT table reading from DOE
  cxl/mem: Add a debug parser for CDAT commands.

 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/cdat.h            |  79 +++++
 drivers/cxl/cxl.h             |  13 +
 drivers/cxl/mem.c             | 279 ++++++++++++++++
 drivers/pci/pcie/Kconfig      |   8 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/doe.c        | 590 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   3 +
 include/linux/pci_ids.h       |   1 +
 include/linux/pcie-doe.h      |  85 +++++
 include/uapi/linux/pci_regs.h |  29 +-
 11 files changed, 1088 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/pcie/doe.c
 create mode 100644 include/linux/pcie-doe.h

-- 
2.19.1


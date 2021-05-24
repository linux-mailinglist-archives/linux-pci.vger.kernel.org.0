Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC55838E7D8
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhEXNmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 09:42:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5760 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXNmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 09:42:09 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpdYB75n5zmkmj;
        Mon, 24 May 2021 21:37:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:40:37 +0800
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:40:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, Fangjian <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 0/5] PCI Data Object Exchange support + CXL CDAT
Date:   Mon, 24 May 2021 21:39:33 +0800
Message-ID: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Series first introduces generic support for DOE mailboxes as defined
in the ECN to the PCIe r5.0 specification available from the PCI SIG [0]

A user is then introduced in the form of the table access protocol defined
in the CXL 2.0 specification [1] used to access the
Coherent Device Attribute Table (CDAT) defined in [2]

Finally, in two patches that are not intended for merging, an example
of a generic IOCTL interface to perform synchronous exchanges from user
space in a kernel mediated fashion is introduced. The current consensus
seems in favour of not introducing such an interface, but instead
providing per protocol interfaces where appropriate. As this code was
developed in parallel with that discussion and may be of use to someone it
is included here.

Open questions.
* Do we need to prevent userspace access to the DOE when the kernel is
  managing it (registered by driver)? Discussion in thread:
  https://lore.kernel.org/linux-pci/20210419165451.2176200-1-Jonathan.Cameron@huawei.com/
* Does a generic userspace mediation interface make sense?
  Currently it seems not, but as it was nearly ready, I've included
  it in this patch set anyway.
* Move CXL cdat handling to a separate file, or wait until we can see
  how it is going to be used?
  
Changes since v3
Thanks to Ira, Bjorn and Dan for feedback.
* Addition of a generic IOCTL interface and demo program for discussion.
* Fixed an issue with accidentally disabling interrupts.
* Ensure IRQ_HANDLED always returned as clearing of BUSY can result
  in an interrupt, but there is no means of identifying this.
  The best that can be done is to eat the interrupt.
* Edited comments to more directly tie them to the code the referred to.
* Lock scope documentation update.
* Dropped the CDAT dump to log patch as we are hopefully getting closer
  to this being applied.
* Fixed the references to pcie_ missed when renaming to pci_ in v3.

Set based on cxl/next

All testing conducted against QEMU emulation of a CXL type 3 device
in conjunction with DOE mailbox patches v5 [3, 4]

[0] https://pcisig.com/specifications
[1] https://www.computeexpresslink.org/download-the-specification
[2] https://uefi.org/node/4093
[3] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[4] https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/

Jonathan Cameron (5):
  PCI: Add vendor ID for the PCI SIG
  PCI/DOE: Add Data Object Exchange support
  cxl/mem: Add CDAT table reading from DOE
  DONOTMERGE PCI/DOE Add per DOE chrdev for ioctl based access
  DONOTMERGE: PCI/DOE: Add userspace example program to tools/pci

 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/cxl.h             |  21 +
 drivers/cxl/mem.c             | 174 ++++++++
 drivers/cxl/mem.h             |   6 +
 drivers/pci/Kconfig           |   8 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 794 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c      |   3 +-
 include/linux/pci-doe.h       | 100 +++++
 include/linux/pci.h           |   3 +
 include/linux/pci_ids.h       |   1 +
 include/uapi/linux/pci_doe.h  |  32 ++
 include/uapi/linux/pci_regs.h |  29 +-
 tools/pci/Build               |   1 +
 tools/pci/Makefile            |   9 +-
 tools/pci/doetest.c           | 131 ++++++
 16 files changed, 1311 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h
 create mode 100644 include/uapi/linux/pci_doe.h
 create mode 100644 tools/pci/doetest.c


base-commit: 35c32e3095d396c750f5cdfdaa94cba83d9b23c6
-- 
2.19.1


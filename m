Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73DF334642
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCJSHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 13:07:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2678 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCJSHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 13:07:37 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dwfz0157Rz67qlf;
        Thu, 11 Mar 2021 02:01:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:07:30 +0100
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 18:07:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/2] PCI Data Object Exchange support + CXL CDAT
Date:   Thu, 11 Mar 2021 02:03:04 +0800
Message-ID: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Jonathan Cameron (2):
  PCI/doe: Initial support PCI Data Object Exchange
  cxl/mem: Add CDAT table reading from DOE

 drivers/cxl/cdat.h            |  79 ++++++++++
 drivers/cxl/cxl.h             |  13 ++
 drivers/cxl/mem.c             | 253 +++++++++++++++++++++++++++++-
 drivers/pci/pcie/Kconfig      |   8 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/doe.c        | 284 ++++++++++++++++++++++++++++++++++
 include/linux/pcie-doe.h      |  35 +++++
 include/uapi/linux/pci_regs.h |  29 +++-
 8 files changed, 700 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/pcie/doe.c
 create mode 100644 include/linux/pcie-doe.h

-- 
2.19.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823431DD479
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgEURcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgEURcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9B1807CB299515510B6F;
        Thu, 21 May 2020 18:32:46 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 May 2020 18:32:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/2] PCI/AER: handling for RCiEPs
Date:   Fri, 22 May 2020 01:31:32 +0800
Message-ID: <20200521173134.2456773-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This RFC adds minimal AER handling for Root Complex integrated End Points
(RCiEPs).   These report their errors via a Root Complex Event Collector
(RCEC).  Note that this series does not provide a driver for said RCEC
because we do not need to do anything to it on a Hardware-Reduced ACPI
platform such as the ARM server we wish to support.

My assumption is that anyone needing support will need to enumerate the
association between the RCEC and RCiEPs, setting the rcec pointer added
to struct pci_dev.  If an alternate mechanism is preferred let me know.

Open questions are mainly in patch 2 description.  In particular a
number of the normal reset actions make little sense for an RCiEP (slot
reset?) so I'm unclear whether we should just call them all anyway or not.

Patch 1 avoids a reset of a register on the root port in a firmware first
flow.  It can occur for normal EP flow as well. It probably shouldn't,
but likely effects are minor (as firmware should have reset the register
already).

All comments welcome.  NB. We only care about the Hardware-Reduced
firmware first case so I'm more than happy to rip out he hints of
explicit RCEC support if people would prefer - I just put them in
for the RFC to show how that just possibly 'might' work.

There are other places that I suspect would need to take the RCEC case
into account that I have not addressed here.  Whilst we do have real
hardware RCiEPs, testing here was done with Qemu to allow comparison
of the flows for RCiEPs and EPs that were otherwise identical.
It is also easier to add whatever error injection is needed than on
real hardware.

Only the reduced hardware ACPI case has been tested as we would need
to add a bunch more stuff to Qemu to test the alternative forms
of firmware first of kernel first handling (which we don't care about :)

Jonathan Cameron (2):
  PCI/AER: Do not reset the device status if doing firmware first
    handling.
  PCI/AER: Add partial initial support for RCiEPs using RCEC or firmware
    first

 drivers/pci/pcie/aer.c |  3 +++
 drivers/pci/pcie/err.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  1 +
 3 files changed, 65 insertions(+)

-- 
2.19.1


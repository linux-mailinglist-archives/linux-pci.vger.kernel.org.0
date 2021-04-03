Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9E353347
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhDCJQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:16:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15473 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbhDCJQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:16:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FCB7X1LW7zyNht;
        Sat,  3 Apr 2021 17:14:16 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 3 Apr 2021 17:16:17 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 0/4] PCI: Enable 10-Bit tag support for PCIe devices
Date:   Sat, 3 Apr 2021 16:54:15 +0800
Message-ID: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

10-Bit Tag capability, introduced in PCIe-4.0 increases the total Tag
field size from 8 bits to 10 bits.

This patchset is to enable 10-Bit tag for PCIe EP devices (include VF) and
RP devices.

Dongdong Liu (4):
  PCI: Add 10-Bit Tag register definitions
  PCI: Enable 10-Bit tag support for PCIe Endpoint devices
  PCI/IOV: Enable 10-Bit tag support for PCIe VF devices
  PCI: Enable 10-Bit tag support for PCIe RP devices

 drivers/pci/iov.c              |   8 +++
 drivers/pci/pci.h              |   2 +
 drivers/pci/pcie/portdrv_pci.c |   3 +
 drivers/pci/probe.c            | 125 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h            |   1 +
 include/uapi/linux/pci_regs.h  |   5 ++
 6 files changed, 144 insertions(+)

--
1.9.1


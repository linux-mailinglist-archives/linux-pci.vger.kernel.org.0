Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650B42EFED0
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 10:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAIJke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jan 2021 04:40:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10863 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbhAIJkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jan 2021 04:40:33 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DCZfj1DJ4z7Qtd;
        Sat,  9 Jan 2021 17:38:53 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Sat, 9 Jan 2021 17:39:49 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 0/3] PCI: Enable 10-bit tags support for PCIe devices
Date:   Sat, 9 Jan 2021 17:11:20 +0800
Message-ID: <1610183483-2061-1-git-send-email-liudongdong3@huawei.com>
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

For platforms where the RC supports 10-Bit Tag Completer capability,
it is highly recommended for platform firmware or operating software
that configures PCIe hierarchies to Set the 10-Bit Tag Requester Enable
bit automatically in Endpoints with 10-Bit Tag Requester capability. This
enables the important class of 10-Bit Tag capable adapters that send
Memory Read Requests only to host memory.

This patchset is to enable 10-bits for PCIe EP devices.

Dongdong Liu (3):
  PCI: Add 10-Bit Tag register definitions
  PCI: Enable 10-bit tags support for PCIe devices
  PCI/IOV: Enable 10-bit tags support for PCIe VF devices

 drivers/pci/iov.c             |  8 ++++++++
 drivers/pci/probe.c           | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  5 +++++
 4 files changed, 53 insertions(+)

--
1.9.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF01B279D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDUNXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 09:23:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbgDUNXf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 09:23:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E1C2A57CB1E21CE031AC;
        Tue, 21 Apr 2020 21:23:30 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.83.77) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 21:23:21 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <bp@alien8.de>, <james.morse@arm.com>, <helgaas@kernel.org>,
        <lenb@kernel.org>, <tony.luck@intel.com>,
        <dan.carpenter@oracle.com>, <gregkh@linuxfoundation.org>,
        <zhangliguang@linux.alibaba.com>, <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [RESEND PATCH v7 0/6] ACPI / APEI: Add support to notify non-fatal HW errors
Date:   Tue, 21 Apr 2020 14:21:30 +0100
Message-ID: <20200421132136.1595-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.83.77]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add common interface for queuing up the non-fatal HW errors and notify
the registered kernel drivers.The interface supports drivers to register
to receive the callback for the non-fatal HW errors, including the vendor
specific HW errors, for the recovery and supports handling the non-fatal
errors in the process context.

Patch set
1. add the new interface to the APEI driver for the non-fatal HW
   error notification.
2. change the existing error handling for the standard errors
   to use the above notification interface.
2. add driver to handle HiSilicon hip PCIe controller's errors.

Changes:

V7:
1. Add changes in the APEI driver suggested by Borislav Petkov, for
   queuing up all the non-fatal HW errors to the work queue and
   notify the registered kernel drivers from the bottom half using
   blocking notifier, common interface for both standard and
   vendor-spcific errors.
2. Fix for further feedbacks in v5 HIP PCIe error handler driver
   by Bjorn Helgaas.

V6:
1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.

V5:
1. Fix comments from James Morse.
1.1 Changed the notification method to use the atomic_notifier_chain.
1.2 Add the error handled status for the user space.  

V4:
1. Fix for the following smatch warning in the PCIe error driver,
   reported by kbuild test robot<lkp@intel.com>:
   warn: should '((((1))) << (9 + i))' be a 64 bit type?
   if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
	^^^ This should be BIT_ULL() because it goes up to 9 + 32.

V3:
1. Fix the comments from Bjorn Helgaas.

V2:
1. Changes in the HiSilicon PCIe controller's error handling driver
   for the comments from Bjorn Helgaas.
   
2. Changes in the APEI interface to support reporting the vendor error
   for module with multiple devices, but use the same section type.
   In the error handler will use socket id/sub module id etc to distinguish
   the device.

V1:  
1. Fix comments from James Morse.

2. add driver to handle HiSilicon hip08 PCIe controller's errors,
   which is an application of the above interface.

Shiju Jose (5):
  ACPI / APEI: Add support to queuing up the non-fatal HW errors and
    notify
  ACPI / APEI: Add callback for memory errors to the GHES notifier
  ACPI / APEI: Add callback for AER to the GHES notifier
  ACPI / APEI: Add callback for ARM HW errors to the GHES notifier
  ACPI / APEI: Add callback for non-standard HW errors to the GHES
    notifier

Yicong Yang (1):
  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors

 drivers/acpi/apei/ghes.c                 | 268 ++++++++++++++++---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 323 +++++++++++++++++++++++
 include/acpi/ghes.h                      |  28 ++
 5 files changed, 595 insertions(+), 33 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

-- 
2.17.1



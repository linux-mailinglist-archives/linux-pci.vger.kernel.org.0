Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82C192E7D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYQnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 12:43:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbgCYQnT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 12:43:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C66C732E45CF1BFCD29;
        Thu, 26 Mar 2020 00:43:13 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.86.66) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 00:43:04 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v6 0/2] ACPI / APEI: Add support to notify the vendor specific HW errors
Date:   Wed, 25 Mar 2020 16:42:21 +0000
Message-ID: <20200325164223.650-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.86.66]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently the vendor drivers are unable to do the recovery for the
vendor specific recoverable HW errors, reported to the APEI driver
in the vendor defined sections, because APEI driver does not support
reporting the same to the vendor drivers.

This patch set
1. add an interface to the APEI driver to enable the vendor
drivers to register the event handling functions for the corresponding
vendor specific HW errors and report the error to the vendor driver.

2. add driver to handle HiSilicon hip08 PCIe controller's errors
   which is an example application of the above APEI interface.

Changes:

V6:
1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.

V5:
1. Fix comments from James Morse.
1.1 Changed the notification method to use the atomic_notifier_chain.
1.2 Add the error handled status for the user space.  

V4:
1. Fix for the smatch warning in the PCIe error driver:
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

Shiju Jose (1):
  ACPI / APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors

 drivers/acpi/apei/ghes.c                 |  35 ++-
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 357 +++++++++++++++++++++++
 drivers/ras/ras.c                        |   5 +-
 include/acpi/ghes.h                      |  28 ++
 include/linux/ras.h                      |   6 +-
 include/ras/ras_event.h                  |   7 +-
 8 files changed, 440 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

-- 
2.17.1



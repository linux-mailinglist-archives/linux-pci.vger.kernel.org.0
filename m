Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6D1F93F8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFOJza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 05:55:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgFOJza (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:30 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 8056736B118F31A0D9D4;
        Mon, 15 Jun 2020 10:55:28 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.26.179) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 15 Jun 2020 10:55:27 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <bp@alien8.de>, <james.morse@arm.com>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <dan.carpenter@oracle.com>,
        <zhangliguang@linux.alibaba.com>,
        <andriy.shevchenko@linux.intel.com>, <wangkefeng.wang@huawei.com>,
        <jroedel@suse.de>
CC:     <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH v9 0/2] ACPI / APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 15 Jun 2020 10:53:10 +0100
Message-ID: <20200615095312.398-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.26.179]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Presently the vendor drivers are unable to do the recovery for the
vendor specific recoverable HW errors because APEI driver does not
support reporting the error to the vendor drivers.

patch set
1. add new interface to the APEI driver for reporting the 
   vendor specific non-fatal HW errors to the drivers.

2. add driver to handle HiSilicon hip PCIe controller's errors.

V9:
1. Fixed 2 improvements suggested by the kbuild test robot. 
1.1 Change ghes_gdata_pool_init() as static function.
1.2. Removed using buffer to store the error data for
     logging in the hisi_pcie_handle_error()

V8:
1. Removed reporting the standard errors through the interface
   because of the conflict with the recent patches in the
   memory error handling path.
2. Fix comments by Dan Carpenter.
   
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

Shiju Jose (1):
  ACPI / APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors

 drivers/acpi/apei/ghes.c                 | 130 +++++++++-
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-hisi-error.c | 305 +++++++++++++++++++++++
 include/acpi/ghes.h                      |  28 +++
 5 files changed, 471 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/pcie-hisi-error.c

-- 
2.17.1



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6518C192A7A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCYNz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 09:55:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbgCYNzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 09:55:25 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8396156066003943785B;
        Wed, 25 Mar 2020 13:55:23 +0000 (GMT)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 25 Mar 2020 13:55:22 +0000
Received: from [127.0.0.1] (10.47.86.66) by lhreml715-chm.china.huawei.com
 (10.201.108.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 13:55:22 +0000
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
        <james.morse@arm.com>, <tony.luck@intel.com>,
        <gregkh@linuxfoundation.org>, <zhangliguang@linux.alibaba.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <yangyicong@hisilicon.com>
From:   Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v5 0/2] ACPI: APEI: Add support to notify the vendor specific
 HW errors
Message-ID: <8aa40a48-39c9-ba6b-ea70-bcb60907a733@huawei.com>
Date:   Wed, 25 Mar 2020 13:55:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.66]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
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
   APEI: Add support to notify the vendor specific HW errors

Yicong Yang (1):
   PCI: HIP: Add handling of HiSilicon HIP PCIe controller errors

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

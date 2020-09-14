Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25745268B0E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgINMcl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 14 Sep 2020 08:32:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbgINMcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 08:32:16 -0400
Received: from lhreml713-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 71917FA49058FFD59948;
        Mon, 14 Sep 2020 13:13:45 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 14 Sep 2020 13:13:45 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 13:13:45 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
        specific HW errors
Thread-Topic: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
        specific HW errors
Thread-Index: AQHWge9vw3KZA5696kitxl2toth2IaloGvNg
Date:   Mon, 14 Sep 2020 12:13:45 +0000
Message-ID: <cb811df3c4cc4f349c4a8da251592904@huawei.com>
References: <20200903123456.1823-1-shiju.jose@huawei.com>
In-Reply-To: <20200903123456.1823-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Can you help to merge this series?

Thanks,
Shiju

>-----Original Message-----
>From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Shiju
>Jose
>Sent: 03 September 2020 13:35
>To: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
>bp@alien8.de; james.morse@arm.com; lorenzo.pieralisi@arm.com;
>robh@kernel.org; lenb@kernel.org; tony.luck@intel.com;
>dan.carpenter@oracle.com; andriy.shevchenko@linux.intel.com
>Cc: Linuxarm <linuxarm@huawei.com>
>Subject: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
>specific HW errors
>
>CPER records describing a firmware-first error are identified by GUID.
>The ghes driver currently logs, but ignores any unknown CPER records.
>This prevents describing errors that can't be represented by a standard entry,
>that would otherwise allow a driver to recover from an error.
>The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of version 2.8).
>
>patch set
>1. add the notifier chain for these non-standard/vendor-records
>   in the ghes driver.
>
>2. add the driver to handle HiSilicon HIP PCIe controller's errors.
>
>Changes:
>
>V15:
>1. Change in the HIP PCIe error handling driver
>   for a comment by Andy Shevchenko.
>   Removed "depends on ACPI" as it already depends on
>   it through ACPI_APEI_GHES.
>
>V14:
>1. Add patch[1] posted by James to the series.
>
>2. Following changes made for Bjorn's comments,
>2.1 Deleted stub code from ghes.h
>2.2 Made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES.
>
>V13:
>1. Following changes in the HIP PCIe error handling driver.
>1.1 Add Bjorn's acked-by.
>1.2. Address the comments and macros order Bjorn mentioned.
>     Fix the words in the commit.
>
>V12:
>1. Changed the Signed-off-by tag to Co-developed-by tag in the patch
>   "ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records"
>
>V11:
>1. Following modifications made by James Morse in the APEI patch
>   for the vendor error record.
>   - Removed kfifo and ghes_gdata_pool. Expanded commit message.
>
>2. Changes in the HIP PCIe error handling driver
>   for the comments by Andy Shevchenko.
>
>V10:
>1. Changes for Bjorn's comments on HIP PCIe error handler driver
>   and APEI patch.
>
>2. Changes in the HIP PCIe error handler driver
>   for the feedbacks by Andy Shevchenko.
>
>V9:
>1. Fixed 2 improvements suggested by the kbuild test robot.
>1.1 Change ghes_gdata_pool_init() as static function.
>1.2. Removed using buffer to store the error data for
>     logging in the hisi_pcie_handle_error()
>
>V8:
>1. Removed reporting the standard errors through the interface
>   because of the conflict with the recent patches in the
>   memory error handling path.
>2. Fix comments by Dan Carpenter.
>
>V7:
>1. Add changes in the APEI driver suggested by Borislav Petkov, for
>   queuing up all the non-fatal HW errors to the work queue and
>   notify the registered kernel drivers from the bottom half using
>   blocking notifier, common interface for both standard and
>   vendor-spcific errors.
>2. Fix for further feedbacks in v5 HIP PCIe error handler driver
>   by Bjorn Helgaas.
>
>V6:
>1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.
>
>V5:
>1. Fix comments from James Morse.
>1.1 Changed the notification method to use the atomic_notifier_chain.
>1.2 Add the error handled status for the user space.
>
>V4:
>1. Fix for the following smatch warning in the PCIe error driver,
>   reported by kbuild test robot<lkp@intel.com>:
>   warn: should '((((1))) << (9 + i))' be a 64 bit type?
>   if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
>	^^^ This should be BIT_ULL() because it goes up to 9 + 32.
>
>V3:
>1. Fix the comments from Bjorn Helgaas.
>
>V2:
>1. Changes in the HiSilicon PCIe controller's error handling driver
>   for the comments from Bjorn Helgaas.
>
>2. Changes in the APEI interface to support reporting the vendor error
>   for module with multiple devices, but use the same section type.
>   In the error handler will use socket id/sub module id etc to distinguish
>   the device.
>
>V1:
>1. Fix comments from James Morse.
>
>2. add driver to handle HiSilicon hip08 PCIe controller's errors,
>   which is an application of the above interface.
>
>Shiju Jose (1):
>  ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records
>
>Yicong Yang (1):
>  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors
>
> drivers/acpi/apei/ghes.c                 |  63 +++++
> drivers/pci/controller/Kconfig           |   7 +
> drivers/pci/controller/Makefile          |   1 +
> drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
> include/acpi/ghes.h                      |  18 ++
> 5 files changed, 416 insertions(+)
> create mode 100644 drivers/pci/controller/pcie-hisi-error.c
>
>--
>2.17.1
>
>
>_______________________________________________
>Linuxarm mailing list
>Linuxarm@huawei.com
>http://hulk.huawei.com/mailman/listinfo/linuxarm

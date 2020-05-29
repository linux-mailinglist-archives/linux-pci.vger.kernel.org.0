Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141661E887E
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2UFO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 29 May 2020 16:05:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbgE2UFN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 16:05:13 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9206CE851D406A4F47D9;
        Fri, 29 May 2020 21:05:11 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 29 May 2020 21:05:11 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 29 May 2020 21:05:11 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     Linuxarm <linuxarm@huawei.com>, yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v8 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v8 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHWNeBR/m4tj2cJW0qFvUY6/34P2qi/fFmg
Date:   Fri, 29 May 2020 20:05:10 +0000
Message-ID: <78a6dfbe246b4dbbbdd9534f87638f86@huawei.com>
References: <20200529173854.2521-1-shiju.jose@huawei.com>
In-Reply-To: <20200529173854.2521-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please ignore this patch set. Resending soon.

Thanks,
Shiju

>-----Original Message-----
>From: Shiju Jose
>Sent: 29 May 2020 18:39
>To: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
>james.morse@arm.com; helgaas@kernel.org; lenb@kernel.org;
>tony.luck@intel.com; dan.carpenter@oracle.com;
>gregkh@linuxfoundation.org; zhangliguang@linux.alibaba.com;
>tglx@linutronix.de
>Cc: Shiju Jose <shiju.jose@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>yangyicong <yangyicong@huawei.com>
>Subject: [PATCH v8 0/2] ACPI / APEI: Add support to notify the vendor
>specific HW errors
>
>Presently the vendor drivers are unable to do the recovery for the vendor
>specific recoverable HW errors because APEI driver does not support
>reporting the error to the vendor drivers.
>
>patch set
>1. add new interface to the APEI driver for reporting the
>   vendor specific non-fatal HW errors to the drivers.
>
>2. add driver to handle HiSilicon hip PCIe controller's errors.
>
>V8:
>1. Removed reporting the standard errors through the interface
>   because of the conflict with the changes in the
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
>  ACPI / APEI: Add support to notify the vendor specific HW errors
>
>Yicong Yang (1):
>  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors
>
> drivers/acpi/apei/ghes.c                 | 126 ++++++++-
> drivers/pci/controller/Kconfig           |   8 +
> drivers/pci/controller/Makefile          |   1 +
> drivers/pci/controller/pcie-hisi-error.c | 321 +++++++++++++++++++++++
> include/acpi/ghes.h                      |  28 ++
> 5 files changed, 483 insertions(+), 1 deletion(-)  create mode 100644
>drivers/pci/controller/pcie-hisi-error.c
>
>--
>2.17.1
>


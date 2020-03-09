Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AF17DC55
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCIJXH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Mar 2020 05:23:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2517 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgCIJXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 05:23:07 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EFEBBDAF59E32787575D;
        Mon,  9 Mar 2020 09:23:05 +0000 (GMT)
Received: from lhreml713-chm.china.huawei.com (10.201.108.64) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 09:23:05 +0000
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Mar 2020 09:23:05 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Mon, 9 Mar 2020 09:23:05 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v4 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v4 0/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHV3aHkegohdCgESkuEgBYAy0dBQqhALNvg
Date:   Mon, 9 Mar 2020 09:23:05 +0000
Message-ID: <30d704c86d8b4be591ee36c0e735069d@huawei.com>
References: <Shiju Jose> <20200207103143.20104-1-shiju.jose@huawei.com>
In-Reply-To: <20200207103143.20104-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Gentle reminder on this patch set.

Thanks,
Shiju

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Shiju Jose
>Sent: 07 February 2020 10:32
>To: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
>lenb@kernel.org; bp@alien8.de; james.morse@arm.com; tony.luck@intel.com;
>gregkh@linuxfoundation.org; zhangliguang@linux.alibaba.com;
>tglx@linutronix.de
>Cc: Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>yangyicong <yangyicong@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: [PATCH v4 0/2] ACPI: APEI: Add support to notify the vendor specific
>HW errors
>
>Presently the vendor drivers are unable to do the recovery for the vendor
>specific recoverable HW errors, reported to the APEI driver in the vendor
>defined sections, because APEI driver does not support reporting the same to
>the vendor drivers.
>
>This patch set
>1. add an interface to the APEI driver to enable the vendor drivers to register
>the event handling functions for the corresponding vendor specific HW errors
>and report the error to the vendor driver.
>
>2. add driver to handle HiSilicon hip08 PCIe controller's errors
>   which is an example application of the above APEI interface.
>
>Changes:
>
>V4:
>1. Fix for the smatch warning in the PCIe error driver:
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
>  ACPI: APEI: Add support to notify the vendor specific HW errors
>
>Yicong Yang (1):
>  PCI: HIP: Add handling of HiSilicon HIP PCIe controller errors
>
> drivers/acpi/apei/ghes.c                 | 116 ++++++++++-
> drivers/pci/controller/Kconfig           |   8 +
> drivers/pci/controller/Makefile          |   1 +
> drivers/pci/controller/pcie-hisi-error.c | 334
>+++++++++++++++++++++++++++++++
> include/acpi/ghes.h                      |  56 ++++++
> 5 files changed, 510 insertions(+), 5 deletions(-)  create mode 100644
>drivers/pci/controller/pcie-hisi-error.c
>
>--
>1.9.1
>


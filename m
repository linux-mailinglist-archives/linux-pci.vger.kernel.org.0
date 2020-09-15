Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3481426AC69
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIOSop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 14:44:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44175 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgIORcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 13:32:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id 185so4741933oie.11;
        Tue, 15 Sep 2020 10:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/XiBF8iZP+AWOwyZnXfgNr6RvYoHK7GCXr5wRTdkK8=;
        b=F7pliRDsbV1Ht5lA55SSKx3/ELLHkLRIvdC5Bnr+Sp0cEi5gIhGPocfbzQe86DkEbI
         HOihB1n14bsuXFn3aXK8ab9tmi8h9HAtNSMrzXrO19lF5t6MQEYz30Bz6P83LD0weUZt
         Q3wnAgdxB3zHMls33sJ6z/goi86WBdY/fGWr13B1KbxK+Xq+xDaSLXXt/92cNJDyeoTI
         cS6WLCQ4FZ44RAhvNtm8XqBhZQ8cCUMdhuxIDQs9C+ayCHbVdtpSDoCeprieHOcUTN7Y
         DW/S6VczTUjggWSFC4fLRZiLSYyhMYePXRSa4Iz/03fIMxdSUdNJmX6D3dK9S7nnOyMO
         /X6A==
X-Gm-Message-State: AOAM533tsrFj5er/p0ZBTC2vJ2Wp40+HWZIR6vOIOv9CKwVzOl5VZJcV
        OVET1+2palp8pB/yp88MWiyT004L5+fbrnBVRdo=
X-Google-Smtp-Source: ABdhPJwzc9vJzPGZruY9Z8VQjGvlZ9an53QxdpepM7ebrnv70yooUs5Q1ZjR0JMVHAKxG61KEthn2Sx6ZKglak3nzRU=
X-Received: by 2002:aca:df84:: with SMTP id w126mr365251oig.103.1600191122649;
 Tue, 15 Sep 2020 10:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200903123456.1823-1-shiju.jose@huawei.com> <cb811df3c4cc4f349c4a8da251592904@huawei.com>
In-Reply-To: <cb811df3c4cc4f349c4a8da251592904@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Sep 2020 19:31:50 +0200
Message-ID: <CAJZ5v0goduHVhXdOjDu6WBnD8eBYzRWAD1PO8KjabpyiHuJ1qw@mail.gmail.com>
Subject: Re: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
        <andriy.shevchenko@linux.intel.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 2:34 PM Shiju Jose <shiju.jose@huawei.com> wrote:
>
> Hello,
>
> Can you help to merge this series?

Do you want this series to go in through the ACPI tree?

> >-----Original Message-----
> >From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Shiju
> >Jose
> >Sent: 03 September 2020 13:35
> >To: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> >kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
> >bp@alien8.de; james.morse@arm.com; lorenzo.pieralisi@arm.com;
> >robh@kernel.org; lenb@kernel.org; tony.luck@intel.com;
> >dan.carpenter@oracle.com; andriy.shevchenko@linux.intel.com
> >Cc: Linuxarm <linuxarm@huawei.com>
> >Subject: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
> >specific HW errors
> >
> >CPER records describing a firmware-first error are identified by GUID.
> >The ghes driver currently logs, but ignores any unknown CPER records.
> >This prevents describing errors that can't be represented by a standard entry,
> >that would otherwise allow a driver to recover from an error.
> >The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of version 2.8).
> >
> >patch set
> >1. add the notifier chain for these non-standard/vendor-records
> >   in the ghes driver.
> >
> >2. add the driver to handle HiSilicon HIP PCIe controller's errors.
> >
> >Changes:
> >
> >V15:
> >1. Change in the HIP PCIe error handling driver
> >   for a comment by Andy Shevchenko.
> >   Removed "depends on ACPI" as it already depends on
> >   it through ACPI_APEI_GHES.
> >
> >V14:
> >1. Add patch[1] posted by James to the series.
> >
> >2. Following changes made for Bjorn's comments,
> >2.1 Deleted stub code from ghes.h
> >2.2 Made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES.
> >
> >V13:
> >1. Following changes in the HIP PCIe error handling driver.
> >1.1 Add Bjorn's acked-by.
> >1.2. Address the comments and macros order Bjorn mentioned.
> >     Fix the words in the commit.
> >
> >V12:
> >1. Changed the Signed-off-by tag to Co-developed-by tag in the patch
> >   "ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records"
> >
> >V11:
> >1. Following modifications made by James Morse in the APEI patch
> >   for the vendor error record.
> >   - Removed kfifo and ghes_gdata_pool. Expanded commit message.
> >
> >2. Changes in the HIP PCIe error handling driver
> >   for the comments by Andy Shevchenko.
> >
> >V10:
> >1. Changes for Bjorn's comments on HIP PCIe error handler driver
> >   and APEI patch.
> >
> >2. Changes in the HIP PCIe error handler driver
> >   for the feedbacks by Andy Shevchenko.
> >
> >V9:
> >1. Fixed 2 improvements suggested by the kbuild test robot.
> >1.1 Change ghes_gdata_pool_init() as static function.
> >1.2. Removed using buffer to store the error data for
> >     logging in the hisi_pcie_handle_error()
> >
> >V8:
> >1. Removed reporting the standard errors through the interface
> >   because of the conflict with the recent patches in the
> >   memory error handling path.
> >2. Fix comments by Dan Carpenter.
> >
> >V7:
> >1. Add changes in the APEI driver suggested by Borislav Petkov, for
> >   queuing up all the non-fatal HW errors to the work queue and
> >   notify the registered kernel drivers from the bottom half using
> >   blocking notifier, common interface for both standard and
> >   vendor-spcific errors.
> >2. Fix for further feedbacks in v5 HIP PCIe error handler driver
> >   by Bjorn Helgaas.
> >
> >V6:
> >1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.
> >
> >V5:
> >1. Fix comments from James Morse.
> >1.1 Changed the notification method to use the atomic_notifier_chain.
> >1.2 Add the error handled status for the user space.
> >
> >V4:
> >1. Fix for the following smatch warning in the PCIe error driver,
> >   reported by kbuild test robot<lkp@intel.com>:
> >   warn: should '((((1))) << (9 + i))' be a 64 bit type?
> >   if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
> >       ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
> >
> >V3:
> >1. Fix the comments from Bjorn Helgaas.
> >
> >V2:
> >1. Changes in the HiSilicon PCIe controller's error handling driver
> >   for the comments from Bjorn Helgaas.
> >
> >2. Changes in the APEI interface to support reporting the vendor error
> >   for module with multiple devices, but use the same section type.
> >   In the error handler will use socket id/sub module id etc to distinguish
> >   the device.
> >
> >V1:
> >1. Fix comments from James Morse.
> >
> >2. add driver to handle HiSilicon hip08 PCIe controller's errors,
> >   which is an application of the above interface.
> >
> >Shiju Jose (1):
> >  ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records
> >
> >Yicong Yang (1):
> >  PCI: hip: Add handling of HiSilicon HIP PCIe controller errors
> >
> > drivers/acpi/apei/ghes.c                 |  63 +++++
> > drivers/pci/controller/Kconfig           |   7 +
> > drivers/pci/controller/Makefile          |   1 +
> > drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
> > include/acpi/ghes.h                      |  18 ++
> > 5 files changed, 416 insertions(+)
> > create mode 100644 drivers/pci/controller/pcie-hisi-error.c
> >
> >--
> >2.17.1
> >
> >
> >_______________________________________________
> >Linuxarm mailing list
> >Linuxarm@huawei.com
> >http://hulk.huawei.com/mailman/listinfo/linuxarm

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368DF22C594
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXMyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 08:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGXMyA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 08:54:00 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9482065E;
        Fri, 24 Jul 2020 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595595240;
        bh=RCrAinQ2iDuDhggp9uedY0HcB9B27aaB8nmj+Icx1yE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WAsXnhiTgA0OwmYAAGY2bi1ZOLtYr0IpsWrWSm7wrq8zyu6slm4urI3hx+aIDux3P
         9prU0ZLHq0fmPv1OEmWSNy4C6e00KjPEr4Rtg/b3tiHkTc/GqreyRo6wIPMBGBvzBM
         b7sXXBKNGQA0aag2kHNgPTS62/ooAw6+Yakege2o=
Date:   Fri, 24 Jul 2020 07:53:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Message-ID: <20200724125357.GA1510118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76444fed0a2468983b2a2c45d7d31b2@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 09:00:41AM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >Sent: 24 July 2020 00:21
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> >kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
> >james.morse@arm.com; lenb@kernel.org; tony.luck@intel.com;
> >dan.carpenter@oracle.com; zhangliguang@linux.alibaba.com;
> >andriy.shevchenko@linux.intel.com; Wangkefeng (OS Kernel Lab)
> ><wangkefeng.wang@huawei.com>; jroedel@suse.de; Linuxarm
> ><linuxarm@huawei.com>; yangyicong <yangyicong@huawei.com>; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; tanxiaofei
> ><tanxiaofei@huawei.com>
> >Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
> >(vendor) CPER records
> >
> >On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
> >> CPER records describing a firmware-first error are identified by GUID.
> >> The ghes driver currently logs, but ignores any unknown CPER records.
> >> This prevents describing errors that can't be represented by a
> >> standard entry, that would otherwise allow a driver to recover from an
> >error.
> >> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> >> version 2.8).
> >
> >> +#ifdef CONFIG_ACPI_APEI_GHES
> >> +/**
> >> + * ghes_register_vendor_record_notifier - register a notifier for
> >> +vendor
> >> + * records that the kernel would otherwise ignore.
> >> + * @nb: pointer to the notifier_block structure of the event handler.
> >> + *
> >> + * return 0 : SUCCESS, non-zero : FAIL  */ int
> >> +ghes_register_vendor_record_notifier(struct notifier_block *nb);
> >> +
> >> +/**
> >> + * ghes_unregister_vendor_record_notifier - unregister the previously
> >> + * registered vendor record notifier.
> >> + * @nb: pointer to the notifier_block structure of the vendor record
> >handler.
> >> + */
> >> +void ghes_unregister_vendor_record_notifier(struct notifier_block
> >> +*nb); #else static inline int
> >> +ghes_register_vendor_record_notifier(struct notifier_block *nb) {
> >> +	return -ENODEV;
> >> +}
> >> +
> >> +static inline void ghes_unregister_vendor_record_notifier(struct
> >> +notifier_block *nb) { }
> >
> >If you made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES,
> >you'd be able to get rid of these stubs, wouldn't you?  It doesn't
> >look like there's any point in building pcie-hisi-error.c at all
> >unless CONFIG_ACPI_APEI_GHES is enabled.
>
> The stub is added because this interface is expected to use by the
> other drivers as well.  Some drivers may not want add the build
> depend on the CONFIG_ACPI_APEI_GHES if the error reporting has less
> priority in the driver.  However we can add dependency on
> CONFIG_ACPI_APEI_GHES for building pcie-hisi-error.c.  

The usual route is to add stubs when they're needed, not just in
anticipation of some need that may never materialize.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC22E205571
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgFWPE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 11:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbgFWPE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 11:04:29 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EC420723;
        Tue, 23 Jun 2020 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592924669;
        bh=pYSmEX90OpGgB4bw3JQlLwOPKGPZt8zcCg2Jw+YWJhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uyCRgzznNIaGzwTA5WSAD0mfkUx7PWjjDA0xuNRfK8wdFyqid6COQmfVRcULXo7eB
         x6r9H+xRROcynvqijhjGKwufYcigaaHtOMvN1NklZTodXP7DkrU83liurSsGCNLFtO
         sRrkKEDXRbWwc9kz0no38z13LtKl0kt/Ne0JEuNE=
Date:   Tue, 23 Jun 2020 10:04:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200623150427.GA2403606@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5d7b2f1-6b32-d965-3b60-eb70a26e02b4@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 10:26:54AM +0800, Zhangfei Gao wrote:
> Have studied _DSM method, two issues we met comparing using quirk.
> 
> 1. Need change definition of either pci_host_bridge or pci_dev, like adding
> member can_stall,
> while pci system does not know stall now.
> 
> a, pci devices do not have uuid: uuid need be described in dsdt, while pci
> devices are not defined in dsdt.
>     so we have to use host bridge.

PCI devices *can* be described in the DSDT.  IIUC these particular
devices are hardwired (not plug-in cards), so platform firmware can
know about them and could describe them in the DSDT.

> b,  Parsing dsdt is in in pci subsystem.
> Like drivers/acpi/pci_root.c:
>        obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid,
> 1,
>                                 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> 
> After parsing DSM in pci, we need record this info.
> Currently, can_stall info is recorded in iommu_fwspec,
> which is allocated in iommu_fwspec_init and called by iort_iommu_configure
> for uefi.

You can look for a _DSM wherever it is convenient for you.  It could
be in an AMBA shim layer.

> 2. Guest kernel also need support sva.
> Using quirk, the guest can boot with sva enabled, since quirk is
> self-contained by kernel.
> If using  _DSM, a specific uefi or dtb has to be provided,
> currently we can useQEMU_EFI.fd from apt install qemu-efi

I don't quite understand what this means, but as I mentioned before, a
quirk for a *limited* number of devices is OK, as long as there is a
plan that removes the need for a quirk for future devices.

E.g., if the next platform version ships with a DTB or firmware with a
_DSM or other mechanism that enables the kernel to discover this
information without a kernel change, it's fine to use a quirk to cover
the early platform.

The principles are:

  - I don't want to have to update a quirk for every new Device ID
    that needs this.

  - I don't really want to have to manage non-PCI information in the
    struct pci_dev.  If this is AMBA- or IOMMU-related, it should be
    stored in a structure related to AMBA or the IOMMU.

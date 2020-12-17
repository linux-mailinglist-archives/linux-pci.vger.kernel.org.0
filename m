Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDD2DDA35
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 21:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLQUit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 15:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgLQUit (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 15:38:49 -0500
Date:   Thu, 17 Dec 2020 14:38:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608237488;
        bh=Rpq08eYW+DA58q5pcS/wXU0VbVBc1vYow6lIlzk55rU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=KqE949u41Nqk8wZdC73imrPNhV6iDujEFjRfkVjZScfGg5NLARgNksvDkk54oZI9i
         mv/u6l2got64jOQ5WYUtngu2q9vI6xjHII+Jcy+PrjjE2gs1K6xgdwztx+nAvI4G2p
         D/IUTUhGXYUo0T11xN0y5dzNNoaIntqhsq2soJ1qJZmtzmxSv5ozHe2eIvw5XczDhw
         7imXx7N9zkX5LZaNE/XBXWbLBfgxWdq6WNk63Vd9f31kXpIWOfBj6C4mP+2GZruhTz
         M32DBRPOd7HuNC1U2xW9CiDgiKPo9i9u/PExMcMNgvaVJ1cxp2OOgAAkXwohRF2CCU
         mV7YA0/SGEecA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com,
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
Message-ID: <20201217203806.GA20785@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FD9EE6E.1040505@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 16, 2020 at 07:24:30PM +0800, Zhou Wang wrote:
> On 2020/6/23 23:04, Bjorn Helgaas wrote:
> > On Fri, Jun 19, 2020 at 10:26:54AM +0800, Zhangfei Gao wrote:
> >> Have studied _DSM method, two issues we met comparing using quirk.
> >>
> >> 1. Need change definition of either pci_host_bridge or pci_dev, like adding
> >> member can_stall,
> >> while pci system does not know stall now.
> >>
> >> a, pci devices do not have uuid: uuid need be described in dsdt, while pci
> >> devices are not defined in dsdt.
> >>     so we have to use host bridge.
> > 
> > PCI devices *can* be described in the DSDT.  IIUC these particular
> > devices are hardwired (not plug-in cards), so platform firmware can
> > know about them and could describe them in the DSDT.
> > 
> >> b,  Parsing dsdt is in in pci subsystem.
> >> Like drivers/acpi/pci_root.c:
> >>        obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid,
> >> 1,
> >>                                 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> >>
> >> After parsing DSM in pci, we need record this info.
> >> Currently, can_stall info is recorded in iommu_fwspec,
> >> which is allocated in iommu_fwspec_init and called by iort_iommu_configure
> >> for uefi.
> > 
> > You can look for a _DSM wherever it is convenient for you.  It could
> > be in an AMBA shim layer.
> > 
> >> 2. Guest kernel also need support sva.
> >> Using quirk, the guest can boot with sva enabled, since quirk is
> >> self-contained by kernel.
> >> If using  _DSM, a specific uefi or dtb has to be provided,
> >> currently we can useQEMU_EFI.fd from apt install qemu-efi
> > 
> > I don't quite understand what this means, but as I mentioned before, a
> > quirk for a *limited* number of devices is OK, as long as there is a
> > plan that removes the need for a quirk for future devices.
> > 
> > E.g., if the next platform version ships with a DTB or firmware with a
> > _DSM or other mechanism that enables the kernel to discover this
> > information without a kernel change, it's fine to use a quirk to cover
> > the early platform.
> > 
> > The principles are:
> > 
> >   - I don't want to have to update a quirk for every new Device ID
> >     that needs this.
> 
> Hi Bjorn and Zhangfei,
> 
> We plan to use ATS/PRI to support SVA in future PCI devices. However, for
> current devices, we need to add limited number of quirk to let them
> work. The device IDs of current quirk needed devices are ZIP engine(0xa250, 0xa251),
> SEC engine(0xa255, 0xa256), HPRE engine(0xa258, 0xa259), revision id are
> 0x21 and 0x30.
> 
> Let's continue to upstream these quirks!

Please post the patches you propose.  I don't think the previous ones
are in my queue.  Please include the lore URL for the previous
posting(s) in the cover letter so we can connect the discussion.

> >   - I don't really want to have to manage non-PCI information in the
> >     struct pci_dev.  If this is AMBA- or IOMMU-related, it should be
> >     stored in a structure related to AMBA or the IOMMU.
> > .
> > 

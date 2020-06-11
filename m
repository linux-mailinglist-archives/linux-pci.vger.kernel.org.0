Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83F1F6944
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFKNoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 09:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKNoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 09:44:14 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BB7207ED;
        Thu, 11 Jun 2020 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591883053;
        bh=xVUiCstzwxRiqsIstYcB/oExcpYP3mQ06Uzbjsb1RaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fCcWdDxUhizLu05tim7PdziyoQm0TsunDkVTg5gnd7NVQ1v3Z0WssIgGmBFQfHtjv
         RhzS1KxhkAIB/8lcKjWTAKHFcrZKT3jWnGdHyhvzRbe6z7xUsGSLs5/OdaMspITUr5
         l7XwqkZoKSdNXIH6IjuwKxi8iamLy2XFOjKChtzg=
Date:   Thu, 11 Jun 2020 08:44:10 -0500
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
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200611134410.GA1586057@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d8a7ec4-b578-a97a-7835-453806f4e3ef@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 11, 2020 at 10:54:45AM +0800, Zhangfei Gao wrote:
> On 2020/6/10 上午12:49, Bjorn Helgaas wrote:
> > On Tue, Jun 09, 2020 at 11:15:06AM +0200, Arnd Bergmann wrote:
> > > On Tue, Jun 9, 2020 at 6:02 AM Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> > > > On 2020/6/9 上午12:41, Bjorn Helgaas wrote:
> > > > > On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
> > > > > > On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
> > > > > > > > +++ b/drivers/iommu/iommu.c
> > > > > > > > @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> > > > > > > > fwnode_handle *iommu_fwnode,
> > > > > > > >            fwspec->iommu_fwnode = iommu_fwnode;
> > > > > > > >            fwspec->ops = ops;
> > > > > > > >            dev_iommu_fwspec_set(dev, fwspec);
> > > > > > > > +
> > > > > > > > +       if (dev_is_pci(dev))
> > > > > > > > +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
> > > > > > > > +
> > > > > > > > 
> > > > > > > > Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
> > > > > > > > Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
> > > > > > > > Will send this when 5.8-rc1 is open.
> > > > > > > Wait, this whole fixup approach seems wrong to me.  No matter how you
> > > > > > > do the fixup, it's still a fixup, which means it requires ongoing
> > > > > > > maintenance.  Surely we don't want to have to add the Vendor/Device ID
> > > > > > > for every new AMBA device that comes along, do we?
> > > > > > > 
> > > > > > Here the fake pci device has standard PCI cfg space, but physical
> > > > > > implementation is base on AMBA
> > > > > > They can provide pasid feature.
> > > > > > However,
> > > > > > 1, does not support tlp since they are not real pci devices.
> > > > > > 2. does not support pri, instead support stall (provided by smmu)
> > > > > > And stall is not a pci feature, so it is not described in struct pci_dev,
> > > > > > but in struct iommu_fwspec.
> > > > > > So we use this fixup to tell pci system that the devices can support stall,
> > > > > > and hereby support pasid.
> > > > > This did not answer my question.  Are you proposing that we update a
> > > > > quirk every time a new AMBA device is released?  I don't think that
> > > > > would be a good model.
> > > > Yes, you are right, but we do not have any better idea yet.
> > > > Currently we have three fake pci devices, which support stall and pasid.
> > > > We have to let pci system know the device can support pasid, because of
> > > > stall feature, though not support pri.
> > > > Do you have any other ideas?
> > > It sounds like the best way would be to allocate a PCI capability for it, so
> > > detection can be done through config space, at least in future devices,
> > > or possibly after a firmware update if the config space in your system
> > > is controlled by firmware somewhere.  Once there is a proper mechanism
> > > to do this, using fixups to detect the early devices that don't use that
> > > should be uncontroversial. I have no idea what the process or timeline
> > > is to add new capabilities into the PCIe specification, or if this one
> > > would be acceptable to the PCI SIG at all.
> > That sounds like a possibility.  The spec already defines a
> > Vendor-Specific Extended Capability (PCIe r5.0, sec 7.9.5) that might
> > be a candidate.
> Will investigate this, thanks Bjorn

FWIW, there's also a Vendor-Specific Capability that can appear in the
first 256 bytes of config space (the Vendor-Specific Extended
Capability must appear in the "Extended Configuration Space" from
0x100-0xfff).

> > > If detection cannot be done through PCI config space, the next best
> > > alternative is to pass auxiliary data through firmware. On DT based
> > > machines, you can list non-hotpluggable PCIe devices and add custom
> > > properties that could be read during device enumeration. I assume
> > > ACPI has something similar, but I have not done that.
> Yes, thanks Arnd
> > ACPI has _DSM (ACPI v6.3, sec 9.1.1), which might be a candidate.  I
> > like this better than a PCI capability because the property you need
> > to expose is not a PCI property.
> _DSM may not workable, since it is working in runtime.
> We need stall information in init stage, neither too early (after allocation
> of iommu_fwspec)
> nor too late (before arm_smmu_add_device ).

I'm not aware of a restriction on when _DSM can be evaluated.  I'm
looking at ACPI v6.3, sec 9.1.1.  Are you seeing something different?

> By the way, It would be a long time if we need modify either pcie
> spec or acpi spec.  Can we use pci_fixup_device in iommu_fwspec_init
> first, it is relatively simple and meet the requirement of platform
> device using pasid, and they are already in product.

Neither the PCI Vendor-Specific Capability nor the ACPI _DSM requires
a spec change.  Both can be completely vendor-defined.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8981F4153
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgFIQta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbgFIQt3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 12:49:29 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1D420737;
        Tue,  9 Jun 2020 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591721368;
        bh=5Q7RvyofmbZbrB/I38g1tWmxg8QS/w1w0oFGJk1TAAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dvG4keriVYERu7ME7jmTxlggF24dPHuT8ZHwsHgyeBv8aHb5TopY1KdfJVDndSoXl
         RxQiw2j9xiinR8ke3p9Ltba3X4AhyTf4XbSb9RwT2AqKWdKTjRg+cV7DgApD257z37
         fAvyNM3ngOAOHRMuIGrK7cGIhRs7rGlN9Hoz8zWA=
Date:   Tue, 9 Jun 2020 11:49:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
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
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200609164926.GA1452092@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 11:15:06AM +0200, Arnd Bergmann wrote:
> On Tue, Jun 9, 2020 at 6:02 AM Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> > On 2020/6/9 上午12:41, Bjorn Helgaas wrote:
> > > On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
> > >> On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
> > >>>> +++ b/drivers/iommu/iommu.c
> > >>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> > >>>> fwnode_handle *iommu_fwnode,
> > >>>>           fwspec->iommu_fwnode = iommu_fwnode;
> > >>>>           fwspec->ops = ops;
> > >>>>           dev_iommu_fwspec_set(dev, fwspec);
> > >>>> +
> > >>>> +       if (dev_is_pci(dev))
> > >>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
> > >>>> +
> > >>>>
> > >>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
> > >>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
> > >>>> Will send this when 5.8-rc1 is open.
> > >>> Wait, this whole fixup approach seems wrong to me.  No matter how you
> > >>> do the fixup, it's still a fixup, which means it requires ongoing
> > >>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
> > >>> for every new AMBA device that comes along, do we?
> > >>>
> > >> Here the fake pci device has standard PCI cfg space, but physical
> > >> implementation is base on AMBA
> > >> They can provide pasid feature.
> > >> However,
> > >> 1, does not support tlp since they are not real pci devices.
> > >> 2. does not support pri, instead support stall (provided by smmu)
> > >> And stall is not a pci feature, so it is not described in struct pci_dev,
> > >> but in struct iommu_fwspec.
> > >> So we use this fixup to tell pci system that the devices can support stall,
> > >> and hereby support pasid.
> > > This did not answer my question.  Are you proposing that we update a
> > > quirk every time a new AMBA device is released?  I don't think that
> > > would be a good model.
> >
> > Yes, you are right, but we do not have any better idea yet.
> > Currently we have three fake pci devices, which support stall and pasid.
> > We have to let pci system know the device can support pasid, because of
> > stall feature, though not support pri.
> > Do you have any other ideas?
> 
> It sounds like the best way would be to allocate a PCI capability for it, so
> detection can be done through config space, at least in future devices,
> or possibly after a firmware update if the config space in your system
> is controlled by firmware somewhere.  Once there is a proper mechanism
> to do this, using fixups to detect the early devices that don't use that
> should be uncontroversial. I have no idea what the process or timeline
> is to add new capabilities into the PCIe specification, or if this one
> would be acceptable to the PCI SIG at all.

That sounds like a possibility.  The spec already defines a
Vendor-Specific Extended Capability (PCIe r5.0, sec 7.9.5) that might
be a candidate.

> If detection cannot be done through PCI config space, the next best
> alternative is to pass auxiliary data through firmware. On DT based
> machines, you can list non-hotpluggable PCIe devices and add custom
> properties that could be read during device enumeration. I assume
> ACPI has something similar, but I have not done that.

ACPI has _DSM (ACPI v6.3, sec 9.1.1), which might be a candidate.  I
like this better than a PCI capability because the property you need
to expose is not a PCI property.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0592B1F1D97
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgFHQl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 12:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbgFHQl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 12:41:56 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E0D206A4;
        Mon,  8 Jun 2020 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591634515;
        bh=9+wSpwKeMW/wdGvPemQJqQQABIsLkQPW2K8a1nmcHm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vcbz31UJVkE9u265rOeW3ymi3j4Td/cEnamY/yY9ERI7XDF6hwJNBbYLuVspo03w5
         +nCy5Z6r28j/PRn+D0ikGuvRbXbN8X1Cx89vEnnUVpdAtfUfJ5pVag/p6J2pakmzHc
         k/V+AhP42zscGFN8csMJ506cA5x/mPmtM2EEkY74=
Date:   Mon, 8 Jun 2020 11:41:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200608164148.GA1394249@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be91b0f0-c685-789d-6868-1c8ebd62b770@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
> On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
> > On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
> > > On 2020/6/2 上午1:41, Bjorn Helgaas wrote:
> > > > On Thu, May 28, 2020 at 09:33:44AM +0200, Joerg Roedel wrote:
> > > > > On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
> > > > > > Is this slowdown significant?  We already iterate over every device
> > > > > > when applying PCI_FIXUP_FINAL quirks, so if we used the existing
> > > > > > PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
> > > > > > adding two more iterations to the loop in pci_do_fixups() that tries
> > > > > > to match quirks against the current device.  I doubt that would be a
> > > > > > measurable slowdown.
> > > > > I don't know how significant it is, but I remember people complaining
> > > > > about adding new PCI quirks because it takes too long for them to run
> > > > > them all. That was in the discussion about the quirk disabling ATS on
> > > > > AMD Stoney systems.
> > > > > 
> > > > > So it probably depends on how many PCI devices are in the system whether
> > > > > it causes any measureable slowdown.
> > > > I found this [1] from Paul Menzel, which was a slowdown caused by
> > > > quirk_usb_early_handoff().  I think the real problem is individual
> > > > quirks that take a long time.
> > > > 
> > > > The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
> > > > course, they're only run for matching devices anyway.  So I'd rather
> > > > keep them as PCI_FIXUP_FINAL than add a whole new phase.
> > > > 
> > > Thanks Bjorn for taking time for this.
> > > If so, it would be much simpler.
> > > 
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> > > fwnode_handle *iommu_fwnode,
> > >          fwspec->iommu_fwnode = iommu_fwnode;
> > >          fwspec->ops = ops;
> > >          dev_iommu_fwspec_set(dev, fwspec);
> > > +
> > > +       if (dev_is_pci(dev))
> > > +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
> > > +
> > > 
> > > Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
> > > Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
> > > Will send this when 5.8-rc1 is open.
> >
> > Wait, this whole fixup approach seems wrong to me.  No matter how you
> > do the fixup, it's still a fixup, which means it requires ongoing
> > maintenance.  Surely we don't want to have to add the Vendor/Device ID
> > for every new AMBA device that comes along, do we?
> > 
> Here the fake pci device has standard PCI cfg space, but physical
> implementation is base on AMBA
> They can provide pasid feature.
> However,
> 1, does not support tlp since they are not real pci devices.
> 2. does not support pri, instead support stall (provided by smmu)
> And stall is not a pci feature, so it is not described in struct pci_dev,
> but in struct iommu_fwspec.
> So we use this fixup to tell pci system that the devices can support stall,
> and hereby support pasid.

This did not answer my question.  Are you proposing that we update a
quirk every time a new AMBA device is released?  I don't think that
would be a good model.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A232FF272
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 18:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbhAURvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 12:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbhAURve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 12:51:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 502B8207C5;
        Thu, 21 Jan 2021 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251454;
        bh=WGwQ/LHJXpuOITyCedmJK7xHBWnLxm4p78A0vIrcCrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WWMIaVUrMsoYXKcThZxUsMzkbftbS6wb7aeJVYFAMYi6c7szO0KcwQGFD7qWB9j3x
         /lc6NcIPhGgD5WUFEt73ESPSagiyNbmFe7NhSYany8aSzG0Rn4+4dA/ikDzT2kHoXX
         kOTCg/GUj9begEkDotw4k7luq6TLQvfFle5dGuOrJ4dLsHCxF0SHW18DULT+1HDSJi
         8HjPpYPtvvi+0u9koFHercHFR41yE9w2kZVBfOD3GjNwdUZrqGNMDKbRZMvVrDR3Nd
         /yAfa+4KDh59SbWxSUP+GqVQj774WcQw7aCvGS09aJf6BLTdIF8uxaudyrix0jrgeF
         jhh2Ng65m6oRA==
Date:   Thu, 21 Jan 2021 11:50:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: set dma-can-stall for HiSilicon chip
Message-ID: <20210121175050.GA2668947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121165706.GA2663152@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 10:57:09AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 18, 2021 at 04:58:36PM +0800, Zhangfei Gao wrote:
> > HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> > actually on the AMBA bus. These fake PCI devices can support SVA via
> > SMMU stall feature, by setting dma-can-stall for ACPI platforms.
> > 
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> > Property dma-can-stall depends on patchset
> > https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
> > 
> >  drivers/pci/quirks.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 873d27f..b866cdf 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -1827,10 +1827,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
> >  
> >  static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
> >  {
> > +	struct property_entry properties[] = {
> > +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
> > +		{},
> > +	};
> > +
> >  	if (pdev->revision != 0x21 && pdev->revision != 0x30)
> >  		return;
> >  
> >  	pdev->pasid_no_tlp = 1;
> > +
> > +	/*
> > +	 * Set the dma-can-stall property on ACPI platforms. Device tree
> > +	 * can set it directly.
> > +	 */
> > +	if (!pdev->dev.of_node &&
> > +	    device_add_properties(&pdev->dev, properties))
> > +		pci_warn(pdev, "could not add stall property");
> 
> What's the purpose of adding the "dma-can-stall" property?  I don't
> see any reference to that property in the tree or in this series.  If
> this is related to some other series that uses it, perhaps this part
> should be moved to that series?

Sorry, I missed your note about this above!  Thanks for the pointer.

I hate having code in the tree that's useless pending some other
series, but I guess doing it this way helps avoid ordering issues
between this series and that one.

But please include the lore URL to Jean-Philippe's series in the
commit log so that if this patch is merged before Jean-Philippe's,
people at least have a hint about what's going on.

> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
> > -- 
> > 2.7.4
> > 

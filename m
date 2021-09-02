Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0154D3FEFA9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbhIBOrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 10:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345450AbhIBOrZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 10:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A548860F56;
        Thu,  2 Sep 2021 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630593987;
        bh=LAjLVOuLv0GADfr79P6bjh2CHXkMV2kcfrQceNgLgGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qTaPzl2UzDiWc3uDLRhjDiwlZDv7imOhLc0wCpTT3WmFykB2Xsx8hv8cS6bfUofXM
         0v/Mx1uahiNtoPMKy5az+unICvEMtyfSO1ENK+wBqynePZIL1O0jaKUoJlkLfji4gB
         1E/CsVVdwJtfy/pY6V3C4Yh5R1LAoEJvc9/FcqwODusnGLX1/Uwba7XM0EI5fD0zCB
         02gSxCl0FJAEBRvqRCS0qYjP816HfRHW3jt0MDop/SOnCZXBGqZMsWoKr+xtlry5LT
         liN0eCRD4zunH1KENg2wBEtdJ1D/gEbzsy4xlaLn7ZqPeDyG9iL0uSfBRVS+rUjBac
         Zm78O8uqoJILg==
Date:   Thu, 2 Sep 2021 09:46:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     robh@kernel.org, will@kernel.org, joro@8bytes.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <20210902144625.GA328403@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820195712.GA3342877@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marek, Anders, Robin]

On Fri, Aug 20, 2021 at 02:57:12PM -0500, Bjorn Helgaas wrote:
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
> > From: Xingang Wang <wangxingang5@huawei.com>
> > 
> > When booting with devicetree, the pci_request_acs() is called after the
> > enumeration and initialization of PCI devices, thus the ACS is not
> > enabled. And ACS should be enabled when IOMMU is detected for the
> > PCI host bridge, so add check for IOMMU before probe of PCI host and call
> > pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> > devices.
> > 
> > Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> > configuring IOMMU linkage")
> > Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> 
> Applied to pci/virtualization for v5.15, thanks!

I dropped this for now, until the problems reported by Marek and
Anders get sorted out.

> > ---
> >  drivers/iommu/of_iommu.c | 1 -
> >  drivers/pci/of.c         | 8 +++++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index a9d2df001149..54a14da242cc 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  			.np = master_np,
> >  		};
> >  
> > -		pci_request_acs();
> >  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> >  					     of_pci_iommu_init, &info);
> >  	} else {
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index da5b414d585a..2313c3f848b0 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >  
> >  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >  {
> > -	if (!dev->of_node)
> > +	struct device_node *node = dev->of_node;
> > +
> > +	if (!node)
> >  		return 0;
> >  
> > +	/* Detect IOMMU and make sure ACS will be enabled */
> > +	if (of_property_read_bool(node, "iommu-map"))
> > +		pci_request_acs();
> > +
> >  	bridge->swizzle_irq = pci_common_swizzle;
> >  	bridge->map_irq = of_irq_parse_and_map_pci;
> >  
> > -- 
> > 2.19.1
> > 

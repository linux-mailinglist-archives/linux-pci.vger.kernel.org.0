Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7C3F69E6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 21:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhHXTfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 15:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhHXTfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 15:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B1E60F91;
        Tue, 24 Aug 2021 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629833680;
        bh=FolpW8ndZBvgISlyt3ab7Myhj7YVQF/oTlf48uWsx28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VstM5jxAZlXmsXVDpR/R44L49vZC+QVsKWs7DzwzufCueSjpP8Ue2k1bC7OIpe5+D
         IF59qR+D865Fz2roOQDdRhn2TFWjkuaq+hoSOk3R8IQzPBx0qWQnaTjDjkcQg9czaI
         pqRk05OwisgUDwXD0ma0tkjedIsDQtGHfb8WM/JA1mfmQ8xxUDWsGqLRMChKMPIMeX
         SoKJS2rqlQ7FQFClxj1DRRwn6IgFwrQrNNBATbLKFTQ1CFMC2Zp51tU+y4Jy0ZleS4
         pZqku68ODvdo+ItwRGjtzY7zFt8VIK4ww19hAQLCUQB/3Owfbz5OPSF0OhB9tMmcx+
         FnaaUovlQdhPg==
Date:   Tue, 24 Aug 2021 14:34:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jonathan.Cameron@huawei.com,
        bilbao@vt.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        luzmaximilian@gmail.com, mchehab+huawei@kernel.org,
        schnelle@linux.ibm.com, Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
Message-ID: <20210824193438.GA3486820@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zceLLBk1K_9Bmiju54CvGYySoEN4Kgy4yATst_E9c68A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 10:46:59AM +1200, Barry Song wrote:
> On Mon, Aug 23, 2021 at 11:28 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Mon, 23 Aug 2021 12:03:08 +0100,
> > Barry Song <21cnbao@gmail.com> wrote:

> +static ssize_t irq_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +#ifdef CONFIG_PCI_MSI
> +       struct msi_desc *desc = first_pci_msi_entry(pdev);
> +
> +       /* for MSI, return the 1st IRQ in IRQ vector */
> +       if (desc && !desc->msi_attrib.is_msix)
> +               return sysfs_emit(buf, "%u\n", desc->irq);
> +#endif
> +
> +       return sysfs_emit(buf, "%u\n", pdev->irq);
> +}
> +static DEVICE_ATTR_RO(irq);

Makes sense to me.  And with Marc's patch maybe we could get rid of
default_irq, which also seems nice.

> > > if we don't want to change the behaviour of any existing ABI, it
> > > seems the only thing we can do here to document it well in ABI
> > > doc. i actually doubt anyone has really understood what the irq
> > > entry is really showing.
> >
> > Given that we can't prove that it is actually the case, I believe this
> > is the only option.
> 
> we have to document the ABI like below though it seems quite annoying.
> 
> 1. for devices which don't support MSI and MSI-X, show legacy INTx
> 2. for devices which support MSI
>     a. if CONFIG_PCI_MSI is not enabled,  show legacy INTx
>     b. if CONFIG_PCI_MSI is enabled and devices are using MSI at this
> moment, show 1st IRQ in the vector
>     c. if CONFIG_PCI_MSI is enabled, but we shutdown its MSI before
> the users call sysfs entry,
>         so at this moment, devices are not using MSI,  show legacy INTx
> 3. for devices which support MSI-X, no matter if it is using MSI-X,
>     show legacy INTx
> 4. In Addition, INTx might be broken due to incomplete firmware or
> hardware design for MSI and MSI-X cases
> 
> To be honest, it sounds like a disaster :-) but if this is what we
> have to do, I'd like to try it in v3.

It doesn't seem necessary to me to get into the gory details of
CONFIG_PCI_MSI -- if that's not enabled, drivers can't use MSI anyway.

I don't understand 3.  If a device supports both MSI and MSI-X and a
driver enables MSI, msi_capability_init() writes dev->irq, so it looks
like "irq" should contain the first MSI vector.

I don't understand 4, either.  Is the possibility of broken hardware
or firmware something we need to document?  

What about something like this?

  If a driver has enabled MSI (not MSI-X), "irq" contains the IRQ of
  the first MSI vector.  Otherwise "irq" contains the IRQ of the
  legacy INTx interrupt.

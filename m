Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA34AE987
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 06:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiBIFti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 00:49:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiBIFqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 00:46:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEBC014F33;
        Tue,  8 Feb 2022 21:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A58FBB81F05;
        Wed,  9 Feb 2022 05:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D27C340E7;
        Wed,  9 Feb 2022 05:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644385575;
        bh=xeDBNZYR9J+WeepIKweiSZOd1OmCFh+pFONtZBwNIT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ancuSAY1zveE5nsDSQILyOVKs49gc4vvtk31JkI59m1/K7qdMGrBRPEU+X3e6rJW4
         hrRM/cY96PZgoT0uDzltCk+ex5v/p1nqIFEyRBsMlVuEwDSjDmlyJzYaj+O/NkpSLu
         mRdoGOFJ/SjWi8+MITvRM/qb5k9kSLKHzDJTXYfY=
Date:   Wed, 9 Feb 2022 06:46:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as
 untrusted
Message-ID: <YgNVJKy0s8MGBRoa@kroah.com>
References: <20220202020103.2149130-1-rajatja@google.com>
 <CACK8Z6GmC7O3__RKwSEOQQ5Pde6h-LRz_5d+--V=CuB76cpe+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GmC7O3__RKwSEOQQ5Pde6h-LRz_5d+--V=CuB76cpe+w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 08, 2022 at 04:23:27PM -0800, Rajat Jain wrote:
> Hello Folks,
> 
> 
> On Tue, Feb 1, 2022 at 6:01 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" or the
> > "external-facing" properties).
> >
> > However, currently there is no way for internal devices to be marked as
> > untrusted.
> >
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted firmware
> > or offers an attack surface by handling untrusted network data etc).
> >
> > Introduce a new "UntrustedDevice" property that can be used by the
> > firmware to mark any device as untrusted.
> 
> Just to unite the threads (from
> https://www.spinics.net/lists/linux-pci/msg120221.html). I did reach
> out to Microsoft but they haven't acknowledged my email. I also pinged
> them again yesterday, but I suspect I may not be able to break the
> ice. So this patch may be ready to go in my opinion.
> 
> I don't see any outstanding comments on this patch, but please let me
> know if you have any comments.
> 
> Thanks & Best Regards,
> 
> Rajat
> 
> 
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: * Also use the same property for device tree based systems.
> >     * Add documentation (next patch)
> >
> >  drivers/pci/of.c       | 2 ++
> >  drivers/pci/pci-acpi.c | 1 +
> >  drivers/pci/pci.c      | 9 +++++++++
> >  drivers/pci/pci.h      | 2 ++
> >  4 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..e8b804664b69 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
> >                                                     dev->devfn);
> >         if (dev->dev.of_node)
> >                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > +
> > +       pci_set_untrusted(dev);
> >  }
> >
> >  void pci_release_of_node(struct pci_dev *dev)
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..2bffbd5c6114 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >
> >         pci_acpi_optimize_delay(pci_dev, adev->handle);
> >         pci_acpi_set_external_facing(pci_dev);
> > +       pci_set_untrusted(pci_dev);
> >         pci_acpi_add_edr_notifier(pci_dev);
> >
> >         pci_acpi_add_pm_notifier(adev, pci_dev);
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9ecce435fb3f..41e887c27004 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
> >         return 0;
> >  }
> >  pure_initcall(pci_realloc_setup_params);
> > +
> > +void pci_set_untrusted(struct pci_dev *pdev)
> > +{
> > +       u8 val;
> > +
> > +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)

Please no, "Untrusted" does not really convey much, if anything here.
You are taking an odd in-kernel-value and making it a user api.

Where is this "trust" defined?  Who defines it?  What policy does the
kernel impose on it?

By putting this value in a firmware requirement like this, it better be
documented VERY VERY well.

thanks,

greg k-h

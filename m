Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555BA5551E1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359505AbiFVREp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358953AbiFVREp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 13:04:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0953ED26;
        Wed, 22 Jun 2022 10:04:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so28798407lfa.11;
        Wed, 22 Jun 2022 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBlB6aagKQHpaazAR7xaMT1ITjWkFt+XxJ7nPPD17Qg=;
        b=WxFIPfIfjfbr1krYSnbhMmSM1ZcLTWhf8YjrKLWaaG+LFS4DCxh1uYunifZ9zFr+Y6
         1rF6gthS6UZ9tIqTvc5fc/3DX2uGRKQeEhPHk3H3ansk52sHDzeJhoEUgAvDWpK1SlQs
         0Wta2xOORlfR68u9epyUDVxkEHk8XcZF7hoXUboj8zvDedT4REf1P4M64QHODGAK+8h9
         Y1dvC/LcWf2yULsKJ3z5ul3WATuMYGMUHO7skFryfuu7s9iNOJ+aeFHyN7c3LCBA5Qqf
         3xpcG7VzD7McONxIX71cLJrZwbrcSbxLTo+UCHJVRkZVv8B5RzDg+/3czO+dgSRqrumu
         ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBlB6aagKQHpaazAR7xaMT1ITjWkFt+XxJ7nPPD17Qg=;
        b=V13x2mKCUVvRp76a/Pm81Kztj2feh705r2nETJTGpc84+bHfSUGJ12b3Uy6hua6j6I
         odPRoMR6quV/pO8Sjc2uyflNM5uQSAfTB6t+rhRBN1YtA9iOuHuP+viEBJr7wsWBj6Vo
         Cbpgj4FdccXawjshYolL6anrlY90LyGG3ibfTWgBdca9aXedZcjkbRYGvzMzfq8+ZLOy
         pwXHzwRUt0owO4vNHwbGTBOTUOVcviAvfXXia1CTExGBGDDKEST90WvcXXnu1ZSfhS7A
         nt1tjSDQF/qH2oZqJTGBWDk+tUzEm5pqD+tfpZdr+cHJRZiS39Ny3/IZZAPwyaH5caG9
         tA/w==
X-Gm-Message-State: AJIora8aPMhA5dDovUI5X/nTCt2uYk1S8NF0CR5T+aB59TN1UWid+e4b
        QXrgHkHBPgoFC/fNQU5amRE=
X-Google-Smtp-Source: AGRyM1tp6WK+g6wL0WLl37JKeQYRY+XpzLYT+gR8LhqN2LwZhszpngjKGno4LIlwLTrjETOkRVGN4Q==
X-Received: by 2002:ac2:4c17:0:b0:47f:67fe:8d4a with SMTP id t23-20020ac24c17000000b0047f67fe8d4amr2859756lfq.554.1655917481449;
        Wed, 22 Jun 2022 10:04:41 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id z6-20020a056512370600b0047f647414efsm1717011lfr.190.2022.06.22.10.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:04:40 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:04:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220622170437.jhvb56jmdup5dcgh@mobilestation>
References: <20220620171347.35beffaudlik7euw@mobilestation>
 <20220621182941.GA1322521@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621182941.GA1322521@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 01:29:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 20, 2022 at 08:13:47PM +0300, Serge Semin wrote:
> > On Wed, Jun 15, 2022 at 11:48:48AM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> > > > trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> > > > is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> > > > turn is connected to the DWC 10G PHY. The whole system is supposed to be
> > > > fed up with four clock sources: DBI peripheral clock, AXI application
> > > > clocks and external PHY/core reference clock generating the 100MHz signal.
> > > > In addition to that the platform provide a way to reset each part of the
> > > > controller: sticky/non-sticky bits, host controller core, PIPE interface,
> > > > PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> > > > handle the GPIO-based PERST# signal.
> > > > 
> > > > Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> > > > interface accessors which make sure the IO operations are dword-aligned.
> 
> > > > +struct dw_pcie_ops bt1_pcie_dw_ops = {
> > > > +	.read_dbi = bt1_pcie_read_dbi,
> > > > +	.write_dbi = bt1_pcie_write_dbi,
> > > > +	.write_dbi2 = bt1_pcie_write_dbi2,
> > > > +	.start_link = bt1_pcie_start_ltssm,
> > > > +	.stop_link = bt1_pcie_stop_ltssm,
> > > > +};
> 
> > > Please rename to "dw_pcie_ops" as most
> > > drivers use. 
> > 
> > IMO matching the structure and its instance names is not a good idea.
> > Other than confusing objects nature, at the very least it forces you to
> > violate the local namespace convention. Thus in the line of the
> > dw_pcie->ops initialization it looks like you use some generic
> > operations while in fact you just refer to the locally defined
> > DW PCIe ops instance with the generic variable name. Moreover AFAICS
> > the latest platform drivers mainly use the vendor-specific prefix in
> > the dw_pcie_ops structure instance including the ones acked by you,
> > Lorenzo and Gustavo. What makes my code any different from them?
> 

> That's fair.  I suggest "bt1_pcie_ops" or "bt1_dw_pcie_ops" to match
> the other drivers that include the driver name:
> 
>   intel_pcie_ops
>   keembay_pcie_ops
>   kirin_dw_pcie_ops
>   tegra_dw_pcie_ops

+   ks_pcie_dw_pcie_ops

which is even further from the suggested names.)

> 
> They're not 100% consistent, but hopefully we can at least not make
> things *less* consistent.

I don't think we can make something less consistent if there is no real
consistency.) There are at most five ops descriptors can be defined in
the DW PCIe platform drivers:

1. struct dw_pcie_ops - DW PCIe DBI interface accessors,
+-> dw_pcie_ops
+-> <vendor>_pcie_ops
+-> <vendor>_dw_pcie_ops

2. struct pci_ops     - own or child PCIe config space accessors,
+-> dw_pcie_ops !!! in the driver core.
+-> <vendor>_pci_ops
+-> <vendor>_pcie_ops
+-> dw_child_pcie_ops
+-> <vendor>_child_pcie_ops
+-> <vendor>_child_pci_ops

3. struct dw_pcie_host_ops - DW PCIe Root Port init/de-init operations
+-> <vendor>_pcie_host_ops
+-> <vendor>_pcie_dw_host_ops

4. struct dw_pcie_ep_ops   - DW PCIe Endpoint init/de-init operations
+-> pcie_ep_ops
+-> pci_ep_ops
+-> <vendor>_pcie_ep_ops

As you can see each can have different naming approaches used in the
DW PCIe platform drivers here and there. Some of them have been utilized
more frequently, some of them - less. As for me what is really consistent
across all the DW PCIe platform drivers is the local namespace prefix
of the form "<vendor>_pcie". It is used in all the locally defined
functions names and more-or-less mainly in the local instances of the
operation descriptors. So if you want we can pick some approach and
make sure it is used in all the driver from now on. For instance,

struct dw_pcie_ops <vendor>_pcie_ops
struct dw_pcie_host_ops <vendor>_pcie_host_ops
struct dw_pcie_ep_ops <vendor>_pcie_ep_ops
struct pci_ops <vendor>_pci_ops // Can be confused with the struct
                                // dw_pcie_ops instance, but this what
                                // is mainly used in the available drivers.
struct pci_ops <vendor>_child_pci_ops // less frequent naming
                                      // approach, but it looks more
                                      // like the own CFG-space IOs.

Note the later two cases will violate the local namespace naming
convention of having "<vendor>_pcie" prefix.

In my case the names would look like:
struct dw_pcie_ops bt1_pcie_ops // What you suggest in the comment above
struct dw_pcie_host_ops bt1_pcie_host_ops
struct pci_ops bt1_pci_ops // It may look ambiguous with bt1_pcie_ops.

What do you think?

> 
> > > > +static int bt1_pcie_get_res(struct bt1_pcie *btpci)
> > 
> > > Can you name this something similar to what other drivers use?  There
> > > are a couple *_pcie_get_resources() functions (normally called from
> > > *_pcie_probe()), but no *_get_res() yet.
> > 
> > Earlier in this patchset I've introduced a new method to get
> > the CSRs ranges, PCIe speed, NoF lanes, etc resources. See the patch:
> > [PATCH v3 14/17] PCI: dwc: Introduce generic resources getter
> > The method has been named as "dw_pcie_get_res()". So the locally
> > defined function has been named to refer to that method. If you think
> > that using the "_resources" suffix is better (IMO there is no
> > significant difference) then we'll need to change the name there too.
> > Do you?
> 

> Yes.  I don't think there's value in names being gratuitously
> different.

Ok.

> 
> > > > +	/* AXI-interface is configured with 64-bit address bus width */
> > > > +	ret = dma_coerce_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> > > > +					   DMA_BIT_MASK(64));
> > 
> > > Just to double-check since this is the first instance of
> > > dma_coerce_mask_and_coherent() in drivers/pci -- I guess Baikal-T1 is
> > > unique in needing this?
> > 
> > To be honest I've set it here just in case, seeing the dma_mask and
> > coherent_dma_mask are left uninitialized in the Host bridge device
> > instance, while it's still participate in the PCI devices hierarchy:
> > 
> > 1. platform_device.dev;
> >                    | (<= devm_pci_alloc_host_bridge(dev))
> >                    +---+
> >                       &v
> > 2. pci_host_bridge.dev.parent
> >                    | (<= pci_register_host_bridge(bridge) or)
> >                    | (<= pci_alloc_child_bus()              )
> >                   &v
> >            pci_bus.bridge
> >                    +-------------------+
> >                    |                   | (<= pci_setup_device())
> >                    v                   v
> > 3.     pci_bus.dev.parent  pci_dev.dev.parent
> >                            pci_dev.dma_mask = 0xffffffff;
> >                                    | (<= pci_device_add())
> >                                    +----+
> >                                        &v
> >                            pci_dev->dev.dma_mask
> >                            pci_dev->dev.coherent_dma_mask = 0xffffffffull;
> > 
> > So each device detected on the very first PCIe bus gets to have the
> > PCI host bridge device as a parent. But AFAICS the PCI subsystem core
> > code doesn't use the PCI host bridge DMA-mask and by default the
> > dma_mask/coherent_dma_mask fields of each PCIe peripheral device are
> > unconditionally initialized with DMA_BIT_MASK(32) (they are supposed
> > to be overridden by the device-driver anyway). So to speak we can
> > freely drop the dma_coerce_mask_and_coherent() method invocation from
> > my driver if you say it is required and the PCI host bridge DMA parameter
> > will never be used. What do you think?
> 

> I'd like the usage across drivers to be consistent unless there's a
> hardware difference that requires something different.  So if you can
> point to something different in bt1, great.  If not, do it the same as
> the other drivers.

Ok. I'll drop it from the driver then.

> 
> > > > +static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)
> > > 
> > > Can you name this something similar to what other drivers use?
> > 
> > For instance? (Please note, the link_stop/link_start callbacks are
> > defined as separate methods above.) The current names correctly describe
> > the methods logic. So I wouldn't want to fully change their names.
> 

> Do any other drivers contain similar logic?  If so, please use a
> similar name.

host_init content is very platform-specific. So each driver has its own
callback implementation and logical sub-methods split up. My case
isn't an exception.

> 
> > > > +	 * Application reset controls are trigger-based so de-assert the core
> > > > +	 * resets only.
> > > > +	 */
> > > > +	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);
> 

> BTW, the comment says "de-assert" but the code looks like "assert".

Right. It is supposed to be "assert" in accordance with what is
actually done.

> 
> > > > +	/* Make sure the reset is settled */
> > > > +	usleep_range(1, 10);
> > 
> > > Is this duration related to something in the PCIe spec?  Or the DWC
> > > spec? 
> > 
> > No. These durations are the chip-specific. Partly due to them being
> > specific for each SoC we can't implement a generic bus reset
> > procedure.
> > 
> > > I'd really like to use named constants when possible, although
> > > we have a ton of bare magic numbers currently.
> > > 
> > > Similar for the poll timeouts and the "state settled" sleep below.
> > 
> > I don't really see much need in this parametrization since these
> > numbers are used only once in the platform driver and their
> > application is easily inferable from the code context.
> 

> Even if they are used only once, it's helpful when constants like this
> can be connected to the spec or other justification for the specific
> values.

Ok. I'll replace the literals with the macros.

> 
> > > > +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> > > > +{
> > > > +	struct bt1_pcie *btpci;
> > > > +
> > > > +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> > > > +	if (!btpci)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	btpci->pdev = pdev;
> > > > +
> > > > +	platform_set_drvdata(pdev, btpci);
> > > > +
> > > > +	return btpci;
> > 
> > > I don't think it's worth splitting this into a separate function.  I
> > > think it would be better to use the same structure as other dwc-based
> > > drivers and keep this in bt1_pcie_probe().
> > 
> > Sorry, I disagree in this matter. Generally I don't like the most of
> > the probe methods designed in the kernel well because after evolving
> > in time they get to be a mess if incoherent initializations,
> > allocations, requests, etc. Splitting it up into a set of smaller
> > coherent methods makes the code much clearer.
> 

> There's definitely some tension between making one driver better and
> making it different from all the others.  I'm all in favor of making
> all the drivers better and more consistent.  I'm less in favor of
> one-off improvements because consistency is extremely important for
> maintenance.

Well, if there were a consistency in the probe method design it would
have been another story, but in case of the DW PCIe there is none.
Some DW PCIe platform drivers perform all the probe actions right in
the probe method forming a long list of the weakly coherent things,
some of them have a few sub-functions called but still look the same,
some of them are mainly split up in the sub-methods, but still perform
some initialization right in the probe method. So in general there is
no unification and well defined convention in that regard.

My approach on the contrary makes the probe method code well unified.
Should any new additional step is required, the new method can be
added together with the cleanup antagonist. Similarly the
sub-methods update patches is easier to review than reading the
all-in-one probe code update. Moreover such design approach I've
been using in all the drivers submitted by me to the kernel and no
questions have been raised so far. Finally the driver is supposed to
be maintained by its author at the very least. So I definitely won't
have any problem with it especially after using the same design
pattern in all my drivers.

> 
> > > > +static int bt1_pcie_add_dw_port(struct bt1_pcie *btpci)
> > 
> > > All other dwc-based drivers call dw_pcie_host_init() from either
> > > *_pcie_probe() or *_add_pcie_port().  Please use a similar convention.
> > 
> > Not entirely. Tegra is an exception. So as before I don't think there
> > is a real convention. Most likely it's a result of a lucky coincident.
> > Moreover I don't really like such naming. Something like
> > VENDOR_pcie_add_root_port() would be much better.
> 

> I stand corrected.  Of the 21 dw_pcie_host_init() calls, 13 are from
> *_pcie_probe(), 7 are from *_add_pcie_port(), and tegra is from
> tegra_pcie_init_controller().  I think the *_add_pcie_port() structure
> is better because it makes room to support multiple root ports.

See the last comment. It concerns the same methods, but you suggest to
use the names "*_add_port()" there.

> 
> > > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > 
> > > Why do you need this when no other dwc-based drivers do?  Is Baikal-T1
> > > different in this respect?
> > 
> > It's because eDMA engine embedded into the DW PCIe root port. 
> 

> Let's add a comment about the fact that this is needed because of the
> eDMA engine.

Ok.

> 
> > > > +static void bt1_pcie_del_dw_port(struct bt1_pcie *btpci)
> > 
> > > Can you call dw_pcie_host_deinit() from the same place as other
> > > drivers?
> > > 
> > >   $ git grep -p dw_pcie_host_deinit drivers/pci/controller/dwc
> > 
> > Sorry I'd rather leave it as is. There are only four drivers using
> > it and one of them don't follow what seems like a convention. I'd
> > rather have my driver code coherent:
> > bt1_pcie_add_pcie_port() is used to add the DW PCIe Root Port.
> > and
> > bt1_pcie_del_pcie_port() is used to remove the DW PCIe Root Port
> 
> I agree with your rationale.  Intel and kirin do:
> 
>   *_pcie_probe
>     dw_pcie_host_init
> 
>   *_pcie_remove
>     dw_pcie_host_deinit
> 
> and tegra is similar but from tegra_pcie_init_controller() and
> tegra_pcie_deinit_controller().  Exynos is the odd one out and calls
> dw_pcie_host_init() from exynos_add_pcie_port() but
> dw_pcie_host_deinit() from exynos_pcie_remove().
> 
> Your model is better since it removes the "single root port"
> assumption.  I would like the "bt1_pcie_add_port()" and
> "bt1_pcie_del_port()" (or "bt1_pcie_remove_port()", which would be
> slightly more parallel with "add") names to align with other drivers.

Ok. I'll use bt1_pcie_add_port() and bt1_pcie_del_port() names then.
* Note the DW PCIe platform drivers mainly use the _pcie_port() suffix
* in the add-method.

-Sergey

> 
> Bjorn

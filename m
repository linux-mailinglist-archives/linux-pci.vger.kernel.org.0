Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2FA743144
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 01:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjF2Xwc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 19:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF2Xwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 19:52:31 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF477C3;
        Thu, 29 Jun 2023 16:52:29 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7836164a08aso56752439f.1;
        Thu, 29 Jun 2023 16:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082749; x=1690674749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3MNWRldOkh7U93wCUf49rUZRsoE94jIXXfBzMK9MhQ=;
        b=Cj84eAAgM3sy5e5i7gX0ztotUUCm82bVEsGh+BcIJidQrLUDK3wRsWLHnFK8N8tPe/
         lfKjcvCEmfGSc15QQvYHGWIvPM+p/4HgR6rgU6W3+XaglS/P+riG1Kg4srUpJShpaBa+
         UyFPOZ6tu1WZm+nWghQ/CkOKbyeBQ0ecWVN+HsM0DQIOj8S9wNylWizR9YYmxDpkqK9t
         14pUFSrdbO6JsWNJ2rq2/PLXetMqn5oh9A0nKRPOOmusVgRvu97hKU0uNyvYtdRrg89k
         Ch/zq8VKkDm5fnRskCATEaRZX/bHHUXTnFC84Xh01mSndq9ZQSnJCQok4NGF2rQFCBkZ
         Rbtg==
X-Gm-Message-State: AC+VfDyxSfvwVFm4S4/5pb2h6QEAxGNOQUFzlRxKGU0T2Wy7HE8k4Fei
        P1a544sjwF0EHinMLeSkoFPT4+alQA==
X-Google-Smtp-Source: ACHHUZ6w1i1dMZturyuh9h8vAl8vSVEogcFbvDOZTsizTlr9O17Dm2PJNHWCKQhBaqZynkazK94n8g==
X-Received: by 2002:a5d:8183:0:b0:776:fd07:3c96 with SMTP id u3-20020a5d8183000000b00776fd073c96mr1254241ion.7.1688082748916;
        Thu, 29 Jun 2023 16:52:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h23-20020a02c4d7000000b0041d878ccc12sm1006543jaj.45.2023.06.29.16.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 16:52:27 -0700 (PDT)
Received: (nullmailer pid 126058 invoked by uid 1000);
        Thu, 29 Jun 2023 23:52:26 -0000
Date:   Thu, 29 Jun 2023 17:52:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Message-ID: <20230629235226.GA92592-robh@kernel.org>
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629225631.GA446944@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 05:56:31PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 29, 2023 at 10:19:47AM -0700, Lizhi Hou wrote:
> > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > the PCI core discovers devices and BARs using the PCI enumeration process.
> > There is no infrastructure to discover the hardware peripherals that are
> > present in a PCI device, and which can be accessed through the PCI BARs.
> 
> IIUC this is basically a multi-function device except that instead of
> each device being a separate PCI Function, they all appear in a single
> Function.  That would mean all the devices share the same config space
> so a single PCI Command register controls all of them, they all share
> the same IRQs (either INTx or MSI/MSI-X), any MMIO registers are likely
> in a shared BAR, etc., right?

Could be multiple BARs, but yes.

> Obviously PCI enumeration only sees the single Function and binds a
> single driver to it.  But IIUC, you want to use existing drivers for
> each of these sub-devices, so this series adds a DT node for the
> single Function (using the quirks that call of_pci_make_dev_node()).
> And I assume that when the PCI driver claims the single Function, it
> will use that DT node to add platform devices, and those existing
> drivers can claim those?

Yes. It will call some variant of of_platform_populate().

> I don't see the PCI driver for the single Function in this series.  Is
> that coming?  Is this series useful without it?

https://lore.kernel.org/all/20220305052304.726050-4-lizhi.hou@xilinx.com/

I asked for things to be split up as the original series did a lot 
of new things at once. This series only works with the QEMU PCI test 
device which the DT unittest will use.

> > Apparently, the device tree framework requires a device tree node for the
> > PCI device. Thus, it can generate the device tree nodes for hardware
> > peripherals underneath. Because PCI is self discoverable bus, there might
> > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > device is hot pluggable, when it is plugged in, the device tree nodes for
> > its parent bridges are required. Add support to generate device tree node
> > for PCI bridges.
> 
> Can you remind me why hot-adding a PCI device requires DT nodes for
> parent bridges?

Because the PCI device needs a DT node and we can't just put PCI devices 
in the DT root. We have to create the bus hierarchy.

> I don't think we have those today, so maybe the DT
> node for the PCI device requires a DT parent?  How far up does that
> go?

All the way.

>  From this patch, I guess a Root Port would be the top DT node on
> a PCIe system, since that's the top PCI-to-PCI bridge?

Yes. Plus above the host bridge could have a hierarchy of nodes.

> This patch adds a DT node for *every* PCI bridge in the system.  We
> only actually need that node for these unusual devices.  Is there some
> way the driver for the single PCI Function could add that node when it
> is needed?  Sorry if you've answered this in the past; maybe the
> answer could be in the commit log or a code comment in case somebody
> else wonders.

This was discussed early on. I don't think it would work to create the 
nodes at the time we discover we have a device that wants a DT node. The 
issue is decisions are made in the code based on whether there's a DT 
node for a PCI device or not. It might work, but I think it's fragile to 
have nodes attached to devices at different points in time.

> 
> > @@ -340,6 +340,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	 */
> >  	pcibios_bus_add_device(dev);
> >  	pci_fixup_device(pci_fixup_final, dev);
> > +	if (pci_is_bridge(dev))
> > +		of_pci_make_dev_node(dev);
> 
> It'd be nice to have a clue here about why we need this, since this is
> executed for *every* system, even ACPI platforms that typically don't
> use OF things.
> 
> >  	pci_create_sysfs_dev_files(dev);
> >  	pci_proc_attach_device(dev);
> >  	pci_bridge_d3_update(dev);
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 2c25f4fa0225..9786ae407948 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -487,6 +487,15 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> >  		} else {
> >  			/* We found a P2P bridge, check if it has a node */
> >  			ppnode = pci_device_to_OF_node(ppdev);
> > +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> 
> I would use plain #ifdef here instead of IS_ENABLED(), as you did in
> pci.h below.  IS_ENABLED() is true if the Kconfig symbol is set to
> either "y" or "m".
> 
> Using IS_ENABLED() suggests that the config option *could* be a
> module, which is not the case here because CONFIG_PCI_DYNAMIC_OF_NODES
> is a bool.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kconfig.h?id=v6.4#n69
> 
> > @@ -617,6 +626,85 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >  	return pci_parse_request_of_pci_ranges(dev, bridge);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> 
> Same here, of course.
> 
> > +void of_pci_remove_node(struct pci_dev *pdev)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = pci_device_to_OF_node(pdev);
> > +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> 
> > + * Each entry in the ranges table is a tuple containing the child address,
> > + * the parent address, and the size of the region in the child address space.
> > + * Thus, for PCI, in each entry parent address is an address on the primary
> > + * side and the child address is the corresponding address on the secondary
> > + * side.
> > + */
> > +struct of_pci_range {
> > +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
> > +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
> > +	u32		size[OF_PCI_SIZE_CELLS];
> 
> > +		if (pci_is_bridge(pdev)) {
> > +			memcpy(rp[i].child_addr, rp[i].parent_addr,
> > +			       sizeof(rp[i].child_addr));
> > +		} else {
> > +			/*
> > +			 * For endpoint device, the lower 64-bits of child
> > +			 * address is always zero.
> 
> I think this connects with the secondary side comment above, right?  I
> think I would comment this as:
> 
>   /*
>    * PCI-PCI bridges don't translate addresses, so the child
>    * (secondary side) address is identical to the parent (primary
>    * side) address.
>    */
> 
> and
> 
>   /*
>    * Non-bridges have no child (secondary side) address, so clear it
>    * out.
>    */
> 
> > +			 */
> > +			rp[i].child_addr[0] = j;
> 
> > +	ret = of_changeset_add_empty_prop(ocs, np, "dynamic");
> 
> It seems slightly confusing to use a "dynamic" property here when we
> also have the OF_DYNAMIC dynamic flag above.  I think they have
> different meanings, don't they?

Hum, what's the property for? It's new in this version. Any DT property 
needs to be documented, but I don't see why we need it.

Rob

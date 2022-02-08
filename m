Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB74ADE2C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 17:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381727AbiBHQUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383054AbiBHQUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 11:20:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACBC061576;
        Tue,  8 Feb 2022 08:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C4F616B8;
        Tue,  8 Feb 2022 16:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FC9C004E1;
        Tue,  8 Feb 2022 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337241;
        bh=p6ssO5fKNiJOSoSBu1ARzzUWvgx5q89QAvBfdf4gyM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QcCLEMiE++29yOF63ODIEl4thzwLCRttGJx082qnm68+ZYEIzo/DsGkUYnxA0dfQp
         7Kp/gMFH+1i2JcnwXf2SNUxF6qaNzOUuxEk6FA+jyzcrgNQH5RNM7rOw2FfN1V6V+R
         aJIGZATY5PAvkUsyxT5i7SWuWhbvez7Lr1j9EbhAow9DRp2mPEdu6Xs5xXPd1RLRyb
         M+Bn8qDuzkAXlkrnCa0VkG67A5c9/0NKOd2+okVIOsBYBcwUx856BC5Q7GGTpCTz3k
         yXpCuUDTEvcG5No1AVKUxTSgu3rU34FghwpCqtq4ZWCyfdAu9nIYKYYjV+pO6hZaxe
         7TffOGjuLrs7A==
Date:   Tue, 8 Feb 2022 10:20:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR
 flag as IORESOURCE_UNSET
Message-ID: <20220208162039.GA477897@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208115344.GB6233@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 08, 2022 at 11:53:44AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Feb 04, 2022 at 08:38:46PM +0530, Kishon Vijay Abraham I wrote:
> > On 11/01/22 11:53 am, Kishon Vijay Abraham I wrote:
> > > On 04/01/22 9:27 pm, Lorenzo Pieralisi wrote:
> > >> On Fri, Nov 26, 2021 at 02:01:18PM +0530, Kishon Vijay Abraham I wrote:
> > >>> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and
> > >>> also has both MSI and MSI-X capability in it's config space.
> > >>> If PCIEPORTBUS is enabled, it tries to configure MSI-X and
> > >>> msix_mask_all() adds about 10 Second boot up delay when it
> > >>> tries to write to undefined location.

s/AM654 RootComplex/The AM654 Root Complex/

But Root Complexes are not normally materialized as PCI devices with
their own bus/device/function address, config space, BARs, etc.
Sounds like this might really be a Root *Port*, not a Root Complex?

s/it's config/its config/
s/10 Second/10 second/

> > >>> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so
> > >>> that msix_map_region() returns NULL for Root Complex and avoid
> > >>> un-desirable writes to MSI-X table.
> > >>
> > >> I don't think this is the right fix (it is not even a fix, just
> > >> a plaster to workaround an issue).
> > >>
> > >> What do you mean by "writing to an undefined location" ?
> > >>
> > >> What does "a hard coded BAR" mean ?
> > >>
> > >> What happens if we _rightly_ write into it (ie to size it) ?
> > > 
> > > There are two parts w.r.t setting the BAR; one is during the
> > > configuration and the other is during the enumeration.
> > > i) During the configuration, the size of the BAR is configured
> > >    and the inbound ATU is configured to map the BAR to a
> > >    physical memory.
> > > ii) During the enumeration, the size of the BAR is obtained and
> > >     an address is allocated and programmed in the BAR.
> > > 
> > > In the case of RC, for (i) above, the BAR size is configured as '0'
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n556
> > > and the inbound ATU is not programmed at all.
> > > 
> > > However, in the case of AM654, the HW configures BAR0 for a
> > > fixed size of 1MB (irrespective of what SW programmed in [i]).
> > > While this was done more for a endpoint usecase, since the same
> > > IP is configured for both RC mode and EP mode, the fixed BAR
> > > size is seen with RC mode as well.

This doesn't seem to quite answer Lorenzo's question.  On AM654, does
__pci_read_base() discover the 1MB size correctly for both RC and EP
mode?

What value should BAR0 contain in RC mode?  Does the device respond at
that address?  Do we still need to ensure that 1MB address space is
not assigned to any other device?

> > > AM654 also has MSI-X capability for RC mode (the IP should have
> > > been ideally configured to have MSI-X capability for EP mode).
> > > This results in PCIEPORTBUS doing some undesired access in
> > > msix_mask_all().

We have several quirks that set dev->no_msi.  Maybe that would be a
better way to prevent use of MSI-X (it would also prevent use of MSI;
not sure whether that needs to be avoided as well)?

> > > Here I configure IORESOURCE_UNSET so that memory is not
> > > allocated for RC BAR.

I guess this implies that this device (RP?  I don't think RCs have
BARs) never responds to PCI address space described by BAR0?

> > Do you need further clarifications on this?
> 
> There are two things here:
> 
> 1) As Rob mentioned, you can write it as a quirk applying only to
>    the bridge _only_
> 2) What you want is that the BAR should not be visible to the OS
>    since it is not an actual resource. What I am questioning is
>    whether your way of doing that complies with how this is done in
>    the kernel for other devices/bridges. I need Bjorn's input on
>    this since he knows better (especially wrt IORESOURCE_UNSET
>    usage). I don't want to add any other IORESOURCE_UNSET usage that
>    deviates from what's expected from it

If BAR0 should not exist at all as far as the OS is concerned, I think
you should just set r->flags = 0.  But that assumes the device never
uses the value in the BAR, and it never responds using whatever
address is there, even when PCI_COMMAND_MEMORY is set.

> > >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > >>> ---
> > >>>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
> > >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > >>> index 52d20fe17ee9..73e6626a0d8f 100644
> > >>> --- a/drivers/pci/controller/dwc/pci-keystone.c
> > >>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > >>> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
> > >>>  		{ 0, },
> > >>>  	};
> > >>>  
> > >>> -	if (pci_is_root_bus(bus))
> > >>> +	if (pci_is_root_bus(bus)) {
> > >>>  		bridge = dev;
> > >>> +		if (pci_match_id(am6_pci_devids, bridge)) {
> > >>> +			struct resource *r = &dev->resource[0];
> > >>> +
> > >>> +			r->flags |= IORESOURCE_UNSET;
> > >>> +		}
> > >>> +	}
> > >>>  
> > >>>  	/* look for the host bridge */
> > >>>  	while (!pci_is_root_bus(bus)) {
> > >>> -- 
> > >>> 2.17.1
> > >>>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD574AD7F8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbiBHLxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiBHLxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 06:53:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A1F2C03FEC0;
        Tue,  8 Feb 2022 03:53:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C17ED1;
        Tue,  8 Feb 2022 03:53:48 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405EF3F70D;
        Tue,  8 Feb 2022 03:53:47 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:53:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR
 flag as IORESOURCE_UNSET
Message-ID: <20220208115344.GB6233@lpieralisi>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-5-kishon@ti.com>
 <20220104155741.GA28358@lpieralisi>
 <f3a2c3f0-caf2-743c-a2f7-a99ea3ddb04f@ti.com>
 <a07040ce-e043-22ac-2ee5-47a3bfdedd3b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07040ce-e043-22ac-2ee5-47a3bfdedd3b@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 04, 2022 at 08:38:46PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 11/01/22 11:53 am, Kishon Vijay Abraham I wrote:
> > Hi Lorenzo,
> > 
> > On 04/01/22 9:27 pm, Lorenzo Pieralisi wrote:
> >> On Fri, Nov 26, 2021 at 02:01:18PM +0530, Kishon Vijay Abraham I wrote:
> >>> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
> >>> both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
> >>> enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
> >>> Second boot up delay when it tries to write to undefined location.
> >>>
> >>> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
> >>> msix_map_region() returns NULL for Root Complex and avoid un-desirable
> >>> writes to MSI-X table.
> >>
> >> I don't think this is the right fix (it is not even a fix, just a
> >> plaster to workaround an issue).
> >>
> >> What do you mean by "writing to an undefined location" ?
> >>
> >> What does "a hard coded BAR" mean ?
> >>
> >> What happens if we _rightly_ write into it (ie to size it) ?
> > 
> > There are two parts w.r.t setting the BAR; one is during the configuration and
> > the other is during the enumeration.
> > i) During the configuration, the size of the BAR is configured and the inbound
> > ATU is configured to map the BAR to a physical memory.
> > ii) During the enumeration, the size of the BAR is obtained and an address is
> > allocated and programmed in the BAR.
> > 
> > In the case of RC, for (i) above, the BAR size is configured as '0'
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n556
> > and the inbound ATU is not programmed at all.
> > 
> > However, in the case of AM654, the HW configures BAR0 for a fixed size of 1MB
> > (irrespective of what SW programmed in [i]). While this was done more for a
> > endpoint usecase, since the same IP is configured for both RC mode and EP mode,
> > the fixed BAR size is seen with RC mode as well. AM654 also has MSI-X capability
> > for RC mode (the IP should have been ideally configured to have MSI-X capability
> > for EP mode). This results in PCIEPORTBUS doing some undesired access in
> > msix_mask_all().
> > 
> > Here I configure IORESOURCE_UNSET so that memory is not allocated for RC BAR.
> 
> Do you need further clarifications on this?

There are two things here:

1) As Rob mentioned, you can write it as a quirk applying only to the
   bridge _only_
2) What you want is that the BAR should not be visible to the OS since
   it is not an actual resource. What I am questioning is whether your
   way of doing that complies with how this is done in the kernel for
   other devices/bridges. I need Bjorn's input on this since he knows
   better (especially wrt IORESOURCE_UNSET usage). I don't want to add
   any other IORESOURCE_UNSET usage that deviates from what's expected
   from it

Lorenzo

> > 
> >>
> >> Lorenzo
> >>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >>> index 52d20fe17ee9..73e6626a0d8f 100644
> >>> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >>> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
> >>>  		{ 0, },
> >>>  	};
> >>>  
> >>> -	if (pci_is_root_bus(bus))
> >>> +	if (pci_is_root_bus(bus)) {
> >>>  		bridge = dev;
> >>> +		if (pci_match_id(am6_pci_devids, bridge)) {
> >>> +			struct resource *r = &dev->resource[0];
> >>> +
> >>> +			r->flags |= IORESOURCE_UNSET;
> >>> +		}
> >>> +	}
> >>>  
> >>>  	/* look for the host bridge */
> >>>  	while (!pci_is_root_bus(bus)) {
> >>> -- 
> >>> 2.17.1
> >>>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038C7D04A8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbjJSWI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJSWIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 18:08:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF3112;
        Thu, 19 Oct 2023 15:08:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C607C433C8;
        Thu, 19 Oct 2023 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697753329;
        bh=5nWEspGQsqIlXLWlQgxxPQ2KwD63lq+0D9hGkCIuI9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UY7WFPw7Knkz/fhmpDW3uN5R3SE/bYFYam4auTj32WhIEkai6nT1cgsj52xtnd5ed
         6v9RQTW3IigxxbLXTzcYBrYAJOTM1aV/OEWr9VAG6mZ+AUYVSaT+bZ/UhLwPP3fvD6
         LnQF+o+bF+cBhVlSbkx5KfdbFB3WZMQRNcPh03cKIVS8EdanJ2Agcoxz42tlETKg5N
         3GUDq9lQHGxMvlM4Brao5bR25dEzJG8IncTqbCF2QiOCta7/SGjeV8uHOAsqW8fjVq
         6YLn3+7d0FILOrYNfDVc6M/HtW1ersC8z/lsXzThZh8msYv0rbJYX3TeLleFzf9JnP
         KzcoL/W1oy4/A==
Date:   Thu, 19 Oct 2023 17:08:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20231019220847.GA1413474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 01:05:24PM +0300, Serge Semin wrote:
> On Thu, Oct 19, 2023 at 01:43:30PM +0530, Siddharth Vadapalli wrote:
> > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > to controller version 3.65a, while the .add_bus() method had been added
> > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > ks_pcie_v3_65_add_bus() method are applicable to the controller version
> > 4.90a which is present in AM654x SoCs.
> > 
> > Thus, fix this by creating ks_pcie_am6_ops for the AM654x SoC which uses DW
> > PCIe IP-core version 4.90a controller and omitting the .add_bus() method
> > which is not applicable to the 4.90a controller. Update ks_pcie_host_init()
> > accordingly in order to set the pci_ops to ks_pcie_am6_ops if the platform
> > is AM654x SoC and to ks_pcie_ops otherwise, by making use of the "is_am6"
> > flag.
> > 
> > Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> LGTM. Thanks!
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> One more note is further just to draw attention to possible driver
> simplifications.
> 
> > ---
> > Hello,
> > 
> > This patch is based on linux-next tagged next-20231018.
> > 
> > The v2 of this patch is at:
> > https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/
> > 
> > Changes since v2:
> > - Implemented Serge's suggestion of adding a new pci_ops structure for
> >   AM654x SoC using DWC PCIe IP-core version 4.90a controller.
> > - Created struct pci_ops ks_pcie_am6_ops for AM654x SoC without the
> >   .add_bus method while retaining other ops from ks_pcie_ops.
> > - Updated ks_pcie_host_init() to set pci_ops to ks_pcie_am6_ops if the
> >   platform is AM654x and to ks_pcie_ops otherwise by making use of the
> >   already existing "is_am6" flag.
> > - Combined the section:
> > 	if (!ks_pcie->is_am6)
> >  		pp->bridge->child_ops = &ks_child_pcie_ops;
> >   into the newly added ELSE condition.
> > 
> > The v1 of this patch is at:
> > https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
> > 
> > While there are a lot of changes since v1 and this patch could have been
> > posted as a v1 patch itself, I decided to post it as the v2 of the patch
> > mentioned above since it aims to address the issue described by the v1
> > patch and is similar in that sense. However, the solution to the issue
> > described in the v1 patch appears to be completely different from what
> > was implemented in the v1 patch. Thus, the commit message and subject of
> > this patch have been modified accordingly.
> > 
> > Changes since v1:
> > - Updated patch subject and commit message.
> > - Determined that issue is not with the absence of Link as mentioned in
> >   v1 patch. Even with Link up and endpoint device connected, if
> >   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
> >   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
> >   AER and PME services. The all Fs return value indicates that the MSI-X
> >   configuration is failing even if Endpoint device is connected. This is
> >   because the ks_pcie_v3_65_add_bus() function is not applicable to the
> >   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> > 
> > Regards,
> > Siddharth.
> > 
> >  drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 49aea6ce3e87..66341a0b6c6b 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -487,6 +487,12 @@ static struct pci_ops ks_pcie_ops = {
> >  	.add_bus = ks_pcie_v3_65_add_bus,
> >  };
> >  
> > +static struct pci_ops ks_pcie_am6_ops = {
> > +	.map_bus = dw_pcie_own_conf_map_bus,
> > +	.read = pci_generic_config_read,
> > +	.write = pci_generic_config_write,
> > +};
> > +
> >  /**
> >   * ks_pcie_link_up() - Check if link up
> >   * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
> > @@ -804,9 +810,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> >  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> >  	int ret;
> >  
> > -	pp->bridge->ops = &ks_pcie_ops;
> > -	if (!ks_pcie->is_am6)
> > +	if (ks_pcie->is_am6) {
> > +		pp->bridge->ops = &ks_pcie_am6_ops;
> > +	} else {
> 
> > +		pp->bridge->ops = &ks_pcie_ops;
> >  		pp->bridge->child_ops = &ks_child_pcie_ops;
> 
> Bjorn, could you please clarify the next suggestion? I'm not that
> fluent in the PCIe core details, but based on the
> pci_host_bridge.child_ops and pci_host_bridge.ops names, the first ops
> will be utilized for the child (non-root) PCIe buses, meanwhile the
> later ones - for the root bus only (see pci_alloc_child_bus()). Right?

I think so.  07e292950b93 ("PCI: Allow root and child buses to have
different pci_ops") says:

  PCI host bridges often have different ways to access the root and child
  bus config spaces. The host bridge drivers have invented their own
  abstractions to handle this. Let's support having different root and
  child bus pci_ops so these per driver abstractions can be removed.

https://git.kernel.org/linus/07e292950b93

> If so then either the pci_is_root_bus() check can be dropped from the
> ks_pcie_v3_65_add_bus() method since the ops it belong to will be
> utilized for the root bus anyway, or the entire ks_child_pcie_ops
> instance can be dropped since the ks_pcie_v3_65_add_bus() method will
> be no-op for the child buses anyway meanwhile ks_child_pcie_ops
> matches to ks_pcie_ops in the rest of the ops. After doing that I
> would have also changed the ks_pcie_v3_65_add_bus name to
> ks_pcie_v3_65_add_root_bus() in anyway. Am I right?

Probably so.

But I don't think this code should be in an .add_bus() method in the
first place.  Ideally I think the content of ks_pcie_v3_65_add_bus()
would move to the ks_pcie_host_init() path so we wouldn't need the
.add_bus() hook at all.

I think it was added as ks_dw_pcie_v3_65_scan_bus() by 0c4ffcfe1fbc
("PCI: keystone: Add TI Keystone PCIe driver"), which doesn't explain
why doing this after scanning the secondary bus is needed.

The .scan_bus() hook was added by b14a3d1784a9 ("PCI: designware: Add
support for v3.65 hardware"), which says:

  3. MSI interrupt generation requires EP to write to the RC's
     application register.  So enhance the driver to allow setup of
     inbound access to MSI IRQ register as a post scan bus API callback.

That's not a convincing argument for why the BAR setup has to be done
*after* enumerating the endpoints, but presumably there was some
reason.

Bjorn

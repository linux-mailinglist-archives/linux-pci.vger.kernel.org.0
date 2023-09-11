Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8879B09C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbjIKVkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbjIKUIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 16:08:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD327185;
        Mon, 11 Sep 2023 13:08:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041CCC433C8;
        Mon, 11 Sep 2023 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694462890;
        bh=3B66jcmtNtcZKdqnNjsSwE55H31iE3Fm1jeKR1LXZy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZiPZf9IYSOHwWiD1bGM1gygzDdlgUugB2Tib7kVD/a8PKgNimxrivYA6uRT78K/RG
         UDla10sEaXy6Q9UT37abR2Pq7V2wHzywFIdivk8YOliNW2mMxagw5dOjxXJK1tKn68
         xDsJtH7NAkI7WnpbvhyM/T+UFwDN/ecI9vedup7FWL/h6gXlYvigRthUPGWY4nN6mT
         AKvk9l+fq7bWfEl969+NmiBNyP9rYqEQrLS3YKnkKOFxGVqPndBiHSCV4GhV9hWlc5
         8ZHbCJN1AMNPNok30IQ4MHePfJM+uKbnu92GAzRr7VO/dEqU1eKPnFVz5Sn3ng/zd4
         L07jXL+fp0WmQ==
Date:   Mon, 11 Sep 2023 15:08:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Message-ID: <20230911200808.GA388026@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4306A066509DC8CB2ECEC164FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 08, 2023 at 01:40:13PM +0000, D M, Sharath Kumar wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, September 8, 2023 6:14 PM
> > To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
> > platform
> > 
> > On Fri, Sep 08, 2023 at 09:09:34AM +0000, D M, Sharath Kumar wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > 
> > > > > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > +			unsigned int devfn, int where, int size, u32 *value);
> > > > > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > +			unsigned int devfn, int where, int size, u32 value);
> > > >
> > > > "ep_read_cfg" isn't the ideal name because it suggests "endpoint",
> > > > but it may be either an endpoint or a switch upstream port.  The
> > > > rockchip driver uses "other", which isn't super descriptive either but
> > might be better.
> > > >
> > > Ok will change to "nonrp_read_cfg" ?
> > 
> > I think the important point is not whether it's a Root Port or not, but whether
> > it's on the root *bus* or not.  In other words, I think the driver has to
> > determine whether to generate a Type 0 (targeting something on the root
> > bus) or a Type 1 (targeting something below a
> > bridge) config transaction (see PCI-to-PCI Bridge spec r1.2, sec 3.1.2.1).
> > 
> > There can be non-Root Ports on the root bus, so "nonrp" doesn't seem quite
> > right.  "Other" would be OK, since that's already used by other drivers.
> > Maybe "type0" and "type1" would be better and would fit well with the
> > root_bus_nr check you use to distinguish them?
>
> Situation is
> Root port configuration space  - memory mapped

I don't quite believe the idea that the access method is based on
whether it's a root port.  For one thing, you decide whether to use
the memory-mapped accessor or the indirect accessor based on whether
the read targets the *root bus*, not whether it targets a root port.
And obviously you don't *know* whether the device at a B/D/F address
is a root port until after you read the PCIe type.

I think using names similar to other drivers will be helpful.

These all work on the root bus:

  exynos_pcie_rd_own_conf
  meson_pcie_rd_own_conf
  rockchip_pcie_rd_own_conf

These work on non-root buses:

  dw_pcie_rd_other_conf
  rockchip_pcie_rd_other_conf

> Non root port configuration space - indirect access/proprietary access
>     Type 0 for devices directly connected to root port
>     Type 1 for others

> > > > > +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
> > > > > +				 unsigned int devfn, int where, int size,
> > > > > +				 u32 *value)
> > > > > +{
> > > > > +	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops-
> > > > >rp_read_cfg)
> > > > > +		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno,
> > > > devfn,
> > > > > +							where, size, value);
> > > > > +
> > > > > +	if (pcie->pcie_data->ops->ep_read_cfg)
> > > > > +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno,
> > > > devfn,
> > > > > +							where, size, value);
> > > > > +	return PCIBIOS_FUNC_NOT_SUPPORTED; }

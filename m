Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6779E87D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjIMM7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbjIMM7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:59:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A61981;
        Wed, 13 Sep 2023 05:59:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F574C433C8;
        Wed, 13 Sep 2023 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694609988;
        bh=rFv3UZPb9fdmzw07pDBoa07LMxHvW2MjxczSaQMIrpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=olLwFu/LCuqXQbjOkMht/YsrXr9Aid437J1Bcu1zRNjvYI+noQJa8lkQlqIJ2fG5O
         nFIDhV6a56cBXxSifBeVBpoPFua6oXCJwoePgJj94uCj/tQyD4zo9jKf++QnW7sawt
         ZEw1w0TqTqtMCosLNz3Ir9CFzK/xDrT4U0D4M7blR3w00abVlfgHOr5Lf3QrPPvdsx
         DohDVRCMlrmQohnj2Z/vN3cDK2/b3WcAykK45RqHnwrW+ri/xCdycaKl6pI8z4Ektb
         +apnhrrmjNtHqeXzDgBJI7oGzqJWMD+5XZDb68G4/lBzuKeTg9rlizqMjHULRHoe1u
         RWiIKjqfoAvcw==
Date:   Wed, 13 Sep 2023 07:59:46 -0500
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
Message-ID: <20230913125946.GA429409@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911200808.GA388026@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 03:08:08PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 08, 2023 at 01:40:13PM +0000, D M, Sharath Kumar wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Friday, September 8, 2023 6:14 PM
> > > To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> > > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
> > > platform
> > > 
> > > On Fri, Sep 08, 2023 at 09:09:34AM +0000, D M, Sharath Kumar wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > > 
> > > > > > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > > +			unsigned int devfn, int where, int size, u32 *value);
> > > > > > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > > +			unsigned int devfn, int where, int size, u32 value);
> > > > >
> > > > > "ep_read_cfg" isn't the ideal name because it suggests "endpoint",
> > > > > but it may be either an endpoint or a switch upstream port.  The
> > > > > rockchip driver uses "other", which isn't super descriptive either but
> > > might be better.
> > > > >
> > > > Ok will change to "nonrp_read_cfg" ?
> > > 
> > > I think the important point is not whether it's a Root Port or not, but whether
> > > it's on the root *bus* or not.  In other words, I think the driver has to
> > > determine whether to generate a Type 0 (targeting something on the root
> > > bus) or a Type 1 (targeting something below a
> > > bridge) config transaction (see PCI-to-PCI Bridge spec r1.2, sec 3.1.2.1).
> > > 
> > > There can be non-Root Ports on the root bus, so "nonrp" doesn't seem quite
> > > right.  "Other" would be OK, since that's already used by other drivers.
> > > Maybe "type0" and "type1" would be better and would fit well with the
> > > root_bus_nr check you use to distinguish them?
> >
> > Situation is
> > Root port configuration space  - memory mapped
> 
> I don't quite believe the idea that the access method is based on
> whether it's a root port.  For one thing, you decide whether to use
> the memory-mapped accessor or the indirect accessor based on whether
> the read targets the *root bus*, not whether it targets a root port.
> And obviously you don't *know* whether the device at a B/D/F address
> is a root port until after you read the PCIe type.

I see eight copies of "[PATCH v3 0/2]" on the list:
https://lore.kernel.org/linux-pci/20230616063313.862996-2-sharath.kumar.d.m@intel.com/T/#t
The duplication just causes confusion and slows things down.

I do think the naming as root port config accessors and endpoint
config accessors is fundamentally broken and needs to be fixed.  It's
not a *functional* issue, but it is important to avoid misleading
names.

> I think using names similar to other drivers will be helpful.
> 
> These all work on the root bus:
> 
>   exynos_pcie_rd_own_conf
>   meson_pcie_rd_own_conf
>   rockchip_pcie_rd_own_conf
> 
> These work on non-root buses:
> 
>   dw_pcie_rd_other_conf
>   rockchip_pcie_rd_other_conf
> 
> > Non root port configuration space - indirect access/proprietary access
> >     Type 0 for devices directly connected to root port
> >     Type 1 for others
> 
> > > > > > +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
> > > > > > +				 unsigned int devfn, int where, int size,
> > > > > > +				 u32 *value)
> > > > > > +{
> > > > > > +	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops-
> > > > > >rp_read_cfg)
> > > > > > +		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno,
> > > > > devfn,
> > > > > > +							where, size, value);
> > > > > > +
> > > > > > +	if (pcie->pcie_data->ops->ep_read_cfg)
> > > > > > +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno,
> > > > > devfn,
> > > > > > +							where, size, value);
> > > > > > +	return PCIBIOS_FUNC_NOT_SUPPORTED; }

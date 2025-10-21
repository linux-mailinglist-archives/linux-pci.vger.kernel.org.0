Return-Path: <linux-pci+bounces-38842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7525BF4618
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BAA18A7A37
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597128469C;
	Tue, 21 Oct 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNM9JV8v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF7283FFB;
	Tue, 21 Oct 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013557; cv=none; b=ptS9S5BTofQBJE4PACMCNUfOQLeyZcAonzZaV2j8fkNuq77jFK6520vdoAm3ywTJjbqYP2W2we90IYcJEGEacrzk1+Q7m4zmHAwpQ4qTHXpAyh8pCYTRkN7cU8QCWJYhwp/+ZL8plkG8e2ytCyUZvWJeiBnJpldPgB5IxFu1mQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013557; c=relaxed/simple;
	bh=1rj/lRwD+09g4LTh/J3rOOI/5OeNJ1N0w55J9NIJXwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSqerf05P0GEtqXApb9tPy0IU1x23LQsgaFcx9AGCGJr+31KjvbbCTQHdysroUqyMyUBSpRTdD/GT8oChCksMj0oRdxIK7/K6A6vzEu2Is5SGFeVRVuYXAOPR03QbqFpUnr9qOI+uHPuH0utXa5P22vbRb5ndwvcxJcRN432vZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNM9JV8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210AC116B1;
	Tue, 21 Oct 2025 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761013556;
	bh=1rj/lRwD+09g4LTh/J3rOOI/5OeNJ1N0w55J9NIJXwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNM9JV8vU0ybZx8KnAEBE3tJfVgwl4shjF8/Or7csMaZQtkwXf2d0qiTPkWSw3R0V
	 ypzjZ3a1zf4TbmjjcE509xUqqetbBlsqxjrjmw0Es0Q17ZfXgL5ITIax94YqwCY+Nv
	 xiVjQJZlVV1Cel+RfYXBVScRSMUID9KThJBYz0bJWhdf2lBikc5O2qOn4YJRfjj5e8
	 GQDLs0NTOxZ7v5BNATL+RynAucia8G4lkx8WTO3K7VKX7+D2htAMNMhsyeR3Xkx3fZ
	 H1CVcYHMdouvzcwkxQqCKNOqbjdfU2dleTL9NO90tXo8z6PYTK1FCttK3iMeJOETGE
	 RlUeke+C1NkrA==
Date: Tue, 21 Oct 2025 07:55:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Message-ID: <mjrcz7qleml7hmwfdwxt2bbbq5qg7ko36l6zwt2snppk7ajrbj@evmvu7tzr4w2>
References: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
 <20251017191005.GA1041995@bhelgaas>
 <mtxez55p4hfvtmhcnwtxeetzqxydyq5e4g5zsdhytxpzgvgeqn@s7asinok5l22>
 <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
 <db799304-1551-410b-af07-fb8d9b50be5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db799304-1551-410b-af07-fb8d9b50be5c@oss.qualcomm.com>

On Sat, Oct 18, 2025 at 03:00:32PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/18/2025 2:55 PM, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 10/18/2025 8:39 AM, Manivannan Sadhasivam wrote:
> > > On Fri, Oct 17, 2025 at 02:10:05PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya
> > > > Chundru wrote:
> > > > > When the vendor configuration space is 256MB aligned, the DesignWare
> > > > > PCIe host driver enables ECAM access and sets the DBI base
> > > > > to the dw_pcie_ecam_conf_map_busstart
> > > > > of the config space. This causes vendor drivers to incorrectly program
> > > > > iATU regions, as they rely on the DBI address for internal accesses.
> > > > > 
> > > > > To fix this, avoid overwriting the DBI base when ECAM is enabled.
> > > > > Instead, introduce a custom ECAM PCI ops implementation that accesses
> > > > > the DBI region directly for bus 0 and uses ECAM for other buses.
> > > > > 
> > > > > Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for
> > > > > enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> > > > > Reported-by: Ron Economos <re@w6rz.net>
> > > > > Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
> > > > > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > > Signed-off-by: Krishna Chaitanya Chundru
> > > > > <krishna.chundru@oss.qualcomm.com>
> > > > > ---
> > > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 28
> > > > > +++++++++++++++++++----
> > > > >   1 file changed, 24 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git
> > > > > a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78
> > > > > 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -23,6 +23,7 @@
> > > > >   #include "pcie-designware.h"
> > > > >   static struct pci_ops dw_pcie_ops;
> > > > > +static struct pci_ops dw_pcie_ecam_ops;
> > > > >   static struct pci_ops dw_child_pcie_ops;
> > > > >   #define DW_PCIE_MSI_FLAGS_REQUIRED
> > > > > (MSI_FLAG_USE_DEF_DOM_OPS        | \
> > > > > @@ -471,9 +472,6 @@ static int
> > > > > dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct
> > > > > resource *re
> > > > >       if (IS_ERR(pp->cfg))
> > > > >           return PTR_ERR(pp->cfg);
> > > > > -    pci->dbi_base = pp->cfg->win;
> > > > > -    pci->dbi_phys_addr = res->start;
> > > > > -
> > > > >       return 0;
> > > > >   }
> > > > > @@ -529,7 +527,7 @@ static int
> > > > > dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
> > > > >           if (ret)
> > > > >               return ret;
> > > > > -        pp->bridge->ops = (struct pci_ops
> > > > > *)&pci_generic_ecam_ops.pci_ops;
> > > > > +        pp->bridge->ops = &dw_pcie_ecam_ops;
> > > > >           pp->bridge->sysdata = pp->cfg;
> > > > >           pp->cfg->priv = pp;
> > > > >       } else {
> > > > > @@ -842,12 +840,34 @@ void __iomem
> > > > > *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int
> > > > > devfn,
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
> > > > > +static void __iomem *dw_pcie_ecam_conf_map_bus(struct
> > > > > pci_bus *bus, unsigned int devfn, int where)
> > > > > +{
> > > > > +    struct pci_config_window *cfg = bus->sysdata;
> > > > > +    struct dw_pcie_rp *pp = cfg->priv;
> > > > > +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +    unsigned int busn = bus->number;
> > > > > +
> > > > > +    if (busn > 0)
> > > > > +        return pci_ecam_map_bus(bus, devfn, where);
> > > > 
> > > > Is there a way to avoid the "root bus is bus 00" assumption here?  It
> > > > looks like something like this might work (it inverts the condition
> > > > to take care of the root bus special case first):
> > > > 
> > > >    if (bus == pp->bridge->bus) {
> > > >      if (PCI_SLOT(devfn) > 0)
> > > >        return NULL;
> > > > 
> > > >      return pci->dbi_base + where;
> > > >    }
> > > > 
> > > >    return pci_ecam_map_bus(bus, devfn, where);
> > > > 
> > > 
> > > I guess it will work.
> > > 
> > > > > +    if (PCI_SLOT(devfn) > 0)
> > > > > +        return NULL;
> > > > 
> > > > This essentially says only one function (00.0) can be on the root bus.
> > > > I assume that someday that will be relaxed and there may be multiple
> > > > Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
> > > > didn't have to have this check.
> > > > 
> > > > What happens without it?  Does the IP return the ~0 data that the PCI
> > > > core would interpret as "there's no device here"?
> > > > 
> > > 
> > > I hope the read returns ~0, but the idea is to catch the invalid
> > > access before
> > > trying to read/write. In case of multi Root Port design, I don't
> > > think we have a
> > > way to identify it. So maybe it is safe to remove this check.
> > > 
> > For multi root port we may need to revisit this, currently along with
> > dbi there are some other registers iATU, elbi etc. So there might be
> > chances to read these registers like iATU as part of enumeration and
> > these can return non ~0 values which will have adverse effects.
> > So we should have this check for now.
> > 
> One more issue is some controllers may pass only 4k memory as dbi memory
> so we might get unmapped address access issues also.

Oh yes. The single Root Port controllers might supply only 4KiB of the DBI
space, so without the check, the driver could read/write past the mapped space.

Good catch!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C967D02DF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJHVcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 17:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbfJHVcy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 17:32:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2180A2070B;
        Tue,  8 Oct 2019 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570570373;
        bh=OkeZztjJfWka8pzSMPcOrgXMFjuPsLVWOcUK/R/EDaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FlKH8Wqfszosjq1WbJV0TfiBvFF7oSzEPUnvg03BFlSgAxMIcTjU5AwgHOrrUWiWN
         xm8lya7Zz4byPfy5RKYQ37t10WZH0YLHYFPCgNHGEUhqSWD2nIaKkQ5XVMYVfmUDDk
         2Btbry32WgNiS/NTqZrPl892l3uHFrpe7HumUi+8=
Date:   Tue, 8 Oct 2019 16:32:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Message-ID: <20191008213251.GA229610@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008082515.ldm2i7j4syuzampr@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 08:25:23AM +0000, Robert Richter wrote:
> On 04.10.19 14:48:13, Bjorn Helgaas wrote:
> > commit 37b22fbfec2d
> > Author: George Cherian <george.cherian@marvell.com>
> > Date:   Thu Sep 19 02:43:34 2019 +0000
> > 
> >     PCI: Apply Cavium ACS quirk to CN99xx and CN11xxx Root Ports
> >     
> >     Add an array of Cavium Root Port device IDs and apply the quirk only to the
> >     listed devices.
> >     
> >     Instead of applying the quirk to all Root Ports where
> >     "(dev->device & 0xf800) == 0xa000", apply it only to CN88xx 0xa180 and
> >     0xa170 Root Ports.
> 
> No, this can't be removed. It is a match all for all CN8xxx variants
> (note the 3 'x', all TX1 cores). So all device ids from 0xa000 to
> 0xa7FF are affected here and need the quirk.

OK, I'll drop the patch and wait for a new one.  Maybe what was needed
was to keep the "(dev->device & 0xf800) == 0xa000" part and add the
pci_quirk_cavium_acs_ids[] array in addition?

> >     Also apply the quirk to CN99xx (0xaf84) and CN11xxx (0xb884) Root Ports.
> 
> I thought the quirk is CN8xxx specific, but I could be wrong here.
> 
> -Robert
> 
> >     
> >     Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_20190919024319.GA8792-40dc5-2Deodlnx05.marvell.com&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=8vKOpC26NZGzQPAMiIlimxyEGCRSJiq-j8yyjPJ6VZ4&m=Vmml-rx3t63ZbbXZ0XaESAM9yAlexE29R-giTbcj4Qk&s=57jKIj8BAydbLpftLt5Ssva7vD6GuoCaIpjTi-sB5kU&e= 
> >     Fixes: f2ddaf8dfd4a ("PCI: Apply Cavium ThunderX ACS quirk to more Root Ports")
> >     Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
> >     Signed-off-by: George Cherian <george.cherian@marvell.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Cc: stable@vger.kernel.org      # v4.12+
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 320255e5e8f8..4e5048cb5ec6 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4311,17 +4311,24 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
> >  #endif
> >  }
> >  
> > +static const u16 pci_quirk_cavium_acs_ids[] = {
> > +	0xa180, 0xa170,		/* CN88xx family of devices */
> > +	0xaf84,			/* CN99xx family of devices */
> > +	0xb884,			/* CN11xxx family of devices */
> > +};
> > +
> >  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> >  {
> > -	/*
> > -	 * Effectively selects all downstream ports for whole ThunderX 1
> > -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> > -	 * bits of device ID are used to indicate which subdevice is used
> > -	 * within the SoC.
> > -	 */
> > -	return (pci_is_pcie(dev) &&
> > -		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> > -		((dev->device & 0xf800) == 0xa000));
> > +	int i;
> > +
> > +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > +		return false;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
> > +		if (pci_quirk_cavium_acs_ids[i] == dev->device)
> > +			return true;
> > +
> > +	return false;
> >  }
> >  
> >  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)

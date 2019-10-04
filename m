Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F042DCC3BF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfJDTsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJDTsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 15:48:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDF92084D;
        Fri,  4 Oct 2019 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570218496;
        bh=YJvS4ja7QkCv/xeilE+vPBPFSgMehIFyb5QZZEJymuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CNHpFUafD0OqBoYBGlS8nwY8IPxdpCwd1umMDz6Bp61Jz+chsV2G4k1o8Vs3olmZm
         qsb8NbW8BPEeGvNgnmWyL6dLhSzpNF59co0FdVCfj9NEMwDHASwHrRLKOhfkYM2pMB
         9Gj7AoiQUfH1SYNtSjXGyKGH08O2tYf34UBCc52Q=
Date:   Fri, 4 Oct 2019 14:48:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     George Cherian <gcherian@marvell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Robert Richter <rrichter@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Message-ID: <20191004194813.GA76466@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930232041.GA22852@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 11:20:50PM +0000, Jayachandran Chandrasekharan Nair wrote:
> On Mon, Sep 30, 2019 at 03:34:10PM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 19, 2019 at 02:43:34AM +0000, George Cherian wrote:
> > > Enhance the ACS quirk for Cavium Processors. Add the root port
> > > vendor ID's in an array and use the same in match function.
> > > For newer devices add the vendor ID's in the array so that the
> > > match function is simpler.
> > > 
> > > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > > ---
> > >  drivers/pci/quirks.c | 28 +++++++++++++++++++---------
> > >  1 file changed, 19 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 44c4ae1abd00..64deeaddd51c 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4241,17 +4241,27 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
> > >  #endif
> > >  }
> > >  
> > > +static const u16 pci_quirk_cavium_acs_ids[] = {
> > > +	/* CN88xx family of devices */
> > > +	0xa180, 0xa170,
> > > +	/* CN99xx family of devices */
> > > +	0xaf84,
> > > +	/* CN11xxx family of devices */
> > > +	0xb884,
> > > +};
> > > +
> > >  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> > >  {
> > > -	/*
> > > -	 * Effectively selects all downstream ports for whole ThunderX 1
> > > -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> > > -	 * bits of device ID are used to indicate which subdevice is used
> > > -	 * within the SoC.
> > > -	 */
> > > -	return (pci_is_pcie(dev) &&
> > > -		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> > > -		((dev->device & 0xf800) == 0xa000));
> > > +	int i;
> > > +
> > > +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > > +		return false;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
> > > +		if (pci_quirk_cavium_acs_ids[i] == dev->device)
> > 
> > I'm a little skeptical of this because the previous test:
> > 
> >   (dev->device & 0xf800) == 0xa000
> > 
> > could match *many* devices, but of those, the new code only matches two
> > (0xa180, 0xa170).
> > 
> > And the comment says the new code matches the CN99xx and CN11xxx
> > *families*, but it only matches a single device ID for each, which
> > makes me think there may be more devices to come.
> > 
> > Maybe this is all what you want, but please confirm.
> 
> There are only a very few device IDs for root ports, so just listing
> them out like this maybe better. The earlier match covered a lot of
> ThunderX1 devices, but did not really match the ThunderX2 root ports.
> 
> This looks ok for ThunderX2. Sunil & Robert can comment on other
> processor families I hope.

I don't know which of these are ThunderX2 vs ThunderX1.

I currently have the change below on a branch waiting for confirmation
that this is what you intend.

> > The commit log should be explicit that this adds CN99xx and CN11xxx,
> > which previously were not matched.
> > 
> > This looks like stable material?
> > 
> > > +			return true;
> > > +
> > > +	return false;
> > >  }
> > >  
> > >  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)

commit 37b22fbfec2d
Author: George Cherian <george.cherian@marvell.com>
Date:   Thu Sep 19 02:43:34 2019 +0000

    PCI: Apply Cavium ACS quirk to CN99xx and CN11xxx Root Ports
    
    Add an array of Cavium Root Port device IDs and apply the quirk only to the
    listed devices.
    
    Instead of applying the quirk to all Root Ports where
    "(dev->device & 0xf800) == 0xa000", apply it only to CN88xx 0xa180 and
    0xa170 Root Ports.
    
    Also apply the quirk to CN99xx (0xaf84) and CN11xxx (0xb884) Root Ports.
    
    Link: https://lore.kernel.org/r/20190919024319.GA8792@dc5-eodlnx05.marvell.com
    Fixes: f2ddaf8dfd4a ("PCI: Apply Cavium ThunderX ACS quirk to more Root Ports")
    Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
    Signed-off-by: George Cherian <george.cherian@marvell.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org      # v4.12+

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..4e5048cb5ec6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4311,17 +4311,24 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+static const u16 pci_quirk_cavium_acs_ids[] = {
+	0xa180, 0xa170,		/* CN88xx family of devices */
+	0xaf84,			/* CN99xx family of devices */
+	0xb884,			/* CN11xxx family of devices */
+};
+
 static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 {
-	/*
-	 * Effectively selects all downstream ports for whole ThunderX 1
-	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
-	 * bits of device ID are used to indicate which subdevice is used
-	 * within the SoC.
-	 */
-	return (pci_is_pcie(dev) &&
-		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
-		((dev->device & 0xf800) == 0xa000));
+	int i;
+
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
+		if (pci_quirk_cavium_acs_ids[i] == dev->device)
+			return true;
+
+	return false;
 }
 
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)

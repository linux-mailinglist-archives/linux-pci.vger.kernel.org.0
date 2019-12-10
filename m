Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0824F118D55
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLJQNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 11:13:48 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:44599 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLJQNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 11:13:47 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1C60C28022E40;
        Tue, 10 Dec 2019 17:13:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D7EF5CD0; Tue, 10 Dec 2019 17:13:45 +0100 (CET)
Date:   Tue, 10 Dec 2019 17:13:45 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Message-ID: <20191210161345.apz4aixgszcd6vco@wunner.de>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
 <MWHPR12MB1358AEEBD730A4EDA78894E6F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
 <20191210154649.o3vsqzrtofhvcjrl@wunner.de>
 <MWHPR12MB1358449C677259C848AAB11EF75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR12MB1358449C677259C848AAB11EF75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 03:53:20PM +0000, Deucher, Alexander wrote:
> > On Tue, Dec 10, 2019 at 03:34:27PM +0000, Deucher, Alexander wrote:
> > > > Nicholas Johnson reports a null pointer deref as well as a refcount
> > > > underflow upon hot-removal of a Thunderbolt-attached AMD eGPU.
> > > > He's bisected the issue down to commit 586bc4aab878 ("ALSA: hda/hdmi
> > > > - fix vgaswitcheroo detection for AMD").
> > > >
> > > > The commit iterates over PCI devices using pci_get_class() and
> > > > unreferences each device found, even though pci_get_class()
> > > > subsequently unreferences the device as well.  Fix it.
> > >
> > > The pci_dev_put() a few lines above should probably be dropped as well.
> > 
> > That one looks fine to me.  The refcount is already increased in the caller
> > get_bound_vga() via pci_get_domain_bus_and_slot() and it's increased
> > again in atpx_present() via pci_get_class().  It needs to be decremented in
> > atpx_present() to avoid leaking a ref.
> 
> I'm not following.  This is part of the same loop as the one you removed.
> All we are doing is checking whether the ATPX method exists or not om the
> platform.  The pdev may not be the same one as the one in
> pci_get_domain_bus_and_slot().  The APTX method in the APU's ACPI namespace,
> not the dGPUs.

Okay.  Still, atpx_present() doesn't pass the found pci_dev back to the
caller, so it would be leaked if the ref isn't returned.

The situation is different for the pci_dev_put() I removed:  The ref is
returned by pci_get_class() on the next loop iteration.

Thanks,

Lukas

> > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > index 35b4526f0d28..b856b89378ac 100644
> > > > --- a/sound/pci/hda/hda_intel.c
> > > > +++ b/sound/pci/hda/hda_intel.c
> > > > @@ -1419,7 +1419,6 @@ static bool atpx_present(void)
> > > >  				return true;
> > > >  			}
> > > >  		}
> > > > -		pci_dev_put(pdev);
> > > >  	}
> > > >  	return false;
> > > >  }
> > > > --
> > > > 2.24.0

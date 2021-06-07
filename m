Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE39F39DE1F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGNzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 09:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFGNzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 09:55:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17934610FB;
        Mon,  7 Jun 2021 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623074042;
        bh=NVdj6ayfoAT3AL4V0wd+dEF46qN8sMjZMWQkJzFPDCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IWuL1O6NPXyju3ouiRqrgFICtCHZwYderI8e8AeyIpXhUxQePEiB1wyNcs9ONkLBv
         ivXD5MV/NWfys8RmFy0Ik2jsia9wpaqiY9dhk1fVPigmXqKYGobrO7zXFKCpf6aFkY
         UT0O1fRzn5eWvzGauhbasZqLknf7ZDxzUZ5ik87y+1XnfKKA0UaI9axVWhWzLkwYKw
         q7iVs9M69IUhaCwlujazZuuXAnRo/PbF3h73VjqXPh03JXQri9pqlI7WbPBPHxlbpV
         iMvbADhEqlOfTotCsa7mUSJDU9WVDj2laj1n3Sme/drbEtFI1n5qnhs2IFM/CXnlK9
         1XSnT1np3PjcQ==
Date:   Mon, 7 Jun 2021 08:54:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS support
Message-ID: <20210607135400.GA2478732@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR12MB26193FFC56E703A01CCC382EE4389@DM6PR12MB2619.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 07, 2021 at 03:41:35AM +0000, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> Thanks Bjorn.
> @Deucher, Alexander can you advise whether this is needed for stable kernel branches and which branches if yes?

Sorry, I should have done this already.  I went ahead and marked it
for stable.

> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Saturday, June 5, 2021 4:59 AM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: linux-pci@vger.kernel.org; kw@linux.com; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS
> > support
> > 
> > On Wed, Jun 02, 2021 at 10:12:55AM +0800, Evan Quan wrote:
> > > Unexpected GPU hang was observed during runpm stress test on 0x7341
> > > rev 0x00. Further debugging shows broken ATS is related. Thus as a
> > > followup of commit 5e89cd303e3a ("PCI:
> > > Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable the ATS for
> > > the specific SKU also.
> > >
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> > 
> > Applied to pci/virtualization for v5.14, thanks.
> > 
> > I updated the commit log like this:
> > 
> >     PCI: Mark AMD Navi14 GPU ATS as broken
> > 
> >     Observed unexpected GPU hang during runpm stress test on 0x7341 rev
> > 0x00.
> >     Further debugging shows broken ATS is related.
> > 
> >     Disable ATS on this part.  Similar issues on other devices:
> > 
> >       a2da5d8cc0b0 ("PCI: Mark AMD Raven iGPU ATS as broken in some
> > platforms")
> >       45beb31d3afb ("PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken")
> >       5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
> > 
> >     Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> >     Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F20210602021255.939090-1-
> > evan.quan%40amd.com&amp;data=04%7C01%7Cevan.quan%40amd.com%7
> > C2999a40d134142c2fdd608d9279b9ddb%7C3dd8961fe4884e608e11a82d994e
> > 183d%7C0%7C0%7C637584371596788532%7CUnknown%7CTWFpbGZsb3d8ey
> > JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C1000&amp;sdata=%2BgYq6SPJNCgqj%2By%2BLzkAGjmm5TONhApdYlze%
> > 2FFz%2FiUM%3D&amp;reserved=0
> >     Signed-off-by: Evan Quan <evan.quan@amd.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> > 
> > > ---
> > > ChangeLog v2->v3:
> > > - further update for description part(suggested by Krzysztof)
> > > ChangeLog v1->v2:
> > > - cosmetic fix for description part(suggested by Krzysztof)
> > > ---
> > >  drivers/pci/quirks.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > b7e19bbb901a..70803ad6d2ac 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5176,7 +5176,8 @@
> > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422,
> > > quirk_no_ext_tags);  static void quirk_amd_harvest_no_ats(struct pci_dev
> > *pdev)  {
> > >  	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> > > -	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
> > > +	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
> > > +	    (pdev->device == 0x7341 && pdev->revision != 0x00))
> > >  		return;
> > >
> > >  	if (pdev->device == 0x15d8) {
> > > @@ -5203,6 +5204,7 @@
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> > > 0x6900, quirk_amd_harvest_no_ats);
> > > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,
> > > quirk_amd_harvest_no_ats);
> > >  /* AMD Navi14 dGPU */
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> > > quirk_amd_harvest_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341,
> > > +quirk_amd_harvest_no_ats);
> > >  /* AMD Raven platform iGPU */
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,
> > > quirk_amd_harvest_no_ats);  #endif /* CONFIG_PCI_ATS */
> > > --
> > > 2.29.0
> > >

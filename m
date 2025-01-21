Return-Path: <linux-pci+bounces-20202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6CA18240
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB53AB4D4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B119DFAB;
	Tue, 21 Jan 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG+eko3m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAC13BC0C;
	Tue, 21 Jan 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478032; cv=none; b=b7F6Oz0mSC1A3M2R5sxCURoVNwSP5c8VO5MUU7zjwrOUAkC/0UHSftFgFL5scHD/uWywnDS+26nLGi4oZfPediiLJhkOf53MSdBD8OkriBqzcQ/8MFclZyzf3f5TmffzClHPzWPBBiwcM8HFo5oKtay4qf15KfPIJhlUeypA+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478032; c=relaxed/simple;
	bh=fkWNTG28jA+g7ynKsm7I8oOQoUt6Fg3Trx1IPv30HoM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lS9lu2G6780Ixri3g/YlAryP4w7+N/Vqf9GBFopOMqWlZaP3XA8Ck7Nh8ktsSt21noluvtk+K5BosVANLtVuBaf6YP5dpfVJb4UiEdmsJNZAQ3aWu0ncl7Rlpw574yFeqU08V5W9rrLteiyEJ1j99bsaJq5FXCN1CiiuictH+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG+eko3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA65C4CEDF;
	Tue, 21 Jan 2025 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737478032;
	bh=fkWNTG28jA+g7ynKsm7I8oOQoUt6Fg3Trx1IPv30HoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XG+eko3m0xcB8W94gwYyzfI2tuW6qVnASXIHGBnV2Rh0hs/I0YSo1Wf5Voxd82qTY
	 DLxf3XoVcuRQYv2bqsH0lr3AsnHR7hBKjqq7c7JJ5zM+pZOLtH6RPfwgsVjUC7wb0m
	 I1QdGLfo2lHlcp6sc/zwmSOEAMXND1mH2m9ow6eSWv66wff08E4QsXVxl3KeqAwmc/
	 lOxq4eo5mhClRGg7/4ltbz4DnDWvI2OfoJEcidBeo5FaULDBuLwnruwlmPzFhvgQ4X
	 auL408GHJVZGn98XofRiAN5XJ4ZWWQhUbF7RlBSsGJFVnTV1aSaakuIdL9daCAKXLJ
	 BbmrC074dQ5dw==
Date: Tue, 21 Jan 2025 10:47:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Saladi.Rakeshbabu@microchip.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, logang@deltatee.com,
	UNGLinuxDriver@microchip.com, kurt.schwemmer@microsemi.com
Subject: Re: [PATCH] PCI: switchtec: Include PCI100X devices support
Message-ID: <20250121164709.GA951990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be829909194332808ab3ed4ad4fce4b488549e12.camel@microchip.com>

On Tue, Jan 21, 2025 at 01:16:05PM +0000, Saladi.Rakeshbabu@microchip.com wrote:
> On Mon, 2025-01-20 at 16:56 -0600, Bjorn Helgaas wrote:
> > [Some people who received this message don't often get email from
> > helgaas@kernel.org. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Mon, Jan 20, 2025 at 03:25:24PM +0530, Rakesh Babu Saladi wrote:
> > > Add the Microchip Parts to the existing device ID
> > > table so that the driver supports PCI100x devices too.
> > > 
> > > Add a new macro to quirk the Microchip switchtec PCI100x parts
> > > to allow DMA access via NTB to work when the IOMMU is turned on.
> > > 
> > > PCI100x family has 6 variants, each variant is designed for
> > > different
> > > application usages, different port counts and lane counts.
> > > 
> > > PCI1001 has 1 x4 upstream port and 3 x4 downstream ports.
> > > PCI1002 has 1 x4 upstream port and 4 x2 downstream ports.
> > > PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports and 2 x2
> > > downstream ports.
> > > PCI1004 has 4 x4 upstream ports.
> > > PCI1005 has 1 x4 upstream port and 6 x2 downstream ports.
> > > PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports.
> > > 
> > > Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
> > > ---
> > >  drivers/pci/quirks.c           | 11 +++++++++++
> > >  drivers/pci/switch/switchtec.c | 26 ++++++++++++++++++++++++++
> > >  2 files changed, 37 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index eeec1d6f9023..266ab5f8c6e1 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5906,6 +5906,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
> > >  SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
> > >  SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
> > > 
> > > +#define SWITCHTEC_PCI100X_QUIRK(vid) \
> > > +     DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
> > > +             PCI_CLASS_BRIDGE_OTHER, 8,
> > > quirk_switchtec_ntb_dma_alias)
> > > +SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
> > > +SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
> > > +SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
> > > +SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
> > > +SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
> > > +SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
> > > +
> > > +
> > >  /*
> > >   * The PLX NTB uses devfn proxy IDs to move TLPs between NT
> > > endpoints.
> > >   * These IDs are used to forward responses to the originator on
> > > the other
> > > diff --git a/drivers/pci/switch/switchtec.c
> > > b/drivers/pci/switch/switchtec.c
> > > index 5b921387eca6..faaca76407c8 100644
> > > --- a/drivers/pci/switch/switchtec.c
> > > +++ b/drivers/pci/switch/switchtec.c
> > > @@ -1726,6 +1726,26 @@ static void switchtec_pci_remove(struct
> > > pci_dev *pdev)
> > >               .driver_data = gen, \
> > >       }
> > > 
> > > +#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
> > > +     { \
> > > +             .vendor     = PCI_VENDOR_ID_EFAR, \
> > > +             .device     = device_id, \
> > > +             .subvendor  = PCI_ANY_ID, \
> > > +             .subdevice  = PCI_ANY_ID, \
> > > +             .class      = (PCI_CLASS_MEMORY_OTHER << 8), \
> > > +             .class_mask = 0xFFFFFFFF, \
> > > +             .driver_data = gen, \
> > > +     }, \
> > > +     { \
> > > +             .vendor     = PCI_VENDOR_ID_EFAR, \
> > > +             .device     = device_id, \
> > > +             .subvendor  = PCI_ANY_ID, \
> > > +             .subdevice  = PCI_ANY_ID, \
> > > +             .class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
> > > +             .class_mask = 0xFFFFFFFF, \
> > > +             .driver_data = gen, \
> > 
> > We have this:
> > 
> >   #define PCI_VENDOR_ID_EFAR              0x1055
> > 
> > but searching the PCI-SIG Vendor ID database for 0x1055 doesn't find
> > anything:
> > 
> >   https://pcisig.com/membership/member-companies
> > 
> > You mention "Microchip", and it looks like Microchip is assigned
> > Vendor ID 0x11f8:
> > 
> >   https://pcisig.com/membership/member-companies?combine=microchip
> > 
> > which we also have defined:
> > 
> >   #define PCI_VENDOR_ID_PMC_Sierra        0x11f8
> >   #define PCI_VENDOR_ID_MICROSEMI         0x11f8
> > 
> > Can you clarify what's going on here?  I assume these parts actually
> > do have Vendor ID 0x1055.  But the PCI-SIG really should know about
> > the usage of this ID.  There's an email contact address on that web
> > page; can you straighten this out?
> 
> PMC, Microsemi are now part of Microchip. The switchtec products are
> from Microsemi and so the vendor ID is 0x11f8. EFAR is also part of
> Microchip. For PCI100x product parts we intended to use the VID 0x1055
> which is of EFAR's VID. PMC, Microsemi and EFAR product parts all are
> now part of Microchip.
> 
> The reason why EFAR VID (0x1055) is not listed in the website is
> becuase the site can list only one VID per company.
> 
> For further information, please refer to Steen's reply of
> https://lore.kernel.org/linux-pci/f695618054232c5f43c2148c5e6551f3ab318792.camel@microchip.com/to
> https://lore.kernel.org/linux-pci/20240621184923.GA1398370@bhelgaas/

Thanks.  What an annoyance that the PCI-SIG can't expose Vendor IDs
that are allocated but no longer correspond to the original vendor.
I'll complain to the SIG again.

Bjorn


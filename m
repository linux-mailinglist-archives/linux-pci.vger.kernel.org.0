Return-Path: <linux-pci+bounces-20512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1876A2169B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 04:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3977A2EED
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9C179BC;
	Wed, 29 Jan 2025 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3ItYUWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E72942A;
	Wed, 29 Jan 2025 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738119798; cv=none; b=C3LPlZ4aWcOUrWDBOfqtt56ki0185AfdocAFbOmaa+fZCMPfcrqT52aOkar0w+93p26E532D+bUV8NV9/CWydKAmiO3VKhMGnJ24KCPKKG9laUN7t+WN9Yq2H+ThUvOA+0zwXllvju0D6tjZUXK42bKxIMhNBtulXkVzDbDDmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738119798; c=relaxed/simple;
	bh=HJAkZQawc1EkKVLluBErityMpfGIYGnetk7FRxtmY+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lnL7bYGHlOFzFvcoXj5mfFT3cbAErVBi28OHqMKiOtEltdD8g2rlECidV2VJrJWfCLfTN/D6HIXMLqkSHDUQzZ3x0uTVhLNsJxU/PnuI2kZTI32foen44vuhdsuH7IntR1/xMeb49JfK+HB2dtR2VIJ55iUWYZE0bg3PBWDcZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3ItYUWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12191C4CED3;
	Wed, 29 Jan 2025 03:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738119797;
	bh=HJAkZQawc1EkKVLluBErityMpfGIYGnetk7FRxtmY+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a3ItYUWK/QZsO/64Gq2SoWwAqVGPgzrZFcUO2mgDWaDQYT90x3yiNuX1MxSyyyGnV
	 lvl8wgBzARdtYLF/3AnPj2+tTeMDKkw4NBPPZMfeB81qcq1w7KcMyY/ECH2k61CRJH
	 bmG8OCttIRBVcsLBGfoGSFxjr0l/CWTzllj9QfVZ9xsCILOoMWrdoECYrTsOx1I4xh
	 y6XS1hN1wvgryiL3UyKs7RmSjvnjARXjSX7qcM7Wst0THzLfLUJcmmRmwhzKNrOUwq
	 v0Mo3aZ6nEG1qVZxfNr4eAAdweR6jbyM99k+YUCFYq1jEL3nzNuX+YIPqwFgst4HGD
	 Jkwi26iWZvC9A==
Date: Tue, 28 Jan 2025 21:03:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <20250129030315.GA392478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5mOKQUrgeF_r6te@mail-itl>

[+cc linux-pci]

On Wed, Jan 29, 2025 at 03:10:49AM +0100, Marek Marczykowski-Górecki wrote:
> On Tue, Jan 28, 2025 at 07:15:26PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 17, 2025 at 01:05:30PM +0100, Marek Marczykowski-Górecki wrote:
> > > After updating PV dom0 to Linux 6.12, The Mediatek MT7922 device reports
> > > all 0xff when accessing its config space. This happens only after device
> > > reset (which is also triggered when binding the device to the
> > > xen-pciback driver).
> > 
> > Thanks for the report and for all the debugging you've already done!
> > 
> > > Reproducer:
> > > 
> > >     # lspci -xs 01:00.0
> > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
> > >     00: c3 14 16 06 00 00 10 00 00 00 80 02 10 00 00 00
> > >     ...
> > >     # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> > >     # lspci -xs 01:00.0
> > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
> > >     00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >
> > > The same operation done on Linux 6.12 running without Xen works fine.
> > > 
> > > git bisect points at:
> > > 
> > >     commit d591f6804e7e1310881c9224d72247a2b65039af
> > >     Author: Bjorn Helgaas <bhelgaas@google.com>
> > >     Date:   Tue Aug 27 18:48:46 2024 -0500
> > > 
> > >     PCI: Wait for device readiness with Configuration RRS
> > > 
> > > part of that commit:
> > > @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> > >                         return -ENOTTY;
> > >                 }
> > >  
> > > -               pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > -               if (!PCI_POSSIBLE_ERROR(id))
> > > -                       break;
> > > +               if (root && root->config_crs_sv) {
> > > +                       pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> > > +                       if (!pci_bus_crs_vendor_id(id))
> > > +                               break;
> > > +               } else {
> > > +                       pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > +                       if (!PCI_POSSIBLE_ERROR(id))
> > > +                               break;
> > > +               }
> > >  
> > >     
> > > Adding some debugging, the PCI_VENDOR_ID read in pci_dev_wait() returns
> > > initially 0xffffffff. If I extend the condition with
> > > "&& !PCI_POSSIBLE_ERROR(id)", then the issue disappear. But reading the
> > > patch description, it would break VF.
> > > I'm not sure where the issue is, but given it breaks only when running
> > > with Xen, I guess something is wrong with "Configuration RRS Software
> > > Visibility" in that case.
> > 
> > I'm missing something.  If you get 0xffffffff, that is not the 0x0001
> > Vendor ID, so pci_dev_wait() should exit immediately.  
> 
> I'm not sure what is going on there either, but my _guess_ is that the
> loop exits too early due to the above. And it makes some further actions
> to fail.

When RRS SV is enabled, reading PCI_VENDOR_ID should always return
0x0001 (if the device isn't ready and responds with RRS status) or the
valid Vendor ID.  I don't think it should ever return 0xffff (unless
the device is powered off, unplugged, or broken, of course).

> > But the log at
> > https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582927149
> > says it *doesn't* exit and eventually times out.
> 
> Note this log is from "working" kernel, so that timeout must be
> something else.

I saw it was labeled "NO BUG" but I'm not sure it's labeled correctly
since there are no interesting messages from the "BUG PRESENT" part.
Awfully funny coincidence if it's unrelated.

> > And the lspci above shows ~0 data for much of the header, even though
> > the device must be ready by then.
> > 
> > I don't have any good ideas, but since the problem only happens with
> > Xen, and it seems to affect more than just the Vendor ID, maybe you
> > could instrument xen_pcibk_config_read() and see if there's something
> > wonky going on there?
> 
> This one is used when pcifront (from a different PV VM) is asking pciback
> to read something. I see the issue even before starting any other VM and
> not even attaching the device to the xen-pciback driver...

The report claims the problem only happens with Xen.  I'm not a Xen
person, and I don't know how to find the relevant config accessors.
The snippets of kernel messages I see at [1] all mention pciback, so
that's my only clue of where to look.  Bottom line, I have no idea
what the config accessor path is, and maybe we could learn something
by looking at whatever it is.

[1] https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582927149


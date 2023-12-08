Return-Path: <linux-pci+bounces-722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01880AFD1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B94B20B45
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090353804;
	Fri,  8 Dec 2023 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acpxM4Vq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F17381A0
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 22:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33813C433C7;
	Fri,  8 Dec 2023 22:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702075442;
	bh=S6MyOU6T0Fer6VF+sjCTieDw8pAVyxQETthgnHZR/y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=acpxM4VqA3yB4RghOq90yVySHiLBvUT6Jf3N11NcC+jCDKrMAv2JE6gU9sW/AH20Z
	 gI0KgQFJ94A/wMG5wdA6yi8ObIbeIZSDUDPqoBaH+zqOgLC3e+4OL9nyz9DJsYrHiE
	 IEDazM6kWy2ytbTgQIutBE4g2GZBFCO42OrQnxn71yrrmXjeGdGUKCsPzAptePV+ap
	 JH0CTPWgmdAmOyUiu+5E95XxGb2DtblcvnOWyZwFuXXdq3GUMXHs94+BcWNyWwfyzw
	 nseDz3zHi16Q+2GNOACRpbc5m8IowuyYTJvlElOd0fIiV+4IF+/Wp4Rtz9wtTjtxno
	 2djQvYJcMB4+w==
Date: Fri, 8 Dec 2023 16:44:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <20231208224400.GA835068@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0431bc-6747-4367-bbbd-95c75395329f@amd.com>

On Fri, Dec 08, 2023 at 04:29:42PM -0600, Mario Limonciello wrote:
> On 12/8/2023 16:24, Bjorn Helgaas wrote:
> > On Wed, Aug 16, 2023 at 10:49:23AM +0530, Sanath S wrote:
> > > In the case of Thunderbolt, it contains a PCIe switch and one or
> > > more hotplug-capable PCIe downstream ports where the daisy chain
> > > can be extended.
> > > 
> > > Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> > > System BIOS allocates a very minimal number of buses for bridges and
> > > hot-plug capable PCIe downstream ports to enumerate the dock during
> > > boot. Because of this, we run out of bus space pretty quickly when
> > > more PCIe devices are attached to hotplug downstream ports in order
> > > to extend the chain.
> > > 
> > > Before:
> > >             +-04.0
> > >             +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
> > >             |                               +-01.0-[66]--
> > >             |                               +-02.0-[67]--
> > >             |                               +-03.0-[68]--
> > >             |                               \-04.0-[69]--
> > >             +-08.0
> > 
> > Looks like a clear issue here because there's no other use for
> > buses 70-c1.  But what would happen if there were more hotplug-capable
> > downstream ports, e.g., assume one at 08.1 leading to [bus c2-c7]?
> > 
> > The 04.1 bridge has a lot of space, but 08.1 has very little.  With
> > this patch, would we distribute it more evenly across 04.1 and 08.1?
> > If not, I think we'll just have the same problem when somebody plugs
> > in a similar hierarchy at 08.1.
> > 
> > > In case of a thunderbolt capable bridge, reconfigure the buses allocated
> > > by BIOS to the maximum available buses. So that the hot-plug bridges gets
> > > maximum buses and chain can be extended to accommodate more PCIe devices.
> > > This fix is necessary for all the PCIe downstream ports where the daisy
> > > chain can be extended.
> > > 
> > > After:
> > >             +-04.0
> > >             +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
> > >             |                               +-01.0-[66-84]--
> > >             |                               +-02.0-[85-a3]--
> > >             |                               +-03.0-[a4-c0]--
> > >             |                               \-04.0-[c1]--
> > >             +-08.0
> > 
> > This doesn't look like anything specific to Thunderbolt; it's just
> > that we don't do a good job of reassigning bus numbers in general,
> > right?  We shouldn't just punt and say "BIOS should have done
> > something" because not all machines *have* BIOS, and the OS can
> > reconfigure bus numbers as needed.  The patch certainly isn't
> > Thunderbolt-specific.
> 
> From the discussions Sanath and I have been in related to this issue
> the BIOS is pretty static with it's initialization under the
> presumption that the OS will rebalance things if necessary.
> ...

> For this particular issue it's being approached a different way.
> 
> Windows never rebalances things but doesn't suffer from this issue.
> That's because Windows actually does a "Downstream port reset" when
> it encounters a USB4 router.
> 
> Sanath posted a quirk that aligned this behavior when encountering
> an AMD USB4 router, but as part of the discussion I suggested that
> we do it for everyone.
> 
> https://lore.kernel.org/linux-usb/20231123065739.GC1074920@black.fi.intel.com/
> 
> So Sanath has a new patch that does this that is under testing right
> now and will be posted soon.

Hmm, ok.  I don't know what a "downstream port reset" does or how it
resolves the bus number allocation issue, but I'm happy if you have a
fix that doesn't need PCI core changes.

Bjorn


Return-Path: <linux-pci+bounces-7529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FB8C6D50
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA20F1C22253
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB415B103;
	Wed, 15 May 2024 20:35:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689E6FBF;
	Wed, 15 May 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805330; cv=none; b=flyTZIVJoC9C5pqS6eVuwk7b+ZQMvdNyT64rjOvisALF49u5KBDKeYC69Mt+HbLq+J3kPnWMRMORwBjhwu1Xx35Qpg0h91Fe0Af5AhS2okIyzLafId1Gn73EvJTw+MC0XNXJSTzkgzxikfTJ39I2u3F/Okk9rC1XhoDRixo041M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805330; c=relaxed/simple;
	bh=1ROaqHeKea4ES3++aMaMcby/3PQ4/hiCneLKczow8pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJXz8qfN7tqUXY9E/yStxRrH9IbG/OcO+2mCxzC2UKn4NacNeB+xMW2cJQWsIZMtSgPMb3KGheGV22RrAWsRk+gElYMPhCBrKx/YNXHRPrlFyIACzOcRlqBouV0sheQbRg4B3spt/iCJ27QXemTnQIl5n851A2ZD0ucdt6cDLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9C66C100B04B8;
	Wed, 15 May 2024 22:35:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 61E274A9A7F; Wed, 15 May 2024 22:35:22 +0200 (CEST)
Date: Wed, 15 May 2024 22:35:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZkUcihZR_ZUUEsZp@wunner.de>
References: <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>

On Wed, May 15, 2024 at 02:53:54PM -0400, Esther Shimanovich wrote:
> On Wed, May 8, 2024 at 1:23???AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > > That is correct, when the user-visible issue occurs, no driver is
> > > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > > attach to the external-facing root port because of the security
> > > policy, so the NHI and XHCI are not seen by the computer.
> >
> > Could you rework your patch to only rectify the NHI's and XHCI's
> > device properties and leave the bridges untouched?
> 
> So I tried a build with that patch, but it never reached the
> tb_pci_fixup function

That means that for some reason, the PCI devices are not associated with
the Thunderbolt ports.  Could you add this to the command line:

  thunderbolt.dyndbg ignore_loglevel log_buf_len=10M

and this to your kernel config:

  CONFIG_DYNAMIC_DEBUG=y

You should see "... is associated with ..." messages in dmesg.
This did work for Mika during his testing with recent Thunderbolt chips.
I amended the patches after his testing but wouldn't expect that to
cause issues.

@Mika, would you mind re-testing if you've got cycles to spare?


> even when NHI and XHCI were both labeled as
> fixed and external facing in the quirk.

Setting the two as fixed and trusted should be sufficient.
The external_facing bit should not be needed on the NHI and XHCI.


> Also, I don't see where you distinguish between an integrated
> Thunderbolt PCIe root port and a root port with no thunderbolt
> functionality built in. Could you point that out to me?

Hm, why would I have to distinguish between the two?

I distinguish between Thunderbolt PCIe Adapters on the root switch
and ones on non-root switches.  The latter are attached Device Routers,
the former is the Host Router.  I just set the ones on the former to
external_facing, fixed and trusted.  Everything downstream is untrusted
and removable.


> I'm not sure how your patch protects against the following case
> scenario I described earlier:
> > Let's say we have a TigerLake CPU, which has integrated
> > Thunderbolt/USB4 capabilities:
> >
> > TigerLake_ThunderboltCPU -> USB-C Port
> > This device also has the ExternalFacingPort property in ACPI and lacks
> > the usb4-host-interface property in the ACPI.
> >
> > My worry is that someone could take an Alpine Ridge Chip Thunderbolt
> > Dock and attach it to the TigerLake CPU
> >
> > TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
> >
> > If that were to happen, this quirk would incorrectly label the Alpine
> > Ridge Dock as "fixed" instead of "removable".

See above, the Alpine Ridge Dock is never the root switch.
The Tiger Lake CPU is.

Thanks,

Lukas


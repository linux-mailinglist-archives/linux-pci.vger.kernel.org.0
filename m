Return-Path: <linux-pci+bounces-3220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E684D268
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 20:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8589FB27075
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA686AD2;
	Wed,  7 Feb 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9k778Iz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E698563E;
	Wed,  7 Feb 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335501; cv=none; b=mNG+JM/oGG3kiNRHj7MYeknzAcUxVjqvpgNiaTqjqb5pYH0RKuzGZkP12z+FP0FltznA7xau6TCzpRm4VKf9FkY56feRYOhRc1QXVA+LPKl3qNm4GRfVZxlD2VsqBQdp58cKtJRoA/tnIJ0Dt+lHn4IJSG2ZJS7xW+VninEpItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335501; c=relaxed/simple;
	bh=pv2VRu3SrRdSAM9IiT+hebyhoOnb9uKKlZWg141JHHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3auuo2Y/ngWkAp7lHG3mH+JXtcPt1N6fnPxzAeiLSDOC+nPnxUHOlQoEhP4Y7pZFlhnyPkwF4+Dt8XVIMhuupv5hhwrRsvvgs6RyU1JNLOsNaH7YEeG+zq90vcJ2gWkWZfDqBH2jnkYlx6j4vK7eIoz+ORlPxzvXn716ItLz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9k778Iz; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707335499; x=1738871499;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pv2VRu3SrRdSAM9IiT+hebyhoOnb9uKKlZWg141JHHw=;
  b=n9k778Iz3oX8rjdnM0+X3B+FGY9wYxRjsMNWkzolC78u1AbpX0u/yYTv
   DcKvrDcdgOTnDtimLyodOyFPNFvYafjJ9417vY18K46m5Z+6GDt+f/w52
   uHuPOjDKTGo9+E9Eve73rLrVrayOKKoL1POfpA53xbabqIIm7FU4eqVKd
   Zt6HezyA1QdBPI2jof6nUnLD84+qTND7Ur3dT2Ebh+sGnwQHeNk5V1mCx
   WucSX1C79UodHEyhxCzOQB2/LSH6OW9J0/aO20EZdBwdamhkD/NtrpjsJ
   WJdnOz2f2LYtteblZpdrluh0sERcrn4EP0Bwc/Y0AHYonIFNbehr20eGM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="436205073"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="436205073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1791657"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:51:39 -0800
Received: from hsinjuiy-mobl.amr.corp.intel.com (unknown [10.209.57.193])
	by linux.intel.com (Postfix) with ESMTP id 60E07580DCE;
	Wed,  7 Feb 2024 11:51:38 -0800 (PST)
Message-ID: <3ebd2ea35aadc23cf122af250bec47294fc2d9e2.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: puranjay12@gmail.com, Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold
 <johan@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
Date: Wed, 07 Feb 2024 11:51:38 -0800
In-Reply-To: <20240206233007.GA886412@bhelgaas>
References: <20240206233007.GA886412@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 17:30 -0600, Bjorn Helgaas wrote:
> On Tue, Feb 06, 2024 at 01:25:29PM -0800, David E. Box wrote:
> > On Mon, 2024-02-05 at 15:05 -0800, David E. Box wrote:
> > > On Mon, 2024-02-05 at 16:42 -0600, Bjorn Helgaas wrote:
> > > > On Mon, Feb 05, 2024 at 11:37:16AM -0800, David E. Box wrote:
> > > > > On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> > > > > > On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> > > > > ...
> > > >=20
> > > > > > > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pc=
i_dev
> > > > > > > *pdev,
> > > > > > > void *userdata)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_write_con=
fig_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > > > > > > ltr_reg);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_info(pdev=
, "VMD: Default LTR value set by driver\n");
> > > > > >=20
> > > > > > You're not changing this part, and I don't understand exactly h=
ow
> > > > > > LTR
> > > > > > works, but it makes me a little bit queasy to read "set the LTR
> > > > > > value
> > > > > > to the maximum required to allow the deepest power management
> > > > > > savings" and then we set the max snoop values to a fixed consta=
nt.
> > > > > >=20
> > > > > > I don't think the goal is to "allow the deepest power savings";=
 I
> > > > > > think it's to enable L1.2 *when the device has enough buffering=
 to
> > > > > > absorb L1.2 entry/exit latencies*.
> > > > > >=20
> > > > > > The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set thi=
s to
> > > > > > the platform's maximum supported latency or less," so it seems =
like
> > > > > > that value must be platform-dependent, not fixed.
> > > > > >=20
> > > > > > And I assume the "_DSM for Latency Tolerance Reporting" is part=
 of
> > > > > > the
> > > > > > way to get those platform-dependent values, but Linux doesn't
> > > > > > actually
> > > > > > use that yet.
> > > > >=20
> > > > > This may indeed be the best way but we need to double check with =
our
> > > > > BIOS folks.=C2=A0 AFAIK BIOS writes the LTR values directly so th=
ere
> > > > > hasn't been a need to use this _DSM. But under VMD the ports are
> > > > > hidden from BIOS which is why we added it here. I've brought up t=
he
> > > > > question internally to find out how Windows handles the DSM and t=
o
> > > > > get a recommendation from our firmware leads.
> > > >=20
> > > > We want Linux to be able to program LTR itself, don't we?=C2=A0 We
> > > > shouldn't have to rely on firmware to do it.=C2=A0 If Linux can't d=
o
> > > > it, hot-added devices aren't going to be able to use L1.2,
> > > > right?
> > >=20
> > > Agreed. We just want to make sure we are not conflicting with what
> > > BIOS may be doing.
> >=20
> > So the feedback is to run the _DSM and just overwrite any BIOS
> > values. Looking up the _DSM I saw there was an attempt to upstream
> > this 4 years ago [1]. I'm not sure why the effort stalled but we can
> > pick up this work again.
> >=20
> > https://patchwork.kernel.org/project/linux-pci/patch/20201015080311.781=
1-1-puranjay12@gmail.com/
>=20
> There was a PCI SIG discussion about this a few years ago that never
> really seemed to get resolved:
> https://members.pcisig.com/wg/PCIe-Protocol/mail/thread/35064
>=20
> Unfortunately that discussion is not public, but the summary is:
>=20
> =C2=A0 Q: How is the LTR_L1.2_THRESHOLD value determined?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 PCIe r5.0, sec 5.5.4, says the same value must b=
e programmed into
> =C2=A0=C2=A0=C2=A0=C2=A0 both Ports.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 A: As noted in sec 5.5.4, the value is determine=
d primarily by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the amount of time it wil=
l take to re-establish the common
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mode bias on the AC coupl=
ing caps, and it is assumed that the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIOS knows this.
>=20
> =C2=A0 Q: How are the LTR Max Snoop values determined?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 PCI Firmware r3.3, sec 4.6.6, says the LTR _DSM =
reports the max
> =C2=A0=C2=A0=C2=A0=C2=A0 values for each Downstream Port embedded in the =
platform, and the
> =C2=A0=C2=A0=C2=A0=C2=A0 OS should calculate latencies along the path bet=
ween each
> =C2=A0=C2=A0=C2=A0=C2=A0 Downstream Port and any Upstream Port (Switch Up=
stream Port or
> =C2=A0=C2=A0=C2=A0=C2=A0 Endpoint).
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Of course, Switches not embedded in the platform=
 (e.g., external
> =C2=A0=C2=A0=C2=A0=C2=A0 Thunderbolt hierarchies) will not have this _DSM=
, but I assume
> =C2=A0=C2=A0=C2=A0=C2=A0 they should contribute to this sum?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 A: The fundamental problem is that there is no p=
ractical way for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0software to discover the =
AC coupling capacitor sizes and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0common mode bias circuit =
impedance.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Software could compute co=
nservative values, but they would
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0likely be 10x worse than =
typical, so the L1.2 exit latency
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0would be significantly lo=
nger than actually required to be.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The interoperability issu=
es here were understood when
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0designing L1 Substates, b=
ut no viable solution was found.
>=20
> So the main reason Puranjay's work got stalled is that I didn't feel
> confident enough that we understood how to do this, especially for
> external devices.
>=20
> It would be great if somebody *did* feel confident about interpreting
> and implementing all this.

As it is BIOS (at least Intel BIOS) is already writing the maximum allowed =
LTR
value on Upstream Ports that have it set to 0. So we can't do any worse if =
we
write the BIOS provided _DSM value for all Upstream Ports, including extern=
al
devices. Sounds like the worst case scenario is that devices take longer th=
an
needed to exit L1.2 (I'm still asking about this detail). But I think this =
is
better than not programming the LTR at all which could prevent the platform=
 from
power gating they very resources that LTR is meant to help manage.

If that reasoning is okay with you, I'll submit patches to use the _DSM.

David


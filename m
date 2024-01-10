Return-Path: <linux-pci+bounces-1997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA5829D81
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA152845AA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412C4BAAB;
	Wed, 10 Jan 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx/wajo7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17964BAAE
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900272; x=1736436272;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VKFaX1h58LHLImE/7wnOp61T767lCCERSA2kFEZSgzk=;
  b=kx/wajo7CCpic9JaFal/pT2tABJ/zxoSggiL5FEESxN8p0UspiIDscGK
   fZtPL3+x2pmkG8ERKREmaxFRYRnDIzAaN1k5CpKqig8mGxKFzbADjXpQp
   ndjAULvdClVM8rL/4QfIbWSC+qwY9FFZ/OX5n6Z78Ek9LjuM/TTpwyM9f
   DI4BvexM1Oy2LKZgZMnGrjK6/UatElJ5yIs+gnAercA4yc5VbBGVdhnLt
   jVyu66TYH91aVqt9KHE4glSCp/titcrT4th3/CYQrwc56sUwxvsOIr/po
   /RW8Bk7wAZk28BztsZXpqmRfeg5/FRbSum0X5ZS7GO2fmdWlaqw3DNy0z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="12037050"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="12037050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="1029186215"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1029186215"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:24:31 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 923F5580960;
	Wed, 10 Jan 2024 07:24:31 -0800 (PST)
Message-ID: <f95657a40a596c7f9ba0bad413fcd414514cf2b7.camel@linux.intel.com>
Subject: Re: [PATCH v5] PCI/ASPM: Add back L1 PM Substate save and restore
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com, 
 sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com, 
 rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com, 
 tasev.stefanoska@skynet.be, enriquezmark36@gmail.com, kernel@witt.link, 
 koba.ko@canonical.com, wse@tuxedocomputers.com,
 ilpo.jarvinen@linux.intel.com,  ricky_wu@realtek.com,
 linux-pci@vger.kernel.org, Michael Schaller <michael@5challer.de>
Date: Wed, 10 Jan 2024 07:24:31 -0800
In-Reply-To: <20231229003045.GA1561509@bhelgaas>
References: <20231229003045.GA1561509@bhelgaas>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-28 at 18:30 -0600, Bjorn Helgaas wrote:
> [+cc Michael]
>=20
> On Thu, Dec 28, 2023 at 04:31:12PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 20, 2023 at 05:12:50PM -0800, David E. Box wrote:
> > ...
>=20
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 55bc3576a985..3c4b2647b4ca 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
>=20
> > > @@ -1579,7 +1579,7 @@ static void pci_restore_pcie_state(struct pci_d=
ev
> > > *dev)
> > > =C2=A0{
> > > ...
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So we restore here only t=
he
> > > +	 * LNKCTL register with the ASPM control field clear. ASPM will
> > > +	 * be restored in pci_restore_aspm_state().
> > > +	 */
> > > +	val =3D cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
> > > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
> >=20
> > When CONFIG_PCIEASPM is not set, we will clear ASPMC here and never
> > restore it.=C2=A0 I don't know if this ever happens.=C2=A0 Do we need t=
o worry
> > about this?=C2=A0 Might firmware restore ASPMC itself before we get her=
e?
> > What do we want to happen in this case?

I just checked this. L1 does get disabled which we don't want. We need to s=
ave
and restore the BIOS ASPM configuration even when CONFIG_PCIEASPM is not se=
t.

> >=20
> > Since ASPM is intertwined with the PCIe Capability, can we call
> > pci_restore_aspm_state() from here instead of from
> > pci_restore_state()?
> >=20
> > Calling it here would make it easier to see the required ordering
> > (LNKCTL with ASPMC cleared, restore ASPM L1SS, restore ASPMC) and
> > it would be obvious that none of the other stuff in
> > pci_restore_state() is relevant (PASID, PRI, ATS, VC, etc).
> >=20
> > If that could be done, I think it would make sense to do the same with
> > pci_save_aspm_state() even though it's a little more independent.
>=20

Makes sense

> The lspci output in Michael's report at
> https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.d=
e
> reminded me that LTR is important for L1.2, and we currently have
> this:
>=20
> =C2=A0 pci_restore_state
> =C2=A0=C2=A0=C2=A0 pci_restore_ltr_state
> =C2=A0=C2=A0=C2=A0 pci_restore_pcie_state
>=20
> I wonder if pci_restore_ltr_state() should be called from
> pci_restore_pcie_state() as well?=C2=A0 It's intimately connected to ASPM=
,
> and that connection isn't very clear in the current code.

Make sense too since LTR is a required capability for L1.2. I'll send updat=
ed
patches after the merge window.

David


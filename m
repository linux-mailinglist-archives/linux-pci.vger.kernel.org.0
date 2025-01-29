Return-Path: <linux-pci+bounces-20513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AACBA216E6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 04:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAEF3A6FEF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E774188734;
	Wed, 29 Jan 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="n5lqyQm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7QlGe/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DD171CD;
	Wed, 29 Jan 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738120972; cv=none; b=kyYmZwwqYJweF1fhdRjD7Z6OHMQWgZIllRLe5KmfKnR+LFjVPglqHwHu21Q/45gj9/Q7x06y5zIZY5yD3IEoMBSZf10nCdLEQoFwd0FNKEyKFcc9NxdDJpqyvJdl5Lyb6se8taxrJtWLgBBLq2xKuPkyuFjYJJQ/YTm1LMYGCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738120972; c=relaxed/simple;
	bh=I5pcERzqT5N4x9eNDsqCZGomd8skEJBMsXDkri+POc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENargLmN8cMU84kptwblRoKdKnPP7wEpkYgYybsQw1ZzscSXVgSAjmh+zZxiI8f/Rr1A+gUR2nnQeFM9nDdBqoM+dZtM6gB22f9+ESuL8odQYzpLwygvO4z1NhgbkLgJ1JWIZC2Y0NdHDhxdGEDUZb6kyCutaHOYeGEgUb7FzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=n5lqyQm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7QlGe/J; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AECCD1140117;
	Tue, 28 Jan 2025 22:22:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 22:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738120967;
	 x=1738207367; bh=S7YOKlMbFES7C1wJ58+2rQQqMC0Rhv4K2F0BUr6oSnw=; b=
	n5lqyQm93dkFYPyIRmzqEFFJVBkj6tf/CHb4DN4ebxKT4KkqrtNYKBRf8pjH7f46
	q3HIb/K8BVHLw0oqN2C6M/3inVlPVQkqmDOcC4wlFIlP6lkNFWMy6alEidFq41aG
	nRhEUZY2scxwS3xMVHt1ed/LHN8kb/V06rROl4KQsCxPbMjKluPr6HXfdrPWT1Fh
	1f5ylg1Ei0wvLVWuSQKQOHnxSA74imKPpdAZ9xpqnaNZEErnP6+jhfE5546p+Ef4
	G2WDpa4ePDXy9k5Cf/CrsEbZIPVkgaPHrya6huXrTCRTanDPt0dR/Vgd9637bFyh
	dqv9ppWKNm6OkZLh373ptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738120967; x=1738207367; bh=S7YOKlMbFES7C1wJ58+2rQQqMC0Rhv4K2F0
	BUr6oSnw=; b=l7QlGe/J/1xn8gg8+q7y5m0O3dvVLy44o4oM3fdUPw1WN+s8fTc
	Zsu6Wpwzm6TDWnAwRf0EgMvQ28ClnDAlnGPKyGF/fg8TAp+RIaR63tPeul8PBSkb
	+pABvy5U8H4z8u1C1I/NxXAe+xi/UVwA1av6HLJuAHJ31Q80zjk0cKtzbkW4zglz
	KDkJvz/0HWAoEDqwUBGWR6gMjRnAcdj4sgroSZb2Jy2YUBNPDbFhBDCikemzc1X4
	5UMLoml/bGzmIERJyNfOTLD9VhBprTCIkUSlUMXE2ovOZcjFR49qp2LZ9Iq1YIg2
	rzfj0jjCh8WXbS6mUkRxrav47JzuikmkorA==
X-ME-Sender: <xms:B5-ZZ2B3FkerFGiAb5rzKUieMrqRQTdeZYN8BM0YkxmCBIOp-gNfMg>
    <xme:B5-ZZwgwRwjeIGmV2yqBnvqrsV7F8zkz-qNPE_Fd5MKvdER7H1Q3b5i8duEd-wYpK
    gU8DyLxUj_e9g>
X-ME-Received: <xmr:B5-ZZ5n7NqqsTzdcFFA_-UQAI0iT3f8muIX6dpB0OTSJ7XhQw-tBNGHz4WdPcyvBLe9S1vp_Kcjqye5MbArFZq2onMOyKsiqHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
    grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
    rfgrthhtvghrnhepjeffleekjefhffffvdevgeehkeeitddtieelgeejffevheduheefff
    ekvedtjeevnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpgigvnhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrh
    gvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthho
    peduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvlhhgrggrsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthhtoheprhhoghgvrh
    drphgruhestghithhrihigrdgtohhmpdhrtghpthhtohepsghorhhishdrohhsthhrohhv
    shhkhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepgigvnhdquggvvhgvlheslhhish
    htshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvghhrvghsshhioh
    hnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnsggusehnsggurdhn
    rghmvg
X-ME-Proxy: <xmx:B5-ZZ0wCZMN_56wC7NNkj2GybruKCXcX-Ev0i7B4aGWIWKB5e_0j2Q>
    <xmx:B5-ZZ7QG-U3yF0FanDEGvLVczbmdkqJznYAMvEY0SKS1mMMnhMVj_w>
    <xmx:B5-ZZ_Yu5LVZKUOJVzsyEfEHMsS6yAwquKOvUB07cQ_GHveWA_FGUQ>
    <xmx:B5-ZZ0SUvoUlFcXygdAZmxlLFGMqCpaFaarw2fEcAgt2bl1nWu1dUg>
    <xmx:B5-ZZ6ItCMh6-qcEVMcgt4SJjgrFWDFI_VsRGRnqMJCkmdSMON3vh3NJ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 22:22:45 -0500 (EST)
Date: Wed, 29 Jan 2025 04:22:43 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <Z5mfA32bvEn6yD-C@mail-itl>
References: <Z5mOKQUrgeF_r6te@mail-itl>
 <20250129030315.GA392478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ffsn6E5EvKfIOHmn"
Content-Disposition: inline
In-Reply-To: <20250129030315.GA392478@bhelgaas>


--Ffsn6E5EvKfIOHmn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jan 2025 04:22:43 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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

On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
> [+cc linux-pci]
>=20
> On Wed, Jan 29, 2025 at 03:10:49AM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Tue, Jan 28, 2025 at 07:15:26PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 17, 2025 at 01:05:30PM +0100, Marek Marczykowski-G=C3=B3r=
ecki wrote:
> > > > After updating PV dom0 to Linux 6.12, The Mediatek MT7922 device re=
ports
> > > > all 0xff when accessing its config space. This happens only after d=
evice
> > > > reset (which is also triggered when binding the device to the
> > > > xen-pciback driver).
> > >=20
> > > Thanks for the report and for all the debugging you've already done!
> > >=20
> > > > Reproducer:
> > > >=20
> > > >     # lspci -xs 01:00.0
> > > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI =
Express Wireless Network Adapter
> > > >     00: c3 14 16 06 00 00 10 00 00 00 80 02 10 00 00 00
> > > >     ...
> > > >     # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> > > >     # lspci -xs 01:00.0
> > > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI =
Express Wireless Network Adapter
> > > >     00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >
> > > > The same operation done on Linux 6.12 running without Xen works fin=
e.
> > > >=20
> > > > git bisect points at:
> > > >=20
> > > >     commit d591f6804e7e1310881c9224d72247a2b65039af
> > > >     Author: Bjorn Helgaas <bhelgaas@google.com>
> > > >     Date:   Tue Aug 27 18:48:46 2024 -0500
> > > >=20
> > > >     PCI: Wait for device readiness with Configuration RRS
> > > >=20
> > > > part of that commit:
> > > > @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev,=
 char *reset_type, int timeout)
> > > >                         return -ENOTTY;
> > > >                 }
> > > > =20
> > > > -               pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > > -               if (!PCI_POSSIBLE_ERROR(id))
> > > > -                       break;
> > > > +               if (root && root->config_crs_sv) {
> > > > +                       pci_read_config_dword(dev, PCI_VENDOR_ID, &=
id);
> > > > +                       if (!pci_bus_crs_vendor_id(id))
> > > > +                               break;
> > > > +               } else {
> > > > +                       pci_read_config_dword(dev, PCI_COMMAND, &id=
);
> > > > +                       if (!PCI_POSSIBLE_ERROR(id))
> > > > +                               break;
> > > > +               }
> > > > =20
> > > >    =20
> > > > Adding some debugging, the PCI_VENDOR_ID read in pci_dev_wait() ret=
urns
> > > > initially 0xffffffff. If I extend the condition with
> > > > "&& !PCI_POSSIBLE_ERROR(id)", then the issue disappear. But reading=
 the
> > > > patch description, it would break VF.
> > > > I'm not sure where the issue is, but given it breaks only when runn=
ing
> > > > with Xen, I guess something is wrong with "Configuration RRS Softwa=
re
> > > > Visibility" in that case.
> > >=20
> > > I'm missing something.  If you get 0xffffffff, that is not the 0x0001
> > > Vendor ID, so pci_dev_wait() should exit immediately. =20
> >=20
> > I'm not sure what is going on there either, but my _guess_ is that the
> > loop exits too early due to the above. And it makes some further actions
> > to fail.
>=20
> When RRS SV is enabled, reading PCI_VENDOR_ID should always return
> 0x0001 (if the device isn't ready and responds with RRS status) or the
> valid Vendor ID.  I don't think it should ever return 0xffff (unless
> the device is powered off, unplugged, or broken, of course).

Maybe it isn't really enabled when Xen is involved?
By looking at lspci of the bridge for this device, I do see RootCtl: ...
CRSVisible+, but maybe there is something else needed too?

Just in case, full lspci -vvvs 2.2 (the bridge):


00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge (=
prog-if 00 [Normal decode])
	Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 102
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: 90b00000-90bfffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 8010900000-80109fffff [size=3D1M] [32-b=
it]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 16GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+, Ma=
xEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equaliz=
ationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee08000  Data: 4000
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 14=
53
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D10us LTR1.2_Threshold=3D166912ns
		L1SubCtl2: T_PwrOn=3D150us
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady- MargSoftReady-
	Kernel driver in use: pcieport

>=20
> > > But the log at
> > > https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582=
927149
> > > says it *doesn't* exit and eventually times out.
> >=20
> > Note this log is from "working" kernel, so that timeout must be
> > something else.
>=20
> I saw it was labeled "NO BUG" but I'm not sure it's labeled correctly
> since there are no interesting messages from the "BUG PRESENT" part.
> Awfully funny coincidence if it's unrelated.

The timeout thing I have seen before, possibly also on a different
hardware (although I'm not 100% sure), I think it's a different issue.

> > > And the lspci above shows ~0 data for much of the header, even though
> > > the device must be ready by then.
> > >=20
> > > I don't have any good ideas, but since the problem only happens with
> > > Xen, and it seems to affect more than just the Vendor ID, maybe you
> > > could instrument xen_pcibk_config_read() and see if there's something
> > > wonky going on there?
> >=20
> > This one is used when pcifront (from a different PV VM) is asking pciba=
ck
> > to read something. I see the issue even before starting any other VM and
> > not even attaching the device to the xen-pciback driver...
>=20
> The report claims the problem only happens with Xen.  I'm not a Xen
> person, and I don't know how to find the relevant config accessors.
> The snippets of kernel messages I see at [1] all mention pciback, so
> that's my only clue of where to look.  Bottom line, I have no idea
> what the config accessor path is, and maybe we could learn something
> by looking at whatever it is.

AFAIK there are no separate config accessors under Xen dom0, the default
ones are used. xen-pcifront takes over PCI config space access (and few
more) only in a domU (and only for PV), when PCI passthrough is used.
Here, it didn't went that far...

But then, Xen may intercept such access [2]. If I read it right, it
should allow all access (is_hardware_domain(dom0)=3D=3Dtrue, and also the
device is not on ro_map - otherwise reset wouldn't work at all).


>=20
> [1] https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582=
927149

[2] https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dblob;f=3Dxen/arch/x86/p=
v/emul-priv-op.c;h=3D70150c27227661baa253af8693ff00f2ab640a98;hb=3DHEAD#l295

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--Ffsn6E5EvKfIOHmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmeZnwMACgkQ24/THMrX
1yyR7Af+KIY4PA0PjnpQt79utqv7p+f3M9SfesSkZTufAXPuwmhGuJtB58kwYfuu
YUM1w3BqfkhSKpyaFyKHtDPjvZEcFzX25swvrcYe+wMM5kdqJBp/WXWR0cROxdan
Qws8s/JUvQFd5byOtfV+rggzfNVGE/cwwTAP49MwyQe8JFoFwUN/srj94rU8Oqm+
Z8IYGmVYlEV5zvcFMZ+Gmxgy6U3SVpkivxMxUIClGwCEAAjqmCNoK9ZAfVN0fgOZ
0aruISde8KcTjNpH4bUjN1EZGyqobDwlp3N8cEAcg/ULYWGYNQ8cZpLeX/1ldoTW
Hbz0lXlbgV3Y4uege+mBuOSk4DYLmA==
=oexv
-----END PGP SIGNATURE-----

--Ffsn6E5EvKfIOHmn--


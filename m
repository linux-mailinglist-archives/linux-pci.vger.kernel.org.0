Return-Path: <linux-pci+bounces-34406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F488B2E57E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303B23A64ED
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9CF203706;
	Wed, 20 Aug 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nXMjhO0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgDllEpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E717A314
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716919; cv=none; b=Q5BcH96E77IY2PnPjUh/SIVE0lHYpdv65/9uzRHJn3U5Ie7FZ1P7CM/0QBQuTzIAxLv0gxgnF7SMxIhmtcSp4ZjSQ16PHKsAeO8tuwlDha4mw16UGaGadsSy9IA764Udlxrclgaph3ChJFBKRAET0du98AG4AlAdcYcZNtDDC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716919; c=relaxed/simple;
	bh=zOQpXjlyPw/ARriFO4kjlRlROI4yVEevtpqlnWfS1AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oamSrzQFRswPA56On4IDLD8TMSA3qxZxzwPzJzJrHxANeyhZANoe+7Kzfpqk32hQnaQX8rrsstOBei5ii1lQ0D8YhgVnS1SbhX2c0sJaiFU5AkUNWtgGZxwX1TKtflTfO4V0YUlPK5EWoQaJS6l76VQnSGUKgOeX3WuTjC/MX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nXMjhO0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kgDllEpD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7982A7A0133;
	Wed, 20 Aug 2025 15:08:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 20 Aug 2025 15:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755716915; x=1755803315; bh=AYdJoKULzg
	g1QvjfOA9lakEkkI+xA5P2j748lkMe6qg=; b=nXMjhO0vtYolVH2STFuanuJxr4
	k2J7ULmkPHUyExYqyKMwQucjLFoF03B/9zH31+5esKWW0v15Zw/CBsgzRGGNLXRa
	+4eEkvr2YPPeV/Am0ZnW9WnIJE874SaCarXmc3tZpMq2EEu/OK7EJl5JlyxP+clW
	k6+L5HS5DiY4sgESyoMq/cH2oo2zYxQIKxmghGq2PU9gBfliSQNt5QvrYK1RJ7Na
	j8RcBorl+a6YnMpIf+VUJjW+cTtJLvAGmGjU6rlntz8ogcqTxRJM9spF/aNlIt7q
	hoGIYCI9k5x4gOZCZpni4R39Fl6OwDLboJ7ejw9QngGOI6AfDqyHSQ0f4LmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755716915; x=1755803315; bh=AYdJoKULzgg1QvjfOA9lakEkkI+xA5P2j74
	8lkMe6qg=; b=kgDllEpDUCrVdnQCczRMP5OyQewF/MB4YN64JOAmooBjWKEQOVj
	4djZQdyEexbZL1a4h7IA3Rp9TWIqna/WgGgtUZFzPBVG/gQ6CSgig5DhvCl+RAnX
	KVDD2n+mFI0p7igFC9Jm4dRwyRZgSwDE7U3oLjiIn9Xr269W9hy5apLZJza4vTaV
	8aPhzGlBY7naam7HUkxyuffRAewxKgm63x2o7ZtwL2x2TuPosexu7vXgvl2pDanB
	x1Zn7HUXFs0I5Ka2KJBTPw951xJJJXGi4w7aO0NPKJcaGnB6hD5nJh29Duw+EEfg
	7blLszdUaNCqHqf9PzA9G1df24LRfCCaNQg==
X-ME-Sender: <xms:Mh2maHeGnvIQN0XRZLQ_20H-a5Ij1_4hoUwUgAoepXK4OS5RBPok8Q>
    <xme:Mh2maE2G3FXr88uGi9TE08y5qEu7TBrjdI6VtheB2xqiSB559aKdNOwxsVC9M67pY
    Wkf9GZ-iz9Lub_EbA>
X-ME-Received: <xmr:Mh2maOJX89Li6sfz9QzJHkX_BrE6HiHyLUmutxQm1XvjfZFehwNiKOwdTM7PPVh4uhsCciEs3B3LPn-5UR9aysMF_o19OrH2SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujggfsehttdfstddtreejnecuhfhrohhmpeflrghnucfr
    rghluhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepudeviefhueeuudekfeeuiedvffegieefvdejgfetffeivdejueevheegheffteej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinhhknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgrii
    iiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprghliheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsth
    hsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:Mh2maDE1dgbcHB8PRwDMUyrWhaQGGMJsXF3JAsAA4uj2uzcwlBLwKA>
    <xmx:Mh2maKXJM_DEfIaHwGE8zxvHXgCbn7oPitvro9b3CW40JiyUJ1tGgg>
    <xmx:Mh2maLynke-YACPjxv3BBKNlFIFJpmV2sNjeDjVXLDVn5Zq1Hx_x-A>
    <xmx:Mh2maPRQv2fTa-m9YGFpPM5J5y0OyjE6cp0Mvwr9JBpwbtX_T06Rtw>
    <xmx:Mx2maDJCu8OvVfwt43zr7C7yJupt-4Nqv1mtYGBIxg6q_HoXKl0w2Gqn>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 15:08:34 -0400 (EDT)
Date: Wed, 20 Aug 2025 21:08:33 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <gn4sih6yrohqn35jc3hesxpgqhodtvq44ad7a6tbmknjywowvk@p2y24kjlnprd>
References: <bug-220479-41252@https.bugzilla.kernel.org/>
 <20250820184603.GA633069@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820184603.GA633069@bhelgaas>
User-Agent: NeoMutt/20250510

On 20.08.2025 13:46, Bjorn Helgaas wrote:
> [+cc maintainers, regressions list]
> 
> Jan, thanks very much for the report and the bisection.  Could you
> attach the devicetree you're using to the bugzilla?

I guess I could dump it from running system if you'd like me to, but it's
an upstream one without any customizations.

 
> On Wed, Aug 20, 2025 at 05:43:39PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=220479
> > 
> >            Summary: [regression 6.16] mvebu: no pci devices detected on
> >                     turris omnia
> >           Reporter: jpalus@fastmail.com
> > 
> > Booting kernel 6.16 results in no PCI devices being detected (output of `lspci`
> > is completely empty). Bisected to:
> > 
> > 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 is the first new commit
> > commit 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 (HEAD)
> > Author: Rob Herring (Arm) <robh@kernel.org>
> > Date:   Thu Nov 7 16:32:55 2024
> > 
> >     PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
> > 
> >     The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> >     but it's still just normal "ranges" as far as parsing is concerned.
> >     Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> >     instead of open coding the parsing.
> > 
> >     Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >     Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >     Link: https://patch.msgid.link/20241107153255.2740610-1-robh@kernel.org
> > 
> >  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> > 
> > 
> > kernel 6.16 logs following mesages related to PCI:
> > 
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: pcie0.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: pcie1.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: pcie2.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > [0x00080000-0x00081fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > [0x00040000-0x00041fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > [0x00044000-0x00045fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > [0x00048000-0x00049fff])
> > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > PCI: bus0: Fast back to back transfers enabled
> > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > 
> > 
> > while kernel 6.15 logs following:
> > 
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: pcie0.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > [0x00080000-0x00081fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > [0x00040000-0x00041fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > [0x00044000-0x00045fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > [0x00048000-0x00049fff])
> > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:01.0: PCI bridge to [bus 00]
> > pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@1,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@1,0/interrupt-controller
> > pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:02.0: PCI bridge to [bus 00]
> > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@2,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@2,0/interrupt-controller
> > pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:03.0: PCI bridge to [bus 00]
> > pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@3,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@3,0/interrupt-controller
> > PCI: bus0: Fast back to back transfers disabled
> > pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus1: Fast back to back transfers enabled
> > pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > pci 0000:02:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
> > pci 0000:02:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> > pci 0000:02:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0000:02:00.0: supports D1
> > pci 0000:02:00.0: PME# supported from D0 D1 D3hot
> > pci 0000:00:02.0: ASPM: current common clock configuration is inconsistent,
> > reconfiguring
> > pci 0000:00:02.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > pci 0000:00:02.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > PCI: bus2: Fast back to back transfers disabled
> > pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > pci 0000:03:00.0: [168c:0033] type 00 class 0x028000 PCIe Endpoint
> > pci 0000:03:00.0: BAR 0 [mem 0x00000000-0x0001ffff 64bit]
> > pci 0000:03:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0000:03:00.0: supports D1
> > pci 0000:03:00.0: PME# supported from D0 D1 D3hot
> > pci 0000:00:03.0: ASPM: current common clock configuration is inconsistent,
> > reconfiguring
> > pci 0000:00:03.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > pci 0000:00:03.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > PCI: bus3: Fast back to back transfers disabled
> > pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > pci 0000:00:02.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]
> > add_size 200000 add_align 200000
> > pci 0000:00:02.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> > pci 0000:00:03.0: bridge window [mem 0xe0400000-0xe04fffff]: assigned
> > pci 0000:00:01.0: PCI bridge to [bus 01]
> > pci 0000:02:00.0: BAR 0 [mem 0xe0000000-0xe01fffff 64bit]: assigned
> > pci 0000:02:00.0: ROM [mem 0xe0200000-0xe020ffff pref]: assigned
> > pci 0000:00:02.0: PCI bridge to [bus 02]
> > pci 0000:00:02.0:   bridge window [mem 0xe0000000-0xe03fffff]
> > pci 0000:03:00.0: BAR 0 [mem 0xe0400000-0xe041ffff 64bit]: assigned
> > pci 0000:03:00.0: ROM [mem 0xe0420000-0xe042ffff pref]: assigned
> > pci 0000:00:03.0: PCI bridge to [bus 03]
> > pci 0000:00:03.0:   bridge window [mem 0xe0400000-0xe04fffff]
> > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe03fffff]
> > pci_bus 0000:03: resource 1 [mem 0xe0400000-0xe04fffff]
> > pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> > pcieport 0000:00:03.0: enabling device (0140 -> 0142)
> 
> #regzbot introduced: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")


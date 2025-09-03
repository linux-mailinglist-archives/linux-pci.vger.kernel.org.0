Return-Path: <linux-pci+bounces-35398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AEB427FB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C9189A8E3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A81F8BD6;
	Wed,  3 Sep 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KFoPu9yq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auTVFjRQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35088282EE;
	Wed,  3 Sep 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920673; cv=none; b=sJhfuuyZRWbnAqCFHP2QQdT90uYYIgRC6mlmNd5ESdXo3jndkgexYkxnLDCpr6XExY7dJWyyGMclkt8rjUWxhElB3fHwBYTmv51bxYs3Lz9eqbOiwfU5Ss1pnRMTNJSv8lZCJnmZyU2BY0P/6dPNIgDxGrnankI6ou5s/vHMlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920673; c=relaxed/simple;
	bh=he7IshlRil/h4hQ8sp9UB7UqEUbVdMbWq0+u7rLnW4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd1Bf3/l7ZInjUF9DNttnu7hMU92RyfDOluL7edmvj/9+A1MEfe30sWiavDq6xHHAkBWC2aPftRNEIxu9GfP2weSzVRVeEqmGI+TdOQeCk4cBiBMji78hmz+dUQGZaQ17npl8DQMuWw3313LZm0YOrmeMxYCzXUMYw8rgxGrsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KFoPu9yq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auTVFjRQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FEFD14003B7;
	Wed,  3 Sep 2025 13:31:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 13:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756920668;
	 x=1757007068; bh=og+IC19JqfXradgQ2Q3tRC+R5U+0xPVyYVp/r/aEtrw=; b=
	KFoPu9yqdbB4XGGjZGlpke2cSdetSchmexrXbKdZgYjF/CVhtg9ONXjuRA56wIRq
	RQIRgIAawaBN5xoy1w3iSe0AKdNwcy1qmMrdAEBylrzaKu1zzQrtRlyTy129GZcU
	4fNB6mRrI1Gi/qdaeIuuBMc5a2VEPX2ZYeVZmuP5E8+9YczCmJxbAhA2ynyyJZyv
	Sv4fz/yTNd1p/mTfsVvYyiReel1YPlaeZQY0akQivbkumiEqGTw5ye5R/jx+KXst
	Al88h2GKqBN5Uqsk8CCwnS9cnhud0rVm4LnA/6psz1d//ZNeRSPx460KKbmu3YU4
	r7x85vCMgoMKnm9tTUTdlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756920668; x=
	1757007068; bh=og+IC19JqfXradgQ2Q3tRC+R5U+0xPVyYVp/r/aEtrw=; b=a
	uTVFjRQ9oWQGoK1zjU20EgjhdDRFnbVKO6xiGDJrYVC+pcIVrszw6Z/t6f8ZuIxb
	CVWiY78jgo3AYoByIxyjL/LSknitbUOzl4pldhYZosjuWbwGyRpwzqmcadRzW8wR
	16k9zTS+uqQkE7N1eVjhcThh0GE5nS6FInHfHU7OJpShPj7sdQoHFztY6MgB07lJ
	xSzURuE+xvdkmxnfP7fUUIddtzZHury45Z9aiDRpSOOfcrBdN1w46XCLgajOXucK
	DgExzzkSt/TYAk/pXgp+Tk1YYxn4I3NuEjvPouSQg8N5F4sOhYpiTdPrlK2bQFae
	g38XnW5+EOwMGvSiY/LcQ==
X-ME-Sender: <xms:XHu4aH22E2z7-ls-M92JAkqBQG9y8oNKauilznAem5KdnG-yOifEQw>
    <xme:XHu4aAgPLiX4TftFuHPTmhWqAFoe5AmJmVDdtBa5SE4frcWEMqS6wyjfhXwbC9bjk
    F3-Nrqast0c9Lb2Iw>
X-ME-Received: <xmr:XHu4aPYU6FP7sTCz4qJ9scdrOv0ZmOvUqI7gJUVkO4ZlCSa5v8K6fpDrrV23jmpSnLQ7Dqlo7qJzuYDTslytCJ3ZYlyz9mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjfgestheksfdttderjeenucfhrhhomheplfgrnhcurfgr
    lhhushcuoehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpedugeehgfffkeefgfetfeekjeeigeduvdetlefhgfevleelhfevgffgffejvdehueen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehroh
    gshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhlrghushdrkhhuughivghlkhgr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhise
    gsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhi
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:XHu4aEUSXmA7hynjXXDY0ZDgZ0tuBqj_vvU8RSkCvlURdxct25OeVg>
    <xmx:XHu4aPFkgZ8Oubo315C-zCc7Nrx_Vx_mjLADrLPmrp6jjNo2takwOg>
    <xmx:XHu4aGaL3s_QfcF1g5hV0MBc6fL-3TCvekETfsSdpGkiCBQ4CpD9rw>
    <xmx:XHu4aGFKsXZqR45dizJQo9hA0C0rJrO6JHjNESZ7xIpMhFNZLzPwDA>
    <xmx:XHu4aMxHfLzRZNGn13YAKYs4-6ZuZmW0Se1kxaHZ1kzG3HeTalkKolLx>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:31:07 -0400 (EDT)
Date: Wed, 3 Sep 2025 19:31:06 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range()
 iterator
Message-ID: <soia4lq57jd65u3rzrjbnpcqknd3gifptz4ysem46qodp6zbsb@ha44wvvdvkl2>
References: <20250902151543.147439-1-klaus.kudielka@gmail.com>
 <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
 <CAL_JsqLo8WbHMtjdbsauncusFh--OkNWXcN_pkpPxxT8xAmBNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLo8WbHMtjdbsauncusFh--OkNWXcN_pkpPxxT8xAmBNA@mail.gmail.com>
User-Agent: NeoMutt/20250510

On 03.09.2025 10:29, Rob Herring wrote:
> On Wed, Sep 3, 2025 at 7:44 AM Jan Palus <jpalus@fastmail.com> wrote:
> >
> > On 02.09.2025 17:13, Klaus Kudielka wrote:
> > > The blamed commit simplifies code, by using the for_each_of_range()
> > > iterator. But it results in no pci devices being detected anymore on
> > > Turris Omnia (and probably other mvebu targets).
> > >
> > > Analysis:
> > >
> > > To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
> > > which resolves to of_bus_pci_get_flags(). That function already returns an
> > > IORESOURCE bit field, and NOT the original flags from the "ranges"
> > > resource.
> > >
> > > Then mvebu_get_tgt_attr() attempts the very same conversion again.
> > > But this is a misinterpretation of range.flags.
> > >
> > > Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
> > > to restore the intended behavior.
> > >
> > > Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> > > Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
> > > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> > > Reported-by: Jan Palus <jpalus@fastmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 14 ++------------
> > >  1 file changed, 2 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > index 755651f338..4e2e1fa197 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -1168,9 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > >       return devm_ioremap_resource(&pdev->dev, &port->regs);
> > >  }
> > >
> > > -#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> > > -#define    DT_TYPE_IO                 0x1
> > > -#define    DT_TYPE_MEM32              0x2
> > >  #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
> > >  #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
> > >
> > > @@ -1189,17 +1186,10 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
> > >               return -EINVAL;
> > >
> > >       for_each_of_range(&parser, &range) {
> > > -             unsigned long rtype;
> > >               u32 slot = upper_32_bits(range.bus_addr);
> > >
> > > -             if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
> > > -                     rtype = IORESOURCE_IO;
> > > -             else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
> > > -                     rtype = IORESOURCE_MEM;
> > > -             else
> > > -                     continue;
> > > -
> > > -             if (slot == PCI_SLOT(devfn) && type == rtype) {
> > > +             if (slot == PCI_SLOT(devfn) &&
> > > +                 type == (range.flags & IORESOURCE_TYPE_BITS)) {
> > >                       *tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
> > >                       *attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
> >
> > Thanks for the patch Klaus! While it does improve situation we're not
> > quite there yet. It appears that what used to be stored in `cpuaddr` var
> > is also very different from `range.cpu_addr` value so the results
> > in both `*tgt` and `*attr` are both wrong.
> >
> > Previously `cpuaddr` had a value like ie 0x8e8000000000000 or
> > 0x4d0000000000000. Now `range.cpu_addr` is always 0xffffffffffffffff.
> > Luckily what used to be stored in `cpuaddr`:
> 
> ~0 is OF_BAD_ADDR which means we couldn't translate the address. Seems
> it is not needed here, but it should work. Can you define DEBUG in
> drivers/of/address.c and post the log?

All of OF: entries from pci initialization (with explicit marks where
mvebu_get_tgt_attr() enters and exits):

mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00080000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000080000
OF: parent translation for: f1000000
OF: with offset: 80000
OF: one level translation: f1080000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d0000000000000
OF: default map, cp=919000000000000, s=10000, da=4d0000000000000
OF: default map, cp=915000000000000, s=10000, da=4d0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d0000000000000
OF: not found !
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d0000000000000
OF: default map, cp=919000000000000, s=10000, da=4d0000000000000
OF: default map, cp=915000000000000, s=10000, da=4d0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04b80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4b8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4b8000000000000
OF: default map, cp=919000000000000, s=10000, da=4b8000000000000
OF: default map, cp=915000000000000, s=10000, da=4b8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4b8000000000000
OF: not found !
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04b80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4b8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4b8000000000000
OF: default map, cp=919000000000000, s=10000, da=4b8000000000000
OF: default map, cp=915000000000000, s=10000, da=4b8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4b8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04b00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4b0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4b0000000000000
OF: default map, cp=919000000000000, s=10000, da=4b0000000000000
OF: default map, cp=915000000000000, s=10000, da=4b0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4b0000000000000
OF: not found !
mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04b00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4b0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4b0000000000000
OF: default map, cp=919000000000000, s=10000, da=4b0000000000000
OF: default map, cp=915000000000000, s=10000, da=4b0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4b0000000000000
OF: not found !
mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000

mvebu_get_tgt_attr() start

OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00080000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000080000
OF: parent translation for: f1000000
OF: with offset: 80000
OF: one level translation: f1080000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !

mvebu_get_tgt_attr() end

mvebu_get_tgt_attr() start

OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00080000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000080000
OF: parent translation for: f1000000
OF: with offset: 80000
OF: one level translation: f1080000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !

mvebu_get_tgt_attr() end

mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W

mvebu_get_tgt_attr() start

OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00080000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000080000
OF: parent translation for: f1000000
OF: with offset: 80000
OF: one level translation: f1080000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d0000000000000
OF: default map, cp=919000000000000, s=10000, da=4d0000000000000
OF: default map, cp=915000000000000, s=10000, da=4d0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d0000000000000
OF: not found !

mvebu_get_tgt_attr() end

mvebu_get_tgt_attr() start

OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00080000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000080000
OF: parent translation for: f1000000
OF: with offset: 80000
OF: one level translation: f1080000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: f0010000 00048000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000048000
OF: parent translation for: f1000000
OF: with offset: 48000
OF: one level translation: f1048000
OF: reached root node
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e8000000000000
OF: default map, cp=919000000000000, s=10000, da=8e8000000000000
OF: default map, cp=915000000000000, s=10000, da=8e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 08e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=8e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=8e0000000000000
OF: default map, cp=919000000000000, s=10000, da=8e0000000000000
OF: default map, cp=915000000000000, s=10000, da=8e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=8e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e8000000000000
OF: default map, cp=919000000000000, s=10000, da=4e8000000000000
OF: default map, cp=915000000000000, s=10000, da=4e8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04e00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4e0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4e0000000000000
OF: default map, cp=919000000000000, s=10000, da=4e0000000000000
OF: default map, cp=915000000000000, s=10000, da=4e0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4e0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d8000000000000
OF: default map, cp=919000000000000, s=10000, da=4d8000000000000
OF: default map, cp=915000000000000, s=10000, da=4d8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d8000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d0000000000000
OF: default map, cp=919000000000000, s=10000, da=4d0000000000000
OF: default map, cp=915000000000000, s=10000, da=4d0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04d00000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4d0000000000000
OF: default map, cp=11d000000000000, s=100000, da=4d0000000000000
OF: default map, cp=919000000000000, s=10000, da=4d0000000000000
OF: default map, cp=915000000000000, s=10000, da=4d0000000000000
OF: default map, cp=c04000000000000, s=100000, da=4d0000000000000
OF: not found !
OF: ** translation for device /soc/pcie **
OF: bus is default (na=2, ns=1) on /soc
OF: translating address: 04b80000 00000000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=4b8000000000000
OF: default map, cp=11d000000000000, s=100000, da=4b8000000000000
OF: default map, cp=919000000000000, s=10000, da=4b8000000000000
OF: default map, cp=915000000000000, s=10000, da=4b8000000000000
OF: default map, cp=c04000000000000, s=100000, da=4b8000000000000
OF: not found !

mvebu_get_tgt_attr() end

mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
OF: ** translation for device /soc/pcie/pcie@2,0 **
OF: bus is pci (na=3, ns=2) on /soc/pcie
OF: translating address: 82001000 00000000 00040000
OF: parent bus is default (na=2, ns=1) on /soc
OF: walking ranges...
OF: default map, cp=80000, s=2000, da=40000
OF: default map, cp=40000, s=2000, da=40000
OF: parent translation for: f0010000 00040000
OF: with offset: 0
OF: one level translation: f0010000 00040000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000040000
OF: parent translation for: f1000000
OF: with offset: 40000
OF: one level translation: f1040000
OF: reached root node
OF: ** translation for device /soc/pcie/pcie@3,0 **
OF: bus is pci (na=3, ns=2) on /soc/pcie
OF: translating address: 82001800 00000000 00044000
OF: parent bus is default (na=2, ns=1) on /soc
OF: walking ranges...
OF: default map, cp=80000, s=2000, da=44000
OF: default map, cp=40000, s=2000, da=44000
OF: default map, cp=44000, s=2000, da=44000
OF: parent translation for: f0010000 00044000
OF: with offset: 0
OF: one level translation: f0010000 00044000
OF: parent bus is default (na=1, ns=1) on 
OF: walking ranges...
OF: default map, cp=f001000000000000, s=100000, da=f001000000044000
OF: parent translation for: f1000000
OF: with offset: 44000
OF: one level translation: f1044000
OF: reached root node
mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00


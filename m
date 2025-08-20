Return-Path: <linux-pci+bounces-34408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275CB2E5DC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 21:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82ED47ABDF3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB026A09F;
	Wed, 20 Aug 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kjPOP8Ub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4Wf1KAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27A261B8F
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719490; cv=none; b=lMzCUx5P+CjFE0txMz8T2WSQS+ayTOe2JR1MxL/LLCQSMVPsVBqZcPMUlKCiY5My6xxzxz6/DbwGWbLELmIZA+lC9Y6B4sUVEmSBKy2iXmwqOdwGT39BLghQ2+ndQVsZqzW1Jx+3XxQqm0dBeNKKAtQimzU1cO0bF6kyHXb9cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719490; c=relaxed/simple;
	bh=nq17Mi3gnCm7mQmUzGVkUPovbYWlvCuOMjB77luuMZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw9a7jYujKF5vbbUiWfAN8hHYtZ/qqqOoRqXeMMMtJgv1fvRImOKmzCM9pfN1/TdOFDcxRnvhA8xiemHqqLi5MlxrMwPTAVsmOshcA2FXIhb8O9UJCcWPR4GuA6EbKmX3o4erIPgjNSvwD/TRTd1OdfX1zDI8dmmoOoP6ydNpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kjPOP8Ub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4Wf1KAv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B68A21D0010E;
	Wed, 20 Aug 2025 15:51:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 15:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755719486; x=1755805886; bh=tMts4sHesj
	6GSNDqFnt9UYF3UMEWpW38HDAZR306TOw=; b=kjPOP8UbesEeV4E9Bf0H+UGgd0
	n7v8oKJJqo3KK4F8JpFElNj7cZKg6L2Je1DTqqTeyMl/oAnDsqd+h1Xhe/C/tvGo
	FHEWXRiCJ/8N24wfVMJiEUrnZPkjhOvvdCgwNyoa2LIrbxb2pNfdeuWtIJIwIEHB
	lnZ9M3oQ7RZwwwnzM+QaYtYH1AXAJdo1HvAN7eQk9CpFsmp+TKWkFS9fw5La1bZs
	zqs0mr0yE9Sl7x9BzTOzkkM0VNI0uEMYj84kA7BwDwNfHr7mYYgeLIw+tcfiMwXi
	19g2FAtiTCQphSbDtKF6M/rNJMqx9R+VMb0HrCPBHa7UpSdZIpV0YcN3wCdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755719486; x=1755805886; bh=tMts4sHesj6GSNDqFnt9UYF3UMEWpW38HDA
	ZR306TOw=; b=g4Wf1KAvYTtaqjgSeraif43qBXAKjmfRoGJ+udkf4iYhm6wkxvA
	iI0m4WV5gbinkQ5oceT6e0QLZhqO6ofFkgTbhi70K5m6ce2yHcw8Ovc1sYiMfQY/
	nixXEWedAbpL44o0zvq4zo4AcfUUJQsI+m50NDuGlsVmTgrzRgJuMgDnVC0EoFfU
	wtQuUqx/BorRSVJ8CF+AHxp+fdF6L7ay3UIH5x93oY/QixFDuiiGjDLiE5iN0lOZ
	MADmmG6Bwj82eKf8vWeKhbdBeBVdRTfYnRDGBDpzja1SLe2GTTYf7ekmr/FRpT91
	2wrWk/iE27RWkjdWoX05TdGpkiqctatEtsg==
X-ME-Sender: <xms:PSemaC-Z_Ot9YL8AZ4NAAz-XvKLeXHhIEogovBWPDppsi8yuync5Og>
    <xme:PSemaKXOW9np-5mjAqheo_UIFPoX1-bftkuf_vD4_fvCLlcoQOczkro2_1AYBlhxy
    foxkpt2x3qHnvg94Q>
X-ME-Received: <xmr:PSemaFo1RCyHfgzv0eKVsMZ14h86Pf7qYBp6KaQYtc-gSumwfNPrEiaIl_JypNpPx0nX69W_HN1QpjWIuPLlXDFZXoOYcot32A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PiemaElRfu-BcsJ0sxUnmx_oXPHzQSqQovn8mLuFh4dhy2yUEVf4tg>
    <xmx:PiemaN1PBSiMAjm1Izwx7xoExp9Mfr9VUBouGJkrPfrxXv8L2pbArw>
    <xmx:PiemaJQd_j2n5XhRbawqICRUkD_thjD75MMIhOUgdIBCxRRCQbDrqg>
    <xmx:PiemaOyN7TByDAfNlCCe2uI6KRZBPC7kYJDOULOtC5Tb7fnfyG2t-Q>
    <xmx:PiemaIpVMdy6B-o6NKnUnrUG6DjHcN2lvGDoCDHCaOMmLJLYvyhc0UvK>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 15:51:25 -0400 (EDT)
Date: Wed, 20 Aug 2025 21:51:24 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <lxel4w2rpv5viwdv22sx72qyjvyircukzm5dkrxntrevighrav@zjsnisjum4us>
References: <gn4sih6yrohqn35jc3hesxpgqhodtvq44ad7a6tbmknjywowvk@p2y24kjlnprd>
 <20250820193055.GA636030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820193055.GA636030@bhelgaas>
User-Agent: NeoMutt/20250510

On 20.08.2025 14:30, Bjorn Helgaas wrote:
> On Wed, Aug 20, 2025 at 09:08:33PM +0200, Jan Palus wrote:
> > On 20.08.2025 13:46, Bjorn Helgaas wrote:
> > > [+cc maintainers, regressions list]
> > > 
> > > Jan, thanks very much for the report and the bisection.  Could you
> > > attach the devicetree you're using to the bugzilla?
> > 
> > I guess I could dump it from running system if you'd like me to, but it's
> > an upstream one without any customizations.
> 
> It's just easier if we know exactly what you're using.  I'm not an
> mvebu user and can't guess.
> 

Just to make it clear, as stated in summary, issue concerns Turris Omnia
device for which following dts is applicable:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts?h=v6.16

> > > On Wed, Aug 20, 2025 at 05:43:39PM +0000, bugzilla-daemon@kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=220479
> > > > 
> > > >            Summary: [regression 6.16] mvebu: no pci devices detected on
> > > >                     turris omnia
> > > >           Reporter: jpalus@fastmail.com
> > > > 
> > > > Booting kernel 6.16 results in no PCI devices being detected (output of `lspci`
> > > > is completely empty). Bisected to:
> > > > 
> > > > 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 is the first new commit
> > > > commit 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 (HEAD)
> > > > Author: Rob Herring (Arm) <robh@kernel.org>
> > > > Date:   Thu Nov 7 16:32:55 2024
> > > > 
> > > >     PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
> > > > 
> > > >     The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> > > >     but it's still just normal "ranges" as far as parsing is concerned.
> > > >     Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> > > >     instead of open coding the parsing.
> > > > 
> > > >     Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > >     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >     Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >     Link: https://patch.msgid.link/20241107153255.2740610-1-robh@kernel.org
> > > > 
> > > >  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
> > > >  1 file changed, 9 insertions(+), 17 deletions(-)
> > > > 
> > > > 
> > > > kernel 6.16 logs following mesages related to PCI:
> > > > 
> > > > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > > > mvebu-pcie soc:pcie: pcie0.0: cannot get tgt/attr for mem window
> > > > mvebu-pcie soc:pcie: pcie1.0: cannot get tgt/attr for mem window
> > > > mvebu-pcie soc:pcie: pcie2.0: cannot get tgt/attr for mem window
> > > > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > > > pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > > > [0x00080000-0x00081fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > > > [0x00040000-0x00041fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > > > [0x00044000-0x00045fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > > > [0x00048000-0x00049fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > > > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > > > PCI: bus0: Fast back to back transfers enabled
> > > > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > > > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > > > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > > > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > > > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > > > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > > > 
> > > > 
> > > > while kernel 6.15 logs following:
> > > > 
> > > > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > > > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > > > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > > > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > > > mvebu-pcie soc:pcie: pcie0.0: Slot power limit 10.0W
> > > > mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W
> > > > mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
> > > > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > > > pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > > > [0x00080000-0x00081fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > > > [0x00040000-0x00041fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > > > [0x00044000-0x00045fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > > > [0x00048000-0x00049fff])
> > > > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > > > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > > > pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > > > pci 0000:00:01.0: PCI bridge to [bus 00]
> > > > pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > > > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > > > /soc/pcie/pcie@1,0: Fixed dependency cycle(s) with
> > > > /soc/pcie/pcie@1,0/interrupt-controller
> > > > pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > > > pci 0000:00:02.0: PCI bridge to [bus 00]
> > > > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > > > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > > > /soc/pcie/pcie@2,0: Fixed dependency cycle(s) with
> > > > /soc/pcie/pcie@2,0/interrupt-controller
> > > > pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > > > pci 0000:00:03.0: PCI bridge to [bus 00]
> > > > pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> > > > pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> > > > /soc/pcie/pcie@3,0: Fixed dependency cycle(s) with
> > > > /soc/pcie/pcie@3,0/interrupt-controller
> > > > PCI: bus0: Fast back to back transfers disabled
> > > > pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > > pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > > pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > > PCI: bus1: Fast back to back transfers enabled
> > > > pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > > > pci 0000:02:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
> > > > pci 0000:02:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> > > > pci 0000:02:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > > > pci 0000:02:00.0: supports D1
> > > > pci 0000:02:00.0: PME# supported from D0 D1 D3hot
> > > > pci 0000:00:02.0: ASPM: current common clock configuration is inconsistent,
> > > > reconfiguring
> > > > pci 0000:00:02.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > > > pci 0000:00:02.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > > > PCI: bus2: Fast back to back transfers disabled
> > > > pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > > > pci 0000:03:00.0: [168c:0033] type 00 class 0x028000 PCIe Endpoint
> > > > pci 0000:03:00.0: BAR 0 [mem 0x00000000-0x0001ffff 64bit]
> > > > pci 0000:03:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > > > pci 0000:03:00.0: supports D1
> > > > pci 0000:03:00.0: PME# supported from D0 D1 D3hot
> > > > pci 0000:00:03.0: ASPM: current common clock configuration is inconsistent,
> > > > reconfiguring
> > > > pci 0000:00:03.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > > > pci 0000:00:03.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > > > PCI: bus3: Fast back to back transfers disabled
> > > > pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > > > pci 0000:00:02.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]
> > > > add_size 200000 add_align 200000
> > > > pci 0000:00:02.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> > > > pci 0000:00:03.0: bridge window [mem 0xe0400000-0xe04fffff]: assigned
> > > > pci 0000:00:01.0: PCI bridge to [bus 01]
> > > > pci 0000:02:00.0: BAR 0 [mem 0xe0000000-0xe01fffff 64bit]: assigned
> > > > pci 0000:02:00.0: ROM [mem 0xe0200000-0xe020ffff pref]: assigned
> > > > pci 0000:00:02.0: PCI bridge to [bus 02]
> > > > pci 0000:00:02.0:   bridge window [mem 0xe0000000-0xe03fffff]
> > > > pci 0000:03:00.0: BAR 0 [mem 0xe0400000-0xe041ffff 64bit]: assigned
> > > > pci 0000:03:00.0: ROM [mem 0xe0420000-0xe042ffff pref]: assigned
> > > > pci 0000:00:03.0: PCI bridge to [bus 03]
> > > > pci 0000:00:03.0:   bridge window [mem 0xe0400000-0xe04fffff]
> > > > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > > > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > > > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > > > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > > > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > > > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > > > pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe03fffff]
> > > > pci_bus 0000:03: resource 1 [mem 0xe0400000-0xe04fffff]
> > > > pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> > > > pcieport 0000:00:03.0: enabling device (0140 -> 0142)
> > > 
> > > #regzbot introduced: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")


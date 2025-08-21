Return-Path: <linux-pci+bounces-34421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A1AB2E98F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 02:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105D05C69E7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1B1B2186;
	Thu, 21 Aug 2025 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gF/oaxrl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEou+RDA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500261917F0
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737144; cv=none; b=DB0qgfZtea6VM2StzmZ2L0Xcq9P1GDGdb+7wz0qAvY8tudmwnHBXZfA97Pf4rirLyUzsRQx7z3ocsqk2yOYuTis3WgSV5T1OkLAtkf6knrr6rBxYI9AMssQedkOLVf/lYTECjLUeX3YWgWfKQ3XtIwVIeV8e47b/c7SKzkXIpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737144; c=relaxed/simple;
	bh=mnstocKDCeVi+H3xByOC+hKB8CitGI7aG7Tgk3HZf0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sofNfrTItIBs7UQe2/JNlCJqx/xUg3kbxE0vqBAUvvymezr1XR9uqeoSkxY5BoG+DKhjBNEspYl5ge+FaRrJS33vT5lMIabFKqAdznawYCi450Z0QZRqN7skHAUITz9lo9ZlIJftSybvbxMDacGgmb8CF9FKNZg0tVArZhi4Xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gF/oaxrl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEou+RDA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DFF47A01FC;
	Wed, 20 Aug 2025 20:45:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 20 Aug 2025 20:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755737141; x=1755823541; bh=V4z2GbfINs
	2UhJLpqAZOyM0KnzFNihvHqwe1pBBOS1Q=; b=gF/oaxrlFBKDxWKhSXy/fjXCyX
	Pbz6dc68JU9fO0Ky4e+WIDMhzZmXg3ryD8j8JQaNr3qQJog5HsmXkFmX0S3ICn1N
	UIvlo3W2LXPaNEAvFboS7PgcFt5ukwpxzPhYMhKDuCn2JucpHCmKRMKf5W+wvyuu
	EPXF8v1wumc7V+nG9pzP68zsVommm3PuPborAXOb++VGun4UT0i1qwnuNRQbLOgx
	4tNfQVZ9fh6B+uZW+Hl9x/Kf77ckoUbvBSvts85WwzFZNBUGTrHV+sBkZO6ZyVB/
	ZVIKl1UEHhJmKg5wqhzHEod8Ii0WNC1W8Xg3aQOskVUlWb68Ii6uXYMOL2bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755737141; x=1755823541; bh=V4z2GbfINs2UhJLpqAZOyM0KnzFNihvHqwe
	1pBBOS1Q=; b=eEou+RDAvHsBX68iB/YD6EJGexfxC4podEwvnz1u5U2e9COX/LO
	vlg6izadNEpUPZczxGKIuJtfEeU6FVuY+I77mGDz3xABgkY2/KWo5C3kj7PxQytX
	oyfE8LVEU3Qn4roOWuvbREHnYZB7XMXCi2hFxiwN+f7OF7emmYrOJ0RxBRMwQmno
	FshFRk4R+g46dgZ00X5z49WbCXHQC/YHrO5+uy+PI2XAuClwzRd4HMR+6UqsfM0y
	1JID5Zjc5IAfXy0y0X9JIyL89gWmVd3qEvt1Y8bZjHHmSfCZh5+VIKHldqM331bx
	nFBjPhMBMvpWF659+FU6gQLJr3Gp4q5SFdg==
X-ME-Sender: <xms:NGymaOxut4arym5ta3gDsnRwMqL3vqtCGfJqQjFatAlnv3jx4EdO8w>
    <xme:NGymaB6eLIcHsE8h7_kOLh82F9urhwRCxFyVu5C9AmsLqATMU_tdMIf8C7ToN3-Gl
    7MF-duZvMv2czHnSQ>
X-ME-Received: <xmr:NGymaN9BH_owiPjlM2jE4g6fD1A-VSewo2GfIbmgVIpncleT9OlWIiCKvGa6Je8eO5BdYYTLanRZW5tPhgcEHS8G3IxGxqxSPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujggfsehttdfstddtreejnecuhfhrohhmpeflrghnucfr
    rghluhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepudeviefhueeuudekfeeuiedvffegieefvdejgfetffeivdejueevheegheffteej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinhhknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghl
    ghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgrii
    iiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprghliheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsth
    hsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:NGymaOojnkNoOcFCpzGvwtiU3eo2A4ftyeayuiXeeef13oR0prCK3w>
    <xmx:NGymaGqkOltrFwoOb33orQmKHqsm-Vs4zmGSBcdkwme_VbWnnhaUQg>
    <xmx:NGymaJ3LpS0dgAlXbEShPl_C4tWzV4OEwbFxvfoVTy2Juk7yMtH7Hw>
    <xmx:NGymaMG9-h8GF3DDDXPGzrMKxkKmgWYbTm9xhdKl4iyXsBBu1EY3Dg>
    <xmx:NWymaCP87p4PUqKdQGi8zJNbk0IDdCj0m2c1WxAiKO-W1x1D87-uBTPo>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:45:40 -0400 (EDT)
Date: Thu, 21 Aug 2025 02:45:37 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <42rznc7krv3gdwmdzfz6o5nalnzleiwfg44yleqjet67cu4ijm@pwap3ph2n2u7>
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

Relevant fragment of mvebu_get_tgt_attr() in mentioned commit:

+		u32 slot = upper_32_bits(range.bus_addr);
 
-		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
+		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
 			rtype = IORESOURCE_IO;
-		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
+		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
 			rtype = IORESOURCE_MEM;
 		else
 			continue;
 
 		if (slot == PCI_SLOT(devfn) && type == rtype) {

mvebu_get_tgt_attr() gets called with type (either 512 or 256) and slot
(1, 2 or 3), after this commit last condition is never met though --
slot is fine but rtype never is.

What appears to be very much different are values of previous 'flags'
and current 'range.flags'. Judging by the code they should still carry
same values but in practice

before: flags=2181038080 end up with rtype=512 (match)
after: range.flags=512 results in no rtype (no match)

before: flags=2164260864 end up with rtype=256 (match)
after: range.flags=256 results in no rtype (no match)

as if now range.flags already represented rtype directly. If I use it
like this situation improves, bridge gets detected, although whole device
reboots without any error on first probe from card driver. Something
that I've noticed during bisect but seems to be an independent
regression.

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


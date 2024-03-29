Return-Path: <linux-pci+bounces-5372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15663891510
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379EC1C22315
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3347540873;
	Fri, 29 Mar 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EVPV/Z53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGtfgx4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD43C48E;
	Fri, 29 Mar 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699947; cv=none; b=bFvmC0xpQsziG16TKU5tXDYe/QO5f4cKXGShXmWTIPNQAwEPxvrTEGdMEDGiIx4H5hR4k8t5NVE4XX2CnuVePGxiOn9GOw3FM+bQDIsRIRBE539vhWn25kAJFEEPqN6WhDyYSumgj3FGaPZfhEGIjHsnvDeVI8DL1cQ0SvBfPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699947; c=relaxed/simple;
	bh=AEr6bvfD1unwFN0oTJYOowoZ4RMyeLvP/2PldxJO5qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWWho8NlfgwBJN1CO6REuc9TVLvmMXlSQ/gAZD0mx7SDrtr1uS2I00OHLAikbbg2P+5zsxgG6smQv1+VqR3sd/JHsJ1HWta2g151tC/HFwC1aCitlgESsEIWQFZEjrOLzcSw7pzDI146CZDFZrkhYDCdIoBqw4RmunfVtS82chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EVPV/Z53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGtfgx4v; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 04C0D1C00096;
	Fri, 29 Mar 2024 04:12:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 29 Mar 2024 04:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711699943; x=
	1711786343; bh=mGbMxmuqKfJn9+1lZlv1xn4BUNJLFRwqYHpGktJGTm8=; b=E
	VPV/Z536MxDpTAti5+98oth5eMCqlrinUYmoD0OdGzeCIqXTY/6GuYTPedMGQ/5R
	CBYi/MLCBMQG8EdPogPTv24EWVhaS4W5Y9sje9GI6pedd+kSPop3jU8pzM4yHTh+
	yBce4R6oycxD9VKOsg0/f8OKKyCsygt2qd6u/bMSBR8qqQ1EzvsRvPru03isvKbX
	7GtUHIFZuMCqEsRfBfP6jRVLorOFoq4DxKTBVfJIXRWHXu0xwO3V2JoUK/n+MswI
	d0xpwSs/UtvIMLtd6ai8Z2H4Hsc6FHRCFjIEbBThw7xe03JCvDiHzLuErFcGr+pc
	dRBO3+jNgYZSzp1ShBlBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711699943; x=1711786343; bh=mGbMxmuqKfJn9+1lZlv1xn4BUNJL
	FRwqYHpGktJGTm8=; b=OGtfgx4vnb3U/h0pe89Dd8vyXHLUhdEj9iRfF4Xa2CNi
	8rmK8ecLmWZjLZr7kn+r23oR6Yysu3w0vIp9ytL/Vyz2luA0mj8B5HQg1XpFVK0J
	sXqHi4Bcodnz577N41DNJPZHq6rq/tUrwMgcc1tiNs1fth+qHhFJFZ5pTU/3Q0eo
	QH8E7LRfXeGhTKbkZsgLcsWRJEPa+DZMlJ7lCcYkIjOXjelhaJsWp2tLN0zUq5SU
	l1aC+TbE1NZ60t+Ws/rC9NKPdrRVQAQPEAE9IVhYs+CSjnpNpLkKIlcvYY8t6iyI
	Tvv5iYykbF9yXdoR/zHgYe3rOJDvGmIWOQ+W0P0d1A==
X-ME-Sender: <xms:5ncGZq1DUULsxdDhEWlcS-0neOxHxeTUe55yBLD4hvOAcSUisVulEA>
    <xme:5ncGZtFa2fCYYNYQZdAdtjAA6UXN5iPX-bCIJKK9m3XLxpLyWXq-qXHxSJN8YIcYb
    wci6oUFJttAja_ahKY>
X-ME-Received: <xmr:5ncGZi7JL8J3xLcV3VPGUBAlJ-xVJC-XTdlFM5kTh7uobClUx7AHV3Vg6NsyL4GJOBwh1qcJEvgCdpIR65poXjNBadK4ue14jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5ncGZr1oYzySfu_4WhI9hmzcV_1hbgnq8g6XCq5p5jk9_0yw7BmwKg>
    <xmx:5ncGZtEq7bb6fKTmBBifN6as-DtxmqfM8tdU9XYHMsfaJFzsm3zi1A>
    <xmx:5ncGZk-dBS-7_NTCiEAWymagpFm-NM3Inlic0oaoagf6Jk7HMcNx0w>
    <xmx:5ncGZimGKgpLnZLdkGMZkAtXVqgnpPp7NjquYyrP30dmWDiw4_iOxw>
    <xmx:53cGZjZZO05cvod-of-X52Sujh3pBa2sU2WASYE21WgVDbTw0u9myQ5_rUs>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 04:12:21 -0400 (EDT)
Date: Fri, 29 Mar 2024 17:12:19 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240329081219.GC231329@workstation.local>
Mail-Followup-To: Lukas Wunner <lukas@wunner.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
References: <20240326131858.GA140624@workstation.local>
 <20240327150119.GA1502858@bhelgaas>
 <20240328144201.510f6d5e.alex.williamson@redhat.com>
 <ZgZGbMj0I3_6Rt0f@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgZGbMj0I3_6Rt0f@wunner.de>

Hi Lukas,

On Fri, Mar 29, 2024 at 05:41:16AM +0100, Lukas Wunner wrote:
> On Thu, Mar 28, 2024 at 02:42:01PM -0600, Alex Williamson wrote:
> > On Wed, 27 Mar 2024 10:01:19 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:
> > The original patch proposed for this gave me the impression that this
> > was a device used on various old Mac systems, not likely applicable to
> > a general purpose plug-in card.
> 
> I'm still using one of those "old Mac systems" as my daily driver.
> 
> Just checked the ACPI tables and there's an FPEN method below the
> FRWR device which toggles GPIO 48 on the PCH.  Checked the schematics
> as well and GPIO 48 is marked FW_PWR_EN.  The GPIO controls load
> switches which cut power to the FW643 chip when nothing is connected.
> 
> Also, FW_PWR_EN feeds into an SLG4AP016V chip where it seems to
> internally gate FW_CLKREQ_L.
> 
> I'm guessing the driver may need to call the FPEN ACPI method after
> issuing a SBR to force the chip on (or perhaps first off, then on)
> and thereby re-enable Clock Request.
> 
> It's a pity the ohci.c driver doesn't seem to support runtime PM.
> That would allow cutting power to the chip when nothing is connected
> and thus increase battery life.  The ACPI tables indicate that the
> platform sends a notification when something is plugged in, so all
> the necessary ingredients are there but we're not taking advantage
> of them.
> 
> Thanks,
> 
> Lukas

Yup. In both PCI drivers and unit drivers belonging to Linux FireWire
subsystem, any type of runtime PM is not supported. If I integrate 1394
OHCI driver, I should implement all of the above in any callback of
runtime PM, or the part of the above is already supported by any driver
in parent PCI layer?


Thanks

Takashi Sakamoto


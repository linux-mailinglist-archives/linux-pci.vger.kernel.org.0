Return-Path: <linux-pci+bounces-43025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AACBBFAB
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727A930084EC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344217A309;
	Sun, 14 Dec 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="UF3H1IhN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1csiyUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8454774;
	Sun, 14 Dec 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765741932; cv=none; b=ONvUEgONHB2ydfHgI2XdUfxfyEsCW8gkCo7+8ZzFSorFPxfqPGknqV01h5iZLGErue8k4v47gMSkPd3GzwXjpmR19WSmYePkQx1i+lqOi7eAhvQpSoiZ3TDtfJSIE3tmvidB4E5jQSa6LhqqO98KHdi3HMPiLttGLVrBxagbTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765741932; c=relaxed/simple;
	bh=hB2hwQTKlbOnhqIGnezlK16WaHQ1KobuZL1Y6AFV9as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs40+/7l4vztKvwoUTX1enLE/XmugTD5Ij+MbEDmgerMT2JQPWhNS0fy/tjMrR7399j9E16BJuUNScMleo6QRZpKiSSkBzSvGgXo1vOg0Qf0xhU5FFmiGusDJoOGeLxBIULa8WdGsDAE5fUFLwmlcX1KqBxvqaJIcJ73pUPeEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=UF3H1IhN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1csiyUU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F5C37A0076;
	Sun, 14 Dec 2025 14:52:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 14 Dec 2025 14:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765741927;
	 x=1765828327; bh=NKa5J0duOKar7LOvOC2+7itthEmm9tHPOZmW81a7/PI=; b=
	UF3H1IhN2QS0nkJ2Mq6q39+iTnGA0QrSC0nwyfDOWpuvUUhKs1tQUYuMmON4GJuV
	v0Vz6TgitAYnUaE0zakLqW0+4r6PQWG2eSWfkKVHXQdtdxjUK05iA0ucDPMs1fsN
	zejZGHOMj9JDKNstTaTsD3MSGry4gpEUPlE4vgjELELPE7c45wombQWiEijaKD8n
	D0hS71Nqa+ha4X8uhEGjNJdPG2LnhcNJNmOxChkl8DiIDlyGjlD47b/SuUH8IRse
	+ImCE9ZqYtwpnpW/mE8diywSbNnlyf6+feUzPjtZMA1VG7zsbujqyhkfRQIyxZFt
	ogfb5fAjtwtXbMPSwekCag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765741927; x=
	1765828327; bh=NKa5J0duOKar7LOvOC2+7itthEmm9tHPOZmW81a7/PI=; b=P
	1csiyUUEwsx5bPj98Z/IALI0TGJWrezdNOhYDD8YzA24EIMezWL/lNi5Ts+dtnfV
	MiHVVEZIgxJiFzi85XNlls4bzkrsK8K+fTQSw/4Olxa2GSvCn333Y19ZXElgU5bI
	sRlWuT+Tqdbksksr/Ww3G1CDVVjc6hw4PeLWTvfk3xR7RP4HMKVVY1sJHBlmAp02
	KwHQWVqYBdQa1PZPs1CRvSdvO9DJQWRStm1xbqFUnSzqHtympO+/v+QU+1JedYHg
	yz+sBU73YFxDdEHV9zeGralxNxOnqmwj+AULXmIIYEwKgmB/Bf3WMHq3e2HyEKQF
	z19ZuTzvvj3VrvEVDXhGQ==
X-ME-Sender: <xms:ZxU_aSJBN2RWqvkoj5P2lO58zc6sdAxn5C_0utFPoGyPFRlggy9NeQ>
    <xme:ZxU_aVmV-SWPQPbC-xWVMqWzsJNfyfzu-TaZxfnH0Yg_EZ2FuTEf_er212rJ1yzzt
    3cf_EiDWGwHOYu6ByLb26dBo1KkLb5aqVFbnLwdngjd1bdpkYoN>
X-ME-Received: <xmr:ZxU_aWOgacsWiFLQdnqkDu45XwlDyxmQKBt_pD8uVWrsWNA4FVbBQnhj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhggtgfgsehtjeertddttddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetteduleegkeeigedugeeluedvffegheeliedvtdefkedtkeekheffhedutefh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghjrgihghgrrhhgnhhsihhtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ZxU_ab0ig1ILvYHsyzRSyfHjTYl00ngrTT_8Bs_MztX8FVu8e27fjQ>
    <xmx:ZxU_aVkrWoKlSG9j_Ul695HVvfEJjXjFVtxxEJpsx4Z8MYUGmgxbvw>
    <xmx:ZxU_aSWVAy3TiTGOR7HLmms-HROMJUnWRy4qNfUxpa7XE3qWiXs6uQ>
    <xmx:ZxU_abt7tytqDWoRsj8-hYtyqUeuP232z8V-KkT24AX1QKYIq1Ckrw>
    <xmx:ZxU_aUTtrUPkIK0YkGa_At3uHGR3d-YFcpiWbMIysM-oboe2sS-24LVW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 14:52:06 -0500 (EST)
Date: Mon, 15 Dec 2025 04:52:03 +0900
From: Alex Williamson <alex@shazbot.org>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
Message-ID: <20251215045203.13d96d09.alex@shazbot.org>
In-Reply-To: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 17:38:50 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Hi everyone.
> 
> Let's assume x86_64-linux host and guest, with full-virtualization and
> iommu hardware capabilities.
> 
> Before launching vm, qemu with the help vfio "installs" "dev1" on the
> virtual-pci-root-complex of guest.
> After bootup, the guest does the usual enumeration, finds "dev1" on
> the pci-bus, and programs the BARs in its domain.
> 
> However, there is no guarantee that guest-pci-mmio-physical-ranges
> would be identical to "what would have been"
> host-pci-mmio-physical-ranges.
> Then how does the EPT/SLAT tables get set up for correct mapping from
> GPA => HPA for dev1's-BARs-MMIO-regions ?

The guest doesn't get to program the device physical BARs, nor does it
require identity mapping in the guest.  The BAR programming is
virtualized.  QEMU mmaps the BAR and that mmap is the backing for the
mapping into the guest.  Thanks,

Alex


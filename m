Return-Path: <linux-pci+bounces-13775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFDF98F4C7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C448BB20D46
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134F1A4F12;
	Thu,  3 Oct 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GKTxUv+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from gainsboro.ash.relay.mailchannels.net (gainsboro.ash.relay.mailchannels.net [23.83.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD519CC09
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975068; cv=pass; b=lOEKZxanHfyy7kGSC5gOVeai0ANvEApLMxayRrzYGpxMiRcX2IOdAtjq5fzr7Ge4Dt61nMgOcGKpZ81d+SHuL0cfd5Hvqiw4d5wAJRbPqRk/qmP6+aoxKIhMYfewsoLPz4Lat7L15ToGWK8yXPLxTIVcSVoPWcRoCz1xfQjBhzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975068; c=relaxed/simple;
	bh=m16cNYK2UqN9o5P5GfthShRwxn645OWMeYndoit53/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QprbC4mATaiAJc4+AbAAeMjXUyZh5kfRJrtp9hoWEYsXZSrQCAz7mJr8dGpo3XsfCsNv2BUF5jZUAE8tjUo4urtXQhVuGt7jUbf37Pt5yUXFLQAkwNukkOGaoOoiXqMsZti/nKH7delK8S5wLOPgSAivEAl0hv5nfltiSM0heZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GKTxUv+f; arc=pass smtp.client-ip=23.83.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7880B183EF7;
	Thu,  3 Oct 2024 17:04:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a295.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.96.86.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E20F1183CC9;
	Thu,  3 Oct 2024 17:04:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727975059; a=rsa-sha256;
	cv=none;
	b=NwIwATJ2mTq6lfs9dxNkutqWmfGHnPeIiLftdrT2e0GkyA92a6yjfDrlLxbZojmKb52UyT
	HQqsNdQmmKu5VReDHv0tgrPaPA34zHml96WgYHbCBAomt2OdGcaLoEkGTc3A2MYnz4y3Vu
	+QuSr3kUTI4WYsb/fcfu8yghr09OrHckOqwxooYnmhi6BCc1hsWzywwQdFc0aslsA34KZX
	PO2GElFE9BGnh5ktqqY9/gKvIzYCzgaYxQaP0Ih2SgsnAs8jt8MKVpegHrJ6qrBVZl5xpa
	FFsZJ3LCdRt/ZAMNEV9UBa9eV2hVnXwUrkPGOx0BCAVPsgX7QQnEUWUFqzJzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727975059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m16cNYK2UqN9o5P5GfthShRwxn645OWMeYndoit53/Q=;
	b=4ceBGBSGGgG4y/0U8QNqNNBsbhYYVIE76VGZgc6iRWq/cn0odRCK9bKMv2D2lM+xQ4NjuF
	WzjW60m5xDBYoBYiZRzWI/JCATRmxAYhR8c1iMya9qiVE/m7ErWQRukAtqEOvaYOoZz4P0
	Ab1toeRq0oTc+w0+4PZaKy8ZjFl2eJ6qZ3mp1P6g2jawq+RkSoHzJ5nDL5BXPc3SEz2WAd
	qdmkhJAhqZ0oNzMcJD0ZN5HWwFe4Xz2Ezy9fXhdGx3FZ/sB16UC5lhZduR1fSmemGEHcGm
	coV2i9ZdNfpvadZ0oSIEGcWeri0m8Hiyv9gJsXkb52uP1jZN69E+MHSPaG/lcw==
ARC-Authentication-Results: i=1;
	rspamd-84548c8bbb-r67bq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Eight: 1258f18e7f194e3f_1727975060172_323314395
X-MC-Loop-Signature: 1727975060172:1844589533
X-MC-Ingress-Time: 1727975060171
Received: from pdx1-sub0-mail-a295.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.86.86 (trex/7.0.2);
	Thu, 03 Oct 2024 17:04:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a295.dreamhost.com (Postfix) with ESMTPSA id 4XKJ1b398Kz54;
	Thu,  3 Oct 2024 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727975059;
	bh=m16cNYK2UqN9o5P5GfthShRwxn645OWMeYndoit53/Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GKTxUv+fYdwh3g++cp0B341gihygemzAk4fZ+Mab1uCU/7Z6PnNRWoj9zXEVay/jb
	 bRzFs4MlIPWzwS6wi0o6EwohVzb0iDkpYQpSH20GhOM3eJ3JrJwWGil3R0lS+PTl3Y
	 j62fdozS/lzdLI0XVJOR2jtt3RXeLPRSlSRooHifpxFHuV7luF8ouMycr902PX18F9
	 ptnCYNco+QImzd9YKNOp7MFzbFKtsG9+aRn98CprfYQI0ySOD1aXZZSQ0o7zUrNLbF
	 asZG9L8Y5wzUBLGYBghuhJDzGL3SqaoR+x253nW3Qj/Nh50MMKcdgBfCxn23fbSakI
	 zsZO6r663TrhA==
Date: Thu, 3 Oct 2024 10:04:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <20241003170416.kfbdpd7xkneh5sgc@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
 <20241003023354.txfw7w4ud247h5va@offworld>
 <Zv6wG5qF74J237w2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zv6wG5qF74J237w2@kbusch-mbp>
User-Agent: NeoMutt/20220429

On Thu, 03 Oct 2024, Keith Busch wrote:

>Oh, that's pretty neat. Thanks for testing that! I think that reference
>counting patch is pretty safe too. I can rebase the series with that one
>included next time.

Well the thing is it is crashing on me, as reported. I was able to reproduce
the deadlock with rescan_remove_lock on a switched CXL topology (via sysfs
remove/rescan parent/child). This is why I tested your full pci-bus-locking-2024-09-09
branch hoping the last patch would fix it, but still cannot confirm because
of that nil ptr deref.


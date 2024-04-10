Return-Path: <linux-pci+bounces-6062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295B89FF3B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8419E1C229BC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1617F385;
	Wed, 10 Apr 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9zoyC0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5E168DC;
	Wed, 10 Apr 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771781; cv=none; b=hvqVlfMOIjOpQomJP7sz1wrNB3Z8hRhDMP5xQTHmU4T8U5BwzrO7ZPZxHujYEksqKNvJF3VYQ5idmIAPlIZT/dOZukUKnZQZN1EbTz3vOERz3acF64lQBpvZ0vjPvIXJ2/oY6G9Ute3eAkAQbtrZZk8b//hg/3C1Oxx1BmaGNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771781; c=relaxed/simple;
	bh=5Xfuczx0L6P895teZD2CEcva7L2fJb64qc8GUo0McN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VM8gw1B+BUnVIMwkM2JDcBSvizIZGc/3VRVvjEBgWAiQCwNyWfhZ9ie/1kkMJ3GNZQkKqJld3G/m60yCvFyj8VIwyscorgnWJWmIwWnHB3y7Le4TqnniuEEhtwJ0TRIvnK28quqiG+kQsYeuKQyN8Dc4Adb3QIlZPaalCgK60nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9zoyC0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C829AC433C7;
	Wed, 10 Apr 2024 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771781;
	bh=5Xfuczx0L6P895teZD2CEcva7L2fJb64qc8GUo0McN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9zoyC0J4KjJUbFZOhypc3xrPXqkjYXnXY9Yj5UdT3EJxq8JLTbmAHIeDbjnRLGdb
	 uZzdYdom/F9iqOIYZKSVCFKkgTfuOGJW4p6fMfFVfwYnwdi3A7WLssrXHo5PUrDhB2
	 WKEuSYuDhFrR0tlqbNzKQgtrq88oYEQv7NchPnrkOpKJh5TMde9+y+/+OMzt1gLfn7
	 fhQOX4T6pvwhPmF4k0+3h5QZBijgwu3LO7LbkKhZiYSItAVgUchOmoqNR1GF77+0qz
	 OdYrA/ce0feNG2ajV0wPIQAuLX4JSFGPrUPQrqh27qGr3SaMdS8izod1IjEnf0D9dw
	 cfTyHNYqmQlLg==
Date: Wed, 10 Apr 2024 10:56:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, pabeni@redhat.com, John Fastabend
 <john.fastabend@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew@lunn.ch>, Daniel
 Borkmann <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240410105619.3c19d189@kernel.org>
In-Reply-To: <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<20240409135142.692ed5d9@kernel.org>
	<ZhZC1kKMCKRvgIhd@nanopsycho>
	<20240410064611.553c22e9@kernel.org>
	<ZhasUvIMdewdM3KI@nanopsycho>
	<20240410103531.46437def@kernel.org>
	<c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 10:39:11 -0700 Florian Fainelli wrote:
> > Hm, we currently group by vendor but the fact it's a private device
> > is probably more important indeed. For example if Google submits
> > a driver for a private device it may be confusing what's public
> > cloud (which I think/hope GVE is) and what's fully private.
> >=20
> > So we could categorize by the characteristic rather than vendor:
> >=20
> > drivers/net/ethernet/${term}/fbnic/
> >=20
> > I'm afraid it may be hard for us to agree on an accurate term, tho.
> > "Unused" sounds.. odd, we don't keep unused code, "private"
> > sounds like we granted someone special right not took some away,
> > maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK. =20
>=20
> Do we really need that categorization at the directory/filesystem level?=
=20
> cannot we just document it clearly in the Kconfig help text and under=20
> Documentation/networking/?

=46rom the reviewer perspective I think we will just remember.
If some newcomer tries to do refactoring they may benefit from seeing
this is a special device and more help is offered. Dunno if a newcomer
would look at the right docs.

Whether it's more "paperwork" than we'll actually gain, I have no idea.
I may not be the best person to comment.


Return-Path: <linux-pci+bounces-6098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1488A037C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B659B22193
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EEE79DF;
	Wed, 10 Apr 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XUV1hJ3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C407F;
	Wed, 10 Apr 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788653; cv=none; b=oMXHV23XREROpXQEqa6gM9BMIGBB+GgOQdHWACKMpzXGG3zQImYUrWQMMeNxApHoNYedzEhP4spLbeppdOaHQrtCra+esBbcX68kkrUvHBqoJRi3+VJ+bf2KF+wptyYZatIg9dcHyOWKpNhNJzr19MjYngoy7m+S76GJo7G9QxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788653; c=relaxed/simple;
	bh=rJd3I0lFxC/TyIkFxSTVQ+nTVKLHJ2m2+xlQZAXqST0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxIrmHWZeyy2tY/0qWXBuxwiR74/iTu9lVSxWl/zYjyv4rkTapNhG/V9PoeUpJ4EZNjlMftpe+g3fL3WRwWXg8xVFC1gPwvt9GKUnB7ork8OOdxigl/u15EQeQBxpMbvaxg+bhqUZLppyTrAke7iUsWo7HUGpI8UM536GNwuzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XUV1hJ3x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zUFTjk3Uz1sjAZCF89cY7ibFazq/lwzoV5czJsG613U=; b=XUV1hJ3xAeU9NZpY4WaspCHDiH
	TcU+rk8t3HXnAavXpdF3M5vSZGcYFoP93BgyIuwdQlWP9T4RJb6L0fImTVE5H9qlUWzFi3HhT/MHd
	Dc/6trPjdYii/s0ZkSrBBtTXYg5W2QD/Px3Gy0r2JvEzptj6zjbCTy/HB6Vb7BeJBsjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rugZF-00Ci8j-KA; Thu, 11 Apr 2024 00:37:21 +0200
Date: Thu, 11 Apr 2024 00:37:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <c437cf8e-57d5-44d3-a71d-c95ea84838fd@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
 <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
 <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>

> Well I was referring more to the data path level more than the phy
> configuration. I suspect different people have different levels of
> expectations on what minimal firmware is. With this hardware we at
> least don't need to use firmware commands to enable or disable queues,
> get the device stats, or update a MAC address.
> 
> When it comes to multi-host NICs I am not sure there are going to be
> any solutions that don't have some level of firmware due to the fact
> that the cable is physically shared with multiple slots.

This is something Russell King at least considered. I don't really
know enough to know why its impossible for Linux to deal with multiple
slots.

> I am assuming we still want to do the PCS driver. So I will still see
> what I can do to get that setup.

You should look at the API offered by drivers in drivers/net/pcs. It
is designed to be used with drivers which actually drive the hardware,
and use phylink. Who is responsible for configuring and looking at the
results of auto negotiation? Who is responsible for putting the PCS
into the correct mode depending on the SFP modules capabilities?
Because you seemed to of split the PCS into two, and hidden some of it
away, i don't know if it makes sense to try to shoehorn what is left
into a Linux driver.

     Andrew


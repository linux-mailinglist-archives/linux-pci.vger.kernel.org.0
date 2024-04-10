Return-Path: <linux-pci+bounces-6033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4889F8E6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FB728434E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975691791F3;
	Wed, 10 Apr 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0t06kEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E715EFBF;
	Wed, 10 Apr 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756773; cv=none; b=jLNft9iQxTwD4gCMgWIpF5XZC9K2jWGfui4gMkNlHo1O1ftLMN++kwlPJ6QcxwmEJ1x9McDWpLyvK/FrxobnJlF+xPP41kICQ8jVop7bLkj5RDcM/UlED9OyEWJ8R7WKKQrJQpNpWw5bhoO52KVX7uCS49moer7g3vExKCDfshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756773; c=relaxed/simple;
	bh=TkulXY//tRDErl5zUqQwlU67GLpRgIH9x+0kXsIFS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjDEpVKiClij7yw8WxoKgI5jHdcM+C1fqwYzE3n+A2ObbMDSsC8wuvOG0gIBdCXqVcxZp7gMTFRZLHnJ/BJ69hh4IzluGCTx7WMW7WEWZtgZRxoP5kua+JLgby/i/JdDU9NxQcvDeDQqr8PxIy2rIhxCB+d/7HM6rRRlfoTH/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0t06kEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5022BC433F1;
	Wed, 10 Apr 2024 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712756773;
	bh=TkulXY//tRDErl5zUqQwlU67GLpRgIH9x+0kXsIFS5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0t06kECvyK3Og0PKsSPcBSHzPxoW5/SoQtmLUIRsh1zsNTO7v6tmHfWucLadWo8+
	 Wy0nCNxUAsUomkaQr4+mNKvwI5pZa4izhakxQ8H5/KrrRzkosBG4RNvxy/7c2/EdCB
	 MTD4CAEBk2+MR7qA8K676Bx9pZPBVO1dmPwzWa/lP4a2R7Aoht2Yris6Cn0buCObRw
	 aodEiwkSrrf/ghmePj2UhxEEj7Dcq9FY1lSLE5zC5UmH3DFGxk/nZAaw8PA1edeA+l
	 xBK1QE6z93KQJ7qEPeePeBu9hI5nuABvz2XDJEv7JGPku5hF21rp1N9NKajryEBR5m
	 w6Uxdhl9alISA==
Date: Wed, 10 Apr 2024 06:46:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann
 <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240410064611.553c22e9@kernel.org>
In-Reply-To: <ZhZC1kKMCKRvgIhd@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<20240409135142.692ed5d9@kernel.org>
	<ZhZC1kKMCKRvgIhd@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 09:42:14 +0200 Jiri Pirko wrote:
> > - not get upset when we delete those drivers if they stop participating=
 =20
>=20
> Sorry for being pain, but I would still like to see some sumarization of
> what is actually the gain for the community to merge this unused driver.
> So far, I don't recall to read anything solid.

=46rom the discussion I think some folks made the point that it's
educational to see what big companies do, and seeing the work
may lead to reuse and other people adopting features / ideas.

> btw:
> Kconfig description should contain:
>  Say N here, you can't ever see this device in real world.

We do use standard distro kernels in some corners of the DC, AFAIU.

> >If you think that the drivers should be merged *without* setting these
> >expectations, please speak up.
> >
> >Nobody picked me up on the suggestion to use the CI as a proactive
> >check whether the maintainer / owner is still paying attention,=20
> >but okay :(
> >
> >
> >What is less clear to me is what do we do about uAPI / core changes.
> >Of those who touched on the subject - few people seem to be curious /
> >welcoming to any reasonable features coming out for private devices
> >(John, Olek, Florian)? Others are more cautious focusing on blast
> >radius and referring to the "two driver rule" (Daniel, Paolo)?
> >Whether that means outright ban on touching common code or uAPI
> >in ways which aren't exercised by commercial NICs, is unclear.  =20
>=20
> For these kind of unused drivers, I think it would be legit to
> disallow any internal/external api changes. Just do that for some
> normal driver, then benefit from the changes in the unused driver.

Unused is a bit strong, and we didn't put netdevsim in a special
directory. Let's see if more such drivers appear and if there
are practical uses for the separation for scripts etc?


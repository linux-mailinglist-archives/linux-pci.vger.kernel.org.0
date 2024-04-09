Return-Path: <linux-pci+bounces-5963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483389E2AE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005E3283F54
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AC156C63;
	Tue,  9 Apr 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEjDyKWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F212FF67;
	Tue,  9 Apr 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687924; cv=none; b=Fh5QTNA6X3e+dINoX98SIADF+pAkSzbHUyAuQ2O2l7fF22d2q3XDUhGAU9ySd5ohmu+sw2F4CsuPZmxhCwBEd56UP8ciy/wH+fH0CwvlX6MMEGAR28BSRsIf5pRNZGHKaDMcz7CYaaoYeRXQBgey0EG5L74ktMXndvbwe1zIkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687924; c=relaxed/simple;
	bh=4OLajTajUU+Bpl2dzOKoYPdKTkOBd6/YGanYlcci/6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1A8SzooZ1meje8YXq4SLE8hbYILdKOg9sSqx40PXHxx/tOll2sA05xqEZ54t0F2ffwDguUUBQbjYaMjgqvkveeJA0fBfvTPN6O4rjMT/coAq0LpndwzxMviEJk1Jv8hcv3Tb2BRZYoG3NkgTAhCdPkl4lVBxwWuX/d6bSasLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEjDyKWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ABDC433F1;
	Tue,  9 Apr 2024 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712687923;
	bh=4OLajTajUU+Bpl2dzOKoYPdKTkOBd6/YGanYlcci/6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEjDyKWGk3JdDN2heue3yOp6z1BoB9x00ZbUvKEgeBcHNg3x1kpaf1E8CcClUIH7L
	 G18ykP7qB+iVoIz9fhfYOgl8XNqX9oE/j8MnGtmoPYw8+8B9K9K+wg0i46e4MhKOQF
	 ht5wTlmN21u4yAXjwah4FXY7sosh/KqueO7c5KSqXU+N9/DG6oymgO174qGeoeWKEJ
	 BlX1JoRebbXNPI10/pslLYUxUCx0Qqpjt18vqEXlPRxaDyEPNodQ+ZZHNF7n5PtTMP
	 GBYHIs8LNCNebOWxaqJ5JwFDPE1Qva7A1b8tDu9D+NSOd93o/0SA1NVtEDt8l2xqfV
	 KFbuz4zKHZcLw==
Date: Tue, 9 Apr 2024 21:38:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409183839.GH4195@unreal>
References: <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <ae67d1a6-8ca6-432e-8f1d-2e3e45cad848@gmail.com>
 <ZhUexUl-kD6F1huf@nanopsycho>
 <49d7e1ba-0d07-43d2-a5e7-81f142152f8a@gmail.com>
 <ZhVQo32UiiSxDC6h@nanopsycho>
 <22f44220-80ae-49f7-bc7a-246e017cb77b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f44220-80ae-49f7-bc7a-246e017cb77b@gmail.com>

On Tue, Apr 09, 2024 at 10:42:44AM -0700, Florian Fainelli wrote:
> On 4/9/24 07:28, Jiri Pirko wrote:
> > Tue, Apr 09, 2024 at 03:05:47PM CEST, f.fainelli@gmail.com wrote:
> > > 

<...>

> Can I buy a Spectrum switch off Amazon?

You can buy latest Spectrum generation from eBay.
https://www.ebay.com/itm/145138400557?itmmeta=01HV2247YN9ENJHP6T4YSN2HP7&hash=item21caec3d2d:g:qWoAAOSwzEZjiq2z&itmprp=enc%3AAQAJAAAA4CjGKSBxVTaO07qnpLBQGBwBJdGVCYhu730MrI5AC6E%2BERJLxS0EdlgE2gKtElk%2FZUj6A9DQR69IXIpTk%2FJbqEGKgCNR4d6TMz6i%2BogO02ZZBCkpLkPOYpOvDJV1jRv2KVOBt7i5k5pUMRJpwPKzAH%2Fwf6tglPOId2d9fSy%2BBM3MbDcbZfkv4V%2FNbItTgspvDnnMKAzUmR3Rs9%2FoHVDVbU4ZsnfRKFOMaKbGH5j%2Fani2jAqtbPEIA3H8nUcdpkxo4I61N5w9peLlN6Hkj8E8irdQY4TTzSTdYZ7EC9JG09cQ%7Ctkp%3ABk9SR8T_kMLYYw

Thanks

> -- 
> Florian
> 
> 


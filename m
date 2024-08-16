Return-Path: <linux-pci+bounces-11777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBF955358
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 00:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61871C2202D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE141465A1;
	Fri, 16 Aug 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LC9URQnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4F146591;
	Fri, 16 Aug 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847633; cv=none; b=dF2yNWx2H3mPEHUI0RAOFYzK1v9dIvT+TNok31qnr1uxbXTpGnwiTVlw4i68tBGH4spkQZyr9kT7I79APbajUzcjU1NBnLTNL6LUJsWLelV5SYmjLJC3y9+gMKENKEvhvuOGdzpX/sQSg0o7Thhk4fg/gMvsua7eM7ZrAP3r8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847633; c=relaxed/simple;
	bh=IfNRY/5p/VGWMH1PPfGSlnef7rDTkdN4OX4eIbjfXlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVcMfS9t1HkC9yLcmdGVIxnQ3OjlHMVxjJjxvOhCJgch/4StUDhgT1le6FgDvjmdCVmycnKTWb/Hr+Jps/kZdfyX1mf1wvKW3ddRL8EZn1XdwUVYC2PAyT9RqRLCjE2quCbLRq99P1Y4yIp6J2V6jcyFWWqcfJt5Xch/wu5iWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LC9URQnh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 450FA418AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723847631; bh=uKFpj34a6+64O4rYy8zGYGv+iPIAbdox/mIVfquOJEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LC9URQnhhmh8OIdIfQW3Dv7x2OdSawBZIUuEqVHr1kP/FUG7qGC+oaXLtI9i3KitV
	 Lhg+Xv6FXQQ3bM7Pkh7grDd3Y7uRQtuIIxrjWoIuvpUa1pfiLYiHBAT831QndB/rI9
	 31Qohq81Mp1OTpFJBTnGAtMwvj9DcOMZFoKZu70v/90GpyAKn1D8QvxPesVgFKaIdK
	 9UGMsem0ehgoFlrxOx6BAxjXvWesWhaCd8eEDOxjdhG/w+19Fk3zqNw48etwxVZqQB
	 7E4lagf2ACa6kNgcmobW91MV4AeWQWScebJwhH4WI0Udy18ULTaTVXl0zoBL2X2hLK
	 hUIZ/ofJV58iA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 450FA418AB;
	Fri, 16 Aug 2024 22:33:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Philipp Stanner <pstanner@redhat.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Philipp Stanner <pstanner@redhat.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] Documentation: devres: fix error about PCI devres
In-Reply-To: <20240809095248.14220-2-pstanner@redhat.com>
References: <20240809095248.14220-2-pstanner@redhat.com>
Date: Fri, 16 Aug 2024 16:33:50 -0600
Message-ID: <87plq8hzch.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philipp Stanner <pstanner@redhat.com> writes:

> The documentation states that pcim_enable_device() will make "all PCI
> ops" managed. This is totally false, only a small subset of PCI
> functions become managed that way. Implicating otherwise has caused at
> least one bug so far, namely in commit 8558de401b5f ("drm/vboxvideo: use
> managed pci functions").
>
> Change the function summary so the functions dangerous behavior becomes
> obvious.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> +CC PCI and Bjorn.
>
> Bjorn, btw. neither PCI nor you are printed by getmaintainers for the
> touched document. Possibly one might want to think about fixing that
> somehow.
> But I don't think it's a huge deal.
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon


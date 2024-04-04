Return-Path: <linux-pci+bounces-5732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1A898B44
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28875B2D286
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD932D272;
	Thu,  4 Apr 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b6QddKaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658576033;
	Thu,  4 Apr 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244250; cv=none; b=OXaYjCnezMmDGT7GJ7yRikziXcy2CmlTJanBZfqJHCM1N+B7X0Brp9lvR8OR7pHGweQBfbscI3hrC2ZrLyZLed1GPYLX5SwanMaM7CHeVl0dHOf0zhIwp8BcCJx2UEXKFeOcQV1w0E53Wv2U2o2hxhtCspZT51mEl/sKmnS3hDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244250; c=relaxed/simple;
	bh=jACElRELWG3sbjfxgQdB2isFgr9do7cSy1GejLeYx0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZiiCwBRLg/wVW3KDepTJwNaDm/h3yje1bzj1ep0J6sFxj5ILnyG2FXnoH1boE1YqYRox97KmXEzjiFtZZ8tn6xT1MVy5SfLIc+zufe+vDL8olw6b77ACxrIUDObNTrtyvV17IExlJ/vGM8trSwBNL5niiePLl40DAmrBaltyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b6QddKaA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K8oFk/2NEB6VU8TT01JOO+IvizbIAuFV6K5q8RsRiKk=; b=b6QddKaA1EV6eH7W5HkOsIU+09
	M6YTHSgF2Q0WfCozOWiapvDeX9Y/FFPnDb97UIZyU0swTRChFBWwX0GVYu/A6/rNcj6NH36GoOdZW
	SO9xSJIqCMLKTJKyIrrzV9SIftLEmVWR97+YLHQATY+ekxyY3uS6a9uHo8ZttaRxmX+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsOwd-00CC94-Ka; Thu, 04 Apr 2024 17:24:03 +0200
Date: Thu, 4 Apr 2024 17:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <d0bd66c7-13d2-40a3-8d7d-055ac0234271@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>

> For now this is Meta only. However there are several reasons for
> wanting to include this in the upstream kernel.
> 
> First is the fact that from a maintenance standpoint it is easier to
> avoid drifting from the upstream APIs and such if we are in the kernel
> it makes things much easier to maintain as we can just pull in patches
> without having to add onto that work by having to craft backports
> around code that isn't already in upstream.
> 
> Second is the fact that as we introduce new features with our driver
> it is much easier to show a proof of concept with the driver being in
> the kernel than not. It makes it much harder to work with the
> community on offloads and such if we don't have a good vehicle to use
> for that. What this driver will provide is an opportunity to push
> changes that would be beneficial to us, and likely the rest of the
> community without being constrained by what vendors decide they want
> to enable or not. The general idea is that if we can show benefit with
> our NIC then other vendors would be more likely to follow in our path.
 
Given the discussion going on in the thread "mlx5 ConnectX control
misc driver", you also plan to show you don't need such a misc driver?

	Andrew


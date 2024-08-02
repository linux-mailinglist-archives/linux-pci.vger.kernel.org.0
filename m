Return-Path: <linux-pci+bounces-11154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC09455C2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239C7B23E3D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32EF171BB;
	Fri,  2 Aug 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQg3hemQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513B79F4;
	Fri,  2 Aug 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559483; cv=none; b=DrEsc9t/dxAxX+se4K8rUMqkzAGS+B50SwIxLsKDZgSa8ZyIlkNzLEgIWQo+g5XDTb7hcPKvGAmjh+uPAFvRSOOxBY9/kOo5le4LMqUCdtzIqHaz8pOOs3CZm2+VM9rWzw98m4m8i6OHEVZfh5ayavPUm+BZ6CXuMLNg9dohJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559483; c=relaxed/simple;
	bh=vviD2XNV3ruNlAaNBhuqEpZMiplNW3m2aWANZWIFIMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajNa88b0tDMOecxXYtXAQavU8Wxx7uDPDnn50MhtR0fdjD2AX88Hen69SlDzniFAmgbBgIsIXnguOe/RaY+bxnRDF6/3ZjdpQnmcc5jbMyLCMjQuwoGQTHyqWimZuzAy/Le5Cg9jxfDviK8KzIp/kXbmaTDZp7UzH8dHeh+DdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQg3hemQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10163C32786;
	Fri,  2 Aug 2024 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559483;
	bh=vviD2XNV3ruNlAaNBhuqEpZMiplNW3m2aWANZWIFIMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQg3hemQQjFzdnitRjbG7Faui1IIYAqWLwzd4TF6GC1y+yAc21bAvVPcpmluopNqD
	 8BoSaPGOdRzR+u0xOjRD+V9gc9ZyZRn/20bUaqAXT6bpyMDvevM3rgvW/SwkjsyD4V
	 eCk37QGd2SJL/5zMfkDSRY1mQXTR2lrxZtErxTqxEa3S1Hse5DCV/QLsjzLlum8ONd
	 mz6y374bb3jnW7BMtBGWaDiA0+iTeh+EwfhH7NEMb6Koqwf+R9qSaSxTib/QkJoAat
	 5CQIfj29LnyyopZYLBPP5+pPd3wX230rlbDBmf7fXPgSjz6VyM2ZbsW5WsiJh+tDu6
	 GqUrWRGsqkP8Q==
Message-ID: <c1c9ea44-d309-4d02-858e-be70a17050e7@kernel.org>
Date: Fri, 2 Aug 2024 09:44:36 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] PCI: Remove pcim_iomap_regions_request_all()
To: Philipp Stanner <pstanner@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>,
 Srujana Challa <schalla@marvell.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jie Wang <jie.wang@intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
 Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240801174608.50592-1-pstanner@redhat.com>
 <20240801174608.50592-11-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240801174608.50592-11-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/24 02:46, Philipp Stanner wrote:
> pcim_iomap_regions_request_all() had been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> All users of this function have been ported to other interfaces by now.
> 
> Remove pcim_iomap_regions_request_all().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



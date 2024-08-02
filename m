Return-Path: <linux-pci+bounces-11153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8099455BD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22924B22F49
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D4DDAD;
	Fri,  2 Aug 2024 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo6xTSzo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47976FC11;
	Fri,  2 Aug 2024 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559430; cv=none; b=NVlTaMyAHGhJ0NIW9sxhRoiHBkwOYHmfLkKe/bPXbNRah9dETtARqFlh6Q1cRmKihVV2hTUtLifqk0jXyeiBlRQcpI2Ym0T33/cUitW+R7xPYV50tPOQ5/gknU63XBKB7GpgMojJRx9QALVZVuOPt/0XhckoigyYjIJtXXzroX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559430; c=relaxed/simple;
	bh=kb4Er6Cc/3bSSz/8+h2xyIo0D6MrCX3wmU15n/+pTP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIqigBEFZ0O1+A9cVE3ft1LGAkI87g996nwQC1sTD4ccOfVPxW+0cGRe/ccFQOGVyirzoJgTW3K5Sb0KXLfV1ac1qZx7kQ/B9x3HipcxPjUJ0dCpJ5hEfOk2GtIvjA5/QTaijC4A6jeIVu2pWr4K5I3+GkT3ZrVuQgFW8Pwh4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo6xTSzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABEBC32786;
	Fri,  2 Aug 2024 00:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559430;
	bh=kb4Er6Cc/3bSSz/8+h2xyIo0D6MrCX3wmU15n/+pTP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uo6xTSzoCXC043p3mLgTWknUf2rgHWo4IFal2y4TRyUUKWXjgfeKteXHeJNatnzOP
	 ykkxBx3M95QinqY4Uv5iDO76L/kujQMnFqwqg6DeoIm+NXGq3X++6CYhj2sy2GBpkN
	 NOo+A2zv0NM0kImpcj8SiB+B3JipANpbEQECkm3Fedbwfxv1nLLZRWx/z8Omk+P95Z
	 NxGW0uSIFBPNDS0bt+kWwgJTsZWqzFbCivIZEmePwopMavMqI8C9EBRYgytCrvX0d7
	 eZgLVg2vJm3/11jtiULsDyUC0bKIbg33RizwDkqtSTzGGhJXgM4ArliEWdyu2U60AS
	 c/ID1txi6dvZw==
Message-ID: <15efa538-fe9d-4dfd-ab22-cd6361c39c8b@kernel.org>
Date: Fri, 2 Aug 2024 09:43:43 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
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
 <20240801174608.50592-3-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240801174608.50592-3-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/24 02:46, Philipp Stanner wrote:
> pcim_iomap_regions_request_all() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



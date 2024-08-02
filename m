Return-Path: <linux-pci+bounces-11152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161929455A4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE84282605
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E4B64E;
	Fri,  2 Aug 2024 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iihRnCfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974A5672;
	Fri,  2 Aug 2024 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559339; cv=none; b=dVl1yafjAmeNcU0psJ4nArOgYC+htYdm9Cn85lzCIBL/bWU0HJkUSKjqXlU4OXnvNA8Y6AqSFlnXrLa3JJ4+CVy0vUzMX6myhFqPvxegrDeS+rOB7tzhhktW8fjoiEt6gw7Bs1c59pPBg3II3X/Rne/2brRKSeChay5SfLTHWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559339; c=relaxed/simple;
	bh=V8dQQ7UGH+1AhEx8lI11JZBKmXrcr/VuZFYYSJkrEak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX91TQOnpuK6L4V3Jlvu+1+v0O8gJLXvlOVYKmFFGV5iw7l1or1o6a0R/XCRfxMP4Gi+Vr3pmfNJGpYwAm/K3iEG97LAw1nW3OqBc72SJwGuSC0CSFCq9HM4p+V1Ha9xu5FSk+e+MWGfi/lMc5YUr6ZAOJG+IDaKKc9vJAN3rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iihRnCfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D83C4AF0F;
	Fri,  2 Aug 2024 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559339;
	bh=V8dQQ7UGH+1AhEx8lI11JZBKmXrcr/VuZFYYSJkrEak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iihRnCfnP7YVmtMb8C1Rz03oNHFtwU7dDTowokFfsOY8NMqPNu6QVcnKpz90DPH26
	 QjDV22jNLw2go8Kr74TC3Hmka/0Gqt4Uq+3ImmUsSU2EDJ+dufyeNXyzr8Gl+u8WUZ
	 XWFjgdpp/RY/tecBq/u4D5zsv40Bl/aTrASw1rDRHmeck2o3jI1WsXhT84QKkCcq+g
	 Tfo+uKXKmJss9N2Y3BhJ5z+Sgm3lCcIQ9Miryf/aD7CSY3EnrTM9Kn72jwIGJIfRE7
	 aB9S+ROAi3Z57xa13AjLsWlcyQG1cWQjv/Pp6nzgD9d+kdHEPIOwNnysK32qPZSNpP
	 LDjUj/rw6KTYQ==
Message-ID: <1e021b7b-b1f7-4604-9e97-370758ac4f4e@kernel.org>
Date: Fri, 2 Aug 2024 09:42:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] PCI: Make pcim_request_all_regions() a public
 function
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
 <20240801174608.50592-2-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240801174608.50592-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/24 02:45, Philipp Stanner wrote:
> In order to remove the deprecated function
> pcim_iomap_regions_request_all(), a few drivers need an interface to
> request all BARs a PCI-Device offers.
> 
> Make pcim_request_all_regions() a public interface.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



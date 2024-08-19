Return-Path: <linux-pci+bounces-11844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BC957861
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 01:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D191F22B1F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F515AAB8;
	Mon, 19 Aug 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXYPoQAR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B61DF696;
	Mon, 19 Aug 2024 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108850; cv=none; b=j9Lp1TDy3FxgKuzhqdZVVG9mbfMHw1ir+mrttaTxKNhwqBck6FWUXdPtppvRrxLRPT2fTDN9vqteXsTsaos1eQ41PbnbO3Ughmo0si8NrNqrIwOfvXtSiu9lOotwhhYQRv1cpyAAkTwffMfWT/qezavwhYJZuBg3f0BYvxu1nmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108850; c=relaxed/simple;
	bh=mJXaRxbMWM39dMzH9l5kYZ7g7ouNmwcruKXMK8gNkX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkPcn6iqTIizIvy/OjjDykZ849cq43lQJta2dtDOVgX4bGTI1mT3vy+UmmqANWwipwKKvOsDn9/Q2nBo3vHRc9hNZ5nKQUN+1BW7cKxiIqbgD3/9MlzO4LS7NjevATYRjjikLB775eDSFoBYgBVmCp//qFWqebBS1+2OemXgEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXYPoQAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998EFC32782;
	Mon, 19 Aug 2024 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108849;
	bh=mJXaRxbMWM39dMzH9l5kYZ7g7ouNmwcruKXMK8gNkX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gXYPoQARvA+Pn4TQep5aX8uvhPU06HBEZC8s7nU3NeDTwzfpLC4/XPM6bcOXpcSMR
	 j+IioWHWPS2jmBGAlBK1B9w6GJyxDfWblqCclt4caiicnCA4GBGM38I8o3Wblu0AP3
	 dyxIzG3yJQASecBEF/gSzYD/687723usA4TQIOs+wgv5E29VuZVe0NMUe/oBuVzBWH
	 xrzpEWN4Fm1cKpkkXgUIF9REemYttOrPNk7l+ICyrUhzfayvlwbNxHb00+Ex6nyLrn
	 Ie4odNMEAbURIqwPUcl7Yv6kPnkV6S6rKmEzfrv1Zk+soK0dsfO56hb9jEPD/y50K/
	 K5TiLUSIvFf4A==
Message-ID: <0a51e728-8005-404f-b2f2-16fc31834d2f@kernel.org>
Date: Tue, 20 Aug 2024 08:07:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] PCI: Make pcim_release_region() a public function
To: Philipp Stanner <pstanner@redhat.com>, onathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-3-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240819165148.58201-3-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 01:51, Philipp Stanner wrote:
> pcim_release_region() is the managed counterpart of
> pci_release_region(). It can be useful in some cases where drivers want
> to manually release a requested region before the driver's remove()
> callback is invoked.
> 
> Make pcim_release_region() a public function.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Looks fine to me. But I think this should be squashed with patch 2 (I do not see
the point of having 2 patches to export 2 functions that are complementary).
Either way:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



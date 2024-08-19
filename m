Return-Path: <linux-pci+bounces-11846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30E957873
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3011C1F23033
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B81DF68D;
	Mon, 19 Aug 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyqUujxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D159565;
	Mon, 19 Aug 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108940; cv=none; b=dkRb6wd0dsYCDrw7taZXBS92AqHUULNfns2yfSVAl7Bw8hgh2BIrD/i31yotNOweAqcj1+tv3gI8O7eSRQojX6TUX0PbE3xers0NcHvrLY/YPB0indAB5jtUlhM/yTuPKLEYH11bP9YbXIsStJAeujAf1EhYk30LxCpT9A3e0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108940; c=relaxed/simple;
	bh=huFSW0O9/vDWk3jLLuBeA3AMJ8s2sEkGg2pXPbb+s68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjQlTJyaTendOQ/iOyH60AhR4ugpcU7ML6HpeMf5eiSWDKelP/+mlZSQ8t3f2tFjkKmyu17GapkqUD49rUtm0zCOyNUUyLT5fqxrSDH/YWH4KiyPAdb5eRA7HubUNjb+jhZBVIX7fBng3WS4B6Qv1RtSPyWwLqT5ApVYk+SrpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyqUujxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0CFC32782;
	Mon, 19 Aug 2024 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108939;
	bh=huFSW0O9/vDWk3jLLuBeA3AMJ8s2sEkGg2pXPbb+s68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QyqUujxrEN6dsd4ERQTt/YOI/cvdOUsxyzulCSEUBiuIHcUjbso3YoHhm+MDDjXT6
	 kO9NWk4G1DxC2IVA3zkGg8srtPDyFLff5uhaOUiFK+NExsY+Ll691k0tYJtyjYNGGx
	 R8ea/prAo67rf/R+QQhD3Rii19DVFFqisY3I2DnLQAE/IPfGUWcrv4lOPmRHd7VZGf
	 JqTO87jDiHxQyeCkXr0+BfY4JpLeRz6Irhp6iVFLE8tq6EkfsJOK81XApXX7vxK3Wi
	 PrCtt8OOS+xYZotvuJuNtHzD7KWzuisUw9dkFacyFCOLy1M7Z1lS5ujaSckETWGpk7
	 a6Iem0/y3hWYQ==
Message-ID: <39af5ef3-04f5-4cfe-a486-6f14504d6a52@kernel.org>
Date: Tue, 20 Aug 2024 08:08:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] PCI: Remove pcim_iounmap_regions()
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
 <20240819165148.58201-11-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240819165148.58201-11-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 01:51, Philipp Stanner wrote:
> All users of pcim_iounmap_regions() have been removed by now.
> 
> Remove pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



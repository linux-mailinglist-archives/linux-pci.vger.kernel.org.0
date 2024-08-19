Return-Path: <linux-pci+bounces-11845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB5957869
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 01:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1BE281F23
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5051DF685;
	Mon, 19 Aug 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7vWsR6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06C1DF668;
	Mon, 19 Aug 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108894; cv=none; b=RwXHNYIMvQmiMvE2aHqGzgltl0PpGkgFiGPLBbusZ45YYnPCCryDw+iLYAlZaDe17LLA+QwqweG9kwydye7RaFE+bwK5+GgFlIk2TX8qZoldOTvXo0ND9yArJpkI6Xk0WK1p7XXTDsd0yn07HV7IFUx2FPK9wixEVNnQY9BKmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108894; c=relaxed/simple;
	bh=Q3A4bDKDw+D/pxKm8nl51yuFDsQ4UfiO0ix22SGurDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBO7j48+/fj9Mbky3kkzAp46aOlQYRa04Rw7sGCu4Nw07n+G0fAeQfjBpo9CYF/9rnUOtISLLmobRaPGw2JkpUHowdTe4OpuboQZTcIX0auXZuTwTgzHHZY0CgeCgEq1Ubk6TFZw3T4UZOgyamza9rZDBeLhf/CmYLmHos0M4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7vWsR6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F7FC32782;
	Mon, 19 Aug 2024 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108893;
	bh=Q3A4bDKDw+D/pxKm8nl51yuFDsQ4UfiO0ix22SGurDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u7vWsR6X8LCJGKE6vvNyQ/UvHu5m6zsjyTsOIh9to5BfzbYc/I0MaAsMFV7hSN+Nn
	 9fB0EVV2wjeP8MzUhM+YOKv9ruNO+EOGdi0eaOtsbyjWlF2XhTDdv3TRDDIA6EhcMh
	 usLnkZjl/xpmbQl/1rVjQcDh19GnZ1dgWroPD8IHWJmKPtbkhPDpI4o7k+77RMAuR9
	 bqugKGWNcelKU50jglkOkN45fzO5dRZN5nBWzk6dR8hKINyYhFg9XsXF1d26VkA42h
	 f4O6F+fDZh9SYKGFgBniIKDcdYp9asip9zNsgBAul/CZHFT+8xUg9mGflttaNeXDDX
	 XuLm9GzIAl4qQ==
Message-ID: <309d9abd-e60b-4e8b-8def-7c4430635422@kernel.org>
Date: Tue, 20 Aug 2024 08:08:07 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] PCI: Make pcim_iounmap_region() a public function
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
 <20240819165148.58201-4-pstanner@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240819165148.58201-4-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 01:51, Philipp Stanner wrote:
> The function pcim_iounmap_regions() is problematic because it uses a
> bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
> prevents getting rid of the problematic iomap table mechanism which was
> deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Make pcim_iounmap_region() public as the successor of
> pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Looks fine, but as commented on patch 1, I think this would look better squashed
with patch 1.

Anyway:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



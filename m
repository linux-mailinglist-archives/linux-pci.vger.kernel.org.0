Return-Path: <linux-pci+bounces-11939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4295997E
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918A11C203A2
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEECE1C32FE;
	Wed, 21 Aug 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QxT2yLCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EF20ABE8;
	Wed, 21 Aug 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234445; cv=none; b=YFt/3rzVUbaNSK8CMsbKfuPHLzl9jlVA4IHgcn/d5jF9E3GAXgYVkVko7TH2TIj3HvSI3TCIvUJaxw0kPnuPnr/N4r2khvcgR7SKPP/7mUT/md013qljIoAZYXkdVblch21ao0B+fVTUrHgSTctIF3uOsb8tImpFa8H5dyWReiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234445; c=relaxed/simple;
	bh=xNUZvZ/XGFquQ7bcR8kjzWBjJpgTgvtWAUsduWt4sgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQA9wCScfYLOzSa/CG+l1UPWMWKn+ebNR9/yC4cR/iQSkfV2VYqSGjCM7y4XHnQXhlE7pZ3jGqx+5SGCSy+22XLxQWwj9QWLJwnbgOIIJ4UibqU3JXf3v8M5J5WWNHvga5mDoV2AHRTAohAULoX12lhdIaII/tMauafuO9Im760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QxT2yLCS; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gi8bsVe5vQYYugi8bs0j4Z; Wed, 21 Aug 2024 12:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724234435;
	bh=w6AIYrBySrGuhkddExNCWqzXmH7gBMeTgtXfKwkDmGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QxT2yLCSf3emNohfH/QMtChqPSQqqWCz+jg4/sJ1vsmTOCfCHpgaAvyqx/WbsPUgZ
	 j0w3Ifi/pO/A9j3NexJSl4xUQGdgAwPSojkhWMogfJYjmNkm75D5FBLvWvzBfsoLnx
	 RtgE/n5BJ2UFiEIPD8sFOVl2YVWvD1WoFHghd/fnChM3vrdlWGJ60YZx+cSO1POKe/
	 UrZjsxDAjN7K04ZUGLvQezWqRv7RkY5CN3xSXxVmxM1ACtkvF+GMWCeH8yp3vLp82I
	 DfoFXgyExAGvtjtoSmSR/NevfVwszwgh3H/mUaKphifhnf+W+FZJJpCz9TpFGY61l8
	 ZEZ3P0e9kIg0Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 12:00:35 +0200
X-ME-IP: 90.11.132.44
Message-ID: <40db668d-8e8b-4782-8a0b-4a0e9965f086@wanadoo.fr>
Date: Wed, 21 Aug 2024 12:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
To: Philipp Stanner <pstanner@redhat.com>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org, axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 davem@davemloft.net, dlechner@baylibre.com, dlemoal@kernel.org,
 edumazet@google.com, eperezma@redhat.com, hao.wu@intel.com, hare@suse.de,
 jasowang@redhat.com, joabreu@synopsys.com, kbusch@kernel.org,
 kuba@kernel.org, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, mdf@kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 stable@vger.kernel.org, trix@redhat.com, u.kleine-koenig@pengutronix.de,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
 yilun.xu@intel.com
References: <20240821071842.8591-2-pstanner@redhat.com>
 <20240821071842.8591-9-pstanner@redhat.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821071842.8591-9-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 09:18, Philipp Stanner a écrit :
> In psnet_open_pf_bar() a string later passed to pcim_iomap_regions() is
> placed on the stack. Neither pcim_iomap_regions() nor the functions it
> calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the string on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/vdpa/solidrun/snet_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..4d42a05d70fc 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>   
>   static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)

snet_open_vf_bar() also needs the same modification (see Andy's comment 
on patch 8/9)

CJ

>   {
> -	char name[50];
> +	char *name;
>   	int ret, i, mask = 0;
>   	/* We don't know which BAR will be used to communicate..
>   	 * We will map every bar with len > 0.
> @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   		return -ENODEV;
>   	}
>   
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>   	ret = pcim_iomap_regions(pdev, mask, name);
>   	if (ret) {
>   		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");



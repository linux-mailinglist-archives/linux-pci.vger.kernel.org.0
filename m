Return-Path: <linux-pci+bounces-15997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983B9BBEB3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C727C1F22B1C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CA1E3768;
	Mon,  4 Nov 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsfWxSZx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1A1E25F1;
	Mon,  4 Nov 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751611; cv=none; b=HYTTpfKyKv6BOJqq4dP526jDEOOS8jFr9aZSSqk6MACy+FASRHvxXjYw8ezhnGWSWY8kqqdU8Z59ujfGZg70hiGShY+LtdrrrANoQ+pWEyZy6kl+Rf6kETV+uSLUrbVQ7JJyFvWJHISfcsTPVES1QsE66M6MXvEhHIUxOWesOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751611; c=relaxed/simple;
	bh=F35QXu0CPb2RNTi9cqqHOPETxQ69DznhMqoB8u7EK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRWhGUen4bT6GXg3eZhO1BQ4agN55/jZLrIHB1TYCn+YnND1iVrwCVEXgwTJFFHqEa0yMDi5C16wt9vl36CBiV836NhFmZUk7aq6BcaHby+0iVHYThxruflabKIN8p169uxwqjYmXDyL/5D+N5j71u/PZuVbINj9HGt3xQxPi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsfWxSZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88909C4CECE;
	Mon,  4 Nov 2024 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730751610;
	bh=F35QXu0CPb2RNTi9cqqHOPETxQ69DznhMqoB8u7EK/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsfWxSZxcLob+OpZQ/6kbeznGeNpk12qsGwzGZQQkwQCFfQv4+n7/UuPxDhC8ZLuN
	 LVONQaZrfhhnRtFu3RcJKdQ34vOBPhLr/g0U8Rcn/BW2RVHx2ZvRvgv0eXVGWGBVIC
	 LojWYoLqFkP4jEiG53jwIwRW6Pl6QMy1U0/lKkAgs8E8PueJYc++VDvXYNBKz3ZFwe
	 XuJI3NW2XZllYTLrRXChbGsMwwCiSrP8NcYu2bky7Kyla7nIacFa/ltzkhFWIBRJUu
	 FnP40w1Bq37G4EPw8KAe5X6KjceW84wHqKVkTKJe7bRh7DriDS8p6bcWBJUk0aEQra
	 c/rrnl387nMlg==
Date: Mon, 4 Nov 2024 14:20:08 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: of: Use device_{add,remove}_of_node() to attach
 of_node to existing device
Message-ID: <20241104202008.GB361448-robh@kernel.org>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
 <20241104172001.165640-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104172001.165640-3-herve.codina@bootlin.com>

On Mon, Nov 04, 2024 at 06:19:56PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices. The newly created of_node is attached
> to an existing device. This is done setting directly pdev->dev.of_node
> in the code.
> 
> Even if pdev->dev.of_node cannot be previously set, this doesn't handle
> the fwnode field of the struct device. Indeed, this field needs to be
> set if it hasn't already been set.
> 
> device_{add,remove}_of_node() have been introduced to handle this case.
> 
> Use them instead of the direct setting.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org

I don't think this is stable material. What exactly would is broken 
which would be fixed by just the first 2 patches?


> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index dacea3fc5128..141ffbb1b3e6 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -655,8 +655,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	np = pci_device_to_OF_node(pdev);
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> -	pdev->dev.of_node = NULL;
>  
> +	device_remove_of_node(&pdev->dev);
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);
>  	of_node_put(np);
> @@ -713,7 +713,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  		goto out_free_node;
>  
>  	np->data = cset;
> -	pdev->dev.of_node = np;
> +	device_add_of_node(&pdev->dev, np);
>  	kfree(name);
>  
>  	return;
> -- 
> 2.46.2
> 


Return-Path: <linux-pci+bounces-32888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB6B10FD5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B02A18868B8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA71E9B22;
	Thu, 24 Jul 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Ohsh4g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9451DF24F;
	Thu, 24 Jul 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375339; cv=none; b=ISM87bhtlTL+Ga+3Q/dSkBZBfhqS6G1TCJcEa+7+R2/KxSxWqE+x26+wapFalbr5Nn3jxAhzSLZmpw+KjTzWToWgSZ+K/zwitkfFsrRm3E5QcaIsp87xzA7SpHhNWbxg9pkCBoBiQXBrEr5BYzlivWFE2V+spJuMZPtbQGQbvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375339; c=relaxed/simple;
	bh=YggnuFxZNDdHmkQCqIlbYBbAnZ7uCChcEN4xtDygVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eMMQQYzVkV1GuikB5ImcFGL4gxXSrHABeTB5+XlclLHN4FtaU/RlRAJgew4NO7acG+ljhezaq6yEqoZjB3u/UpLgg64uY3DRLYjdLC3ZdqE/zD+Hrq1cRlIs8JKbfcTqffxOsnzJozlegzXC24X/NrDwm5VzCRlCDw58j8c9DvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Ohsh4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01554C4CEED;
	Thu, 24 Jul 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375339;
	bh=YggnuFxZNDdHmkQCqIlbYBbAnZ7uCChcEN4xtDygVK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n4Ohsh4gBa2yZix3c5JN8VjoVhV+ZcFo4cc+r6Ctl3PAzduinkQK728TEo+5ZE/C3
	 Kau0wf8vxSu2aRty3POjjY2wx4bKL4b5E78tGinmdq5AbJlw60FBscfxJEasT9JrD8
	 n8herMmLUCb20787/6vnkt1JLOQJtQVxTlhyuElEOSr3Av6gWOqUuSx4pxZArcZesp
	 qA6BuQJFPHgKmeSNHHsBcZDaNEADvO2MTvy389q+9LHZbp4BJBlSdqT8cTg2MHGryJ
	 N3ifWDdKKeFWkXQqMALZcyt97kVzC7IAit1JP6w88ptLJjDUWXtqT9ZmGEE46GguN4
	 NdP1LukyR+qbA==
Date: Thu, 24 Jul 2025 11:42:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-ID: <20250724164217.GA2942464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHsgYALHfQbrgq0t@pc>

On Sat, Jul 19, 2025 at 05:34:40AM +0100, Salah Triki wrote:
> Replace devm_add_action() with devm_add_action_or_reset() to make code
> cleaner.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index a4a2bac4f4b2..755651f33811 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1353,11 +1353,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  		goto skip;
>  	}
>  
> -	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);
> -	if (ret < 0) {
> -		clk_put(port->clk);
> +	ret = devm_add_action_or_reset(dev, mvebu_pcie_port_clk_put, port);
> +	if (ret < 0)
>  		goto err;
> -	}

Looks OK to me (and already applied, so no action necessary).

But this is the only use of mvebu_pcie_port_clk_put(), which only does
the clk_put(), so I think we could also remove
mvebu_pcie_port_clk_put() completely and simply do this:

  port->clk = of_clk_get_by_name(child, NULL);
  ...

  ret = devm_add_action_or_reset(dev, clk_put, port->clk)

which would arguably make this more readable because clk_put()
corresponds with of_clk_get_by_name(), and it's clear that port->clk
is the target.

Also, and unrelated, the "err:" label only does a return, so I think
this function would be improved by removing the "err:" label and
replacing all the "goto err" cases with "return -ENOMEM" or whatever.

Bjorn


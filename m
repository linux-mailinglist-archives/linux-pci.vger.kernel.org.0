Return-Path: <linux-pci+bounces-6200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B898A37DC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1433D1C20D49
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDA152160;
	Fri, 12 Apr 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R47GTcAF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A19610B
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957364; cv=none; b=KwiK0t6Au3y+PKZcTCdpdnhdxjCmE5tIwUgYAH7ZW2ZyM5489KJ05eGhGyAvMgifrIHjIDzrK7affUqZ8C1xmH+1hd6cHhUTQ5N3edG4D2Gb9pbHXnO3wR4xRgsoJ0V141sHc09uVtGlNhKUztYsbRRHsXVFUOfLs+pnD50AvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957364; c=relaxed/simple;
	bh=5XnegERMQKroUQ2lJJ9YEwEr8cwIYfsZ4h8Q9CAPgn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G+77QY4ZOEnu0ZmTX+jTgOrjcWkXWmknBgVwg8yhwl5BRxmTzcmTwQxNy8Qp0IQr2rZTUO4OY99izARbs9c30d8oLX5avcQwFzw6oQrh3Ao3g/xSpQx52UL/4iusqionzuUgE+puqRCoOXM/oIHbwRDMkVrfy88SsSRphWNm70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R47GTcAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B569C113CC;
	Fri, 12 Apr 2024 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957363;
	bh=5XnegERMQKroUQ2lJJ9YEwEr8cwIYfsZ4h8Q9CAPgn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R47GTcAFmPX7i/WqLJ6onAHbVQ95/Z9AmnxYk3Ngy85X1zUqPA8bHHOian+lyqUiD
	 SuY2N9BPk3SbCaJr6gQZZ6NndJPO9d0vulqjxpaah4LIURZ19zx0uDPwslcr8ffkLM
	 JxusHgEyswQWKwQ0+Aar7HSnLFyKiFYZ3093p6OwEGThP46XJa4ju1lUxL18V8Mplz
	 mAXtoVOTMjHAbgJj5U3kssR6HwVuEKi3T7mqBIectnAzSIcx1dTVwMwtc5HfwNKs44
	 iE2qCH00niD8QzCVLJYu2a6qeQnzvnQ+/3kvGN/Jduh6+6grGQMbdMkjQuIoS4ySW3
	 iXQgUiT1b83OA==
Date: Fri, 12 Apr 2024 16:29:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI: rockchip-host: Wait 100ms after reset before
 starting configuration
Message-ID: <20240412212916.GA18789@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412023721.1049303-3-dlemoal@kernel.org>

On Fri, Apr 12, 2024 at 11:37:21AM +0900, Damien Le Moal wrote:
> The PCI Express Base Specification r6.0, section 6.6.1, states that the
> host should wait for at least 100 msec from the end of a conventional
> reset (PERST# is de-asserted) before sending a configuration request to
> ensure that the device is able to respond with a "Request Retry Status"
> completion.
> 
> Add the PCIE_T_RRS_READY_MS macro to define this wait time and modify
> rockchip_pcie_host_init_port() to add this 100ms sleep after bringing
> back PESRT# signal to high using the ep_gpio GPIO.

s/PESRT#/PERST#/
s/bringing back PERST# signal to high/deasserting PERST#/

> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 2 ++
>  drivers/pci/pci.h                           | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index fc868251e570..cbec71114825 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -325,6 +325,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
> +	msleep(PCIE_T_RRS_READY_MS);
> +
>  	/* 500ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>  				 status, PCIE_LINK_UP(status), 20,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..c93ffc5e6e1f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -16,6 +16,13 @@
>  /* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
>  #define PCIE_T_PVPERL_MS		100
>  
> +/*
> + * End of conventional reset (PERST# de-asserted) to first configuration
> + * request (device able to respond with a "Request Retry Status" completion),
> + * from PCI Express Base Specification r6.0, section 6.6.1.

"PCIe r6.0, sec 6.6.1" to match typical style, e.g., the reference
just below.

Whoever applies this can take care of this.

> +#define PCIE_T_RRS_READY_MS	100

Thanks a lot for doing this; there are many similar places we can
update to use this #define.

>  /*
>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>   * Recommends 1ms to 10ms timeout to check L2 ready.
> -- 
> 2.44.0
> 


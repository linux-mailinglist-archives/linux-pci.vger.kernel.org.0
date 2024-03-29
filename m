Return-Path: <linux-pci+bounces-5406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D464891D86
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4639F283F79
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C729B2319F0;
	Fri, 29 Mar 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9vNiMrV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36232319EB
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716379; cv=none; b=lM1ZZni/K20THPSohY9HAUQNisg4YrXMDIPj0yoBiI6BYhkUWTPLAV8BZkt8GjCwMzQPQZ25QlVqZgw46WDmFP6WCYHdql/Zvx9PgmVcq42p6IQGcMtP1rAu/oNrqF3Mc4dj8EaNX1fu+MJXqd+yVxAlrNeN62kK0UskQxvQ9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716379; c=relaxed/simple;
	bh=IpjMDZLzrUytvFtsKWmfYOw5lDbAvGoJhWYr2bVnGpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BRJ4Oj+XrAjIYTGxoJrsbwSLe5WOHESNDExlcjTgzf2hOflbZeHSJJFBiN6/ol1QaXdhfvYk08zbEhAsrgZQYbts4vnYHoldLiLoaPYAD75B1Afhghauk9F1yNHCGORPV2joOdzaefpbC40b/Ym04wycMtDTg3rTt/uuZOECUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9vNiMrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7862C433C7;
	Fri, 29 Mar 2024 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716379;
	bh=IpjMDZLzrUytvFtsKWmfYOw5lDbAvGoJhWYr2bVnGpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j9vNiMrVrVkbuOfgrlcVxKPWa9zHaNMEDlIBqXWbPnsW26ZD+z0m99Rk2YIDumo3W
	 lTr9IieOTlGERGgtldy4nZdUkoqoVY1ub6sK0oxCiFb1RzC/uXy6HLvi7769X5lCXE
	 nVZOexqdd3XgiW2XqLl3wKhTeqzutx8JBeP7zZf3yQ7zxI93bEwtG/AwRhO0RmOJW1
	 MQySlPUcMdptxdXpkIvoJ/CjfRj93DJcdfoozEUO4cQV/08Utk9ofuxp9H5NlncMct
	 fZiSTWEZiqiFVzeyfw7yo1DUReFOW8Lp6FOTy2TJocEd18pKZwv3vipD6OgjuclNsh
	 lVaLG9X53OVyQ==
Date: Fri, 29 Mar 2024 07:46:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip-host: Fix rockchip_pcie_host_init_port()
 PERST handling
Message-ID: <20240329124616.GA1639231@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329084407.1050307-1-dlemoal@kernel.org>

Observing the timing is the important thing here, if you can wedge
that into the subject somehow.

On Fri, Mar 29, 2024 at 05:44:07PM +0900, Damien Le Moal wrote:
> The PCI specifications mandate that PERST be asserted for at least
> 100ms. Make sure that is done in rockchip_pcie_host_init_port() by
> adding a 100ms sleep before bringing back PESRT signal to high using the
> ep_gpio GPIO. Comments are also added to clarify this behavior.

"PERST#" in spec, and to make the "assert" and "set value to 0" all
match up.

s/PESRT/PERST#/

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 300b9dc85ecc..d526b9d26c18 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -294,6 +294,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	int err, i = MAX_LANE_NUM;
>  	u32 status;
>  
> +	/* Assert PERST */
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>  
>  	err = rockchip_pcie_init_port(rockchip);
> @@ -322,6 +323,11 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	/*
> +	 * PCIe specifications mandate that PERST be asserted for at
> +	 * least 100ms.
> +	 */
> +	msleep(100);

Specific rev, section citation?  And a name for the parameter if there
is one (T_PVPERL, etc).  And hopefully a macro along the lines of
PCIE_T_PVPERL_MS since this isn't rockchip-specific.

>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
> -- 
> 2.44.0
> 


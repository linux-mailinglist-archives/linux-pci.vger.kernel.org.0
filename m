Return-Path: <linux-pci+bounces-5957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF889E027
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8190228ADC2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93313D8A0;
	Tue,  9 Apr 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdMlwBtc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9D13D63C
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679360; cv=none; b=dSbzKQN1RdATOj/NF7gqnUG9LLxq81eN+wYKE6IJo6SJCo76g7jpIBo165lxln80D1S1kfdFheIpUkQD9OozCydGxmgxMgfo0dppPTCPQqZjtYoAthqTI8TciBMuEs/roi5yA6xmcnjnEbxL/2jRvh4RHLad6USI/Rzj7D9L6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679360; c=relaxed/simple;
	bh=AcZ3QNcbgLEVSP63LdF8sRSKm3cjsDvhlKbu7sqN0Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F2BUN3amY4Fiefmxy46k3wuTOraWbzH9euLFtB1L8j0zjCDLV6vPiqSFegmby0Gt6Q4tr3R0J9ruHNRf07e+pWhqUWRiCefBJcFu7+PcnBHD1sMsDt7yAUMvkWSN0iFJ/YkCTHP7xVSueR7n2ttRwTTj9Cs7/BkVPPyQaMeaQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdMlwBtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3B2C433C7;
	Tue,  9 Apr 2024 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679360;
	bh=AcZ3QNcbgLEVSP63LdF8sRSKm3cjsDvhlKbu7sqN0Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GdMlwBtcEN+nL3PndlKHfnpn7S2v8i0VjbL2Y5fZGNLIH1sCdMJCHFXZXCzBRaEiS
	 UGX79JT9mtiJMtVrqDdXfHlOyzzvJ5EwhU/Hk75K9oYD7ipMhOBf9ymwAxh4kvq67W
	 wgP23CfzTlaJC7+sElyjX6YjYPrQuq0fuYKRwuBsRosHZIvPVuxvWlDO6ykYWhAYsi
	 FpXQdxtvatLrXSXzF9SMlPx0tiAthIX9v+1SAmPgQMtkGVihqrXmCIqxtMEcOMZiJ2
	 fgWYrow5+abWnUEOC/rKc18PyQpzSWN3x+T6tEemb1Hrv8sWuE2qh07AV+QLs7s6AQ
	 um8lMK8z1qn+w==
Date: Tue, 9 Apr 2024 11:15:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: rockchip-host: Fix
 rockchip_pcie_host_init_port() PERST# handling
Message-ID: <20240409161558.GA2077808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330035043.1546087-1-dlemoal@kernel.org>

On Sat, Mar 30, 2024 at 12:50:43PM +0900, Damien Le Moal wrote:
> The PCIe specifications (PCI Express Electromechanical Specification rev
> 2.0, section 2.6.2) mandate that the PERST# signal must remain asserted
> for at least 100 usec (Tperst-clk) after the PCIe reference clock
> becomes stable (if a reference clock is supplied), for at least 100 msec
> after the power is stable (Tpvperl).

Reference current spec, e.g., "PCIe CEM r5.1, sec 2.9.2" and a note
about why you mention two parameters here but the code change only
uses one of them.

> In addition, the PCI Express Base SPecification Rev 2.0, section 6.6.1
> state that the host should wait for at least 100 msec from the end of a
> conventional reset (PERST# is de-asserted) before accessing the
> configuration space of the attached device.

Current spec, e.g., "PCIe r6.0, sec 6.6.1".

> Modify rockchip_pcie_host_init_port() by adding two 100ms sleep, one
> before and after bringing back PESRT signal to high using the ep_gpio
> GPIO. Comments are also added to clarify this behavior.

s/PESRT/PERST#/

This is two separate changes that really would be better as separate
patches.

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> 
> Changes from v1:
>  - Add more specification details to the commit message.
>  - Add missing msleep(100) after PERST# is deasserted.
> 
>  drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 300b9dc85ecc..ff2fa27bd883 100644
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
> @@ -322,8 +323,19 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	/*
> +	 * PCIe CME specifications mandate that PERST be asserted for at
> +	 * least 100ms after power is stable.
> +	 */

Remove comment completely (given use of PCIE_T_PVPERL_MS below).

> +	msleep(100);

s/100/PCIE_T_PVPERL_MS/

>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
> +	/*
> +	 * PCIe base specifications rev 2.0 mandate that the host wait for
> +	 * 100ms after completion of a conventional reset.
> +	 */
> +	msleep(100);

Please add a #define for this since it's generic across all PCIe, not
just Rockchip.

I don't think the PCIe spec actually names this parameter.  It's
similar to T_rhfa (Conventional PCI r3.0, sec 4.3.2), although I think
devices must be ready to accept config cycles after T_rhfa.

This delay is a little different because IIUC, a PCIe device doesn't
have to be "Configuration Ready"; after 100ms, it only has to be able
to respond with a "Request Retry Status" completion if it isn't
Configuration Ready yet.

So I think we should add something like

  #define PCIE_T_RRS_READY_MS   100

to drivers/pci/pci.h for this case.

>  	/* 500ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>  				 status, PCIE_LINK_UP(status), 20,
> -- 
> 2.44.0
> 


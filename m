Return-Path: <linux-pci+bounces-44598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D3D17EC6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80D6D301D504
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90D38A297;
	Tue, 13 Jan 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4jHHzHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9027313550;
	Tue, 13 Jan 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299253; cv=none; b=mqYu2PpUUIVyIsIbxbkXYzFRSunA3mjOXP/bciH4zhAouFVqadi+rTNnjq8WdFndds+OQ/4mr59svdG6dbUs9/4ehgfeWg1QhWkWmqPUkfPJx7Ku2qgkakC0FM+msJtvvTGDSDq4CT4gKuRLnHmDOnKijbsTz5i/m+ZCojoEgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299253; c=relaxed/simple;
	bh=TGUkh8Gval+loBUcY0wl9fpiuvXqEh3n7gDAud8tPZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAvpFnQkcZRxtUc+iOrtrP7Jy3NlnCC8stReJRLzPB2kPETOvAOiWD3uLCQxpXH07r6j96bBpngflwS3qBglC3brjAxfFt97HDd/4qJsHKHVJ4jj3dqgsBwL753kGSDx7dQgbjDuC3oXUl06RkscQFeBj0xgsXH1KogWHCvsvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4jHHzHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8ABC116C6;
	Tue, 13 Jan 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299252;
	bh=TGUkh8Gval+loBUcY0wl9fpiuvXqEh3n7gDAud8tPZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4jHHzHOUVsgIY6iLEFwNqEhROfJX0HqEz2AgiMoJ905dpc27Ipl7uiQTzDuSkHGt
	 a4zqFmQddcjjIpU2Hk3SV+UnBl1MicSbvTR3yWKw7wp+MVL+NWLjFwKsS7xUA/1Ccb
	 kNVgZP8Lgvr//+yMpx/aw01IOJZlWqk/NM8uUKtlM5PbVbeOiN/MvtCR7FMhwZbUyT
	 mj1PV/ATKjO2Tcxn2J9SnCGVkgOlTlA04Cx64oDamNIXkqBH9smtxiiJSdrPOXnc45
	 8GojOC7O2PjYBb2RMI+Sa4E6tlzIl8RDdudZLPrZc8befQdJTEqeHc10imI5fCVeSk
	 g4bwybfGogERQ==
Date: Tue, 13 Jan 2026 11:13:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 1/5] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <aWYa59GgcB7jOfQq@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023715.3463724-2-den@valinux.co.jp>

On Tue, Jan 13, 2026 at 11:37:11AM +0900, Koichiro Den wrote:
> Extend the PCI endpoint core to support mapping subranges within a BAR.
> Introduce a new 'submap' field and a 'use_submap' flag in struct
> pci_epf_bar so an endpoint function driver can request inbound mappings
> that fully cover the BAR.
> 
> Add a subrange_mapping feature bit to struct pci_epc_features so EPC
> drivers can explicitly advertise support. Make pci_epc_set_bar() reject
> use_submap requests (-EINVAL) when the EPC does not advertise
> subrange_mapping, to avoid silently accepting a configuration that the
> controller cannot implement.
> 
> The submap array describes the complete BAR layout (no overlaps and no
> gaps are allowed to avoid exposing untranslated address ranges). This
> provides the generic infrastructure needed to map multiple logical
> regions into a single BAR at different offsets, without assuming a
> controller-specific inbound address translation mechanism. Also, the
> array must be sorted in ascending order by offset.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

I think this patch should be after the:
"PCI: endpoint: Add dynamic_inbound_mapping EPC feature"
patch...


>  drivers/pci/endpoint/pci-epc-core.c |  3 +++
>  include/linux/pci-epc.h             |  3 +++
>  include/linux/pci-epf.h             | 31 +++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index ca7f19cc973a..8d809a2c3ce9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -596,6 +596,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (!epc_features)
>  		return -EINVAL;
>  
> +	if (epf_bar->use_submap && !epc_features->subrange_mapping)
> +		return -EINVAL;

...then you can change this condition to:

	if (epf_bar->use_submap &&
	    !(epc_features->dynamic_inbound_mapping &&
	      epc_features->subrange_mapping))
		return -EINVAL;


> +
>  	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
>  	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
>  		return -EINVAL;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 4286bfdbfdfa..898a29e7d6f7 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -223,6 +223,8 @@ struct pci_epc_bar_desc {
>  /**
>   * struct pci_epc_features - features supported by a EPC device per function
>   * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
> + * @subrange_mapping: indicate if the EPC device can map inbound subranges for a
> + *                    BAR

This text should probably also mention that this feature depends on the
dynamic_inbound_mapping feature.


With those comments fixed, looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


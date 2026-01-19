Return-Path: <linux-pci+bounces-45203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01999D3B579
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77DFB3008C81
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119532ED22;
	Mon, 19 Jan 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FoIPIVOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CB2DE6FC
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846894; cv=none; b=BREA5LvuRvCCqwydzyK9Q9giLetwE4v1iXT3sXEsAgbciIPYuJmolaIaNc20/wcd3stIhK/Mx6HE9Dc4tY6/MW3ZV2Sl0dcGTkdnke8pQChH8vX6BOafeERYprsrSyGVjYiskRGVmh+rdRs26fOCB0yrUwz2IMTvv0RqGymCG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846894; c=relaxed/simple;
	bh=yJrsSK2fWi+q4jMJJQesGuCBtt15oy0D4t8SJ1tZm58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esMtUe3ZxczGxdQ1TT5F/l77rYJykJrFpaWQGJvoiJQ4MLxBu1BZMOqvMWcbN7GXDBc8rGspFenQUQK3+JPPqv3fzhGf/kHsrJq+ukNH3EZE5gMS9W0fctebsfAUR40lfseFmzYszrHFs0fGW6uuBWWaCeiIZII8DqL2MAIP+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FoIPIVOu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so8141375a12.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768846891; x=1769451691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVCwgsSzKKeqgi77IITqgWQFeCapLo/mhtqYI2p2tcA=;
        b=FoIPIVOuFE5s6gqAaRK5+nO9lCoW26JG22a3bU3tnMMg2IyiwNq+Uv2NjVfVVNmH2v
         /55skxB4cuBUtJ0CunydB0GBiS3hQUCyZvyNvT86bGH0Q0HrUZVPrMuYFPHe48qEnM5S
         lzBxaNngYPMAIaT8BGlkFymUieWj7kfQpqMpVY+eBZbhghLt6CUetRTDVGIzFs9bKzWL
         hg/76HWkdFHjTfr14F+zyHCCU+haI8OLVO7tCRL06oazoKQngOJmgePqi0Q+g4j1N4vl
         AzQp9d8Kh+jllqv8Cx60859vxxbL19e0HvdSCX3C/TGpA+RD1iVE34zNp31b+3dwjBWy
         UlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846891; x=1769451691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVCwgsSzKKeqgi77IITqgWQFeCapLo/mhtqYI2p2tcA=;
        b=J575NNXmhjSUyuJyGHb50aGRPX6gUI4JOsxBsZirIK1/3OZ/d1lbxjDTT/pwEmn8RT
         ip9MXRQV7wywwZMRmmK5Frkj4R0YUXP/kGzVzG8psJPK7UIropsY7eCNMPttU1OxfT3s
         ymVLNB1lLaU3m7XJwMvB1SUfOszsaDZ8svsthZh4bloXha0hswXOHhhQRTJtqV8b09ex
         mTVskiPkidWuY9rtfj3s+j+0dQPS2uFQwdtPlMHG5k6IZlcV7U09Eh8Y5bVRItdeYMgC
         wvPa/PsQoqJbzNZUzKPqjgpWrarN8QTZIwqtBgoTz7l1JC0jrlxLk8KbzBZL545lKaNr
         1bcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLyc9OccDof9kdkHSUqp0xVxcQMaJtpqfECl4GcX/1IIirq2P3SnPE7lN22SCUYVSeNsYMCC90oVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5OlB2Kz6xc0Rvw94RZJ+BeKI+Bzcp8Gsft1NKy6feGmoHkO6n
	stjq9S7FH/NZ1OZNru0SDhzPtlVaMQ0KZNvlJQ1P877XQ7wRg+lEP46V2utY3W6jGa8=
X-Gm-Gg: AZuq6aJta6Io5qCoLwumVp9XQ3DTndRdiEuXZB3fD63Yx7B+2nr9tde1CLqojgiDMR3
	1g6+/751M/4yLb4b68ANinZ4tRo3oQr6vDVUrdJVj/nFsISUt2o+/4oNOfAIjOxoy9bB+/+QeNZ
	zspxZPoVpMRSppX1pJHLEGi4E4vERK7qLuQbSCkSQYB8nrpN2Bjzjmnks0kq+J59mh3yskuBKK8
	hbJox7tWuXeO7yecv4DU7zjb/wj0ro8SWzshASE+Ug1VWibPBWXHpPsBhVGJ+C2DFWciEnwBK3Y
	//1ZxynsoiAd0+JNA5BtGOK7MyBhGGvIGmuf50IaHBpR0cLEcP3Lh4hbk56SniER6g5r3teZPxv
	yzZoNaMCJxU8K71G/Iy/oPnSREchrcSlL1OsPRQhp/tV9W10mSjnCv+LHbGSjR2w71ma2Kq1Ada
	9LGRx3VIZoZm7SKDTDxA==
X-Received: by 2002:a17:907:6d1b:b0:b87:115c:4a2b with SMTP id a640c23a62f3a-b8792f9be9fmr1190953166b.25.1768846890765;
        Mon, 19 Jan 2026 10:21:30 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169f10sm1189937466b.26.2026.01.19.10.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 10:21:30 -0800 (PST)
Message-ID: <2af0b06e-539f-4ecb-a609-27c24838f625@tuxon.dev>
Date: Mon, 19 Jan 2026 20:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuration and
 initialization callbacks
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-10-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-10-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/14/26 17:33, John Madieu wrote:
> Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
> to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> reset framework with dedicated reset lines, other SoC variants like RZ/G3E
> control configuration resets through PCIe AXI registers.
> 
> As Linux reset bulk API gracefully handles optional NULL reset lines
> (num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
> reset framework when reset lines are available, while custom callbacks
> are only invoked when provided.
> 
> This provides a balanced pattern where:
> - RZ/G3S: Uses reset framework only, no callbacks needed
> - RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit
> - In addition to that, RZ/G3E requires explicit cfg reset and clok turned off
>    to put the PCIe IP in a known state.
> 
> Add cfg_pre_init, cfg_post_init, and cfg_deinit callbacks to support
> custom configuration mechanism in preparation to RZ/G3E PCIe support.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 54 ++++++++++++++++++------
>   1 file changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index a9773e5f25c7..bb071bacd0b2 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -224,6 +224,9 @@ struct rzg3s_pcie_host;
>    * struct rzg3s_pcie_soc_data - SoC specific data
>    * @init_phy: PHY initialization function
>    * @set_inbound_windows: SoC-specific function to set up inbound windows
> + * @cfg_pre_init: Optional callback for SoC-specific pre-configuration
> + * @cfg_post_init: Optional callback for SoC-specific post-configuration
> + * @cfg_deinit: Optional callback for SoC-specific de-initialization
>    * @power_resets: array with the resets that need to be de-asserted after
>    *                power-on
>    * @cfg_resets: array with the resets that need to be de-asserted after
> @@ -237,6 +240,9 @@ struct rzg3s_pcie_soc_data {
>   	int (*set_inbound_windows)(struct rzg3s_pcie_host *host,
>   				   struct resource_entry *entry,
>   				   int *index);
> +	void (*cfg_pre_init)(struct rzg3s_pcie_host *host);
> +	int (*cfg_post_init)(struct rzg3s_pcie_host *host);
> +	void (*cfg_deinit)(struct rzg3s_pcie_host *host);

Looking on patch 12/16, I see you have rzg3e_pcie_config_pre_init(). I think it 
make sense to name these:

- config_pre_init
- config_post_init
- config_deinit

As all these are related to the setting done for the config unit (CFGU) and 
there is already rzg3s_pcie_config_init() function taking care of this.

>   	const char * const *power_resets;
>   	const char * const *cfg_resets;
>   	struct rzg3s_sysc_info sysc_info;
> @@ -1119,6 +1125,12 @@ static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
>   	writel_relaxed(~0U, host->axi + RZG3S_PCI_MSGRCVIS);
>   }
>   
> +static int rzg3s_cfg_post_init(struct rzg3s_pcie_host *host)

Based on the above mentioned rationale, please rename it 
rzg3s_config_post_init() and move it close to rzg3s_pcie_config_init().

> +{
> +	return reset_control_bulk_deassert(host->data->num_cfg_resets,
> +					   host->cfg_resets);
> +}
> +
>   static int rzg3s_pcie_power_resets_deassert(struct rzg3s_pcie_host *host)
>   {
>   	const struct rzg3s_pcie_soc_data *data = host->data;
> @@ -1233,6 +1245,10 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   	u32 val;
>   	int ret;
>   
> +	/* SoC-specific pre-configuration */
> +	if (host->data->cfg_pre_init)
> +		host->data->cfg_pre_init(host);
> +

In pre_init() from patch 12/16 the code de-asserts LOAD_B and CFG_B. I think 
those should be asserted back in failure path of rzg3s_pcie_config_init(), 
rzg3s_pcie_host_init_port(), host->data->cfg_post_init(). Jumping to cfg_deinit 
label would to the work for now.

>   	/* Initialize the PCIe related registers */
>   	ret = rzg3s_pcie_config_init(host);
>   	if (ret)
> @@ -1245,8 +1261,8 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   	/* Initialize the interrupts */
>   	rzg3s_pcie_irq_init(host);
>   
> -	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
> -					  host->cfg_resets);
> +	/* SoC-specific post-configuration */
> +	ret = host->data->cfg_post_init(host);
>   	if (ret)
>   		goto disable_port_refclk;
>   
> @@ -1257,14 +1273,17 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
>   				 PCIE_LINK_WAIT_MAX_RETRIES);
>   	if (ret)
> -		goto cfg_resets_deassert;
> +		goto cfg_deinit;
>   
>   	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
>   	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>   
>   	return 0;
>   
> -cfg_resets_deassert:
> +cfg_deinit:
> +	if (host->data->cfg_deinit)
> +		host->data->cfg_deinit(host);
> +
>   	reset_control_bulk_assert(host->data->num_cfg_resets,
>   				  host->cfg_resets);

It looks to me that you can also implement deinit for RZ/G3S that will only call:

    	reset_control_bulk_assert(host->data->num_cfg_resets,
    				  host->cfg_resets);

With that, the resulting code should be simpler.

Otherwise, you will have to also call deinit() on the probe, suspend/resume 
failure path, close to reset_control_bulk_assert() for cfg resets.


>   disable_port_refclk:
> @@ -1609,6 +1628,9 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto rpm_disable;
>   
> +	if (host->data->cfg_deinit)
> +		host->data->cfg_deinit(host);
> +

Can we keep this before host->data->cfg_pre_init() call from 
rzg3s_pcie_host_init() ? Or, embed it in cfg_pre_init() implementation for RZ/G3E ?

In Table 6.6-130 Initialization Procedure (RC) from the RZ/G3E HW manual, the 
steps are one after each other.

Doing it like this will drop the necessity to update rzg3s_pcie_probe().

>   	raw_spin_lock_init(&host->hw_lock);
>   
>   	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_init_irqdomain,
> @@ -1663,32 +1685,35 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   
>   	clk_disable_unprepare(port->refclk);
>   
> -	ret = reset_control_bulk_assert(data->num_power_resets,
> -					host->power_resets);
> -	if (ret)
> -		goto refclk_restore;
> +	/* SoC-specific de-initialization */
> +	if (data->cfg_deinit)
> +		data->cfg_deinit(host);
>   
>   	ret = reset_control_bulk_assert(data->num_cfg_resets,
>   					host->cfg_resets);
>   	if (ret)

With deinit() for RZ/G3S calling reset_control_bulk_assert() you will have only:

if (data->cfg_deinit)
     data->cfg_deinit();

here. Also, take into account that reset control assert/de-assert can return 
errors. So, your APIs will have to be modeled with this in mind.


> -		goto power_resets_restore;

> +		goto cfg_reinit;

Jumping to cfg_reinit label is not actually right, for RZ/G3S at least. The 
reset_control_bulk_assert() function take care the resets passed as arguments 
are de-asserted back in case of failure. The code here jumps to cfg_reinit() 
which for the RZ/G3S SoC just calls again de-assert for the cfg resets.

> +
> +	ret = reset_control_bulk_assert(data->num_power_resets,
> +					host->power_resets);
> +	if (ret)
> +		goto cfg_reinit;

You changed the order here. I get it why, but it should have been done and 
explained, in a separate patch.

Thank you,
Claudiu

>   
>   	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
>   				 sysc->info->rst_rsm_b.mask,
>   				 field_prep(sysc->info->rst_rsm_b.mask, 0));
>   	if (ret)
> -		goto cfg_resets_restore;
> +		goto power_resets_restore;
>   
>   	return 0;
>   
>   	/* Restore the previous state if any error happens */
> -cfg_resets_restore:
> -	reset_control_bulk_deassert(data->num_cfg_resets,
> -				    host->cfg_resets);
>   power_resets_restore:
>   	reset_control_bulk_deassert(data->num_power_resets,
>   				    host->power_resets);
> -refclk_restore:
> +cfg_reinit:
> +	data->cfg_post_init(host);
> +
>   	clk_prepare_enable(port->refclk);
>   	pm_runtime_resume_and_get(dev);
>   	return ret;
> @@ -1756,6 +1781,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
>   	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
>   	.cfg_resets = rzg3s_soc_cfg_resets,
>   	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
> +	.cfg_post_init = rzg3s_cfg_post_init,
>   	.init_phy = rzg3s_soc_pcie_init_phy,
>   	.set_inbound_windows = rzg3s_pcie_set_inbound_windows,
>   	.sysc_info = {



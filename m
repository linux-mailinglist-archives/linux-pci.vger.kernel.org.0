Return-Path: <linux-pci+bounces-45202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5BD3B555
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CECD301BCD2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C87362127;
	Mon, 19 Jan 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DwCbk89Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9935FF55
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846525; cv=none; b=KJj+qf+35OAV603HMI1qkt0OgDMrbllKGm6vRY67dAeY9OCuEIFTVvTCf9GdcxYTqMJtyRkJ5yHfxW+x3f+eOrnkbSJOCe6/95mtToPVltFaKkgACb10cOPcT7LSiOBInCIYuhzq4LLBvOMA+EE+mBNR1PO509sym1F3VRXDsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846525; c=relaxed/simple;
	bh=m+Pn7jarKNpf03UF+yoC3DqAXPbvISf/cH1u8TsRRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Twzq2DDSSVK+BrGAT4ah2i1KC3OuIDrg12nZlWX8lEzfNJoOAFev+Arf8/LGn5toGezhGPamLxsa1pab1t/VznuVDXcqZKjW1tAdytrQO6letmEiQ3qIIbyWjRTJ63VV90y0yz0gyf4pgp+k4AZKTZk4T/1QijVZ/75aYupWYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DwCbk89Q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so6711453a12.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768846522; x=1769451322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txeaoc1/FnFGAR4hVY6E0qC+7bbG67qxJt1YMnZB4MY=;
        b=DwCbk89Qr2VOvPA/GyvY18tlZt2/DUQ2MzNkH+KMOdlcqC5luoKHXtjR24M8VdK+dO
         eXkbuU597VQn5EkpwcsIfePWN8eZOaXhJE63m8VHYjze8HjpZh1HEFEsO48P1U1G/jnn
         x8zemmhEPoK9HLd7QgydVc76uV8kxqo6vwkm2ri7yIqF0mtbcggFPiwDH1hRoP2FEo76
         Zw2RU30yYMUGy665Otl648h2T6CuaVjQAiQkt5NYr3XGGjqwontls7C/tBLos/1hnYR+
         gjAP9iwFffTzfUZ/Rh5WdW6jNJL0vqwnDajjnX5JMtmBMX5KlWVkXPQuSionGzpIdqDB
         97ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846522; x=1769451322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txeaoc1/FnFGAR4hVY6E0qC+7bbG67qxJt1YMnZB4MY=;
        b=PKCgwXQBR1zsmCwDFQXxHaLlwnZWdpEQidLzDwDqeYnFkvEWhJt//XuFYyTxaYRhzg
         ltBzatHX5BRN5fpRmciHyViGPi4AJwyOU+Axd+bjNSmcY3sN++Q0XLXQAI50uDuluCqi
         a0e3K+fTYUohZ1sOcXwjT4+3EKJyMptvU5GfwvHotBRDEQDkdyRrkvcapCylqaFxff7G
         hhT3BPLgaw6owbpc9T0ZkNzzANtkMHx1tk3J3QBoMZoWJRN2j0scjDH18vk6giaVdoYF
         LEW30nfhOOwHGm13/zFcoyo2Eg/cFqRy3ya3e2M1LjxwN0TqziHiDJZNX0hfG9Y1b1qL
         Xtpg==
X-Forwarded-Encrypted: i=1; AJvYcCW9KWy6+5IxkuFaOpmBUF+2/P5s5lMeLKX3MR4ZfSN4YG5pyF9iEIR3cBMuAg0UeQInrb1XFp9PHFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY2y4QmE9YXn5NjbSckzQMBgz7A+fIkGZXXLrWSrQgVc6FmoF
	PStwILJP42s45g2jkvvYNE6wUO0Jt0QKmHNPD8Xl1eUiiupAQFwXff8BgP+NeqY/hD8=
X-Gm-Gg: AY/fxX6OCr2mQOAOxtjYP2AgM+p+yC44YTUKVkt/SajxiHSFu4yiM0wI41B+Pj65EK+
	Rx30TJ0bXTu5TwBC+OoZvKbUGMRhs2qoJf/PpvvZFrpUPQV5UAOLvbYYkUxmD5shfP3u3PEYkwT
	sQbnSqQH7VJQMIDCtt2Ol/74Am0NgsN9810mrATchmdgzwPYfcuW0zeq38fQ6zPKaUyVOd6QXvH
	lcWuTOYrdokCTAyrmG/mAw1OfTCCd00uW0iTLGKoleDiB/vqACgZr0NqL7b795Op9EVqvlrsiYp
	6zQnkJJeYXE1xY1hd2ab2ovWODHN/Fdb/MYbm8aDRhH+9iRQTMGGR0ZvN4HkwE15tv9t3olh0ZH
	aqga1iS68TJCo4dDWJkmDzufT5keJQfpPOW3hvVeBZ3hPwjLes5Ti2ZgepZAAxUAPOdSEtOwibS
	dbN1FVvy5Ql/Vw/dfKJw==
X-Received: by 2002:a17:907:268d:b0:b86:fd46:72f with SMTP id a640c23a62f3a-b8792d489f3mr934010166b.10.1768846522152;
        Mon, 19 Jan 2026 10:15:22 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e9dcsm1186284066b.6.2026.01.19.10.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 10:15:21 -0800 (PST)
Message-ID: <9e76a2ec-1684-42b6-b2e0-6f7935c95d61@tuxon.dev>
Date: Mon, 19 Jan 2026 20:15:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] PCI: rzg3s-host: Make inbound window setup
 SoC-specific
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-9-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-9-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/14/26 17:33, John Madieu wrote:
> Different RZ/G3 SoCs have different requirements for inbound window
> configuration. While both require power-of-2 sized windows (4KB * 2^N),
> they differ in how non-power-of-2 memory regions are handled:

AFAICT, both RZ/G3S and RZ/G3E HW manuals document the setup of the inbound 
windows the same. Please point me to the proper chapter in case I'm wrong.

Moreover, I tested the code from rzg3e_pcie_set_inbound_windows() (proposed in 
patch 12/16) to setup the inbound window on RZ/G3S and I see no differences in 
terms of mapped regions and functionality. So, unless I'm missing something, I 
think better to use the same code for window setup.

Thank you,
Claudiu

> 
> - RZ/G3S: Uses roundup_pow_of_two() to create a single larger window
>    that may over-map beyond the actual memory region. This approach is
>    simpler but relies on hardware tolerance for over-mapped regions.
> 
> - RZ/G3E: Requires precise coverage without over-mapping. Memory regions
>    must be split into multiple power-of-2 windows, and window sizes must
>    respect address alignment constraints to ensure proper hardware address
>    decoding.
> 
> Move the inbound window sizing and splitting logic to a SoC-specific
> callback to accommodate these differences. This allows each SoC variant
> to implement its own window setup strategy while maintaining the common
> window programming sequence.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index fcedccadecf6..a9773e5f25c7 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -223,6 +223,7 @@ struct rzg3s_pcie_host;
>   /**
>    * struct rzg3s_pcie_soc_data - SoC specific data
>    * @init_phy: PHY initialization function
> + * @set_inbound_windows: SoC-specific function to set up inbound windows
>    * @power_resets: array with the resets that need to be de-asserted after
>    *                power-on
>    * @cfg_resets: array with the resets that need to be de-asserted after
> @@ -233,6 +234,9 @@ struct rzg3s_pcie_host;
>    */
>   struct rzg3s_pcie_soc_data {
>   	int (*init_phy)(struct rzg3s_pcie_host *host);
> +	int (*set_inbound_windows)(struct rzg3s_pcie_host *host,
> +				   struct resource_entry *entry,
> +				   int *index);
>   	const char * const *power_resets;
>   	const char * const *cfg_resets;
>   	struct rzg3s_sysc_info sysc_info;
> @@ -1354,7 +1358,7 @@ static int rzg3s_pcie_parse_map_dma_ranges(struct rzg3s_pcie_host *host)
>   	int i = 0, ret;
>   
>   	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> -		ret = rzg3s_pcie_set_inbound_windows(host, entry, &i);
> +		ret = host->data->set_inbound_windows(host, entry, &i);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1753,6 +1757,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
>   	.cfg_resets = rzg3s_soc_cfg_resets,
>   	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
>   	.init_phy = rzg3s_soc_pcie_init_phy,
> +	.set_inbound_windows = rzg3s_pcie_set_inbound_windows,
>   	.sysc_info = {
>   		.rst_rsm_b = {
>   			.offset = 0xd74,



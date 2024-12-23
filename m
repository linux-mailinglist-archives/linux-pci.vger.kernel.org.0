Return-Path: <linux-pci+bounces-18964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1619FADDD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619F71883D13
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967819DF47;
	Mon, 23 Dec 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zft3yCMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B1192D73
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954437; cv=none; b=kXkXf9kCALYsVv+xO0t2NBUa0cn4ncyas2s1iQu9hsqFoLhVqZUDNmXjmW8uTBQRyS4XzeZ7cZhmEf4vhTSJ4Oj9LRzC6bawHp21KohIlLaLxhaR2sNqKIvLc22qq4DRSZ1cy7hhCDjJwRjyQqxVGGzfX3YUT2WC5zj6XAKwhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954437; c=relaxed/simple;
	bh=9B0swlY1icHspmzhbtnmpjXB5ErYiUPiOOG7FNdfGCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKW0bceDpzHHp/Ny+i1cOYOdqW6imDHQ96A+pqzHto++iBsb4P83DxH/6UDyU3tOmJXYIWc+N61YcYPihp0oMzLVTpICIkEUgSoXiiYn/rd61sPWLTfP2xfi5mQ4bNzd3iCOIwBjk8WHxhJx8Wq//H2iiWzK2V0VO3P/JM5M23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zft3yCMA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso52692171fa.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 03:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734954433; x=1735559233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7flEVlk8MpTJOgTC9yYtanlDHLTp9jgY7oIg2zLVp8=;
        b=Zft3yCMAfSkfb1CmOb6WTndLnvlgKzVsPD4hXB//uJX358uIbqc8PdzzUq/1mhsX2j
         +kJZRXDFSc8CkekWtO4Eil+hqnYugC/D8+QhhaOWep0sTJ7BIf5DB0VQLGtCxJxMo0QQ
         EYgoW4FAMJ4YCdf+W8FsqM+qEC+cVfZingdsZXyG2bZJSG9eCAt0ZM7v5Fho2x7Ux1YM
         YBpO9ZDG8M8aY/1k3EzEPZChoi7529/NchMNVD1BX5AwW8xHtw0Hq+3uGXV+svx46Ciz
         p59mptzJVGlI726xQNaYKtYJvednLNntZD27hJwxbdoVIOCU29M+o6sRKYs1H7uz1z2U
         Qucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734954433; x=1735559233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7flEVlk8MpTJOgTC9yYtanlDHLTp9jgY7oIg2zLVp8=;
        b=Go/OmfRKS0UkZRf8X7Vg8TCeihUiUjOvESoo83vAyCVq+br///MojxvcXr/yfyeA9c
         Wfa7LvgQS4qwqC1htj2PYCVNt8B4/pNdMmg/C/Cr6mcOPPI7Bm4cYcCtwf+eLOKksJk6
         GFwERHw8ApVVRNV6Xxig8maLhaRlOJPVt4UStMGR+MfMn+UZVZUWokNjKvW91CSdD8uS
         phGG1ZpszTMJp9DB+z53gUzMZRSoz4EzzZiVt6L5Q1NwhPKbsnP6VV3+/jFO0GAe6gWo
         e7cnbzb9BWRaWFjNTUCSiCzrEmBTLjtbHUbV5flOAezp9pHTH7aeZ4ZDc9pa16lCWm/m
         a5hg==
X-Forwarded-Encrypted: i=1; AJvYcCWHEYTH/jW7LP0S6qHwl0ZAAiSf7R7KrJx2EXQU/I5I9eyPrQW1G79voYx7oBhAecd9lClQejCVZDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90Nilt00DaDIvkm1pfJWWQwVt55Gjn/0fRGa0a4KU1fmVFLZs
	tl1GNwRl3+ZP3OygERanbziaAnlKcvA1TPqbzvK04vbxsYEltBIWjFJxIRXHk30=
X-Gm-Gg: ASbGncsPbupMIKw+ACfrCmG/1Us8dP1QhBtUhPXLosJwWieWH+ceisUWKR4hcNiFyfq
	hWULGjdFGnNePDp/OmBPVucMJX4b3DT+EyD550KaieZph+4msbSztoGyLTXHMEHO7WFm5FIqKEo
	5hkiafSCViFayzGxDOkd+eTXbVa9U+DOjeopiZogdNs6Xl8tBQYAUMMsVjjI13Asm6EtD+bgyO/
	uXLKB9QXpbzmY3fGaYx6HgbZHj5XW0d/w+9Y7kVCx83afrFsKhPzsuML8VxVtpamkOLd6yXMh7m
	2L2yj2y28TvQfopXTwwAF8Qb3i+HFNc/Fy+u
X-Google-Smtp-Source: AGHT+IHLyRi7Tw7aBKCX/6QAu/E4dS/9nNWC1QwOhKkG5IJ629IcuSzAa7yysmIgIEYb+glTHefHsA==
X-Received: by 2002:a05:651c:545:b0:2ff:bb68:4233 with SMTP id 38308e7fff4ca-3046862f303mr47513551fa.33.1734954432965;
        Mon, 23 Dec 2024 03:47:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad99d51sm14072201fa.32.2024.12.23.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 03:47:12 -0800 (PST)
Date: Mon, 23 Dec 2024 13:47:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>

On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> Based on the number of lanes and the supported data rate, this function
> reads the device tree property and stores in the presets structure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 17 +++++++++++++++--
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index dacea3fc5128..99e0e7ae12e9 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>  	return slot_power_limit_mw;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +

kerneldoc? Define who should free the memory and how.

> +int of_pci_get_equalization_presets(struct device *dev,
> +				    struct pci_eq_presets *presets,
> +				    int num_lanes)
> +{
> +	char name[20];
> +	void **preset;
> +	void *temp;
> +	int ret;
> +
> +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
> +		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
> +		if (!presets->eq_presets_8gts)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> +						 presets->eq_presets_8gts, num_lanes);
> +		if (ret) {
> +			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
> +		if (of_property_present(dev->of_node, name)) {
> +			temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
> +			if (!temp)
> +				return -ENOMEM;
> +
> +			ret = of_property_read_u8_array(dev->of_node, name,
> +							temp, num_lanes);
> +			if (ret) {
> +				dev_err(dev, "Error %s %d\n", name, ret);
> +				return ret;
> +			}
> +
> +			preset = (void **)((u8 *)presets + i * sizeof(void *));

Ugh.

> +			*preset = temp;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..82362d58bedc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>  }
>  
>  struct device_node;
> -
> +struct pci_eq_presets {
> +	void *eq_presets_8gts;
> +	void *eq_presets_16gts;
> +	void *eq_presets_32gts;
> +	void *eq_presets_64gts;

Why are all of those void*? 8gts is u16*, all other are u8*.

> +};

Empty lines before and after the struct definition.

>  #ifdef CONFIG_OF
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
> @@ -746,7 +751,9 @@ void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
>  
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
> -
> +int of_pci_get_equalization_presets(struct device *dev,
> +				    struct pci_eq_presets *presets,
> +				    int num_lanes);

Keep the empty line.

>  #else
>  static inline int
>  of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> @@ -793,6 +800,12 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  	return 0;
>  }
>  
> +static inline int of_pci_get_equalization_presets(struct device *dev,
> +						  struct pci_eq_presets *presets,
> +						  int num_lanes)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_OF */
>  
>  struct of_changeset;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


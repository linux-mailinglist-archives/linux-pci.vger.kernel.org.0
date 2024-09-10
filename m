Return-Path: <linux-pci+bounces-13007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C5973E3F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F085B27E76
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5191A38CF;
	Tue, 10 Sep 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XwR6pyb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3E1A2C1E
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988099; cv=none; b=F8W6U8yuAT7Idj/m7TiV2VxwVPUoLuIb2+iLK7zcOE/fhm6NgAYKtwwnrRwG5VtwyVohqPzgRz4PPDqYMfXKmM70UqtbxjUGdYzxiYXGLNNMWvMMxtQVKqZNjOCu8Q5Wz4La8mQIWfYJaKeZrkcquGsNhOW5dO4cb1Zf567++qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988099; c=relaxed/simple;
	bh=PsoKbmnPw8uD/ESYxSoCTm8LcXQuemntQCrFLlLxjIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebQ2qwLU/X5ueeep1ald/HRV1vZloYM1YlVw0824dAIKdWzR8CewJSrpxGui/418rKdZFKuo9WglRJKHNeL28NnNC31TyJvCg7a5gcjCMh20xPfFAfs+MhXZxhClCHTiZ/FcaXEpaCKNoTaZ3d3TG74XrDgH+OUwNaythgD2Bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XwR6pyb0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9a30a045cso354109985a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725988097; x=1726592897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BkAGXy5fwH3yB9Zy6dj2Q5CIztXKHlL7SKHxGY5b/5Y=;
        b=XwR6pyb0uYFHzLqKl/bfgQLsjHvREwKTTp5WNeNTHp5fHytp7S3SrwAxOOUBEsWxoe
         L6F8kxBvd4kpA1NFjvtg1zbUD3jzpEECzXnzh7Nm7V0hFRddweNCiGXerXGPFjjFRDAJ
         K18Ie9JWhzmH33YUr7v3sYS1dmVZ9ydxVz32g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988097; x=1726592897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkAGXy5fwH3yB9Zy6dj2Q5CIztXKHlL7SKHxGY5b/5Y=;
        b=dlvPsjxsb/gNfgSJi7q6DHqStJUSUsKOo9oQ+FWdqui+PT/nSOYlFftVOEp+HhWtr1
         ou31+V/4GkjuBp/Jy/HGNifioh9jVtFZp7Wo3MfA6sl69TcNFYgxsFmZ5Uzzjra6/fa0
         VcPFhjcXreXFSMjGXC/FClmi9unKBZ2109Xn8t806ZM215367+xmQExtYyl77kL/5Peo
         LthTbeTJrmEGu6xxdut9KqgZXrYQJtqOztzK0OOLqrhvZwHTSHiDO/7GIDxlNkbbircV
         HfMmVWR0UcBMtC5HMe2J3A695mmlABFrWDIh5xTo7ef8dAAXTxgGL6REOJucWbaY7rEe
         EZRg==
X-Forwarded-Encrypted: i=1; AJvYcCWlEBynksV0lBZIbwsU7oPdDa4Gc8eUdB8Vx3xA6+qwEScPyqSjt4lhuaeos+0Zt3zLsmy+bmi95Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouODOiJ+KabnvsoCkJqNhEY1yB05fKwFQyLK0FHRYWuJIhrQS
	iirYLzhTsUNdwWIt5v/kR2m4lO4gCxyr8kA6ZMp0uissH2YMr1KYwqMWef1V6Q==
X-Google-Smtp-Source: AGHT+IE3TYPIM1U0DuydzJ5H7rPV3abukJwzsrBcwFc74iGwcfNrsWfwDYMh1gt6nx1YJQE24eQAXA==
X-Received: by 2002:a05:620a:4494:b0:7a9:bdac:63f9 with SMTP id af79cd13be357-7a9bdac663bmr945444285a.10.1725988096759;
        Tue, 10 Sep 2024 10:08:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7967e9esm322618985a.41.2024.09.10.10.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:08:15 -0700 (PDT)
Message-ID: <9d627e67-bac1-4f85-a5ec-ab9b0c167a18@broadcom.com>
Date: Tue, 10 Sep 2024 10:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 10/11] arm64: dts: broadcom: bcm2712: Add PCIe DT
 nodes
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-11-svarbanov@suse.de>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240910151845.17308-11-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 08:18, Stanimir Varbanov wrote:
> Add PCIe devicetree nodes, plus needed reset and mip MSI-X
> controllers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 166 ++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> index 6e5a984c1d4e..9dd127d4c9a2 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -192,6 +192,12 @@ soc: soc@107c000000 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> +		pcie_rescal: reset-controller@119500 {
> +			compatible = "brcm,bcm7216-pcie-sata-rescal";
> +			reg = <0x00119500 0x10>;
> +			#reset-cells = <0>;
> +		};
> +
>   		sdio1: mmc@fff000 {
>   			compatible = "brcm,bcm2712-sdhci",
>   				     "brcm,sdhci-brcmstb";
> @@ -204,6 +210,12 @@ sdio1: mmc@fff000 {
>   			mmc-ddr-3_3v;
>   		};
>   
> +		bcm_reset: reset-controller@1504318 {
 > +			compatible = "brcm,brcmstb-reset";> +			reg = <0x01504318 0x30>;
> +			#reset-cells = <1>;
> +		};
> +
>   		system_timer: timer@7c003000 {
>   			compatible = "brcm,bcm2835-system-timer";
>   			reg = <0x7c003000 0x1000>;
> @@ -267,6 +279,160 @@ gicv2: interrupt-controller@7fff9000 {
>   		};
>   	};
>   
> +	axi@1000000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x00 0x00000000 0x10 0x00000000 0x01 0x00000000>,
> +			 <0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>,
> +			 <0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>,
> +			 <0x1c 0x00000000 0x1c 0x00000000 0x04 0x00000000>;
> +
> +		dma-ranges = <0x00 0x00000000 0x00 0x00000000 0x10 0x00000000>,
> +			     <0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>,
> +			     <0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>,
> +			     <0x1c 0x00000000 0x1c 0x00000000 0x04 0x00000000>;
> +
> +		pcie0: pcie@100000 {
> +			compatible = "brcm,bcm2712-pcie";
> +			reg = <0x00 0x00100000 0x00 0x9310>;
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			max-link-speed = <2>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gicv2>;
> +			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pcie", "msi";
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &gicv2 GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &gicv2 GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &gicv2 GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&bcm_reset 42>, <&pcie_rescal>;
> +			reset-names = "bridge", "rescal";
> +			msi-controller;
> +			msi-parent = <&pcie0>;
> +
> +			ranges = <0x02000000 0x00 0x00000000
> +				  0x17 0x00000000
> +				  0x00 0xfffffffc>,
> +				 <0x43000000 0x04 0x00000000
> +				  0x14 0x00000000
> +				  0x3 0x00000000>;

Maybe a comment would help in figuring out what these ranges describe, 
and we could probably do a single line cell:

> +
> +			dma-ranges = <0x43000000 0x10 0x00000000

Likewise

> +				      0x00 0x00000000
> +				      0x10 0x00000000>;
> +
> +			status = "disabled";

Other than that, this LGTM, assume the dt-bindings maintainer are also 
OK with that.
-- 
Florian


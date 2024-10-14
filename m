Return-Path: <linux-pci+bounces-14491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B499D544
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9570A283B0C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4281BFE01;
	Mon, 14 Oct 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Llgjbq+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17901AB6DC
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925678; cv=none; b=gh3nVnMu+geAg82A0WxBIL3IieYSXREBIKbwAjBVP6Fvw/XILDQWUVxLhx5WxZsramATHZGMdE0ysh04piEW1EDeWWlsU3kJpt0jvEXsUjRVohmSCDTmqykQoM8G3Q9tqRipoksWHaw3QKfCMXmyNbMpe5Wi3K0Si3E0CZMVrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925678; c=relaxed/simple;
	bh=OTxZOlFr7lF/giDCl2WbtXA6Ph6giq3edd6UTXVPf1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvKHAxCj4uiqPsywxgAPQ8IXwGed31oEflLgAZNNFOJ0AjuuyZ23rf1Dxb65F28iNGd0Yb+QEF1hqAJnwPfCnP+gtbuLvg2nzkV7L2OuBZp11LfWpD68nbol+pSr9tR4lkqYrFmCK8DfzRKhsss/vcQAslrG6HJa3QCgXvVp2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Llgjbq+c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1116811b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728925676; x=1729530476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d57W/1gTpeBBCc/zpl7NspKLrqvmEwEWM6BGQvTt2Jw=;
        b=Llgjbq+cNnZN2tl2o7XajT2sWTLjmCMY8RTsv/2XDthTeFdYI4aG39Px/xYles0MGV
         xBV1pZHFseQ3xFTaNoOcB/XjjNoGPHe/Di4BOlmMdvl6q04d/hm/je+q9M2dYuGYYVVM
         srJEf1qM11DxuhxDC3wta25cEywzqvK596WMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925676; x=1729530476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d57W/1gTpeBBCc/zpl7NspKLrqvmEwEWM6BGQvTt2Jw=;
        b=LDguQZjeP4zVXshAA12HYDVM5UBbFQHH4SLrONVzwy3lddE6OYod093M3rkDvM1dwB
         DXVNzXCjF6lzXZrHI4YVMr+zGXUttZ3TnOOcEO2d1+ahkoPk6BUsTdhuekqIpcxfPGnY
         cUW8FDrGD/myqp8YR1VzbUjN/KqhAdzkGksoFcDjB1rZduskRHocVItuKTjZNc9MxV1y
         19Q1PzkE/T/DM34N1/+NQTznqXzKrvGLZgGPzt3m1V9mhXfsohMDQO7l35IjITJbGCDU
         MLeT4R5zGSwqLrgEFmqx+ijIFyJXiDfxFTfiEZZdSr2Cf29PWS9cGWsr4t7RXq41crW+
         /HVA==
X-Forwarded-Encrypted: i=1; AJvYcCUCYpFQsHzBsUU2lH0eVlyKweLOr4es5Xl3nHLzBC5kLIhUnCUG/eCJ7jtqhgiQJAVkbljsU8ymu+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6T7hpyrDVxMXPvDNhQRaMQsU8Dia4IspfRAMk+PLyqLlbn5e
	s4SKQ+JXr+qX1rJQ9TfqxqLtT7LmLrxdy3HA0XB4LgHIItkQnd8RSwIAy+r1HQ==
X-Google-Smtp-Source: AGHT+IFjnV/HtzUs61LrEWSz3V9PeQDvduk31j26C3pMmN26Fi5U9AbminFgIto6QxKKWmdBsMOOZA==
X-Received: by 2002:a05:6a00:174b:b0:71e:148c:4611 with SMTP id d2e1a72fcca58-71e4c13a1d0mr13847060b3a.6.1728925675864;
        Mon, 14 Oct 2024 10:07:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e6818a0e2sm2054083b3a.31.2024.10.14.10.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:07:55 -0700 (PDT)
Message-ID: <60de2ae5-af4b-4c31-bc63-9f62b08be2fc@broadcom.com>
Date: Mon, 14 Oct 2024 10:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
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
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-10-svarbanov@suse.de>
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
In-Reply-To: <20241014130710.413-10-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 06:07, Stanimir Varbanov wrote:
> Use canned MDIO writes from Broadcom that switch the ref_clk output
> pair to run from the internal fractional PLL, and set the internal
> PLL to expect a 54MHz input reference clock.
> 
> Without this RPi5 PCIe cannot enumerate endpoint devices on
> extension connector.

You could say that the default reference clock for the PLL is 100MHz, 
except for some devices, where it is 54MHz, like 2712d0. AFAIR, 2712c1 
might have been 100MHz as well, so whether we need to support that 
revision of the chip or not might be TBD.

> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v2 -> v3:
>   - New patch.
> 
>   drivers/pci/controller/pcie-brcmstb.c | 35 +++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 407343a30439..12591e292c0c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -55,6 +55,10 @@
>   #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>   #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
>   
> +#define PCIE_RC_PL_PHY_CTL_15				0x184c
> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
> +
>   #define PCIE_MISC_MISC_CTRL				0x4008
>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
>   	u8 num_inbound_wins;
>   	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>   	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	int (*post_setup)(struct brcm_pcie *pcie);
>   };
>   
>   struct subdev_regulators {
> @@ -826,6 +831,32 @@ static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>   	return 0;
>   }
>   
> +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
> +{
> +	const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
> +	const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
> +	u32 tmp;
> +	int i;
> +
> +	/* Allow a 54MHz (xosc) refclk source */
> +

This newline is not necessary. Other than that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


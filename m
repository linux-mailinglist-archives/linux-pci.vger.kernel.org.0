Return-Path: <linux-pci+bounces-30479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD47AE5DAF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C31400B4C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D224EA85;
	Tue, 24 Jun 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRMecQPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D57335BA
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750156; cv=none; b=fj2ZQCwNBUCdaAzPJqycwUq2m8YiSSpB2g/QNkBvVQ7dYCF0THRpsxCr8UIZls1PexXJ/arK+ud1TpEkBKpv52VUo9itJ1JnIHF7Su9bSD36/NrswoE/vgWYWUNGZaAr9165x+bMpyA1JrnMrxoP3dsU8W7D7VG4xR3u7XjNDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750156; c=relaxed/simple;
	bh=TZQo+F/jBHrm9unWexUMY/+GozTBkwRpcJ6ui9uqLyc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S7TnLoQk55xE4PaQlPVT+wD3twEx2OIo+jZQnW7UHsszgGe5t4i+G8FyEnUxMlU/HDJOiRvpEZC/UcPh7eFs33Yk+JuY6MWlKmsTVt/JvIFJFNJ2suQoka5rjqLLN2ORoVmr8+mUDWGRbcnvCdpzN/tl4J3cbCdEACvFjvohq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rRMecQPP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so70202f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750750153; x=1751354953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXQvyWKGqoA++0+nLyhrIs47IOqxWVGOvjV4paCklaM=;
        b=rRMecQPPM6eo99rS11ZTMA8WUk+SviQGWWXblh5cE/9MyBo2KBM5zR/sTVx467MmKE
         6hq5ACWk/569Pj1lBD9s6Tnl16qitdTRxzqjvgzmFKqFwtRx/59DmWrcFh4Z2BqYPFUo
         rLyWVhkTgyKUtR0ZaV3PTBbW4qUkKwC9VK6SdIFLvfWeajT1H5IUz27bVA865GIF9eDW
         jCthr0bi3+1PcUVYUguVZukPX++pgAg7G0OalrJTtqbuIyHOBw+ex+yAiqPsWJHh2YKD
         LmfParo1pl+8/r109AAvziYktRKTOvJdZsj/DF6PH7kNh74STdJUWf6QfGDVWlsc9nGY
         PzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750153; x=1751354953;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXQvyWKGqoA++0+nLyhrIs47IOqxWVGOvjV4paCklaM=;
        b=vorl+vrFg66Dx4EGfDw7qrJasrX251cX6mf8nNx9uXterLd5b3yw/IVNOoNONnGoSD
         ylTB6qbrElW8VUD9XtgffgZl2f6xGAWNNuEFyrd8f5ZZyLGcO493A3Hxs+aw/uCDc9bL
         6VSwRHy+j67VYZrhcZoZ+RZQzxObK3zv13LpjfeS/gq8B8nojxsmcFC4b0n/x62Wt3Kr
         nUiyPeaXRs27WAR6eISmN/J9toJ0wCF4+l2YTyErdhWTA6lB8YgPrraCidTWka8Dt/Bo
         pslAupCujGHevG1lKg5MCS7DsOW7P6Lr1offtHNR2cUxW7/dIRSzTFkv/GIoGasufusb
         gTDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVWbAuLkjn8syM4nHGO7DBNWuq8th+Vq8pnq2BtKOjaVn+DzwPXC3I/kz9jIrz9ayWGTF/0MYGlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUDaksBWDBwDQhDFpdN4ufCK77/kY+NTQR5ViDudM+Xh1QxGH
	KgkxydzzjIURmiCHxbMNHXRP6ZzVM4qguQdmqQOUq9lB3blVfhmY5uORHq2KG81WWZk=
X-Gm-Gg: ASbGncsCmgeG9rqzfX4LUrdiqEFALUId7uLZaqwD5Egm1kku9798BbDJcPSYjAYINF8
	COFoI6yxMX9qK+23lY9vJNHdwNIx8JXXeb76aLWRz6Odx22Qyqy9WReQBjS8csKrSjihJLug3Bk
	WmkWcNSAweMwiHTtBgZadFd7b/PKdL7u4C/dwZhnr06C6dlDhAQDf6OZGkDjjhduyehBEpW2QL4
	+wjufjbmLb42LFeITbmN6BiUs/SqTdVDRsxzBG57E+MB4oqrS/cB7ec6Y24AI7oUDeGWeVHrqoV
	caSwy0SdkQN8jKkyfM6crr9Lt+9R2PP0QprT1HDlCwNm6T36df8FjMffAulLjFZSnPVQpKP+M9w
	ydcVslYDWQOgItLdUwRj+R/oK+JtWTLPD3lCNkM0=
X-Google-Smtp-Source: AGHT+IFNAvVc0Ym/Nl4SzjssDYkzNoxmE/MYxf9idIfGl+W01JZ50berxeUOTRJ/Uec/VhLDWdvcjg==
X-Received: by 2002:a5d:64e6:0:b0:3a5:8d0b:600c with SMTP id ffacd0b85a97d-3a6d12bb37emr13160349f8f.3.1750750152898;
        Tue, 24 Jun 2025 00:29:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6fea:600c:ca20:f54a? ([2a01:e0a:3d9:2080:6fea:600c:ca20:f54a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f27besm1190928f8f.57.2025.06.24.00.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 00:29:12 -0700 (PDT)
Message-ID: <754d260c-1a31-494e-af06-49f6aae1813f@linaro.org>
Date: Tue, 24 Jun 2025 09:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIDAvN10gQWRkIEFTUEVFRCBQQ0llIFJv?=
 =?UTF-8?Q?ot_Complex_support?=
To: Jacky Chou <jacky_chou@aspeedtech.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: "elbadrym@google.com" <elbadrym@google.com>,
 "romlem@google.com" <romlem@google.com>,
 "anhphan@google.com" <anhphan@google.com>, "wak@google.com"
 <wak@google.com>, "yuxiaozhang@google.com" <yuxiaozhang@google.com>,
 BMC-SW <BMC-SW@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <7178e816-4cb4-49b3-9a1e-1ecd4caa43ed@linaro.org>
 <SEYPR06MB513414A5AE38EE6749A2902C9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <SEYPR06MB513414A5AE38EE6749A2902C9D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2025 10:20, Jacky Chou wrote:
>>> This series has been tested on AST2600/AST2700 platforms and enables
>>> PCIe device enumeration and operation.
>>>
>>> Feedback and review are welcome.
>>
>> So it seems all PCIe RC code is bundled in a single driver and there's no PCIe
>> PHY driver code, is there a reason for that ? If yes I think it should be described
>> in the cover letter.
>>
> 
> Yes, because our design includes the PCIe RC and the PCIe EPs.
> The two functions use the same PCIe PHY and are mutually exclusive.
> And there are different configurations on RC and EP.
> Therefore, we do not use a phy driver to configure our PCIe but use
> the phandle of phy syscon to set the RC and EP drivers separately.

I don't get why a PHY drive could not exist, it could be used by either
the RC or EP PCIe driver in an exclusive way.

Neil

> 
> I will add more description in next version.
> 
> Thanks,
> Jacky
> 



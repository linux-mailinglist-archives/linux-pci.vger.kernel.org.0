Return-Path: <linux-pci+bounces-22026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C160A40040
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EB4163620
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1A2512FB;
	Fri, 21 Feb 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1piDK0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC331FCFF2;
	Fri, 21 Feb 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168030; cv=none; b=HvB4PfRh0jewVmwfdXwUY/ja9bQ2Rln/Pz6n1OwgslglHxlV6BHOlMbs6GbeQ/bA5Gq70Z8Od+g74hyBW0nLhCdBqPAKHJwr+y9bwUdZhnxnJzEY9QbklqiZ6NvWWPcZJVO2xBmXdAIszApp18I3K8mltj60hhdWLJAoo2W3CtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168030; c=relaxed/simple;
	bh=JeF6DqOgaMLhxI91Dr59kKL8+DhZtDJL0b2peQiXBBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlIGVqKK7DPP/xJ4o/FU5uW2OsRQJxNNclNrm8VHUDfUgjxgNjy/RT8YlvJCD0AuLaYrKhgOci84o0GoDxixY2yj9QMfxd/FcA8y4h02AParcrK2Jatll6yisjn6iDMqPxKmvK/04IouaZl7tf+BgBW7o3s5fSO7U33HH8lkfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1piDK0x; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso440891866b.1;
        Fri, 21 Feb 2025 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168027; x=1740772827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/bDV0FJprpFaWKwMkQmi8YDMou1+i2MOt8dZqdBO6I=;
        b=B1piDK0xP1Dn/1ro5+Bhp0kBXMe/kYAH8wsAzbPq0YNdyZ4gpViw0oOa7rMStSVEoV
         R1VX4xIkpFeWF7rOQ+xepdz/nCQrIvDHEZ5ZNZO9iiK204H5B5pYDa5DzsnhiS6W34pA
         KHPElzE8KT4GBrq3tKkPgJKyaq3LJLz4+Xig3SDMTNBIKt9sP7g08vzWFi9YgseE5HYq
         KpC4z3bws1WqklfO2Iw45Y5aPhzwYYzKcyIS1+9a5Y335wQSpJLq/+NarDbbU1jZJpOD
         WUlgY3OtVv20XWyjO4rQOIsHLK6Gk7FwmT0gK88UlrtGcyoz6KrziqFfQdUW4tqf3Qbp
         aX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168027; x=1740772827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/bDV0FJprpFaWKwMkQmi8YDMou1+i2MOt8dZqdBO6I=;
        b=aPxFuz1clMZpdquzVxIwJStfdbbRnX3KIS5z33Y0//pA2V7+0oIJ3bL/KBfgb2vR+Z
         Nkwr77NoV2rsWd7LZbYpvZJp90NvxYCzHjPtMp9rF/Fv866Icx5qZarw6xeh9XH4KfAA
         aZUEXg9YEV8mjG49rFWzyx1HzngHgj3hQzHmcbg47DGKuYAkFpNyJWu9wUMEaMFvI+sS
         HJVgPtyoOsJEYRvM3mGsa4ogtyEzJRRcO9TYp6FGG52bjv4Je1ewUq26Ls9JnahP3qED
         wn6U6cDACu8/K6dhaiC7Seb50O+YeWyf81f0yywNo3lqoLnGSoGLysuchykDpLDYzEaR
         x/YA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dvSAPxRQM4UuPt4Z7bwNUMotaH6hU6SkVEYDcpyiIpWZI5EcR6A7ZOPhhr0tHtF6DQQLWgf0R5J0ABA=@vger.kernel.org, AJvYcCXi2j4jROa2yU8t0cK+nihioJ1Z5kLkFF6xsXATXTrUoAJk7OS0sx4fyPPylvA5+ENiv+f2G+VGdGMF@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1TqJIo6U7kp1faqMOW6JqFkhbdDzvDmjDgFthlIPklai/OoV
	DYzxJTPjS9Ds2AROYKtXiT/35t8a1JO+iwLLnPru5s76cMN8MZ1ncVz6vGL6
X-Gm-Gg: ASbGnctBHIttW/bK6c4BAivl5TfHm0BJvFxc6ZFuEzN+IuNt47f63LYOxbfpEwKDEAB
	RBhnMLpx0iaMymlfX++onrJ89ll0OLeBtOU9fud6emwprGdjwbItmb2ljYw7B5HVascnXHB2kXS
	1we15/J6cu4sFNo0NWvX1dTJMDa3yxdlPwIqs40t0Z+M5GgDf/ywb4DddHuMZiv9P9XM9nkI+i+
	joZHFDTEHa4GJF/7WgveJf5PHJOimXl6ykdDCuMXeeg+brlzZm/6OXUpIKtFHPdTBwCnosAyanA
	bx38KRfpbgeDpicDGqvGS5UcGvzHPQQ66yDKlUXjMfPra6GiNeWEVIIwrphY06ywI5ukEkm2lHT
	TLNgHQTwdttzCzJc1mi6W5p3MuCIgB0tgcjXjj+wflUcBo0km9qJDZG2KfKehtfJSiKgxKhyVLA
	wM8/pTBrobJ07T
X-Google-Smtp-Source: AGHT+IH7sCibLyLZK+FdM59FBs+/kdsPTeFwVDuE9WC/Cq46tw/WEd3zp1lpAqulE7WN3k2fvR+JIg==
X-Received: by 2002:a17:907:3ea8:b0:ab7:d10b:e1de with SMTP id a640c23a62f3a-abc0d9deb71mr375904366b.13.1740168026317;
        Fri, 21 Feb 2025 12:00:26 -0800 (PST)
Received: from ?IPV6:2a02:3100:b29e:900:9dc2:647a:dfc:6311? (dynamic-2a02-3100-b29e-0900-9dc2-647a-0dfc-6311.310.pool.telefonica.de. [2a02:3100:b29e:900:9dc2:647a:dfc:6311])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abba358ec3asm947077466b.35.2025.02.21.12.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:00:25 -0800 (PST)
Message-ID: <8eadd7db-aeb8-4c2a-8758-e4dbd06788ca@gmail.com>
Date: Fri, 21 Feb 2025 21:01:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Bjorn Helgaas <bhelgaas@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
 <20250221071828.12323-442-nic_swsd@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250221071828.12323-442-nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2025 08:18, ChunHao Lin wrote:
> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
> device will exit L1 substate every 100ms. Disable it for saving more power
> in L1 substate.
> 
Is this compliant with the PCIe spec? Not being an expert on this topic,
but when I read e.g. the following then my understanding is that this wakeup
every 100ms is the expected behavior.

https://lore.kernel.org/all/1610033323-10560-4-git-send-email-shradha.t@samsung.com/T/


> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9953eaa01c9d..7a5b99d54e12 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2851,6 +2851,21 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
>  		RTL_R32(tp, CSIDR) : ~0;
>  }
>  
> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	u8 val;
> +
> +	if (pdev->cfg_size > 0x0890 &&
> +	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
> +	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)
> +		return;
> +
> +	netdev_notice_once(tp->dev,
> +		"No native access to PCI extended config space, falling back to CSI\n");
> +	rtl_csi_write(tp, 0x0890, rtl_csi_read(tp, 0x0890) & ~BIT(0));
> +}
> +
>  static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -3930,6 +3945,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>  
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  {
> +	rtl_disable_zrxdc_timeout(tp);
>  	rtl_set_def_aspm_entry_latency(tp);
>  	rtl_hw_start_8125_common(tp);
>  }



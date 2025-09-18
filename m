Return-Path: <linux-pci+bounces-36409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B385B83E46
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0791C005F4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBC279DA1;
	Thu, 18 Sep 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ybv3BI+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394027726
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188865; cv=none; b=k5dZhI1G0pqUxIiI3p0NPo8iU23cFeidMaoH+V1dUxmso+y5tziSewEOeBpyAIBO060sqXBTTJfRE2q37jl9C51Z+1P3CYzvzUzWaG8U7OdrpW+03G1MoGH63ETdp51JXQijc98z+rUsZuCO4GH3tyKN/qo4oWxPCyXZFliLB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188865; c=relaxed/simple;
	bh=ebIejkG9lO3H+4v19Kd3NsOO4t6uOqMYtPLh1XK6HPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h08HeKbB5X4ZJ8kg9JSn/zvKgeJY0qewQ8gktpoB5NazaKYr3tk/Q70brsysYn2lSE3dOfFk39zm4RPDiI1Wf9caQI8Ttz2na58rMyswZvpj4GJRJpRfkds+diHv1J+UMvtAXqKvbIV7OR21gkyqMqZB1eZ9SxMwm1c5EI/4GNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ybv3BI+6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so107131866b.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758188862; x=1758793662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY2fN2zgk9K5ePhnAH7PE+WNn7DSzrHO8ylDHhqkcZ4=;
        b=Ybv3BI+6pNabav/XvdmX6XIsppQ0M/5IxuGMMtXGZgPUwY0Lnd/MprI2Pk+tOS7kbu
         w2fp5utdwqax5a1S9sBlkkn7oAbBk1ju3xCZ0EHQv/lYLwEjgbeUIgxZIxTOhXj9nefr
         qPiv2mCwuGuJI9ezJUK6Xo9K1uZ9Ae08ij4XxyXDeSwiFt/BW9DxV3KC2zA3DKvDrGI6
         N6nUXPpEtXLqIsyy3Q7F6qLx0OuqWg8OE6X6flkiKAoV4oFhP5E9C0Tvw9SvRzp8cluG
         yxv9j7zqAIQmCBkecM0MwzPVezr/UPQoij/GCYGfDzWnDgeb+mBWcoO4AzzC1oMpIkT4
         cJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188862; x=1758793662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY2fN2zgk9K5ePhnAH7PE+WNn7DSzrHO8ylDHhqkcZ4=;
        b=uZBndBzIU/tZtNNKYWKgtM5bwykKp0t3Mx+f/sxxKYbOasJaR26vSn4VL++hN5TwjB
         inBjsNyhhlZD+rFtnn9w0MKi/UhydZ6t8P/t9SQtgze1JhuEpcSFNehC3zT7ruDEcifM
         BTN8jO2dvzZfhmitpXYlPFEfmgejAlwvBYYy3bOSwtVMnCcyD/yjMifMt3HLUjabnJID
         kQ31cMgx9QGubqGDBGWCy5ZA2Uqu/3J4wRiFiAvE94i3cXz4NO2964hdZdMmJYIJeX7N
         ArZFZzG+JSQJPnpydgdRYsBSMkcdaCrd0JKStWSF7I9DyX9RupcED4Hk7UUbgbLGpFop
         dcWg==
X-Forwarded-Encrypted: i=1; AJvYcCUgpMPlDCmBZix0ZID2gTCHMz6Qm5HTR//1q3CQx8UGn2QarQINu3MF8rmdw75mZjO5foaJkbo6Woo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq+NM5a/QtCXubnIswI2EwIxpuvuFHO6XQGrzE7Ds9bBCnVvQ
	Q+KfiCeZZOcZEShxidh/aLSKGooI8EMVOIy7JwFMnDs9FWb3b+6q+/Ft8oFTtVpL+2E=
X-Gm-Gg: ASbGncvuAAMRHl7H3hfHx51yYet9jPLJMbYAJQktSq5IDlWyzYc8UJtVdw5KFWqi/Vh
	pUS7XsdNDU6AnQ/nhAfa/8J00QeolePlGe9BisCunyaB8eVVCYUoN6ot7DbcDe0IsJEL4qVVNP/
	xoXx+XKza7nc1hyYgwPECdbv12E6YxejrTt05GKVtK3dF4AqQ2izJsUid8wupBX9ZdLWlTT8vyb
	QJvQWT5M0ezLl8b/CNeSWmxnnCozZYcK2LYrpNXmIrmHJEgyi49dk+SXfY9OgQKrN+qKHf69QiJ
	WREbeY/OrtVE+1zyPNbbOcKleNXQbSB0KfckTvatI3aQBAS1g8mAKNAblyZl1sLVpMU4i3OFsiw
	eX8tBWpBG6S3fOy3hIAXNgrKfSmIkgH9HWGAKf6xDpe9gW8WyhYm/cRUM9VdH
X-Google-Smtp-Source: AGHT+IGm1gMecKNS7ulsOyutPp7cC/3sMrnG/x/HjeoFQdZsaPx3dh9Tz2I2uksJ4hOSdxJlyIcHBg==
X-Received: by 2002:a17:906:730d:b0:b07:88ae:4b80 with SMTP id a640c23a62f3a-b1bbb7615cdmr515429166b.65.1758188862248;
        Thu, 18 Sep 2025 02:47:42 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd15cb2fesm161684766b.89.2025.09.18.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:47:41 -0700 (PDT)
Message-ID: <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
Date: Thu, 18 Sep 2025 12:47:40 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/18/25 12:09, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The first 128MB of memory is reserved on this board for secure area.
>> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
>> memory node (memory@48000000) excludes the secure area.
>> Update the PCIe dma-ranges property to reflect this.
>>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -214,6 +214,16 @@ &sdhi2 {
>>  };
>>  #endif
>>
>> +&pcie {
>> +       /* First 128MB is reserved for secure area. */
> 
> Do you really have to take that into account here?  I believe that
> 128 MiB region will never be used anyway, as it is excluded from the
> memory map (see memory@48000000).
> 
>> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> Hence shouldn't you add
> 
>     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> instead, like is done for all other Renesas SoCs that have PCIe?

I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
the available memory for board, as the available memory is something board
dependent.

If you consider it is better to have it in the SoC file, please let me know.

> 
>> +};
>> +
>> +&pcie_port0 {
>> +       clocks = <&versa3 5>;
>> +       clock-names = "ref";
>> +};
> 
> This is not related.

Ah, right! Could you please let me know if you prefer to have another patch
or to update the patch description?

Thank you,
Claudiu

> 
>> +
>>  &pinctrl {
>>  #if SW_CONFIG3 == SW_ON
>>         eth0-phy-irq-hog {
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 



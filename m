Return-Path: <linux-pci+bounces-36462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD6B883A9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231173BE8CC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342872D2394;
	Fri, 19 Sep 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LLfIf4GA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EE2F7477
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267539; cv=none; b=CbzzOPhmk9nPnKY1IjGpqEhzY7uqDrjvJPQ9N574QP4dCXlWzPpdm47xIdGrN7wRJyZX53OWnZW/FT4G4ZQlPNvttzckcLZnsUL0i8VLyefthS+2ekkCDzNWkNpoloVKdaWtmF1Qs1hZ/NfCUyVD3bbW/9//4iwT993O/O7yn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267539; c=relaxed/simple;
	bh=kMc6qIYkpkSaZVkYzK0h2R64lMZcG/aeYocJD7OH9t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYJGR804LLNESEN4bkeOPxd3VDRCZ2hQdGl2Oeu06F1IxC8XUB81HF+PMp5Dwmb0RT0LHcuasPIx0rzkDSLyX9TvxTZX+D10OIVDasW2bMu4tlZBNBS0hgWgbNJPW+Xd0pWSmJEOZlRc5g/t9IS88BY36VZDQN2UyPtQQarv/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LLfIf4GA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so2778342a12.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758267535; x=1758872335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C52fJI8OZn6dmpJ0EOOlg/5SF4AUK9kWOko1av6xLQQ=;
        b=LLfIf4GAnVHjjU7p7nlOkC4EhaL2uxwAaiVPmwozaKqf/Tv9iNlt8JRYALD5QEJGq1
         vLnCmIBKAL8b57erjZBJQum377AcTR1Zc02OCH5DfOOEg0klz47zdq698d67fMZlIthG
         B5/l8VqVSkIfYMgYYlvy34sn/3fjjm7hCKI8738VPuATVWOvwxeiij0WAzMOIn2XuaXw
         z1HoaJ5F/iT03Wqp2z2gOBNYDNQvvpQyJbBbW52D1HTtWkNEdHSLdr0AZ9FLq3lxGNZ1
         PrCLb5fWQZsP+S4N/sFGAzUcylmgvYda6n8AwWiPMVVFmlpAnn4BAHmZEEf8Ec1M8qXW
         Aw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267535; x=1758872335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C52fJI8OZn6dmpJ0EOOlg/5SF4AUK9kWOko1av6xLQQ=;
        b=gYVjWEfFtDJW+RyE+9fbmnskjrCA4MkR5kMyR25V5AmGzLAHhnf0TkO/me0DCDmEEE
         shQjhuOFzWGzcUs3lp6Sd4hb8P0tRjlizTAIV5YArh0oR2uj5VTr2e2gzTItexlGT036
         vuRJcNh8plPD/6dAu2HkztXGO4NAN9EpbnKwCKV/kv6cnXEWF8wdKl8Bco/5E89zQOtl
         XIGwvKdTlakh090tqnQVGP/hK04uQSy8doDivQeM5kvT3XQ8cEMdLsPiQqvAJPBsV3IR
         AdceqnfT1HbnNfpVDTLUctQo1uf2rJF9M4yEca4/up2+zxk2VDF/tVbXKDvtW1Qo02GF
         lczw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7VeI/sDohMcPm54iq++ghSJT81Vm3VkxzEw9UYalTqJQFAIjNHJXJ2Nc0szxd4fNeW+oT3SzUsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6o63dPWDa/8EJo5ledXzsseLmKm/pHbd05ASobhA7MwWzGI3
	olHt8ehyiKp82PKZFFUvqXKRun5LGdZBCDWWj7OjrDbtKnbB4PA1M11KZH5oBCSrkkI=
X-Gm-Gg: ASbGncsVKF4mhAOw3kQM+1NYKRj7cDmvP0edZ5PxI8BXVhg5vPXt4FI1h7epK1SF14z
	gBMI1Eg20C2gxpIiV9/19JENF0WEFn96b1K1343Viq7fhcIhvuMSQmd3TI7Q51nfkwnjKU4YRCE
	uxM/BJWV/Ehqw437fvJryqV0WzdfjU0azYXL+9QEVKR5y4JKwEGRRFcuGD5DmqwZOPpaf6OqTSX
	FkQOOLl16Pb2j1H3hS/btUcyqvM/GlZr+WFuuGlx31rifxf4ngXrYh9HINPy+2tRFCVqLE8wNhm
	6ti3z6Jn/ZNzipeN3FJxJplpl3m3hbQeroZIy07jVKPLnj7RJcod1G3FJyz33UIwldJ7RArgX3U
	YdSkWAPT07fiOAQ8sSv1dMtkd81O8gYGZruKlsggDNQ==
X-Google-Smtp-Source: AGHT+IGZhuyuyTd1aKAi+fBtFosLneGcx8gx8yEr9OgXp4C95CMy9oC3K7BFoFpsdhrbZOu6d5TNSA==
X-Received: by 2002:a17:907:3e96:b0:afe:63ae:c337 with SMTP id a640c23a62f3a-b24f727a7f1mr237583366b.57.1758267535087;
        Fri, 19 Sep 2025 00:38:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43924sm386437766b.6.2025.09.19.00.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 00:38:54 -0700 (PDT)
Message-ID: <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>
Date: Fri, 19 Sep 2025 10:38:52 +0300
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
 <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
 <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/18/25 13:00, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, 18 Sept 2025 at 11:47, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 9/18/25 12:09, Geert Uytterhoeven wrote:
>>> On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The first 128MB of memory is reserved on this board for secure area.
>>>> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
>>>> memory node (memory@48000000) excludes the secure area.
>>>> Update the PCIe dma-ranges property to reflect this.
>>>>
>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>> @@ -214,6 +214,16 @@ &sdhi2 {
>>>>  };
>>>>  #endif
>>>>
>>>> +&pcie {
>>>> +       /* First 128MB is reserved for secure area. */
>>>
>>> Do you really have to take that into account here?  I believe that
>>> 128 MiB region will never be used anyway, as it is excluded from the
>>> memory map (see memory@48000000).
>>>
>>>> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
>>>
>>> Hence shouldn't you add
>>>
>>>     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> Oops, I really meant (forgot to edit after copying it):
> 
>     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x0 0x40000000>;
> 
>>>
>>> to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
>>> instead, like is done for all other Renesas SoCs that have PCIe?
>>
>> I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
>> the available memory for board, as the available memory is something board
>> dependent.
> 
> But IMHO it is independent from the amount of memory on the board.
> On other SoCs, it has a comment:
> 
>      /* Map all possible DDR as inbound ranges */
> 
>>
>> If you consider it is better to have it in the SoC file, please let me know.
> 
> Hence yes please.
> 
> However, I missed you already have:
> 
>     /* Map all possible DRAM ranges (4 GB). */
>     dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
> 
> in r9a08g045.dtsi, so life's good.
> 
> +
>>>> +};
>>>> +
>>>> +&pcie_port0 {
>>>> +       clocks = <&versa3 5>;
>>>> +       clock-names = "ref";
>>>> +};
>>>
>>> This is not related.
>>
>> Ah, right! Could you please let me know if you prefer to have another patch
>> or to update the patch description?
> 
> Given the dma-ranges changes is IMHO not needed,

I kept it here as the driver configures the PCIe registers for the inbound
windows with the values passed though the dma-ranges. This is done through
rzg3s_pcie_set_inbound_windows() -> rzg3s_pcie_set_inbound_window(). The
controller will be aware that the secure area zone is something valid to
work with. In that case, if my understanding of PCIe windows is right, I
added this in the idea that an endpoint (a malicious one?) could DMA
into/from secure area if we don't exclude it here?

Thank you,
Claudiu

> this can just be
> a separate patch.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 



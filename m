Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BAA324E4F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhBYKcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 05:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhBYKa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2021 05:30:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F81C061574
        for <linux-pci@vger.kernel.org>; Thu, 25 Feb 2021 02:29:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d11so4695410wrj.7
        for <linux-pci@vger.kernel.org>; Thu, 25 Feb 2021 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9+3/+fyGcCMN5e5ou02tPq2RuOezR5zkyq0RSXBrWY=;
        b=sxyW9XTGWiS2KQYpcoSDRLitbuIrI8z0nerDJDyYsvMqPTygeAPgVQ2SnhkrUe/Y9P
         I1VMi3Rpz7S1em9XQMU2ZSTXKVJQy8ANW9j0C5mlukLC1Q4qN/4b0kQTR/V0Fgc8Uztk
         gMKfkbdeyUXS3FKjxEO00c42TkH0xBgZmKKFJEc3e1i14B7zlrihHD76q/79Rg2x2cDc
         nrAq3F4eC68TtABIE4a4xGJwBuzZlPVqI4Iw35CGxxikAI5lHKghC+SdARwOaWA1J841
         LNvhP8B/YnEN9bvFPxW86BWipGv8iqaxM90/KllLliodOOHkOZd9RrLgu8g23hKuEupE
         yb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N9+3/+fyGcCMN5e5ou02tPq2RuOezR5zkyq0RSXBrWY=;
        b=jdKkj+ntWTKlru3GS4b69AsfOLWPYsJvw8XhSErm3EfMpuroxr5fySGANm9OaIHM2V
         gQH/osCvH+AL+s/5HrkPsRm/1C1X1jAkBOae0a//PSK524tS5TuTLeNdE5rjrmAKJuje
         l1wknmG7QrBUDyq/nuZKrcqn1nKXnD1koF19DA895THfBvG9JniakEAkyQ8ctd0FyDZc
         eHGvcp3ObwJgVBAJLuCz5lUsBHyXhgwXf/JAoUjuhlhlR/bI86ZnKufC/rE905kLbDCc
         iZMZWaMehh1bcGur8cPgXiVTTSwSi61IJqloqmyJ3hzoq5mVUvtJPkls6I2iHAQAEs+K
         0G9g==
X-Gm-Message-State: AOAM531saFf6e5/xYD3KTE1aY6va3oS9ejEhgHi9U5/g58iWDEDxgkrv
        1W2nTfEmpiVN4jCkVNhYMZcA2Q==
X-Google-Smtp-Source: ABdhPJwVfUdBrdeuNlwsivJTQqSABtod4qNsZUbOKSeh4ocXPfQfyf3a9FO5bJ5gmpXXkMoihvWTeQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr2790715wrv.111.1614248986796;
        Thu, 25 Feb 2021 02:29:46 -0800 (PST)
Received: from ?IPv6:2a01:e0a:90c:e290:c3ab:3c03:bb16:99c6? ([2a01:e0a:90c:e290:c3ab:3c03:bb16:99c6])
        by smtp.gmail.com with ESMTPSA id m6sm7964148wrv.73.2021.02.25.02.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 02:29:46 -0800 (PST)
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Robin Murphy <robin.murphy@arm.con>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
 <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
 <20210224202538.GA2346950@infradead.org>
 <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0e52b124-e5a8-cdea-9f15-11be8c20af2a@baylibre.com>
Date:   Thu, 25 Feb 2021 11:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/02/2021 21:35, Florian Fainelli wrote:
> 
> 
> On 2/24/2021 12:25 PM, Christoph Hellwig wrote:
>> On Wed, Feb 24, 2021 at 08:55:10AM -0800, Florian Fainelli wrote:
>>>> Working around kernel I/O accessors is all very well, but another
>>>> concern for PCI in particular is when things like framebuffer memory can
>>>> get mmap'ed into userspace (or even memremap'ed within the kernel). Even
>>>> in AArch32, compiled code may result in 64-bit accesses being generated
>>>> depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc.,
>>>> so it's basically not safe to ever let that happen at all.
>>>
>>> Agreed, this makes finding a generic solution a tiny bit harder. Do you
>>> have something in mind Nicolas?
>>
>> The only workable solution is a new
>>
>> bool 64bit_mmio_supported(void)
>>
>> check that is used like:
>>
>> 	if (64bit_mmio_supported())
>> 		readq(foodev->regs, REG_OFFSET);
>> 	else
>> 		lo_hi_readq(foodev->regs, REG_OFFSET);
>>
>> where 64bit_mmio_supported() return false for all 32-bit kernels,
>> true for all non-broken 64-bit kernels and is an actual function
>> for arm64 multiplatforms builds that include te RPi quirk.
>>
>> The above would then replace the existing magic from the
>> <linux/io-64-nonatomic-lo-hi.h> and <linux/io-64-nonatomic-hi-lo.h>
>> headers.
> 
> That would work. The use case described by Robin is highly unlikely to
> exist on the Pi4 given that you cannot easily access the PCIe bus and
> plug an arbitrary GPU, so maybe there is nothing to do for framebuffer
> memory.
> 

Erf, not really, with the compute module ATX/ITX boards are being designed with a full PCIe connector like:
https://www.indiegogo.com/projects/over-board-raspberry-pi-4-mini-itx-motherboard/#/

Neil

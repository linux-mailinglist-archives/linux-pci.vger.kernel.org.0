Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F034DAAA0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbfJQKzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 06:55:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54358 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfJQKzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 06:55:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so2064255wmp.4;
        Thu, 17 Oct 2019 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IxONth+hY/1FvXeqwblw/4Ymr/wl/s8t1jCvbrkXrm8=;
        b=HvaOaGTUaY8qTjatP1fL8lYGlu5Ze5H5Dq2SQwVso1Ui+gwgapAMFHP+HF408qrkBA
         la+yd2rcynsrqahrrT6RstVzAuTxe16CzQT4x9J81IeZfYlmgxD8rb/kbiPgVS0oZPLj
         WMdSDmg7JpN34OMjhi7qnmaEZxpBKiOCdC2Sht8qVxTq0z/++NaUVDOdo6FJyVEyljoO
         OKUX4CuAE4zytF4tChAqm5jjiIcaxR9yUnI71PV88bO0TmGje6kffzk9AnwFua2pU1Cb
         3TK/Ec4AZT7UM+mWFYY+WSff8N+xlrHk2EXEWjb+1I8aRESjffVyxS0pgW5dw64bUvy6
         Qs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxONth+hY/1FvXeqwblw/4Ymr/wl/s8t1jCvbrkXrm8=;
        b=TnASoNtRxB/FqM/Y8nV0suiueS+R+3i8vDL+n/MlUC3qE0miuNvaHTLEukm1sVm4bJ
         78aQCBa/cR36qD3QQAcGHgHsBEC6A20kENv1f9WUeDgE5Tco1YOCVfVNWC9m/+qiZgVy
         d3U8+v+1LaxGdHwFC3GWgSPSFCkvjZYmIFgnuxc82Um8CRP9m2zQxjXV/IXrhnNuxqPK
         ftf/5vRBewc/hm8INQfQmTqf6FufIcSFkmX6uYIJmac7xoq3iozMiT11DXe89C7Im/vQ
         /BME+s+1dKGmXEYdrH4cK+0cC6C1jt4uNDnWBLCqAnVDvxr3fWwFN/L0yK+CQVWwKMzz
         Orzw==
X-Gm-Message-State: APjAAAV6v057VrfZ14NLGwijL/E5B+4/jCF1pxktbX0J++2+RsLck24I
        Ktx4WE8GMTY/HAxKfPlbR5b6WRHk
X-Google-Smtp-Source: APXvYqy+vr5B6Za8vkExE+Yrbd7gALcxMJj6zZY37ykX4Cr6JEjeIhRoygnkXdEEALcs8ZVQwDXsTg==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr2304570wma.65.1571309752446;
        Thu, 17 Oct 2019 03:55:52 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id g1sm2049024wrv.68.2019.10.17.03.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 03:55:51 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
 <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
 <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
 <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
 <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
 <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
Date:   Thu, 17 Oct 2019 12:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/19 9:06 AM, Geert Uytterhoeven wrote:

[...]

>>>>> I suppose if your intent is to use inbound windows as a poor man's
>>>>> IOMMU to prevent accesses to the holes, then yes you would list them
>>>>> out. But I think that's wrong and difficult to maintain. You'd also
>>>>> need to deal with reserved-memory regions too.
>>>>
>>>> What's the problem with that? The bootloader has all that information
>>>> and can patch the DT correctly. In fact, in my specific case, I have
>>>> platform which can be populated with differently sized DRAM, so the
>>>> holes are also dynamically calculated ; there is no one DT then, the
>>>> bootloader is responsible to generate the dma-ranges accordingly.
>>>
>>> The problems are it doesn't work:
>>>
>>> Your dma-mask and offset are not going to be correct.
>>>
>>> You are running out of inbound windows. Your patch does nothing to
>>> solve that. The solution would be merging multiple dma-ranges entries
>>> to a single inbound window. We'd have to do that both for dma-mask and
>>> inbound windows. The former would also have to figure out which
>>> entries apply to setting up dma-mask. I'm simply suggesting just do
>>> that up front and avoid any pointless splits.
>>
>> But then the PCI device can trigger a transaction to non-existent DRAM
>> and cause undefined behavior. Surely we do not want that ?
> 
> The PCI device will trigger transactions to memory only when instructed
> to do so by Linux, right?  Hence if Linux takes into account chosen/memory
> and dma-ranges, there is no problem?

Unless of course the remote device initiates a transfer. And if the
controller is programmed such that accesses to the missing DRAM in the
holes are not filtered out by the controller, then the controller will
gladly let the transaction through. Do we really want to let this happen ?

[...]

-- 
Best regards,
Marek Vasut

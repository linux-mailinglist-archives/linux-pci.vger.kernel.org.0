Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB9128E89
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2019 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVOcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Dec 2019 09:32:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfLVOcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Dec 2019 09:32:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1336725wru.4;
        Sun, 22 Dec 2019 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JTaMAihMQcGoLYVzC8yfarHE4d+Vw11ecW2v7rlvYc=;
        b=aW4GWiH4RRWzVi1YvxtgC6SKRcDtgfkHhl5d9qxCzfDOlqz8FrdxgU7iuLwEvejWbo
         d6pXhPqoKCP7QfnYEWuP8ZA+EfkOBG8k3YtGszhBeLjdH+7KjgjkmFliIPuJ8eCUG7MS
         D25Z7LykTLWJmCjBXbVpz5J3ZLFqwPqpn/yKRP7/xBwZ418M1YxeJ6zfJ/Lds2LNoB4A
         avUZZnfmXv2zV72xUrTa6cAxTh9/9iiL+D6G9Mo766L8asxIhpfyUY/y//85WVTvSsed
         Webge9BNSGswgWzXHIlONEKnXukBPf7lJBiTfOGCcjkUl8cnWqD1cOKfJr46qsixxqk0
         fwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JTaMAihMQcGoLYVzC8yfarHE4d+Vw11ecW2v7rlvYc=;
        b=BH0tErNqbN9dzAL4cNWl2KwQ0wSt8sxNXs/ttQa6Y5lBkrd7PkCBZjM68pTNZ+knDw
         Ax6E7bl4YPSiP/jRHfcGrQ9nKksPFn/K9j7YzZCNSXdhJfR1Nj4kSsB9Mqi4ceJylQSX
         Z7kt5wGOC1OoMxLWQN7W8a4aG3ZtErr1h17JywioDkqUp/6ptJzdzTGUDp0obgy33LcR
         4MZLbzPoNb2UzyD1A0b2mzMv69pG6EdH9CHqjrlykTSGjQdg+QkNUNFWq8AuvM+f7Xr9
         VqwokFDo0I6dOAkeGcFzwlbmPXPQ6XTqvjla6tQdAioVjDVZuEZixPMNNth1kqKZoSET
         mlig==
X-Gm-Message-State: APjAAAUTjPgKq0oLeORoCp3vAd9XuKkcqaQeBs20qVuFuVwV5mgl2/1V
        xV9BgIiR7K9Mwj43bYYGv8FRi6He
X-Google-Smtp-Source: APXvYqzGNZRDvouRP65RO3Fj4ECALDB/bjLNoA1qO8hB9P5QU33Y7/nHQ87nvJdmY0xXeojYWMpNSA==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr25602381wrw.311.1577025123628;
        Sun, 22 Dec 2019 06:32:03 -0800 (PST)
Received: from [172.16.0.186] (188-175-35-175.client.rionet.cz. [188.175.35.175])
        by smtp.gmail.com with ESMTPSA id i10sm17179060wru.16.2019.12.22.06.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 06:32:02 -0800 (PST)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Robin Murphy <robin.murphy@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
 <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
 <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
 <9c46a2d2-00bd-3854-8060-fc7389751f3f@gmail.com>
 <20191107141906.GB43905@e119886-lin.cambridge.arm.com>
 <3424b83c-4693-0259-ac3d-ea10a3f98377@gmail.com>
 <82c69634-ffb5-0b20-2254-55e5cfbef035@arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ddb1295c-dbee-d965-0278-52d8b8937940@gmail.com>
Date:   Sun, 22 Dec 2019 08:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <82c69634-ffb5-0b20-2254-55e5cfbef035@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/19 7:42 PM, Robin Murphy wrote:
[...]

>>> Despite the good intentions here, it doesn't seem like dma-ranges is
>>> designed for this purpose and as the hardware has limited ranges it will
>>> only be best-effort.
>> So what other options do we have ?
> 
> If you really want to sacrifice DMA efficiency for a perceived increase
> in theoretical robustness by setting very conservative windows,

That really means configuring the hardware correctly.

> then
> ultimately it's your choice, go ahead. It's just that you *need* to make
> that choice in the bootloader, not in Linux. If Linux gets passed
> dma-ranges that aren't actually reflected by the hardware, such that
> this patch is needed, then it *will* go wrong eventually, and you'll
> only get an "I told you so" from me.
> 
> The bootloader knows what platform it's running on, so it has no excuse
> for emitting more ranges than there are available windows on that platform.

So basically the conclusion is to limit the amount of DMA ranges added
into the DT and be done with it ?

-- 
Best regards,
Marek Vasut

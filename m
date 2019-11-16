Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17108FEF17
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfKPP4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 10:56:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbfKPP4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Nov 2019 10:56:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so14235366wrs.12;
        Sat, 16 Nov 2019 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLTRaPPwtJ3K9nh3qqgcTMjSi8M/0U9rDvtpI862WLs=;
        b=guseDXw+VmTigoJWqP62o17VmQNWJ8E4GWd5IIq4gAZOARKZPBUQoe7/I/DDvHFJDD
         cPgCRB/86IRKnUohfw/4NbfOuK3aDKCjPOLVB2Z3JhDUdGW2rZAE2GYIouQ+nRFvjgon
         G1F68xwwlrXKcnyZq29m/FKy3VmzzI9QlsamwsmfLsv+SYEOa16icNjHfKjkYfSOnvaR
         MKdPv/1LtnScYak+PPzUUrvd3Ry/Nv3Hg3Hq4jx6+rXpsqIPEBhKceK8ka6sDpyzBt6V
         Yp/K1ub8n9A3AeuZcx+9g5wWehBryrzsH0Gsx/wyrV+0EOaW+9CEg5ISzYSrHrtI8NyN
         GLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLTRaPPwtJ3K9nh3qqgcTMjSi8M/0U9rDvtpI862WLs=;
        b=pwoK6CdLUUPt1/MFfKPYI53vjRg3mU7VVy2IXZaJpmUImJJsi0a9x7jw0l66hdjgKi
         b2I/fON/Y3TxtkzJnclxBAhDbBX6B+Mu/9ybxFq0Pvz1ATmTgHEHNV1BfX+VQvfohYKv
         n12kGPwmPbdf7yMHjQL0FY2HSbOASMnDiO5XvHBb+/vm1eHSh2uykR2VF75orA/V4vwp
         JgAqF3gkZW9a7xYK/Lu2aStwBDhg+XDidv8sYA34DHSl8olbVzK2fU5lrMOEAKj3Nydo
         VfYoomoivlFXn1FANEwNfErXerVCjK0q2Qx8P/mYVi5R/pbfjHZIvMbx0TlDEi0yrBCE
         ABAQ==
X-Gm-Message-State: APjAAAXc/X/6UB0g4mZ9mTRXetWmqAuP4x7nF/x254CDvbkk0Ywbxm5J
        mTXr9VrIbSVhWs6p3M+A4b9qoCgy
X-Google-Smtp-Source: APXvYqxblfXkeWlPwNsQ1+mAsLiqe1bwWEjBqZowk103SVPAQuJtFl220YWJrmWlUi40r5CJOdjRtA==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr844796wrr.368.1573919780499;
        Sat, 16 Nov 2019 07:56:20 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id 65sm19018517wrs.9.2019.11.16.07.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 07:56:19 -0800 (PST)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, Robin.Murphy@arm.com
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
 <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
 <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
 <9c46a2d2-00bd-3854-8060-fc7389751f3f@gmail.com>
 <20191107141906.GB43905@e119886-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3424b83c-4693-0259-ac3d-ea10a3f98377@gmail.com>
Date:   Sat, 16 Nov 2019 16:48:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107141906.GB43905@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/19 3:19 PM, Andrew Murray wrote:
> On Thu, Nov 07, 2019 at 12:37:44AM +0100, Marek Vasut wrote:
>> On 10/26/19 10:36 PM, Andrew Murray wrote:
>> [...]>> But this still leaves me with one open question -- how do I
>> figure out
>>>> what to program into the PCI controller inbound windows, so that the
>>>> controller correctly filters inbound transfers which are targetting
>>>> nonexisting memory ?
>>>
>>> Your driver should program into the RC->CPU windows, the exact ranges
>>> described in the dma-ranges. Whilst also respecting the alignment and
>>> max-size rules your controller has (e.g. the existing upstream logic
>>> and also the new logic that recalculates the alignment per entry).
>>>
>>> As far as I can tell from looking at your U-Boot patch, I think I'd expect
>>> a single dma-range to be presented in the DT, that describes
>>> 0:0xFFFFFFFF => 0:0xFFFFFFFF. This is because 1) I understand your
>>> controller is limited to 32 bits. And 2) there is a linear mapping between
>>> PCI and CPU addresses (given that the second and third arguments on
>>> pci_set_region are both the same).
>>>
>>> As you point out, this range includes lots of things that you don't
>>> want the RC to touch - such as non-existent memory. This is OK, when
>>> Linux programs addresses into the various EP's for them to DMA to host
>>> memory, it uses its own logic to select addresses that are in RAM, the
>>> purpose of the dma-range is to describe what the CPU RAM address looks
>>> like from the perspective of the RC (for example if the RC was wired
>>> with an offset such that made memory writes from the RC made to
>>> 0x00000000 end up on the system map at 0x80000000, we need to tell Linux
>>> about this offset. Otherwise when a EP device driver programs a DMA
>>> address of a RAM buffer at 0x90000000, it'll end up targetting
>>> 0x110000000. Thankfully our dma-range will tell Linux to apply an offset
>>> such that the actual address written to the EP is 0x10000000.).
>>
>> I understand that Linux programs the endpoints correctly. However this
>> still doesn't prevent the endpoint from being broken and from sending a
>> transaction to that non-existent memory.
> 
> Correct.
> 
>> The PCI controller can prevent
>> that and in an automotive SoC, I would very much like the PCI controller
>> to do just that, rather than hope that the endpoint would always work.
> 
> OK I understand - At least when working on the assumption that your RC will
> block RC->CPU transactions that are not described in any of it's windows.
> Thus you want to use the dma-ranges as a means to configure your controller
> to do this.

Yes

> What actually happens if you have a broken endpoint that reads/writes to
> non-existent memory on this hardware? Ideally the RC would generate a
> CA or UR back to the endpoint - does something else happen? Lockup, dead RC,
> performance issues?

The behavior is undefined.

> Using built-in features of the RC to prevent it from sending transactions
> to non-existent addresses is clearly helpful. But of course it doesn't stop
> a broken EP from writing to existent addresses, so only provides limited
> protection.

Correct.

> Despite the good intentions here, it doesn't seem like dma-ranges is
> designed for this purpose and as the hardware has limited ranges it will
> only be best-effort.
So what other options do we have ?

-- 
Best regards,
Marek Vasut

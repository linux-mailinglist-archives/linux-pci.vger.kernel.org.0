Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58905449F2B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbhKHXr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 18:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbhKHXr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 18:47:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40AC061570;
        Mon,  8 Nov 2021 15:45:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y7so448650plp.0;
        Mon, 08 Nov 2021 15:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h3desR1Vsd4jK6UvMi7IedYToe+3uCEnZSZG2vFgpWo=;
        b=L3Lt3FiC1S8s5dsAC+kr8MjxPtoYink0ysIyDMwcwDHbV9abqbVM9hNSEFTnYeOwd3
         7y7+TXzgsl8GmCuSjl/YRp7gZHeZ+0jsYSVzQISEgBEncICCdOx2tZYfk/uhDPnIaLr+
         bg/pjYvuVFvXmnCcG8DkWbFAt/wKSyfv1pbL7KWdsXYIyYiBcGebmt2xjILIhV/Pn1HM
         SG0h1u4YHTFnzcdb/yM9Mzgs3MRohz4q4jW6GGztmSzWuSWRT8VskhpsLST6f4oiGW5c
         sJ872iholrrLoC/hUw19SfMGMPldjG+WQ+Dklq+01q5CXpNPdhHmCRNvbn3S1hQr9BqO
         3QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h3desR1Vsd4jK6UvMi7IedYToe+3uCEnZSZG2vFgpWo=;
        b=zXb6ArUf6FexPEYHbHHvnaEW51Zr+J8c+fgHkP6norUhIfSS3ytdS34Rlr5dlCENjx
         9o1M7W3HoKjYvlZadrz5VWCTFmH+HlXe8LCvmmteTbEvDOZKDOJlA1aXHwWCy04oZSdd
         PUP2n9ar0FYoHfgT3SOcZe6dy9lf2Ffe7YPTSrShvS+HD/z/b5KerGc3vJF6KvDkkFpD
         n0E1SYWw2s6K9Oc5f56yyGjpzHdv8zFY79L3dJ4pJoKjR9S2TNB+xBkcq8vn9buRGaMf
         h7T6RfQxpRqxYdG48sURDYnXMIiUbPYcMTIkm9cihd00/raQYw2DTDX+iQ/JhKGAC+wS
         7paQ==
X-Gm-Message-State: AOAM531J/9PeFEpgFhU2KVxThLfdcZRD1tf5zvS7ClkFzgMByP97gFjc
        nUek7g5KkXEgT3BhOAPapTJhepKAQSQ=
X-Google-Smtp-Source: ABdhPJy/Zm31TobY8eRU8X9Abcnzs2DumKtx+GyyxtAPrLcyMjsbGKbFRFrhnZ7jwPB8gPxx1+PKqw==
X-Received: by 2002:a17:902:6902:b0:13f:c1cd:88f1 with SMTP id j2-20020a170902690200b0013fc1cd88f1mr2732134plk.36.1636415111871;
        Mon, 08 Nov 2021 15:45:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z23sm13038540pgn.14.2021.11.08.15.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 15:45:11 -0800 (PST)
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     nsaenz@kernel.org, jim2101024@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <YYh+ldT5wU2s0sWY@rocinante> <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
 <4997ef3c-5867-7ce0-73a2-f4381cf0879b@wanadoo.fr>
 <YYmzDSjLgmx9bQQs@rocinante>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fd853199-6400-000f-1472-3bd6de0662c4@gmail.com>
Date:   Mon, 8 Nov 2021 15:45:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYmzDSjLgmx9bQQs@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/8/21 3:30 PM, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>>>> Jim, Florian and Lorenzo - is this something that would be OK with you,
>>>> or you would rather keep things as they were?
>>>
>>> I would be tempted to leave the code as-is, but if we do we are probably
>>> bound to seeing patches like Christophe's in the future to address the
>>
>> Even if I don't find this report in the Coverity database, it should from
>> around April 2018.
>> So, if you have not already received several patches for that, I doubt that
>> you will receive many in the future.
>>
>>
>> My own feeling is that using a long (and not a long *) as a bitmap, and
>> accessing it with &long may look spurious to a reader.
>> That said, it works.
>>
>> So, I let you decide if the patch is of any use. Should I need to tweak or
>> resend it, let me know.
> 
> I would be pro taking it, not only to addresses the Coverity complaint, but
> also to align the code with other drivers a little bit more.  Only if
> the driver maintainers have no objection, that is.

Driver consistency is a strong argument, fine with me then.
-- 
Florian

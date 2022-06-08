Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052D543FD6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 01:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiFHXYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 19:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFHXYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 19:24:47 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79303B925F;
        Wed,  8 Jun 2022 16:24:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x75so13247705qkb.12;
        Wed, 08 Jun 2022 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ead1Z+ftE/qHTCUA2RIf9dZRjyNbEP4gnJ7T+xPqunE=;
        b=OVMZ3zrODKIF40VOCX8xNe9NL7utPGOiN68HSTRFHAkNzkDG+SmYd8Gf/IJWjWxL//
         SGaQ7AhfoUYYSHqCODoFFMaWZ4lA2QbiZivmlorUP0wo2zHu+OR4vPZkNF8vD/CFFI8u
         VXMkFZcGJCiiHtuqTe+HoMcxn8Xjp53PQASkz4QwDbYvuur4R/so9PDhkwyNnndBCnAP
         x65ZYYtIVDtCKjxoO4lz+Jm7L7nmIXu6Z+HUpTYboDvwLUZZVRHpcKj3MH8qGJz4OmXU
         SgsMzV+cky0T8QN4620DIdBG6f3Pa3bxNFbOTfG4obuvk3pzi8MNoh+aIl6wj7f3LGg2
         /fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ead1Z+ftE/qHTCUA2RIf9dZRjyNbEP4gnJ7T+xPqunE=;
        b=ItHFGrqIOe9XgtTh0iIOEIkX+MfLESQvjBImRnxHE2HDo32LauywnGiwL/ZEorXs3F
         vxibLFvjQRZ/IGEVQ4BfBPISJLI9l1cmZ8eMc6VAxeLeUxf/JM7ar2C1e3qhFFLHA4OY
         mMchoNpbD6Mk9Qsu5ghwiajs4cI3zwCYpGXreekgMleYOAH6wHgl/JN/rlSvSdyTNafn
         HSGfYz4tBNrf9doPHqT6Dq0kJP6iRldtMuXUHhTkp4mMd88dzIJl1VFrTx6tjzpRkEtz
         TNbqTo/ldpMA871SsVHH+HA98rC4J6D2/6BmTWYIfMhtvg0BshQ1yT84avxoWVU3bdpM
         +dnw==
X-Gm-Message-State: AOAM533IE3OCqeSnPsLEb9pNAXFFJ/oN3ePM0j6sJTOraPUOl3h29OKP
        1RxDA9CbA3IKRR885kU8Ww==
X-Google-Smtp-Source: ABdhPJzIqMfyZPSmW0BruVk7AmKsn+uz6h7SSC+cHqntVb3YXnsBvgg8LYwM/8I4E8bTW+Z34/nyVQ==
X-Received: by 2002:a05:620a:2441:b0:6a5:a05c:e06b with SMTP id h1-20020a05620a244100b006a5a05ce06bmr23962595qkn.295.1654730644008;
        Wed, 08 Jun 2022 16:24:04 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b006a6cadd89efsm6866618qkp.82.2022.06.08.16.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 16:24:03 -0700 (PDT)
Message-ID: <d5d0cc2e-79e1-3248-0f55-8f1afd21f926@gmail.com>
Date:   Wed, 8 Jun 2022 19:24:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 29/33] PCI/P2PDMA: Convert to printbuf
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
References: <20220608211146.GA422296@bhelgaas>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220608211146.GA422296@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/8/22 17:11, Bjorn Helgaas wrote:
> [+cc Logan, maintainer of p2pdma.c]
> 
> On Sat, Jun 04, 2022 at 03:30:38PM -0400, Kent Overstreet wrote:
>> This converts from seq_buf to printbuf. We're using printbuf in external
>> buffer mode, so it's a direct conversion, aside from some trivial
>> refactoring in cpu_show_meltdown() to make the code more consistent.
> 
> cpu_show_meltdown() doesn't appear in p2pdma.c.  Leftover from another
> patch?  Maybe from 27/33 ("powerpc: Convert to printbuf")?
> 
> I'm not opposed to this, but it would be nice to say what the benefit
> is.  How is printbuf better than seq_buf?  It's not obvious from the
> patch how this is better/safer/shorter/etc.
> 
> Even the cover letter [1] is not very clear about the benefit.  Yes, I
> see it has something to do with improving buffer management, and I
> know from experience that's a pain.  Concrete examples of typical
> printbuf usage and bugs that printbufs avoid would be helpful.

Take a look at the vsprintf.c conversion if you want to see big 
improvements. Also, %pf() is another thing that's going to enable a lot 
more improvements.

> I guess "external buffer mode" means we use an existing buffer (on the
> stack in this case) instead of allocating a buffer from the heap [2]?
> And we do that for performance (i.e., we know the max size) and to
> avoid sleeping to alloc?

I did it that way because I didn't want to touch unrelated code more 
than was necessary - just doing a direct conversion. Heap allocation 
would probably make sense here, but it's not my code.

> Are there any other printf-type things in drivers/pci that
> could/should be converted?  Is this basically a seq_buf replacement,
> so we can find everything with "git grep seq_buf drivers/pci/"?

All seq_buf uses are fully converted to printbuf in this patch series, 
and seq_buf is removed.

There is a lot of non seq_buf code that still uses raw char * pointers 
and lengths that should be converted to printbuf, but this patch series 
already does a lot of that and I'm not trying to boil the oceans today... :)

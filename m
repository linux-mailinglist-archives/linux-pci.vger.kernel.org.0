Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5418326A119
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIOImF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIOIl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 04:41:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B5C06174A;
        Tue, 15 Sep 2020 01:41:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so2514111wmi.1;
        Tue, 15 Sep 2020 01:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWxyaW6253KQoFu0UHMqhP8AMPbDHxMp498wfuHOKQs=;
        b=saOqAbectSltZwthpuw0WtmRLXNslq/6YA27xlyKH+Ylqo/uY6YiGQhcX5SylY598U
         /4pxJWKWaFw3E16XlejBDo9W7PkY7tFbRw18KcFD9PmJ3Xt4Zm7sS8CXDAddd9JRmQZu
         +KzPkW6YysKzbKlSB0tygqQY5IdFqBKsaYrZwCaNgqXMkAE43NqCWl6fKy3/GI2DwYBK
         otwIGXfzLFKdY6fNDul1WeGmGb+VXJWn+xfX+j8KU58hd9xe1uzWxBkxOissd7CRzYbz
         XETlbz4gt+x+Bncp6QksrENLbE/Ni2xAGMHPVdnKZPUI7JhPEDd9Tsx3viieTQ+mGDua
         B8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWxyaW6253KQoFu0UHMqhP8AMPbDHxMp498wfuHOKQs=;
        b=i4pf0lygxghF9BewKIvAZHt1IDuBpdy+trtrCvKx0mxA/v7p7nXMqKpUkoWbLE9VBh
         EPNZjHNaJTr6LrJMMZQVQv6/Wok7Y/4h7TakpWhxtrBRpX83WNzzULbmdkyq13It9idh
         Mrw3UUnwhlj8M5IitAx0ylliQ8obEyvrADN4FIoOhTtDCBfva5EPQnHVS6cMUhWVSoR/
         7rtOD13mhbitl1er+QVYKPWIcRj9kvzE0uQRK1ymFLh79/JNnFchhOLqPgdk+3GTcsJO
         DybwNnHc2m4F4ge8Sc6uo2PZNDk8ZwwcCwasR4sW/fYlrKxczWDFj3qIQ9UjYEHFMYHR
         7k7g==
X-Gm-Message-State: AOAM532VE5a6nr0NTnsx3qZY0y45rA2hz0tXOoiOvRe3rmfq2D73DksB
        mZEocYHu2BupFGPlepf9QeDgNowigPCY1w==
X-Google-Smtp-Source: ABdhPJw7fbniVY5pujFTy+9h14GxGq4rfw+vU0pN0UCtS1Q/6Sb6mViWzSz+ImsOlxBwh6Dn15tWTw==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr3340434wml.12.1600159316177;
        Tue, 15 Sep 2020 01:41:56 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id k8sm23349010wma.16.2020.09.15.01.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:41:55 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks consistent
To:     David Woodhouse <dwmw2@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
 <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com>
 <alpine.DEB.2.21.2009141208200.17999@felia>
 <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com>
 <alpine.DEB.2.21.2009141552570.17999@felia>
 <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <14193442-3b41-29f2-4380-e2cbcc00e5d4@gmail.com>
Date:   Tue, 15 Sep 2020 10:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/09/2020 16:12, David Woodhouse wrote:
> On Mon, 2020-09-14 at 16:01 +0200, Lukas Bulwahn wrote:
>>>> I am not subscribed to linux-mediatek. When I sent an email to the list,
>>>> it showed up really seconds later in the lore.kernel.org of the
>>>> linux-mediatek public-inbox repository. So, either it was delivered
>>>> quickly as it is not moderated or my check with lore.kernel.org is wrong,
>>>> e.g., mails show up in the lore.kernel.org archive, even they were not
>>>> yet permitted on the actual list.
>>>>
>>>
>>> I'm the moderator and I get requests to moderate emails. I suppose I added you
>>> to the accepted list because of earlier emails you send.
>>>
>>
>> Okay, I see. I did send some clean-up patch in the past, but I completely
>> forgot that, but my mailbox did not forget. So, now it is clear to me why
>> that mail showed up so quickly.
>>
>> Thanks for the explanation.
> 
> AFAICT the linux-mediatek list isn't configured to automatically
> moderate messages from non-subscribers. Its generic_nonmember_action
> setting is 'Accept'. That is the default setting for lists on
> infradead.org and I strongly encourage list maintainers to leave it
> that way.

Ok, thanks for clarification. I never bothered too much with all the 
configuration option of the list. :|

> 
> Lukas, I don't see your address in the allowlist either.

I tried to find that in the web interface, but wasn't able to find the list.

Regards,
Matthias

> 
> There are other reasons why some messages get might trapped for
> moderation — the message size, number of recipients, spam score, etc.
> 
> The mere fact that *some* messages are moderated does not mean that the
> list is "moderated for non-subscribers" in the sense that the
> MAINTAINERS file lists.
> 
>> Bjorn, with that confirmation and Reviewed-by from Matthias, could you
>> please pick this patch?
> 
> I think we should be fixing the ones that *do* say it's moderated for
> non-subscribers, not the one that correctly didn't :)
> 

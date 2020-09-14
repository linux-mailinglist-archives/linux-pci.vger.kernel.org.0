Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6ED268BDB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgINNMB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 09:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgINNLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 09:11:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5810C06174A;
        Mon, 14 Sep 2020 06:11:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so18638390wrl.12;
        Mon, 14 Sep 2020 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9w3sxxj8pSXMWFjqFI11OsxhpoFFNgS3AccbtAl9K1M=;
        b=lBT/TEIoVFDPRE5LwTVY/VpAg2giTJNs4JR7ctTfRE1fCQmUZXODK+A2klNxsJhbwR
         m9NC+xn8xfAqF4J5rMCWADG08i1mY7wpdcnPMLMKEBuTVZF4dAzSMkG40HYKngprFpSs
         fDBHbBw4eiddbMeHOZX9207boj7dTc0D5ErsiWBslRM7+JMaFOxmksFe/phZI072dX29
         2pZZLE1jUyORQkqa6pEfBwjtA2xpfN6ouZqbgA3S9VJlbrcyBvW/YZVLwWcDc0YWZaV9
         vo8Ox5rSwCDom5JJX69nSnfMH6vNRGWGUheLbCbnyESqoz/rOOyuKmg4xZ4sPULfrWNI
         ALVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9w3sxxj8pSXMWFjqFI11OsxhpoFFNgS3AccbtAl9K1M=;
        b=DS/sZ/76+RPDC7iEhzZFM2W8RFQvhhyusxYvg8ry6VVlk66N/WfAGiuNIR2xlKE9WV
         /JLXiMsUvM3GWJcbDSz3xAL2AAxor+zrp/3KPaU60VJBGyr1lPbVVzqV5d08r583oBCv
         Yz4Wz4lPKeRXaiT0tK68aN8/+ndZ/HJVJzCbXY5imDa0LV5VBLCZd3rmXH1EwXMeoHZx
         K2PXagMzMfzqHgVx5NsX3Opm/tkJRlt9IUSZMZdRO79iPTYk5xvn4KxzrazU2xGKJ7JR
         qiLHxTsR2D2olDN0JibYWC3NW0va4rFXBv5tSv3HQiCdr+ZIqXHLuzf4B4tnl4ezcoRD
         4shw==
X-Gm-Message-State: AOAM531ZgpcVgNr4LQT1KphqeQ5iX20lcRFAk5bB+bRrOojbwLCLtx/S
        wF6ySv7DxTNYHj6BeL56Iwj+/l5wcBgVHQ==
X-Google-Smtp-Source: ABdhPJzSLIDDoxmjCP7UlhRP0PsUbCmacVeAoUB2b/QALbpC2eIxxdOx01zPUhBWyQo8GwEN91CDPA==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr15276243wrx.140.1600089083213;
        Mon, 14 Sep 2020 06:11:23 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id i16sm20417229wrq.73.2020.09.14.06.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:11:22 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks consistent
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com>
Date:   Mon, 14 Sep 2020 15:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2009141208200.17999@felia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/09/2020 12:20, Lukas Bulwahn wrote:
> 
> 
> On Mon, 14 Sep 2020, Matthias Brugger wrote:
> 
>>
>>
>> On 14/09/2020 07:31, Lukas Bulwahn wrote:
>>> Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
>>> support") does not mention that linux-mediatek@lists.infradead.org is
>>> moderated for non-subscribers, but the other eight entries for
>>> linux-mediatek@lists.infradead.org do.
>>>
>>> Adjust this entry to be consistent with all others.
>>>
>>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>
>> Maybe rephrase the commit message to something like:
>> "Mark linux-mediatek@lists.infraded.org as moderated for the MediaTek PCIe
>> host controller entry, as the list actually is moderated."
>>
>> Anyway:
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>>> ---
>>> applies cleanly on v5.9-rc5 and next-20200911
>>>
>>> Ryder, please ack.
>>>
>>> Bjorn, Matthias, please pick this minor non-urgent clean-up patch.
>>>
>>> This patch submission will also show me if linux-mediatek is moderated or
>>> not. I have not subscribed to linux-mediatek and if it shows up quickly in
>>> the archive, the list is probably not moderated; and if it takes longer, it
>>> is moderated, and hence, validating the patch.
>>
>> I can affirm the list is moderated :)
>>
> 
> Hmm, do we mean the same "moderation" here?
> 
> I believe a mailing list with the remark "moderated for non-subscribers"
> means that a mail from an address that has not subscribed to the mailing
> list is put on hold and needs to be manually permitted to be seen on the
> mailing list.
> 
> Matthias, is that also your understanding of "moderated for
> non-subscribers" for your Reviewed-by tag?

Yes.

> 
> I am not subscribed to linux-mediatek. When I sent an email to the list,
> it showed up really seconds later in the lore.kernel.org of the
> linux-mediatek public-inbox repository. So, either it was delivered
> quickly as it is not moderated or my check with lore.kernel.org is wrong,
> e.g., mails show up in the lore.kernel.org archive, even they were not
> yet permitted on the actual list.
> 

I'm the moderator and I get requests to moderate emails. I suppose I added you 
to the accepted list because of earlier emails you send.

Regards,
Matthias

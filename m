Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC005FF3D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJNSwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNSwx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 14:52:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5E1D0658;
        Fri, 14 Oct 2022 11:52:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o64so5968508oib.12;
        Fri, 14 Oct 2022 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjTGbgLL1E+Ar8FdvDAUWbKGmgf0GFsLgLaDGmZd6uE=;
        b=Gy5ZzZpsMsHgo5dACgAzfZDi41Zg2iJpUdpc6P2h2Dpqufa0eLfd9tEGDF0xItwRHe
         baO1GmANcGABtTFRQQ+1oSpe3jBkIGaQ3mcOH9wB2o0f7ETW8ma9OrmlgIAV8ghMBjzm
         0Tu7QLKS0oKPBult0jxu3idP2a1oaCC+jst9jb+uhQoKF9d9CWKLIjPzNP7A5Gtbeqn9
         tyF5UTtCNOJiMtCErM+qcrUt2h65sNFfl9Orp9gpejQzI5+qgbXZgbS0BdXPBJ3ob2U/
         XZM347n6yO8TarlbQ12VR3aLVQOyHStJ1XKdVfhpm7+9Mth6cYMqBsdTceRt4MqzHtLv
         dgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjTGbgLL1E+Ar8FdvDAUWbKGmgf0GFsLgLaDGmZd6uE=;
        b=ijTp+sxqK7v2EV0Mgnp15F4nLFHKxUH/fziP1HAYxQwZBxhQXmdiCu0mskQpauqDm5
         6gCxdvuYo8igWUuHs0dQEr0rAHnk/2yQv2U5xtxJs99VHzIw6t2ob5bk3KPEjpsv8+0+
         IJStTbdSkvnVudtCaU3riLILNi/viwxDr3NywDgg+JrT8o2kcJvRlDFRTcuyCf5vFxa2
         dwVC8WV2Pb8TqfBJ+C3Z8We05/RTpSyi3AI816t/wyRmkaVpTnbod3PAWtbSX/yECq8z
         NYUwqLIW5NAh4V4GGCpShQoTeBrZyLil7j8qNapZ7q+3JQZxAlbxNyOiWP/XTTGtj2zy
         eD3g==
X-Gm-Message-State: ACrzQf2LUXrh3RRBowUrpZqC0k6/gPpw6c7IafBza5F/HUI4xEMnZzE6
        7G7j04C/bLI89l4jwvcrA4RL3wwBvN0=
X-Google-Smtp-Source: AMsMyM551BdHYSzlImPOkXj9Q81CtG36Oq7PnoacevHfrCv6nonFja0ABoThaMMo8g7FFTH6kxTrEw==
X-Received: by 2002:a05:6808:1285:b0:350:9908:6394 with SMTP id a5-20020a056808128500b0035099086394mr8265376oiw.150.1665773572327;
        Fri, 14 Oct 2022 11:52:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b45a:72e4:d631:1b4c? ([2600:1700:2442:6db0:b45a:72e4:d631:1b4c])
        by smtp.gmail.com with ESMTPSA id f23-20020a9d7b57000000b00661b5e95173sm1559424oto.35.2022.10.14.11.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:52:51 -0700 (PDT)
Message-ID: <fbfb817c-6f09-32d0-fafc-7d37618e2886@gmail.com>
Date:   Fri, 14 Oct 2022 13:52:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <20221010104210.68edf825@fixe.home>
 <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
 <20221013100245.14c509ec@fixe.home>
 <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
 <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/14/22 12:33, Rob Herring wrote:
> On Thu, Oct 13, 2022 at 12:28 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/13/22 03:02, Clément Léger wrote:
>>> Le Thu, 13 Oct 2022 01:05:26 -0500,
>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>
>>>>> This would also require two different descriptions of the same card
>>>>> (for ACPI and device-tree) and would require the final user to create a
>>>>> specific overlay for its device based on the PCI slots the card is
>>>>> plugged in.
>>>>
>>>> One of the many missing pieces of overlay support.  There have been several
>>>> discussion of how to describe a "socket" in a device tree that a device
>>>> could be plugged into, where a single device tree subtree .dtb could be
>>>> relocated to one or more different socket locations.  Thus in this
>>>> case a single overlay could be relocated to various PCI slots.
>>>>
>>>> I don't expect be getting involved in any future efforts around sockets
>>>> (see my following comment for why).
>>>>
>>>>>
>>>>> The solution we proposed (Lizhi and I) allows to overcome these
>>>>> problems and is way easier to use. Fixing the potential bugs that might
>>>>> exists in the overlay layer seems a way better idea that just pushing
>>>>
>>>> It is not potential bugs.  The current run time overlay implementation is
>>>> proof of concept quality and completeness.  It is not production ready.
>>>>
>>>> I got an opportunity for early retirement a couple of weeks ago.  My first
>>>> inclination was to continue the same level of device tree maintainership,
>>>> but I am quickly realizing that there are other activities that I would
>>>> like to devote my time and energy to.  I will continue to support Rob with
>>>> minor patch reviews and testing, and potentially finishing up some
>>>> improvements to unittest.  On the other hand, bringing run time overlay
>>>> support to product quality would be a major investment of my time that I
>>>> am not willing to continue.
>>>
>>> Hi Frank,
>>>
>>> This explains your position on the overlay support and I can
>>> certainly understand it ! Regarding the fact that it would enter
>>
>> No, my position on the technical aspects of overlay support is totally
>> unchanged.
>>
>> The only thing that has changed is that my time will not be available to
>> assist in future overlay related work.  The burden for this will fall
>> more on Rob than it has in the past.
> 
> s/Rob/someone that steps up to maintain the overlay code/
> 
>>> "production", the devices we are talking about are not really
>>> widespread yet? This would be a good opportunity to gather feedback
>>> early and improve the support gradually. We could probably even be able
>>> to support improvements in the overlay code if needed I guess.
>>
>> That is avoiding my point about the current implementation being
>> proof of concept.
> 


> I think it would be better to talk in terms of under what conditions
> the overlay support is adequate (for production) rather than a blanket
> statement that it is not-production ready. 

I sort of agree.  Use of run time overlays has been narrowly supported
for use by a limited set of very cautious developers in a very constrained
usage.

> A large part of it is
> really outside the code itself and related to going from static to
> dynamic DT. There are certainly issues, but dynamic DTs have been used
> in production for a very long time. However, that usage has been
> constrained.

Yes, to the dynamic DT comments.

When the run time overlay code was added the overlay code used the existing
dynamic DT code as a foundation but did not address the architectural
issues that are exposed by using the dynamic DT code in a less constrained
manner.

> 
> Rob


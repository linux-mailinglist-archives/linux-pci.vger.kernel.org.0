Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4102C54B5CA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiFNQRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiFNQRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 12:17:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40149F1A
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 09:16:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so9514423pjo.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZrPOrbduk5agLBkDaiS0XxQj4fFOrAQ9O+7QcyJaVuo=;
        b=P1/uHyqFJqst4YGHH+0ciDBVx5bBINo7Yb1VjVdwLtjD1W3Q1xfHe/nTZWfcl7A3pC
         xKjLknwo6UO5awJeSd4lkszoExCu3o6jZ5+CYYxsl2r2Tbw3/lsKNvSgEasdpbmfV3h9
         zAMfM194B895hZfV/2omJy+FqOvSKR8FnCO6F8UL6u4jAoJPzB2ZYuwewqU1FWNRyrqP
         YFbHYyqdwyrSwyLFA8wO8mnRsx8zEeGZ/OwC+/fjs1lc0ohUO6v48+0f4ehMBpQhc2H/
         BZDOBEUjSj2NGUtdXOtz1aPoHT+QDTzc833tu2n9clr8bvVVt7QunEFP5WayD5UDLlp6
         h+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZrPOrbduk5agLBkDaiS0XxQj4fFOrAQ9O+7QcyJaVuo=;
        b=Oce9dmHekFUHl0XnMxg3eGXABjGbg4pf4Tmlp2u5v196oSFUR4rER0eIVUT3xSRY8M
         tJ2Fcg2zARudBjTKzMpG15pWmCuZjZ4WhtUItmIV0CW2tDyE+F4p6LSJaKpYBIEljNiZ
         45mn3PH1C4vvhyUwVbmIl9p2jfaKqNKhqnX6tBUarVh0Nmozi65D6S9cIB/cb3wah1x4
         kz54rwi1rb2Sby953qdhzuZqCUOyfSGPiNYAEIpgoQW2q6K5lcEYQml70ShBAIMAOBKy
         gJRAe4MToMdqrR3APsttOrjKIZzXBZbhxy3sraZFo+0IYchl2rkLB7Wx8mNvjsCjUDjd
         p+hA==
X-Gm-Message-State: AJIora+gVT/H3JPAp0SyLt+9o2C+TDyKfj/tJhcYRf9odBGhX4MiqQEc
        Zvbq2cjPyk8Dzh1/crVt7sk=
X-Google-Smtp-Source: AGRyM1vNeQNegOiexKyfdLxr2Qw5Cz9AjLYL4jGo74x9dpvG4s3ac4k4YQUJx2Pxn4zB+c5LYxdkOQ==
X-Received: by 2002:a17:90b:3654:b0:1ea:4540:d32 with SMTP id nh20-20020a17090b365400b001ea45400d32mr5345414pjb.92.1655223402172;
        Tue, 14 Jun 2022 09:16:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gg6-20020a17090b0a0600b001df51dd0c93sm3310826pjb.1.2022.06.14.09.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:16:41 -0700 (PDT)
Message-ID: <7b2d26e2-e4a5-b5f2-4e57-a5b102ed3f4a@gmail.com>
Date:   Tue, 14 Jun 2022 09:16:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
References: <20220614000052.GA727153@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220614000052.GA727153@bhelgaas>
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

On 6/13/22 17:00, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2022 at 10:06:12AM -0700, Florian Fainelli wrote:
>> On 5/11/22 13:39, Bjorn Helgaas wrote:
>>> On Wed, May 11, 2022 at 01:24:55PM -0700, Florian Fainelli wrote:
>>>> On 5/11/22 13:18, Bjorn Helgaas wrote:
>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>> Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
>>>>> into two funcs"), which appeared in v5.17-rc1, broke booting on the
>>>>> Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
>>>>> for now.
>>>>
>>>> How about we get a chance to fix this? Where, when and how was this even
>>>> reported?
>>>
>>> Sorry, I forgot to cc you, that's my fault:
>>>     https://lore.kernel.org/r/CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com
>>>
>>> If you come up with a fix, I'll drop the reverts, of course.
> 
>> What is even better is that meanwhile there was already a candidate fix
>> proposed on May 18th, and a v2 on May 28th, so still an alternative to the
>> reverts making it to Linus' tree, or so I thought.
> 
> I hoped for a fix, but neither of those seemed to be clearly better.

Humm, OK.

> 
>> - the history for pcie-brcmstb.c is now looking super ugly because we have 4
>> commits getting reverted and if we were to add back the original feature
>> being added now what? Do we come up with reverts of reverts, or the modified
>> (with the fix) original commits applied on top, are not we going to sign
>> ourselves for another 13 or so round of patches before we all agree on the
>> solution?
> 
> I agree on the ugliness and I try hard to avoid that.  In this case I
> waited too long after the regression was discovered, hoping for a fix
> that was better than the revert.  And I should have asked for
> trade-offs between the revert and the the CM4 regression.

Yes, I suppose that is fair, ideally this would have been an one liner 
but it was not quite that simple.

> 
>> - we could have just fixed this with proper communication from the get go
>> about the regression in the first place, which remains the failure in
>> communicating appropriately with driver authors/maintainers
> 
> I apologized earlier for omitting you when the regression was
> discovered, and I'm still sorry.

Apologies accepted :)

> 
>> I appreciate that as a maintainer you are very sensitive to regressions and
>> want to be responsive and responsible but this is not leaving just a
>> slightest chance to right a wrong. Can we not do that again please?
> 
> Cyril opened the bugzilla April 30 and I forwarded it to linux-pci and
> to Jim (but not you; again, I'm sorry for that omission) on May 2.
>  From my perspective we had almost a month to push this forward, but we
> didn't quite make it.

This is fine, I am not technically the driver author but Jim and I work 
together and I can always prioritize his work on upstream versus what we 
do downstream. As the "new" Raspberry Pi maintainer however I do care as 
well about not introducing regressions for Pi users, even if upstream is 
a niche on those platforms.

> 
> I posted the reverts May 11, but I did not realize the regression to
> you and other users they would cause.  I apologize for that.
> 

OK, thanks for your response, this makes me feel better.
-- 
Florian

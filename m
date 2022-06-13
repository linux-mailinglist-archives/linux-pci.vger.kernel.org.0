Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7162549CF7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348375AbiFMTKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349281AbiFMTIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 15:08:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DA12C128
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 10:06:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d129so6070678pgc.9
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MOQgXtI+BKSvQKp350OufIdxJrNapSAlu2QwriUAL0M=;
        b=Xr7brTWW1FS8zff2fqX5in7RA7W1ehGdNrTPpeehBMhGZLvChDjV5pABpRpyOvTxh2
         +hFSK4aggLX2HLQh5AXCo0EkJpeIt8smwjmG6CoKDTxULhJPTSbnQuVGcXq+uUAEgFgo
         MUO8lUwZjLjoVpzbK0Yh79o2bM1IwcP550ns91RLEY1ZhV35kAN7jMFexP/OvmsMmkO5
         E3H4q67N9BhNr3oX+ovhxHlbX/jQ59vNB1ZpRNJc2udHx0hfENEKSgW25MlKGYzGuSb8
         oTQSphWbPVCdzE70YFtOxLwdOk5vdq74xwoQT4oZEtnMDdlfdvK/OdHzv5oSoufXztIF
         GZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MOQgXtI+BKSvQKp350OufIdxJrNapSAlu2QwriUAL0M=;
        b=dNWeM2dlUoBcwZjsh4BS4UmwxanM6fznllimF4b27QwRQQzWRJ13mExSwS4KI+u7Pv
         SkmN5Un+i4yi6AVlcSZQ3Kmv2gKUU4NLsTd0t3Ez/cAThXxkQfrnOPHqghWJ50amHlrT
         F4uqCA54Fz8NljgDymmw5/qVtPxoADLAB+eppe9tA3Zka/U7Zo0gZfVIVyaGnpjnVx3L
         vZD4qytu0hm+/1OPsPOfBEpaKDxTx0iDis4e5V/MckZxHMyG3BMhxdVLtkba/c3V2mfd
         iYClfUr7xZKVD/6cvaQ1zuowfoQrRcmdwvZLV7QQPhGDnooFq94PQ1h4Bb0jEAg8hyB5
         gpqw==
X-Gm-Message-State: AOAM533RanigQ8arU+LCU+BA7+Aii3ZVmcpEBB5jm2dRZA6hVz+OnyVY
        l3+HY6w6cq2Yu8XxmB1w6eA=
X-Google-Smtp-Source: ABdhPJzZ7i5tys91503gKW2Dx5yn+4/pmdYgJ0M/Iv2UGbTxpnBMOzfRw0pPhZwC6EEadmpIF1e9UQ==
X-Received: by 2002:a05:6a00:1687:b0:518:6c6b:6a9a with SMTP id k7-20020a056a00168700b005186c6b6a9amr161951pfc.81.1655139974873;
        Mon, 13 Jun 2022 10:06:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 199-20020a6300d0000000b003f24d67d226sm5702673pga.92.2022.06.13.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:06:14 -0700 (PDT)
Message-ID: <e58125a4-f885-ae55-0441-d52ecab9a1e8@gmail.com>
Date:   Mon, 13 Jun 2022 10:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
References: <20220511203948.GA811126@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220511203948.GA811126@bhelgaas>
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

Bjorn,

On 5/11/22 13:39, Bjorn Helgaas wrote:
> On Wed, May 11, 2022 at 01:24:55PM -0700, Florian Fainelli wrote:
>> On 5/11/22 13:18, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
>>> into two funcs"), which appeared in v5.17-rc1, broke booting on the
>>> Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
>>> for now.
>>
>> How about we get a chance to fix this? Where, when and how was this even
>> reported?
> 
> Sorry, I forgot to cc you, that's my fault:
>    https://lore.kernel.org/r/CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com
> 
> If you come up with a fix, I'll drop the reverts, of course.

OK, so now this patch series has landed in Linus' tree and was committed 
on May 31st and we got no notification that this patch series was applied :/

How did I notice? Because suddenly the stable auto selection started to 
email me about the 4 reverts being included which is kind of the worse 
way to know about a patch having been applied.

What is even better is that meanwhile there was already a candidate fix 
proposed on May 18th, and a v2 on May 28th, so still an alternative to 
the reverts making it to Linus' tree, or so I thought.

This utterly annoys me because:

- the history for pcie-brcmstb.c is now looking super ugly because we 
have 4 commits getting reverted and if we were to add back the original 
feature being added now what? Do we come up with reverts of reverts, or 
the modified (with the fix) original commits applied on top, are not we 
going to sign ourselves for another 13 or so round of patches before we 
all agree on the solution?

- we could have just fixed this with proper communication from the get 
go about the regression in the first place, which remains the failure in 
communicating appropriately with driver authors/maintainers

- v5.17 and v5.18 final were already broken, but who on earth uses v5.17 
or v5.18 and not their stable counter parts, so we had a chance of 
slipping in a fix in a subsequent stable, I mean, it's been broken for 2 
releases on the CM4 and it was not noticed, so what was the urgency?

- the reverts will make it to -stable being bug fixes for regressions, 
however for users like Jim and I, now we will lose a feature that we 
were relying on, thus causing a regression for *many other* platforms 
than just the CM4

I appreciate that as a maintainer you are very sensitive to regressions 
and want to be responsive and responsible but this is not leaving just a 
slightest chance to right a wrong. Can we not do that again please?

Maybe I am being overly sensitive and disgruntled today, but really this 
is the type of thing that makes me want to quit working on the Linux kernel.
-- 
Florian

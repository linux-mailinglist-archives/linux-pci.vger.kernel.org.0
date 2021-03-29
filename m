Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7034D5A1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhC2RCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 13:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2RBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 13:01:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E635C061574;
        Mon, 29 Mar 2021 10:01:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gb6so6324883pjb.0;
        Mon, 29 Mar 2021 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KaU2X8BYBo2iEYrCYnDX7Io7zwEGngt8bXiDSOA3dU=;
        b=Kg42A+C8lwb0lncwa2RQMG/aGsCwIFedHnSNQ5tAzBoKpV7+4z32DzKBLqagztyFcR
         5foEL4IWF1C2q3jlXjdsh7nliv2yDPKhtPOIpnPICy4j8l0aMeZoXyAQyrTmUcL32PAB
         b3XxiYzpReNucgoVjwzRn+OFrqbtj07XYipNt6AhQ8uemiICKdx+rPfhBi2AfDs7HQ4J
         xWAdzSQlZGkbN7nHm5QkqXUCiO9A7gorZVuGXwdS8EyAeO9CrvEH8NBGLWktcPooXpeJ
         q4LxzdRWU9wkxHOF0Mhl0aJKJy2nDI6nVYe6jeAVrr5lgPsx+AOfGkRFnsCHsCSEmOHH
         Re0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KaU2X8BYBo2iEYrCYnDX7Io7zwEGngt8bXiDSOA3dU=;
        b=Pw7docRGW/AJJl653krYWmO7Ldv5byPNrMVn4FY7Rk8kOaT7oGwPmJO9q+hZVhzcDh
         O7Y1NeylzqgELkM+N7+R1OK0TMWub61QrtIUWLOyiOJoTBITqerP2LNYua+JHf/+BhJw
         +aHyjG3lE4fIiF6Y+JCj4WhGoj4WxwlNd5TicknvmYvwALkp/MG7UjOp0Y+LsE5+hjF1
         vNKQMBXPHi1kUQ66N36HWpq13euhqeBhjGvufpOT0FeUjRB5yxFQQeCmUQ5Tn1qn98gg
         1c7CD5+yFyaErAmxeWF84WqSf7FSgeu5fOfYs9TgUtUs8Acf44fu3ua2sBn3SdnFfpfA
         z6Ig==
X-Gm-Message-State: AOAM532HgDxETakxLXCrC/PvUc5XQ86cVe1BMwgPvEaEQFnDQPzpKOyM
        HOd0INU2snlEq/mAaJ0gsSJ+mVkOask=
X-Google-Smtp-Source: ABdhPJzLqubBwMwApiffsPDmTZ/4mHx8yGrQUWgZKoYE3ro/5jmcfBk2I7198NgYttUDrK18m1+TqQ==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr62162pjr.123.1617037310528;
        Mon, 29 Mar 2021 10:01:50 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w3sm43671pjg.7.2021.03.29.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:01:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] PCI: brcmstb: Use reset/rearm instead of
 deassert/assert
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-3-jim2101024@gmail.com>
 <20210329161040.GB9677@lpieralisi>
 <71903454-c20c-31f7-aaee-0d05eb22db7f@gmail.com>
 <20210329165847.GA10454@lpieralisi>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e602340f-c13d-0cda-25cf-960dd546857e@gmail.com>
Date:   Mon, 29 Mar 2021 10:01:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329165847.GA10454@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/21 9:58 AM, Lorenzo Pieralisi wrote:
> On Mon, Mar 29, 2021 at 09:50:13AM -0700, Florian Fainelli wrote:
>> On 3/29/21 9:10 AM, Lorenzo Pieralisi wrote:
>>> On Fri, Mar 12, 2021 at 03:45:55PM -0500, Jim Quinlan wrote:
>>>> The Broadcom STB PCIe RC uses a reset control "rescal" for certain chips.
>>>> The "rescal" implements a "pulse reset" so using assert/deassert is wrong
>>>> for this device.  Instead, we use reset/rearm.  We need to use rearm so
>>>> that we can reset it after a suspend/resume cycle; w/o using "rearm", the
>>>> "rescal" device will only ever fire once.
>>>>
>>>> Of course for suspend/resume to work we also need to put the reset/rearm
>>>> calls in the suspend and resume routines.
>>>
>>> Actually - I am sorry but it looks like you will have to split the patch
>>> in two since this is two logical changes.
>>
>> I do not believe this can be easily split, since there is currently a
>> misused of the reset controller API and this patch fixes all call sites
>> at once. It would not really make sense to fix probe/remove and then
>> leave suspend/resume broken in the same manner.
> 
> Right - I was reading the previous versions of the set, it makes sense
> to keep it in one logical change.
> 
> Do you want me to take it or you prefer an ACK so that it can go via
> a different tree ?

I would be comfortable with you taking this via the PCI driver trees, we
would want an Ack from Jens that he is okay with taking the ahci_brcm.c
change as well through your tree.

Thank you!
-- 
Florian

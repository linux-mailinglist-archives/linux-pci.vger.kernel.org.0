Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5519409DF9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhIMUNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhIMUND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:13:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C2C061574;
        Mon, 13 Sep 2021 13:11:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so296030wmc.0;
        Mon, 13 Sep 2021 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5BdvwOG+6brlU0D3bu5VRlz5Ma1oo1EfgyPoxcREHNc=;
        b=jGM8xa4HqxA+zZC0bigHTjuqCcKJKPBdcnFPqYh1kHFwzxK3fsARm20pxL5svSVN2l
         QekatSTLP7x8gm5MlOTLvOD7SGaLP2lI2moov5QWqhxHTPzxuRbKcYai7beOhq5RKnB1
         /fFYnAjImgP5pEni4mt8MGp7HgAY8UMfWsDPTDaNRd4ligJ2yZge7Z6jJyZ37xMMGJV4
         if9xQ2H3ycs1K4OWL8jVxztt98iyARqfC7zQ1jUQgt4+L3YUNdQeeLhPDrjTzj4DVe6h
         xfIN69KvYB9HHAz3lBddaql33YQxVOpRhUS5H0YCrIii6kNNzvQruozPK6+HziIXKY3F
         i2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BdvwOG+6brlU0D3bu5VRlz5Ma1oo1EfgyPoxcREHNc=;
        b=fTUrP99KCZG+GSE9y/Sm58Ia3Rki7/J9zu6o/fSq5rB2tx2qzt+DPZEhGKeB0XnPOK
         SNQq2bYqxbvtrIZld+tbyAr5qsigxbn59mBR8imFjri9qt8yYyyNz/mndUa8vBq+c626
         3MDrZMHbhgtLWBYaOF96fu+Dmmfkaef+c/jYfvXtDqGNgJEqcjhfnyYnnSG8r95qAKO0
         9vbyyrtBeeXskFUF4T0F6KI4hKB1IWmqGyC+FB1uVseViRXDtCrYQdBvIR11KvOWk4CZ
         D9GgwG750YI1VPRG9uWZHEaw1uUE1hc1lE0oUHA5QpGn0yEV4aElk7ieytGjUZnaqspU
         reig==
X-Gm-Message-State: AOAM530UE38bABzwG+isJC0c3s02Hu/ah0aOhoPcaAm//pmNsa6AwUEy
        ugf1T5RY/PXgkLn7Q/9nxpHXLHJOh1A=
X-Google-Smtp-Source: ABdhPJyfL+Qa/AyO0DgPs0WE2+9vF/u3M6AHwH6B3hUjkw9D5g7625IYJ9tGqMX0N04QenjxZMLdNg==
X-Received: by 2002:a1c:7e12:: with SMTP id z18mr13327752wmc.60.1631563905920;
        Mon, 13 Sep 2021 13:11:45 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id s10sm8451247wrg.42.2021.09.13.13.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:11:45 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1
Message-ID: <18e101d9-f94c-1122-1436-dc3069429710@gmail.com>
Date:   Mon, 13 Sep 2021 22:11:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.09.2021 21:51, Linus Torvalds wrote:
> On Mon, Sep 13, 2021 at 12:00 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> With an older kernel you may experience the stall when accessing the vpd
>> attribute of this device in sysfs.
> 
> Honestly, that old behavior seems to be the *much* better behavior.
> 
> A synchronous stall at boot time is truly annoying, and a pain to deal
> with (and debug).
> 
> That pci_vpd_read() function is clearly NOT designed to deal with
> boot-time callers in the first place, so I think that commit is simply
> wrong.
> 
> And yes, I see that "128ms timeout". If it was _one_ timeout, that
> would be one thing,. But it looks like it's repeated over and over.
> 
No. The timeout is not the issue, otherwise you would see the message
"VPD access failed.."  over and over again. The issue here seems to be
that this call in PCI config space access to adress
vpd->cap + PCI_VPD_ADDR stalls.

In a first place this seems to be due to a buggy device. We'll know
for sure once Dave checks with the test patch applied. To deal with
such buggy devices we have the VPD blacklist quirk.

Secondly you could blame the PCI subsystem for not detecting stalled
access to a buggy device. However I don't know the PCIe spec good
enough to really comment on this.

> Not acceptable at boot time. Not at all.
> 
> Bjorn. Please revert. Or I can do it.
> 
>             Linus
> 
Heiner

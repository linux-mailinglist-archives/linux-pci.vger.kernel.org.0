Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46C2FF649
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhAUUtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 15:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbhAUUsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 15:48:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C48C0613ED;
        Thu, 21 Jan 2021 12:48:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq1so2400325pjb.4;
        Thu, 21 Jan 2021 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jg+KbBGSyqt1CGC6UoXAGyoLxjVy4wU+kcvWer3I0k8=;
        b=Qj59WwB7YE/QrrQ/dQefmdtpy7U/8IfLfbxMTekC7iYTjuJtZ5WcbeV9CKLnbt4hVl
         m9QCp04aV3kJtoFWXe1iTMLGVQHvlUW732clsAkoiXHV/UHBKPjoXhYmH/vT8eFJ1BmW
         RbIuJDo6wxwFkcTv12YzqiJTPloaJppW/hQG6KJ4i8nJJy6jt2sRaU9fy/HYz9devP68
         FowuKaETXtENqhQoTQcqLm+4Y5frMT7PB3Bt41QiSen30MPe3AsEOYV55Sgnp3r9Xy/u
         BLNwO/M8kxmxufuQsDUSmBXCj+i/U84szUYpOJEZwSGpabfR3AQmd1zleuTqUDFmexz7
         5W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jg+KbBGSyqt1CGC6UoXAGyoLxjVy4wU+kcvWer3I0k8=;
        b=lwElhVyILdJ18xMPGDLgkuXWmEmBihC2BltMyFnAqKABjtW/y/M8QZpOSaJrZr1y2Q
         113D+w0LL3niH33Tz+KP75QRRYpu9xwSClFEjf4NHspzkvNfZm4FPy1YT6x0qsOj25He
         UhfbZddKM+8mhBtY/b7/9UZ+Rq6l1HCMgUgMaDeFsFADlGqF+tdd8egBfoPM6DubZIVP
         kdyHXCwLYbSzbGZs4mDYxVCKal+m6AmHA6rKU7w75LQRoeR3vLkLLAQIDJHAxJthOLkn
         +eW78X68zXSRTyb4AYSfOa7PTblhPl6pmyybQ9WzuO2/Z1TA5uVqccZegMUdRhzmadfR
         Qi8w==
X-Gm-Message-State: AOAM531FBNs5ZMEhKaAH+l/UGevrJ2jDfgXkkW0caEPjBDm2m8lVsgVp
        9C5Qd69BXMVQptscXL2ZKvE=
X-Google-Smtp-Source: ABdhPJxe8Zg6phmzTtTUGD6Zu3dAA4XEnbHG62NuMKugNIdXP4kiUmntQxY3s5K8P43bAbVQclKMgA==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr1327762pjq.91.1611262090190;
        Thu, 21 Jan 2021 12:48:10 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h19sm6367622pfq.151.2021.01.21.12.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:48:09 -0800 (PST)
Subject: Re: [RESEND PATCH v3 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Jim Quinlan <jim2101024@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20201216214106.32851-1-james.quinlan@broadcom.com>
 <92084293-d2fd-1663-0f6a-a10f01e23066@gmail.com>
 <ece90017-4b7d-d5bb-e868-9b63909be5f3@gmail.com>
 <05ac4282-5ff4-8294-1cfc-da05212acffe@gmail.com>
Message-ID: <4b1cec20-679f-783c-159f-fa6aa9b1d568@gmail.com>
Date:   Thu, 21 Jan 2021 12:48:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <05ac4282-5ff4-8294-1cfc-da05212acffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/14/2021 12:46 PM, Florian Fainelli wrote:
> On 1/5/21 1:22 PM, Florian Fainelli wrote:
>> On 12/23/20 4:05 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 12/16/2020 1:41 PM, Jim Quinlan wrote:
>>>> v3 -- discard commit from v2; instead rely on the new function
>>>>       reset_control_rearm provided in a recent commit [1] applied
>>>>       to reset/next.
>>>>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
>>>>       to use reset/rearm verses deassert/assert.
>>>>
>>>> v2 -- refactor rescal-reset driver to implement assert/deassert rather than
>>>>       reset because the reset call only fires once per lifetime and we need
>>>>       to reset after every resume from S2 or S3.
>>>>    -- Split the use of "ahci" and "rescal" controllers in separate fields
>>>>       to keep things simple.
>>>>
>>>> v1 -- original
>>>>
>>>>
>>>> [1] Applied commit "reset: make shared pulsed reset controls re-triggerable"
>>>>     found at git://git.pengutronix.de/git/pza/linux.git
>>>>     branch reset/shared-retrigger
>>>
>>> The changes in that branch above have now landed in Linus' tree with:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=557acb3d2cd9c82de19f944f6cc967a347735385
>>>
>>> It would be good if we could get both patches applied via the same tree
>>> or within the same cycle to avoid having either PCIe or SATA broken on
>>> these platforms.
>>
>> Ping? Can someone apply those patches if you are happy with them? Thank you.
> 
> Ping? Can we review and ideally also apply these patches? Thanks

Is there something going on preventing these patches from being reviewed
and/or applied?
-- 
Florian

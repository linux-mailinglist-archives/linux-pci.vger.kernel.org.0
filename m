Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1F36E0A7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhD1VDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhD1VDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 17:03:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510CC06138A;
        Wed, 28 Apr 2021 14:03:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so1289247pjd.4;
        Wed, 28 Apr 2021 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wMabVH0ExtCWX2/wFa5+AtEFnFN0QYvKQkf+hCG3bPg=;
        b=u490ivj9sdEMW+0Yl2DMwSEvsCDhomynsFqu2mbdCpByf64F3TXMEG/ZWwDikzr3Xr
         vaCTDQHx/V+JaOOUYVg7NZ8rTKFTQn2UOVhZArEFXMxrInJ6WQauLGgPwUk/f1B8NOzs
         rJCYHOBanXAETJdr9Mt6V+H1t41UKZTFBwAJSa2FQ8OYlp0wuqsquEuHJ6iRgmTPFeVI
         xAAsHoXF4xoleJPGKc+RSDRf+ugiQ/gUDJVQuihvHyXKZdWn7clxrUSeywKLUlRSyyal
         bxGogFAD97XUA7mo5N5gXuxvFLBWfXwdepO5STnbNpyRNe3JICcOp2gMT9lQ9RFtALYf
         DdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wMabVH0ExtCWX2/wFa5+AtEFnFN0QYvKQkf+hCG3bPg=;
        b=EzmUEs/etPdhEpLCA7KULG3qQn7GOgFIxlUdSJQKOhtOCWGJ4XwwpCk8qSn3+ZykTR
         qfkKt62JWJTYS5bGPiM1CjivFOVlnGF1dTUfY1Q5jwkrGOXSAYYW93/uvlbIcrz3a45k
         HKONXgHCUy0I9hYPBRxim9/wk3gruRVlV494ATgBC2KNC24tpyX5WmYfg+8dJl4vioA6
         nwkiaJoKsZgqawPGUyhaJQGsQSP+caWhW+kwBkvA3mZs5P9Px6KRmFpx06+rS1RgGszD
         QTg7KB+3OtfaOKL6uvA4CshEejxN0gVE+LWCCY76LAdRkG0VN1eFjHSbHbq5PAyBuBlK
         k1MA==
X-Gm-Message-State: AOAM530iDEVt7Ao0Exm0LbhQGfG9rONeCFVTAWt3xPNjZyt1895IqR86
        5XpMPn56f2qdNsQNls4esG0=
X-Google-Smtp-Source: ABdhPJy81yzMweyUwlvCinns5bo/H/RFfnymi1IjnBOEMBeKjwrSIO7NQBHPufvMnUW06INFLHYyPA==
X-Received: by 2002:a17:90a:5602:: with SMTP id r2mr7103814pjf.60.1619643783543;
        Wed, 28 Apr 2021 14:03:03 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n39sm515076pfv.51.2021.04.28.14.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:03:02 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20210428205319.GA429792@bjorn-Precision-5520>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cd166f27-119d-a5ac-548e-175d79ddf49c@gmail.com>
Date:   Wed, 28 Apr 2021 14:03:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428205319.GA429792@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/28/2021 1:53 PM, Bjorn Helgaas wrote:
> [+cc Amjad, Philipp: possible issue with 557acb3d2cd9 ("reset: make
> shared pulsed reset controls re-triggerable") below; report at
> https://lore.kernel.org/linux-ide/20210428200058.GA366202@bjorn-Precision-5520/]
> 
> On Wed, Apr 28, 2021 at 04:34:00PM -0400, Jim Quinlan wrote:
>> On Wed, Apr 28, 2021 at 4:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Fri, Mar 12, 2021 at 03:45:53PM -0500, Jim Quinlan wrote:
>>>> v5 -- Improved (I hope) commit description (Bjorn).
>>>>    -- Rnamed error labels (Krzyszt).
>>>>    -- Fixed typos.
>>>>
>>>> v4 -- does not rely on a pending commit, unlike v3.
>>>>
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
>>>> Jim Quinlan (2):
>>>>   ata: ahci_brcm: Fix use of BCM7216 reset controller
>>>>   PCI: brcmstb: Use reset/rearm instead of deassert/assert
>>>>
>>>>  drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
>>>>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
>>>>  2 files changed, 36 insertions(+), 29 deletions(-)
>>>
>>> Tripped over these errors while build testing with the .config below.
>>> This is on the pci/brcmstb branch from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>>>
>>> Dropping the pci/brcmstb branch while we get this figured out.  This will
>>> remove the following commits:
>>>
>>>   a24fd1d6469f ("PCI: brcmstb: Use reset/rearm instead of deassert/assert")
>>>   92b9cb55a9b6 ("ata: ahci_brcm: Fix use of BCM7216 reset controller")
>>>   b5d9209d5083 ("PCI: brcmstb: Fix error return code in brcm_pcie_probe()")
>>
>> Hi Bjorn,
>>
>> I believe the problem is that the commit
>>
>> 557acb3d2cd9c82de19f944f6cc967a347735385
>> "reset: make shared pulsed reset controls re-triggerable"
>>
>> defined reset_control_rearm() for the CONFIG_RESET_CONTROLLER=y  case
>> but forgot to define  an empty function for the unset case.  Your test
>> .config has this CONFIG unset.
>>
>> Would you like me to resubmit this with an additional commit that
>> fixes this?
> 
> The fix could be a patch along those lines, or it could be a Kconfig
> change that makes this config impossible.  I didn't look deeper to see
> what makes sense.  But I don't think the fix should be "manually avoid
> this configuration."
> 
> It looks like 557acb3d2cd9 ("reset: make shared pulsed reset controls
> re-triggerable") appeared in v5.11, so if a patch is the right thing,
> it should probably be marked for stable ("v5.11+").

All of the other reset controller API have inline stubs when
CONFIG_RESET_CONTROLLER is disabled, not having one for
reset_control_rearm() seems like an oversight (easy to make since if you
introduce the API you obviously needed it and did not consider the case
where it may not be available).

I agree this would be stable material.
-- 
Florian

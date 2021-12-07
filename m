Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76146C207
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhLGRr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 12:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhLGRr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 12:47:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0044C061574;
        Tue,  7 Dec 2021 09:44:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np3so17592pjb.4;
        Tue, 07 Dec 2021 09:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hSAdXrk133U0WbgiFQpHMNwpQjObfpGgkUoZBDfK8aM=;
        b=ZW2X6Chr61FyM8paaiD7DtUYLVYMawzF9J3JPVfmVehO2SrFRzHFpE51kokgyB9q3p
         faXp/dG2Nr91/Uv0bx8zeHqAxC3h+Epq5IG1cifsCh9vv7gaA4E3QgVYGmTldE89h1HQ
         ER84O+v5cYSMdgSVsvxsmdAwRABpvPfo8kieXcf7bYoAY7l3vZ1rCLLWdNcsbeXet1OU
         Wd7ok58VbEAHvyCLGJV3pay+R0suRSMO+TzTOG7L2pi+l5Jhg54at19kSkwuqVQkTWFK
         K2Wl01diiUR69yuvzOwJnjnpjNqaYONN3scndrieFPB0uemD/3ZVnKBdUqY4wuOnHugV
         JyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSAdXrk133U0WbgiFQpHMNwpQjObfpGgkUoZBDfK8aM=;
        b=fGjrnBEOaYn/FP1kuMo+3Y+o1jaAKZ7OskPHmelsewx3PiYnGyIxLka0r1yLDaW485
         g2FkX+HBnt7PuoR5063X4hhIUEKj0K05oHkssvZDYWIwjzgHtjt+xsHVso5hPzkuR8R4
         gjAAPmi0+v6WVo+HLP25V7OTtggesNRt6FCBXpp4xp3BAzInqf3L2WTXnExfnWy4yiDF
         Yhq2O0k0SV/hynNUQHh4D3aHtk9ojK/m0gy96/ddqAdt1Rh4tUCBPGYjH0Qq6q5rUl//
         Gu15vuZrVsaOAArn7SY5daz9LlGn1Brz5oEBwQBzLBEsJc4uH+j8zb716eTKQEe41asE
         jkbA==
X-Gm-Message-State: AOAM5333hJsoDzrKfQ1ubRncnFV6WGF4BhN3sNnNyFy3BSjUiA7iPQmi
        MaERVLMBSXX931byxJYI6aNi0RVLXTs=
X-Google-Smtp-Source: ABdhPJxoHTi/6QQhPLP4vbrWSm4ju6gS+9r4Z/Q+R8wI5UKhwYmHmiZUZ7getrMg5lPDVCuF4BsCfg==
X-Received: by 2002:a17:902:c643:b0:141:cf6b:6999 with SMTP id s3-20020a170902c64300b00141cf6b6999mr53212481pls.80.1638899067843;
        Tue, 07 Dec 2021 09:44:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j15sm319231pfh.35.2021.12.07.09.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:44:26 -0800 (PST)
Subject: Re: [PATCH v2 1/5] ARM: dts: Cygnus: Fixed iProc PCIe controller
 properties
To:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211206185242.2098683-1-f.fainelli@gmail.com>
 <20211206185242.2098683-2-f.fainelli@gmail.com>
 <CAL_JsqKaOkByjwYzyW6G_b90zRjCWVHvi2V0gBx_MJ8v2FmOaw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fc263ef8-10f8-206e-5df7-76f0b9d50fae@gmail.com>
Date:   Tue, 7 Dec 2021 09:44:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKaOkByjwYzyW6G_b90zRjCWVHvi2V0gBx_MJ8v2FmOaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/7/21 5:49 AM, Rob Herring wrote:
> On Mon, Dec 6, 2021 at 12:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Rename the msi controller unit name to 'msi' to avoid collisions
>> with the 'msi-controller' boolean property and add the missing
>> 'interrupt-controller' property which is necessary. We also need to
>> re-arrange the 'ranges' property to show the two cells as being separate
>> instead of combined since the DT checker is not able to differentiate
>> otherwise.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 8ecb7861ce10..ea19d1b56400 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
>>                         compatible = "brcm,iproc-pcie";
>>                         reg = <0x18012000 0x1000>;
>>
>> +                       interrupt-controller;
> 
> How is this a fix? This doesn't even work before v5.16 with commit
> 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
> interrupt controller").

What is the path forward? I suppose I could make the
interrupt-controller property not required for this controller but then
the default interrupt-controller schema is not terribly happy about
seeing an interrupt-map/interrupt-map-mask properties without
interrupt-controller.
-- 
Florian

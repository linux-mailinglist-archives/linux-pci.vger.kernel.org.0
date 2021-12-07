Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F420746C7BD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 23:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbhLGWxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 17:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbhLGWxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 17:53:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B779C061574;
        Tue,  7 Dec 2021 14:49:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id p13so789332pfw.2;
        Tue, 07 Dec 2021 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EdYea8gkEDGih1RnGbJo2dm6hJijWB5dNAEaQbMNm28=;
        b=XK03meLzpPySHZumczyM01BVWrjErrL8miiNiU6yeobYKNBv9QSMaGdcEymmy8pKvA
         hexe8G+raZtoCzLR6fX/tLWlgGWKycTffZxAk8iprUJzUvfjMMyd/hrtO35PebHSp8Iz
         4ks7sXJKDtLEWXdPE+gPQrNiPfaIxR+TGRRhK6E6T9ijNgXLM3tsR+ekbTYauL/fd0ra
         59eRWmywLaxmZd0TZtnrWWA+ZFVmxsjjcZ130/3mefw98BsQQiqrmtJ3COxu5wpgIhTN
         srIW00HiEdJaWNZRd9RrjBJzL2RTfIOWBGe05GMM9SadGETUQ8ttOkoAtV9YOABRAy73
         HZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EdYea8gkEDGih1RnGbJo2dm6hJijWB5dNAEaQbMNm28=;
        b=TACjGOUe130Hx3WewdWtK3CNUSosohxd0CcjJqKC0D5CbtpGqDOnuN4g6FWpWQgN/m
         RVl8w8QBuL6dPF9DbVSpPS0YjNNURkWPcWfBXMHh43l86rTMWNGakxYv8IdT7I/4Yovn
         S/BNQsuM4s/EeRf7EiPibhh64ziNjpLOnMA+mCV4vkvkNDY3Zh0AXlm8NDk2RvGVeco9
         v0fKCLqdXXLbSKax9gAE4wj1iLEspvhXfKWhY3l2HQiiT9GWtiZabQQu8JEEhaqUetfJ
         /1ONyRYvP0FK0jsOM8rFcKRbOrCByw3dG+Rq/WjG5r0lctxWGiIa4d0GpsCyXm8bO7YZ
         +uIQ==
X-Gm-Message-State: AOAM533VuqrZrk19NJAnxnvKb0lFigW/Bg8fNoFVKUv+DUyC940/Ljog
        UeExjKYvGnNzVoIyE/yfyyglnGwaZyI=
X-Google-Smtp-Source: ABdhPJyBJRO4d61TzlSU1qqEV5Y3OLwZjRUGoq8bqkPyJdODmb4ru8puCWYQVdpmuJEv7I7g8yJr9A==
X-Received: by 2002:a63:4e1c:: with SMTP id c28mr23399855pgb.318.1638917387522;
        Tue, 07 Dec 2021 14:49:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id na13sm551019pjb.11.2021.12.07.14.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 14:49:46 -0800 (PST)
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
 <fc263ef8-10f8-206e-5df7-76f0b9d50fae@gmail.com>
 <CAL_JsqL6HV-C6+9Pna_8GVT5V+uEzcYcPDaS1m6AK8LhsWnFaw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <745799e8-dc2e-359a-0d35-58e74bf86055@gmail.com>
Date:   Tue, 7 Dec 2021 14:49:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL6HV-C6+9Pna_8GVT5V+uEzcYcPDaS1m6AK8LhsWnFaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/7/21 12:08 PM, Rob Herring wrote:
> On Tue, Dec 7, 2021 at 11:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 12/7/21 5:49 AM, Rob Herring wrote:
>>> On Mon, Dec 6, 2021 at 12:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> Rename the msi controller unit name to 'msi' to avoid collisions
>>>> with the 'msi-controller' boolean property and add the missing
>>>> 'interrupt-controller' property which is necessary. We also need to
>>>> re-arrange the 'ranges' property to show the two cells as being separate
>>>> instead of combined since the DT checker is not able to differentiate
>>>> otherwise.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> index 8ecb7861ce10..ea19d1b56400 100644
>>>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> @@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
>>>>                         compatible = "brcm,iproc-pcie";
>>>>                         reg = <0x18012000 0x1000>;
>>>>
>>>> +                       interrupt-controller;
>>>
>>> How is this a fix? This doesn't even work before v5.16 with commit
>>> 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
>>> interrupt controller").
>>
>> What is the path forward? I suppose I could make the
>> interrupt-controller property not required for this controller but then
>> the default interrupt-controller schema is not terribly happy about
>> seeing an interrupt-map/interrupt-map-mask properties without
>> interrupt-controller.
> 
> There's certainly no requirement for having 'interrupt-controller'.
> What error are you getting?

This was the error I was getting because I had made the
'interrupt-controller' a required property in the brcm,iproc-pcie.yaml
binding, silly me:

/home/fainelli/dev/linux/arch/arm/boot/dts/bcm958300k.dt.yaml:
pcie@18012000: 'interrupt-controller' is a required property
        From schema:
/home/fainelli/dev/linux/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

after taking it out from the required property there are no more
warnings, I will spin a v3 with the changes, thanks!
-- 
Florian

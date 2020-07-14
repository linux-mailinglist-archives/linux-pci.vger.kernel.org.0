Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E655E21FFDC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGNVSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNVSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 17:18:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC6C061755;
        Tue, 14 Jul 2020 14:18:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so200870wrv.9;
        Tue, 14 Jul 2020 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+lZBBeyUE0lPJ7ofFYfVPRC61PUIwQVU3H14G0pJ7tc=;
        b=F3NZpnIvV6tqV2q8ALdGW4uRyADrH4iYT2AdqPJNK9HsU8K0tyI4WQv1+Uig6/NNmk
         qKScQHCi/YEBEAb/zqm1Lu7ne97Bgc9rhgPgJUmbijzfEv888yDzLkyDzccIHEO8KbGR
         qxFzYZ8t7qwkeZu4D2e4oLdrfdSIZl6H8V74LCrBSVqIQdydQYRdR9gRZ9jRjiwKZRBq
         ArvQ633flh6Kur0V6qlhpeIbnSw/tHpSwuybMcWheu5IJTq39FxowWwCkF6Oh9Iclg/h
         NrUdkvAukBfkC1z1NkI6kmqWQ06qAOW1Q6yYiWlTvrUXwlz9h6KBhjnCQlFXJyfuFlLl
         Hz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lZBBeyUE0lPJ7ofFYfVPRC61PUIwQVU3H14G0pJ7tc=;
        b=QMldNHnDkztlAySfHygh4xhX1mQWZ2EpJVXtf3V4jrpjBa4XJAYVIwnvEvyqXBoaXl
         DoTZZ9JVS+9/RfGK0ncZn/y9iVdrseWVd90e6Bt0V4w/WYgu9fKjDmJ16FUBENumc/v0
         Z0xrFFiwCZ/p4+jmo95tZRCJmFwGhBLFWIBqN9WJXlyOcZNdn4lSBU3t0aZ3UxtlFGuY
         y1FBQnr61aPwgp7rRh0oKyU3nbXcHQd7SuVteW7mGahU161Ww8tEuyU8t9N+/awgyJIl
         5rLTLeVeEhkIiuoPrsL2Qu5zdIB3xAMcjxnuuotw4db/WfGEksEwkDhj4a8vOxXg8R9d
         na9A==
X-Gm-Message-State: AOAM531Q67fqjbOpHozuDoCjuCreJ3FIqnnq3sdjtL8YzArt0sylUtGT
        +lPIb17dmH9fEYJdDFpS1ETw87BN
X-Google-Smtp-Source: ABdhPJzDcFTmUmW90ndfjqy6LWZjEbFnjFisW6pTMPwBDeX+av28s7sc1wH8uk2lKXjz1BYHgeNsEw==
X-Received: by 2002:adf:e908:: with SMTP id f8mr7787367wrm.3.1594761485670;
        Tue, 14 Jul 2020 14:18:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id f14sm34071251wro.90.2020.07.14.14.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 14:18:04 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
To:     Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
 <20200612171334.26385-2-nsaenzjulienne@suse.de>
 <20200713182356.GA413630@bogus>
 <ed42e27eaf48fd19cc8ccccd15b0b25ba1d836ae.camel@suse.de>
 <20200714210708.GA2897216@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <925bab2c-91e0-bf60-9ec4-286eb53f72ab@gmail.com>
Date:   Tue, 14 Jul 2020 14:17:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714210708.GA2897216@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/14/2020 2:07 PM, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 01:59:21PM +0200, Nicolas Saenz Julienne wrote:
>> On Mon, 2020-07-13 at 12:23 -0600, Rob Herring wrote:
>>> On Fri, Jun 12, 2020 at 07:13:25PM +0200, Nicolas Saenz Julienne wrote:
>>>> The firmware running on the RPi VideoCore can be used to reset and
>>>> initialize HW controlled by the firmware.
>>>>
>>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>> ---
>>>> Changes since v2:
>>>>  - Add include file for reset IDs
>>>>
>>>> Changes since v1:
>>>>  - Correct cells binding as per Florian's comment
>>>>  - Change compatible string to be more generic
>>>>
>>>>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
>>>>  .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
>>>>  2 files changed, 34 insertions(+)
>>>>  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
>>>> firmware.yaml
>>>> b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
>>>> firmware.yaml
>>>> index b48ed875eb8e..23a885af3a28 100644
>>>> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
>>>> firmware.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
>>>> firmware.yaml
>>>> @@ -39,6 +39,22 @@ properties:
>>>>        - compatible
>>>>        - "#clock-cells"
>>>>  
>>>> +  reset:
>>>
>>> I'm not really thrilled how this is evolving with a node per provider. 
>>> There's no reason you can't just add #clock-cells and #reset-cells to 
>>> the parent firmware node.
>>
>> What are the downsides? The way I see it there is not much difference. And this
>> way of handling things is feels more intuitive and flexible (overlays can
>> control what to enable easily, we can take advantage of the platform device
>> core).
> 
> What the OS wants can evolve, so designing around the current needs of 
> the OS is not how bindings should be done.
> 
> Using overlays to add clocks or resets wouldn't really work given they 
> are spread out over the tree. And with clocks in particular, you'd have 
> to replace dummy fixed clocks with actual firmware clocks. Sounds 
> fragile and messy...
> 
>>> I probably should have complained with the clocks node, but that's only 
>>> pending for 5.9.
>>
>> Note that there are more users for this pattern: "raspberrypi,firmware-ts" and
>> "raspberrypi,firmware-gpio". Actually you were the one to originally propose
>> this it[1]. :P
> 
> Sigh, this is why I dislike incomplete examples...
> 
> Based on that,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> And please get gpio and ts converted to schema and referenced here 
> before the next time I look at this.
> 
>> There already is a fair amount of churn in these drivers because of all the DT
>> changes we did in the past, and if we need to change how we integrate these
>> again, I'd really like it to be for good.
>>
>>> The bigger issue is this stuff is just trickling in one bit at a time 
>>> which gives no context for review. What's next? Is it really a mystery 
>>> as to what functions the firmware provides?
>>
>> We have no control over it, RPi engineers integrate new designs and new
>> firmware interfaces show up. This is a good example of it.
>>
>> I proposed them to use SCMI as it covers most of what they are already
>> providing here. But no luck so far.
> 
> Once we get tired of supporting all the different firmware interfaces 
> and the mess they become, we'll just have to start refusing custom ones. 
> Worked for PSCI.

In this particular case, the Raspberry Pi Foundation VPU firmware should
just implement SCMI and that would avoid having to write new client
drivers for Linux, it is not clear to me why this has not been done yet.
-- 
Florian

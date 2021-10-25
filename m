Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D943A7EA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJYWy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhJYWyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 18:54:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEAEC061227;
        Mon, 25 Oct 2021 15:51:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so8939905plr.6;
        Mon, 25 Oct 2021 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=81AJNMnFxRWUqJjijgRXknq5Pna9QzgGgJMBSF89pBE=;
        b=VrKyvOaQP5K8pq1kWushtEbX6vFeMxgzWBmx6Tx6ks40hKKRlI93Bo68TA3WK9+Ocq
         Gqtp950zOM0xO+SCXqu3Wskmv6KwX75D5RN46F0Wkc2D4nywXFNNTCXlZ893yNvn3BON
         AzgXkC9UsRQ51NTzZYcQ5Z7enYfVJ2N8LtnG2z+74uDkWnUrsegSwyqiVOfPT0hUTXgJ
         LrLhJK5ZgXepcCSF5PwYG8RZjfWdaXY3/GLeFysUZ/4G7j6b2Elkh77M6QAW1WGBhM31
         mCx6iOGbgg3cseuHtcgqe8LiAMMSbr2yOzZFeTQ+0rbo0YbAq11ZcU9vg1v3r5MyLiCF
         0+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81AJNMnFxRWUqJjijgRXknq5Pna9QzgGgJMBSF89pBE=;
        b=jiq1Dxfig8+w0S362LrFCLSSeYW6BFOvZVG4HuilzEclzRlGBT8ZF4j3JE+HkmcGWR
         cThaKDdMj8x9GCF3GaIVD0+kd2meya/s49bdMdsD77O7cTNEXgx6ViImrluBurYMq03B
         2OihrMrUJ0l3XSOjDQsZsbok8ZpoLBW5sDItEQLjEeqHfyMnmIw6Dnob7ERwJrx8Lp1h
         IF/ZAgZ36ILsp+CZBiAxPHT1CQ7/yl87CIXCreCw4AcYs66TlJhGceMKOr8GYvmCD8pq
         IxmpC0YxzVp0489iQwXUxrDv/xd100hZK1m75d2Oat0UfricofzYOLwqIlKWigY4nQc0
         D8gw==
X-Gm-Message-State: AOAM5312KnQcfW3Hhi9wiqPKdF1eWlizImLnj/4MU1uy7LYBJjh4E/kb
        SW2DVJSida171tK8fq6wMN1JxImZz3U=
X-Google-Smtp-Source: ABdhPJzxSbQ66PzcTLSO+Bfscalmt8f1RSlJLotiWFdKAvnUinoFG/Rfh0U1skgADEkKwTdO5suZKw==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id v10mr38840829pjj.130.1635202294456;
        Mon, 25 Oct 2021 15:51:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id oc12sm3906084pjb.17.2021.10.25.15.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 15:51:33 -0700 (PDT)
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage
 regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
 <YXMVSVpeC1Kqsg5x@sirena.org.uk>
 <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
 <YXbF+VxZKkiHEu9c@sirena.org.uk>
 <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
 <YXczHKg77Z5oIJX3@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <54855dfe-f91a-f2eb-dc28-28de468449c1@gmail.com>
Date:   Mon, 25 Oct 2021 15:51:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXczHKg77Z5oIJX3@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/25/21 3:43 PM, Rob Herring wrote:
> On Mon, Oct 25, 2021 at 03:04:34PM -0700, Florian Fainelli wrote:
>> On 10/25/21 7:58 AM, Mark Brown wrote:
>>> On Mon, Oct 25, 2021 at 09:50:09AM -0400, Jim Quinlan wrote:
>>>> On Fri, Oct 22, 2021 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
>>>>> On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:
>>>
>>>>> That sounds like it just shouldn't be a regulator at all, perhaps the
>>>>> board happens to need a regulator there but perhaps it needs a clock,
>>>>> GPIO or some specific sequence of actions.  It sounds like you need some
>>>>> sort of quirking mechanism to cope with individual boards with board
>>>>> specific bindings.
>>>
>>>> The boards involved may have no PCIe sockets, or run the gamut of the different
>>>> PCIe sockets.  They all offer gpio(s) to turn off/on their power supply(s) to
>>>> make their PCIe device endpoint functional.  It is not viable to add
>>>> new Linux quirk or DT
>>>> code for each board.  First is the volume and variety of the boards
>>>> that use our SOCs.. Second, is
>>>> our lack of information/control:  often, the board is designed by one
>>>> company (not us), and
>>>> given to another company as the middleman, and then they want the
>>>> features outlined
>>>> in my aforementioned commit message.
>>>
>>> Other vendors have plenty of variation in board design yet we still have
>>> device trees that describe the hardware, I can't see why these systems
>>> should be so different.  It is entirely normal for system integrators to
>>> collaborate on this and even upstream their own code, this happens all
>>> the time, there is no need for everything to be implemented directly the
>>> SoC vendor.
>>
>> This is all well and good and there is no disagreement here that it
>> should just be that way but it does not reflect what Jim and I are
>> confronted with on a daily basis. We work in a tightly controlled
>> environment using a waterfall approach, whatever we come up with as a
>> SoC vendor gets used usually without further modification by the OEMs,
>> when OEMs do change things we have no visibility into anyway.
>>
>> We have a boot loader that goes into great lengths to tailor the FDT
>> blob passed to the kernel to account for board-specific variations, PCIe
>> voltage regulators being just one of those variations. This is usually
>> how we quirk and deal with any board specific details, so I fail to
>> understand what you mean by "quirks that match a common pattern".
>>
>> Also, I don't believe other vendors are quite as concerned with
>> conserving power as we are, it could be that they are just better at it
>> through different ways, or we have a particular sensitivity to the subject.
>>
>>>
>>> If there are generic quirks that match a common pattern seen in a lot of
>>> board then properties can be defined for those, this is in fact the
>>> common case.  This is no reason to just shove in some random thing that
>>> doesn't describe the hardware, that's a great way to end up stuck with
>>> an ABI that is fragile and difficult to understand or improve.
>>
>> I would argue that at least 2 out of the 4 supplies proposed do describe
>> hardware signals. The latter two are more abstract to say the least,
>> however I believe it is done that way because they are composite
>> supplies controlling both the 12V and 3.3V supplies coming into a PCIe
>> device (Jim is that right?). So how do we call the latter supply then?
>> vpcie12v3v...-supply?
>>
>>> Potentially some of these things should be being handled in the bindings
>>> and drivers drivers for the relevant PCI devices rather than in the PCI
>>> controller.
>>
>> The description and device tree binding can be and should be in a PCI
>> device binding rather than pci-bus.yaml.
>>
>> The handling however goes back to the chicken and egg situation that we
>> talked about multiple times before: no supply -> no link UP -> no
>> enumeration -> no PCI device, therefore no driver can have a chance to
>> control the regulator. These are not hotplug capable systems by the way,
>> but even if they were, we would still run into the same problem. Given
>> that most reference boards do have mechanical connectors that people can
>> plug random devices into, we cannot provide a compatible string
>> containing the PCI vendor/device ID ahead of time because we don't know
>> what will be plugged in. 
> 
> I thought you didn't have connectors or was it just they are 
> non-standard? If the latter case, what are the supply rails for the 
> connector?

We now have reference boards with full-sized x1 and x4 connectors in
addition to half sized and full-sized mini-PCIe connectors and the
soldered down Wi-Fi on board (WOMBO) and the Multi-chip Module packages
(MCM).

When using connectors we would use the standard PCIe pinout nomenclature
however for the latter two, there appears to be a variety of
non-standard stuff being done there. We reviewed some schematics with
Jim and it looks like some of the usages for the regulators are just
laziness on the Wi-Fi driver side, like asking the kernel to keep the
radio on (PA, LNA etc.) as if it was as critical and necessary as the
12V and 3.3V supplies that actually power on the PCIe end-point... We
will get those fixed hopefully.

> 
> I'd be okay if there's no compatible as long as there's not a continual 
> stream of DT properties trying to describe power sequencing 
> requirements.

Have not looked whether Dmitry's power sequencing generalizing is
helping us here:

https://www.spinics.net/lists/linux-bluetooth/msg93564.html

it still looks like the PCIe host controller is involved in requesting
the power sequence.

> 
>> In the case of a MCM, we would, but then we
>> only solved about 15% of the boards we need to support, so we have not
>> really progressed much.
> 
> MCM is multi-chip module?

Correct, see above.
-- 
Florian

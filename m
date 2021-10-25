Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E265043A64D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhJYWHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJYWG7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 18:06:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025FC061745;
        Mon, 25 Oct 2021 15:04:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v193so5592102pfc.4;
        Mon, 25 Oct 2021 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zO5xhn2/Z+kiwacnB4osflfdSzmNXjSex1D/P98VGU=;
        b=Xh3k41dOMbxMuiMFRkKT1v3P6AUQjHYwWVULvwKZXLWBBzbd0F5I6q7PNaR4pwexYB
         jxgojj0g2Cf5oytXbwKvh559C72FrF3EEI5yozwBraVDx00h6tPR4yxq7ym7qpcGAL59
         xBZVw1/nVI1pkGlZjuTwuwOw84aTaMABVmZaMwBRkW00gpvFl3PVBqhnzNDut9vNtWIT
         GI8sV8zjoyXHSheESp4KYG4B3gnKd3Z7fde12933GMv5Qcwik7goYz5wgKTsK7Qlp5/H
         YcivUuL/V0D1Vy2IMO+rmptdMTFuIemOa8Tqb9lnrLrBs77Anvt9DDTSAaOkVnlx3xWk
         aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zO5xhn2/Z+kiwacnB4osflfdSzmNXjSex1D/P98VGU=;
        b=m9WoWapgwROp9R2rBMpsctS6I9UeNn8ZmJeAGGimwuqhtCsp6GkdgVyeV1mL2CR5u0
         ZJETEl764Tmss8I8KG2z4x0RF82DCOMyJQvmtgal6Ab4yE+XZcJs7EF7JkLSNnW1gy68
         hGcfnStAKsRu9NJFqvAwzbVLv6voznvsdXYqLx4/YQvpuLk0sSxpijVn0zqzwI996Jkb
         cYZwwiBm0QmF99ZYVYJtwccjpgEJ4R6SamwSKUT6EYwESNVYRTLlYS7g1rPi0H1vIpFd
         2QBBCObUvQfipM034n+qqbW7U+ofTuuHtBmW84ASrNalHjw++FTMxfMGwnc6K14JWsQr
         V4lA==
X-Gm-Message-State: AOAM533G3XTAzVS2PWR6QkzDydy7fU3qJB8FgUnaS8WOfaOAIsLkrnfx
        TIVgalH7NtgTRNykzIrnYC0ZGBuJeO4=
X-Google-Smtp-Source: ABdhPJxl978yCxMCohsUqDoykPYlfMm5FNpKY+/hXzQx0jIy436CHBYwdxXghao8VJ7upqQlBUQx8g==
X-Received: by 2002:a63:ab02:: with SMTP id p2mr15692560pgf.209.1635199476219;
        Mon, 25 Oct 2021 15:04:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 17sm18290535pgr.10.2021.10.25.15.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 15:04:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage
 regulators
To:     Mark Brown <broonie@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
Date:   Mon, 25 Oct 2021 15:04:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXbF+VxZKkiHEu9c@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/25/21 7:58 AM, Mark Brown wrote:
> On Mon, Oct 25, 2021 at 09:50:09AM -0400, Jim Quinlan wrote:
>> On Fri, Oct 22, 2021 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:
> 
>>> That sounds like it just shouldn't be a regulator at all, perhaps the
>>> board happens to need a regulator there but perhaps it needs a clock,
>>> GPIO or some specific sequence of actions.  It sounds like you need some
>>> sort of quirking mechanism to cope with individual boards with board
>>> specific bindings.
> 
>> The boards involved may have no PCIe sockets, or run the gamut of the different
>> PCIe sockets.  They all offer gpio(s) to turn off/on their power supply(s) to
>> make their PCIe device endpoint functional.  It is not viable to add
>> new Linux quirk or DT
>> code for each board.  First is the volume and variety of the boards
>> that use our SOCs.. Second, is
>> our lack of information/control:  often, the board is designed by one
>> company (not us), and
>> given to another company as the middleman, and then they want the
>> features outlined
>> in my aforementioned commit message.
> 
> Other vendors have plenty of variation in board design yet we still have
> device trees that describe the hardware, I can't see why these systems
> should be so different.  It is entirely normal for system integrators to
> collaborate on this and even upstream their own code, this happens all
> the time, there is no need for everything to be implemented directly the
> SoC vendor.

This is all well and good and there is no disagreement here that it
should just be that way but it does not reflect what Jim and I are
confronted with on a daily basis. We work in a tightly controlled
environment using a waterfall approach, whatever we come up with as a
SoC vendor gets used usually without further modification by the OEMs,
when OEMs do change things we have no visibility into anyway.

We have a boot loader that goes into great lengths to tailor the FDT
blob passed to the kernel to account for board-specific variations, PCIe
voltage regulators being just one of those variations. This is usually
how we quirk and deal with any board specific details, so I fail to
understand what you mean by "quirks that match a common pattern".

Also, I don't believe other vendors are quite as concerned with
conserving power as we are, it could be that they are just better at it
through different ways, or we have a particular sensitivity to the subject.

> 
> If there are generic quirks that match a common pattern seen in a lot of
> board then properties can be defined for those, this is in fact the
> common case.  This is no reason to just shove in some random thing that
> doesn't describe the hardware, that's a great way to end up stuck with
> an ABI that is fragile and difficult to understand or improve.

I would argue that at least 2 out of the 4 supplies proposed do describe
hardware signals. The latter two are more abstract to say the least,
however I believe it is done that way because they are composite
supplies controlling both the 12V and 3.3V supplies coming into a PCIe
device (Jim is that right?). So how do we call the latter supply then?
vpcie12v3v...-supply?

> Potentially some of these things should be being handled in the bindings
> and drivers drivers for the relevant PCI devices rather than in the PCI
> controller.

The description and device tree binding can be and should be in a PCI
device binding rather than pci-bus.yaml.

The handling however goes back to the chicken and egg situation that we
talked about multiple times before: no supply -> no link UP -> no
enumeration -> no PCI device, therefore no driver can have a chance to
control the regulator. These are not hotplug capable systems by the way,
but even if they were, we would still run into the same problem. Given
that most reference boards do have mechanical connectors that people can
plug random devices into, we cannot provide a compatible string
containing the PCI vendor/device ID ahead of time because we don't know
what will be plugged in. In the case of a MCM, we would, but then we
only solved about 15% of the boards we need to support, so we have not
really progressed much.

> 
>>> I'd suggest as a first pass omitting this and then looking at some
>>> actual systems later when working out how to support them, no sense in
>>> getting the main thing held up by difficult edge cases.
> 
>> These are not edge cases -- some of these are major customers.
> 
> I'm trying to help you progress the driver by decoupling things which
> are causing difficulty from the simple parts so that we don't need to
> keep looking at the simple bits over and over again.  If these systems
> are very common or familiar then it should be fairly easy to describe
> the common patterns in what they're doing.

We are appreciative of your feedback, and Rob's, and everyone else
looking at the patches really.

> 
> In any case whatever gets done needs to be documented in the bindings
> documents.

Is not that what patch #1 does?
-- 
Florian

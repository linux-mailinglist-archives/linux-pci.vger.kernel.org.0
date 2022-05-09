Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BC5205F7
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiEIUjs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiEIUjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 16:39:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698932623;
        Mon,  9 May 2022 13:35:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h85so16583208iof.12;
        Mon, 09 May 2022 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YuzWP6Ilisk+02CdVUyIpxlsqIqBvtvz0R4k+B5Ty88=;
        b=gW3Sr+KJsEFqZaMjeVBcezZBoCDqmE2rWb9jBZXSClx7/N2pzxt9dDIm1uDbfvi/r9
         ma8qOdWrj5Q3kws3+9VmGb5WxSwX9I9r2e/BQu3YYbjQfH3SpdPOEhNcNybS0ipghRtk
         qJS5J5LLFt6ytRFo98xbW5qO36nYHb/P3Ypw30oEq2CToeUHP5zUaoJmQua59lYYKQoc
         bGG+bx6UbTgCQd+2kDU2FVffgeB3Fi7SXFtYZSV8SbDmlTqyb9IsSimZ7LIP0kVwjvnv
         ZST4FD1F0vZAIMexgJDAQeR8mWPDY8yaaDAia38BeLrmiSwIILFQVEOrQfjFgKNH6UFu
         L/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YuzWP6Ilisk+02CdVUyIpxlsqIqBvtvz0R4k+B5Ty88=;
        b=cQa66U9dYqjN+VadkYaHQ7zPRqUx0ePfSCxjHzjso7uQDqrMOIh+Hpp39wlfUr2Z3Q
         hHHsdExIytyVa/NskDvDW4ckMil20DCqhrhNrZwhzeQNmkTPu7R4qKMWZ0qN4mY/eu5A
         FZCEop5RNfJGqzjzosFPg0jzA8J7+PUdvUOOcG3gjJj7hr25ZbUe4fflH3KPdoEyIAwS
         XNIbFDrLEtRroLqeDSt4z4UepIu4cZKkMYfT6XrWaO1ujsAFlTEke2w/JEJwDOdsUusJ
         GmDno5476/pCmOnu96HxtNQ48jWRsihJP9H/58vdWEW2vwGrFvJlvah3OzeyIWdyrDFx
         VuHg==
X-Gm-Message-State: AOAM5337RO/Iue/sPBj5MhF9ZJ1kHXiExyiYcEARw3NO5ENxMRdvjOvO
        eUaLdPLQQJc8BWg1vg4EhuU=
X-Google-Smtp-Source: ABdhPJzJI09tcIP6MUUbnsvIhRamFfxgrCDSX7jWJd55qrciHnGIBvef0kUby1ULOp/Lxb8/3Fw+xA==
X-Received: by 2002:a02:3f08:0:b0:32b:51f6:fa9c with SMTP id d8-20020a023f08000000b0032b51f6fa9cmr7610729jaa.28.1652128546735;
        Mon, 09 May 2022 13:35:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:4a3:2265:73fb:e310? ([2600:1700:2442:6db0:4a3:2265:73fb:e310])
        by smtp.gmail.com with ESMTPSA id ck19-20020a0566383f1300b0032b62accd1bsm3811453jab.98.2022.05.09.13.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 13:35:46 -0700 (PDT)
Message-ID: <50d044ca-8d46-17a5-0a16-541e079af933@gmail.com>
Date:   Mon, 9 May 2022 15:35:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <CAL_Jsq+jnz3SAc+m5RRN9cOs+5k=CC4Fud9gsmquVjv2zVv6pQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_Jsq+jnz3SAc+m5RRN9cOs+5k=CC4Fud9gsmquVjv2zVv6pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/9/22 13:36, Rob Herring wrote:
> On Mon, May 9, 2022 at 10:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/9/22 07:16, Clément Léger wrote:
>>> Le Fri, 6 May 2022 13:33:22 -0500,
>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>
>>>> On 4/27/22 04:44, Clément Léger wrote:
>>>>> This series adds foundation work to support the lan9662 PCIe card.
>>>>> This card is meant to be used an ethernet switch with 2 x RJ45
>>>>> ports and 2 x 2.5G SFPs. The lan966x SoCs can be used in two
>>>>> different ways:
>>>>>
>>>>>  - It can run Linux by itself, on ARM64 cores included in the SoC.
>>>>> This use-case of the lan966x is currently being upstreamed, using a
>>>>>    traditional Device Tree representation of the lan996x HW blocks
>>>>> [1] A number of drivers for the different IPs of the SoC have
>>>>> already been merged in upstream Linux.
>>>>>
>>>>>  - It can be used as a PCIe endpoint, connected to a separate
>>>>> platform that acts as the PCIe root complex. In this case, all the
>>>>> devices that are embedded on this SoC are exposed through PCIe BARs
>>>>> and the ARM64 cores of the SoC are not used. Since this is a PCIe
>>>>> card, it can be plugged on any platform, of any architecture
>>>>> supporting PCIe.
>>>>>
>>>>> The problem that arose is that we want to reuse all the existing OF
>>>>> compatible drivers that are used when in SoC mode to instantiate the
>>>>> PCI device when in PCIe endpoint mode.
>>>>>
>>>>> A previous attempt to tackle this problem was made using fwnode [1].
>>>>> However, this proved being way too invasive and it required
>>>>> modifications in both subsystems and drivers to support fwnode.
>>>>> First series did not lead to a consensus and multiple ideas to
>>>>> support this use-case were mentioned (ACPI overlay, fwnode,
>>>>> device-tree overlay). Since it only seemed that fwnode was not a
>>>>> totally silly idea, we continued on this way.
>>>>>
>>>>> However, on the series that added fwnode support to the reset
>>>>> subsystem, Rob Herring mentioned the fact that OF overlay might
>>>>> actually be the best way to probe PCI devices and populate platform
>>>>> drivers using this overlay. He also provided a branch containing
>>>>> some commits that helped
>>>>
>>>> I need to go look at the various email threads mentioned above before
>>>> I continue reading this patch series.
>>>>
>>>> I do have serious concerns with this approach.  I need to investigate
>>>> more fully before I can determine whether the concerns are addressed
>>>> sufficiently.
>>>>
>>>> To give some background to my longstanding response to similar
>>>> proposals, here is my old statement from
>>>> https://elinux.org/Device_Tree_Reference:
>>>>
>>>>    Overlays
>>>>    Mainline Linux Support
>>>>    Run time overlay apply and run time overlay remove from user space
>>>> are not supported in the mainline kernel. There   are out of tree
>>>> patches to implement this feature via an overlay manager. The overlay
>>>> manager is used successfully by many users for specific overlays on
>>>> specific boards with specific environments and use cases. However,
>>>> there are many issues with the Linux kernel overlay implementation
>>>> due to incomplete and incorrect code. The overlay manager has not
>>>> been accepted in mainline due to these issues. Once these issues are
>>>> resolved, it is expected that some method of run time overlay apply
>>>> and overlay removal from user space will be supported by the Linux
>>>> kernel.
>>>>
>>>>    There is a possibility that overlay apply and overlay remove
>>>> support could be phased in slowly, feature by feature, as specific
>>>> issues are resolved.
>>>
>>> Hi Frank,
>>>
>>> This work uses the kernel space interface (of_overlay_fdt_apply())
>>> and the device tree overlay is builtin the driver. This interface was
>>> used until recently by rcu-dcar driver. While the only user (sic),
>>> this seems to work pretty well and I was able to use it successfully.
>>
>> Yes, of_overlay_fdt_apply() was used by one driver.  But that driver
>> was explicitly recognized as a grandfathered exception, and not an
>> example for other users.  It was finally removed in 5.18-rc1.
> 
> What API are folks supposed to use exactly? That's the only API to
> apply an overlay.

Yes, that is the API to designed to be used if overlays are applied
after the kernel has booted.

> I thought the FPGA mgr code was using it too, but

That was my understanding too.

> it's not. It doesn't look to me like the upstream code there even
> works as nothing applies the overlays AFAICT. If there are no in
> kernel users applying overlays, then let's remove the overlay code. I
> hear it has lots of problems.

I would not object to doing that.  But I suspect there are other people
who might.  I much prefer that overlays be applied before boot.

> 
> I am *way* more comfortable with driver specific applying of overlays
> than any generic mechanism. I don't think we'll ever have a generic
> mechanism. At least not one that doesn't end up with the same usage
> constraints driver specific cases would have.

Yes, generic use leads to a lot of the complications of implementing
runtime overlays.

> 
> 
>> You may have used of_overlay_fdt_apply() in a specific use case at
>> a specific kernel version, but if you read through the references
>> I provided you will find that applying overlays after the kernel
>> boots is a fragile endeavor, with expectations of bugs and problems
>> being exposed as usage is changed (simple example is that my adding
>> some overlay notifier unittests exposed yet another memory leak).
> 
> The exception being specific drivers that are only applying overlays
> isolated to their device as this usecase is. The usecase here is
> entirely self-contained. The only base tree is only what's needed to
> represent the PCI device.

This example might be the best example of such a use case.  As it is
claimed that the drivers for the devices on the board do not access
anything on the host other than the pcie slot.

> 
>> The reference that I provided also shows how the overlay code is
>> being improved over time.  Even with improvements, it will remain
>> fragile.
>>
>>>
>>> Moreover, this support targets at using this with PCI devices. This
>>> devices are really well contained and do not interfere with other
>>> devices. This actually consists in adding a complete subtree into the
>>> existing device-tree and thus it limits the interactions between
>>> potentially platform provided devices and PCI ones.
>>
>> Yes, that it is very important that you have described this fact, both
>> here and in other emails.  Thank you for that information, it does help
>> understanding the alternatives.
>>
>> I've hesitated in recommending a specific solution before better
>> understanding the architecture of your pcie board and drivers, but
>> I've delayed too long, so I am going to go ahead and mention one
>> possibility at the risk of not yet fully understanding the situation.
>>
>> On the surface, it appears that your need might be well met by having
>> a base devicetree that describes all of the pcie nodes, but with each
>> node having a status of "disabled" so that they will not be used.
>> Have a devicetree overlay describing the pcie card (as you proposed),
>> where the overlay also includes a status of "ok" for the pcie node.
>> Applying the overlay, with a method of redirecting the target to a
>> specific pcie node would change the status of the pcie node to enable
>> its use.  (You have already proposed a patch to modify of_overlay_fdt_apply()
>> to allow a modified target, so not a new concept from me.)  My suggestion
>> is to apply the overlay devicetree to the base devicetree before the
>> combined FDT devicetree is passed to the kernel at boot.  The overlay
>> apply could be done by several different entities.  It could be before
>> the bootloader executes, it could be done by the bootloader, it could
>> be done by a shim between the bootloader and the kernel.  This method
>> avoids all of the issues of applying an overlay to a running system
>> that I find problematic.  It is also a method used by the U-boot
>> bootloader, as an example.
> 
> Adding a layer, the solution to all problems...

< insert xkcd reference here >  :-)

> 
> I don't think that's a workable solution unless all the components are
> in one party's control. Given the desire to work on ACPI and DT based
> systems, that doesn't sound like the case here.

That is the motivation behind my questions of how generic or targeted
the use of this one specific card is.

A pre-boot shim that discovers the card and applies the overlay could
be somewhat generic to ACPI systems.

Is the overlay approach also being proposed for DT based systems?

> 
>> The other big issue is mixing ACPI and devicetree on a single system.
>> Historically, the Linux devicetree community has not been receptive
>> to the ides of that mixture.  Your example might be a specific case
>> where the two can be isolated from each other, or maybe not.  (For
>> disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
>> ACPI and devicetree is a recipe for disaster in the general case.
> 
> The idea here is what is described by ACPI and DT are disjoint which I
> think we can enforce. Enforcement comes from fwnode assuming it has
> either an ACPI or a DT handle, but not both.

I thought the intent was to use DT API drivers, not fwnode API drivers.
And I thought the card was not to be described by ACPI, so there would
not be any ACPI fwnode info for the card _and_ fwnode is somewhat
irrelevant since the drivers are using the DT API.  So the enforcement
you mention could be implemented by the overlay apply code verifying
that there is no ACPI fwnode for any DT node in the overlay.  So not
an _assumption_, but a testable rule.

That is a long way of essentially agreeing with you.

> 
>> More to come later as I finish reading through the various threads.
> 
> There is also the Xilinx folks wanting to support their PCI FPGA card
> with DT for the FPGA contents on both ACPI and DT systems.

Is that the XRT Alveo driver infrastructure thread?  I was not cc:ed
on that thread, and just recently stumbled upon it.  Yet another
thread that is on my to-read list.

> 
> Rob


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCD5205C1
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiEIUZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiEIUYL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 16:24:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0612397AE;
        Mon,  9 May 2022 13:07:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f2so16509562ioh.7;
        Mon, 09 May 2022 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBdVJcHdqbtyx+NxaVm9KQbBrTAdRTKsDdJxxaJYvL4=;
        b=jFdEHzypiblPDjhn4aC2Ui/AgTaVRieng6vnqO9HHWVYbRcX8g8GBe3vfRS5XjYuke
         EM4S/qf82a2EpKAEXO2hWOJE7GLPxpX922UpkWp5deDa5DywkHoF7YWA01mC8z4o3tOW
         +SU55dTflZNYQ6xUgrDCd8k1yjX4xd6O+I2Y0uuTTENuWojfK/V1f7v+TBkpjirwO1Ho
         xtWY0m85bgrjr1kgLK8n2siBrB6IEdh5g5FJmT79+KvSN4boB6EHpa6mP0Tcg/+j+Ab1
         ZgjV48F2MUfN+WR/T/dzqlD2IaF4Tuskg5aePmVJxZpgy6APdKKsX5MVCzqwQ1TASLg6
         QzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBdVJcHdqbtyx+NxaVm9KQbBrTAdRTKsDdJxxaJYvL4=;
        b=YxtqsrEzpBCvxbj7MsX6PX+kMBhQYTnj9UvexBpaJqSF34ElhZwNqZ+kEsQFnaYPra
         lGhpE6zMhAQVGFTG0RjYd4TdebawPHbLy2UyC1Y1sGF/2iYIbjICbcFphTotpLQph5Tw
         2KTMhJyYs9JWfokiDMqa/NcRhoH3R9b3OW+xMuQIdooc5E9M7rTb4icmUKkIRxsP13q+
         uVgOo0T8tR/AVQTE50a9LcIT88rYEydqDbsbzgH4s1lv61f9gcm385NbUVZnktfWfG//
         sUB5dAKkKHUk6fsZbCftnM/Zr7ZjiL0D/k8ws5C5lFPK0ncUS59VPpUyn18qK+dgWWFd
         z9jg==
X-Gm-Message-State: AOAM531ma0wFhfBAddfO2GNH1MU8/ptrUEd1okm7daeVltzaHKkoq3VQ
        iF1mf4CHUlgD3mzf/p23eOSUI9cDD7s=
X-Google-Smtp-Source: ABdhPJz4BVBpV5Y8VubYvds5o5jdOLxW0I6G/FMgoGe9F8yU5J0pEbLwlQj2Qz8I7jTtIaJvpirSzg==
X-Received: by 2002:a05:6638:3012:b0:317:9a63:ecd3 with SMTP id r18-20020a056638301200b003179a63ecd3mr8728165jak.210.1652126840675;
        Mon, 09 May 2022 13:07:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:4a3:2265:73fb:e310? ([2600:1700:2442:6db0:4a3:2265:73fb:e310])
        by smtp.gmail.com with ESMTPSA id e26-20020a026d5a000000b0032b3a781760sm3814847jaf.36.2022.05.09.13.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 13:07:19 -0700 (PDT)
Message-ID: <e6828dce-3e10-779e-4d12-67e7bdfd0f73@gmail.com>
Date:   Mon, 9 May 2022 15:07:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <20220509180917.0f0ae851@xps-bootlin>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220509180917.0f0ae851@xps-bootlin>
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

On 5/9/22 11:09, Clément Léger wrote:
> Le Mon, 9 May 2022 10:56:36 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>>> Hi Frank,
>>>
>>> This work uses the kernel space interface (of_overlay_fdt_apply())
>>> and the device tree overlay is builtin the driver. This interface
>>> was used until recently by rcu-dcar driver. While the only user
>>> (sic), this seems to work pretty well and I was able to use it
>>> successfully.  
>>
>> Yes, of_overlay_fdt_apply() was used by one driver.  But that driver
>> was explicitly recognized as a grandfathered exception, and not an
>> example for other users.  It was finally removed in 5.18-rc1.
> 
> I noticed that unfortunately.
> 
>>
>> You may have used of_overlay_fdt_apply() in a specific use case at
>> a specific kernel version, but if you read through the references
>> I provided you will find that applying overlays after the kernel
>> boots is a fragile endeavor, with expectations of bugs and problems
>> being exposed as usage is changed (simple example is that my adding
>> some overlay notifier unittests exposed yet another memory leak).
>>
>> The reference that I provided also shows how the overlay code is
>> being improved over time.  Even with improvements, it will remain
>> fragile.
> 
> Acked.
> 
>>
>>>
>>> Moreover, this support targets at using this with PCI devices. This
>>> devices are really well contained and do not interfere with other
>>> devices. This actually consists in adding a complete subtree into
>>> the existing device-tree and thus it limits the interactions between
>>> potentially platform provided devices and PCI ones.  
>>
>> Yes, that it is very important that you have described this fact, both
>> here and in other emails.  Thank you for that information, it does
>> help understanding the alternatives.
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
>> its use.  (You have already proposed a patch to modify
>> of_overlay_fdt_apply() to allow a modified target, so not a new
>> concept from me.)  My suggestion is to apply the overlay devicetree
>> to the base devicetree before the combined FDT devicetree is passed
>> to the kernel at boot.  The overlay apply could be done by several
>> different entities.  It could be before the bootloader executes, it
>> could be done by the bootloader, it could be done by a shim between
>> the bootloader and the kernel.  This method avoids all of the issues
>> of applying an overlay to a running system that I find problematic.
>> It is also a method used by the U-boot bootloader, as an example.
> 

Apologies if my following questions have already been answered in the
other threads...

> Ok, that is actually possible on a system that is given a device-tree
> by the bootloader. But on a system that is desrcibed using ACPI (such
> as the x86), this is much more difficult (at least to my knowledge)...
> We want this feature to be easy to use for the end user. Adding such
> configuration which also differs between various architecture is
> clearly not so easy to setup.

Are you trying to make your card work on any ACPI based system (x86,
x86-64, etc)?  Or do you have a specific model of computer that you
want to make this work on for a specific customer or appliance?

If for many arbitrary systems, can you limit it to one architecture
or sub-architecture?

> 
> Moreover, since the PCI is meant to be "Plug and Play", such
> configuration would completely break that. If the user switches the
> PCIe card from one slot to another, the bootloader configuration will
> need to be modified. This seems a big no way for me (and for the user).

Yes.  I was envisioning the pre-bootloader, bootloader, or Linux pre-boot
shim dynamically determining the slot containing the card, and applying
the overlay devicetree to the base devicetree, retargeting the overlay
to the proper location, before the Linux boot.

The base devicetree would be for a specific type of machine or family
of machines, just as is the case for all devicetree based systems.

> 
>>
>> The other big issue is mixing ACPI and devicetree on a single system.
>> Historically, the Linux devicetree community has not been receptive
>> to the ides of that mixture.  Your example might be a specific case
>> where the two can be isolated from each other, or maybe not.  (For
>> disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
>> ACPI and devicetree is a recipe for disaster in the general case.
> 
> Agreed, on that fact, it did raised some eyebrows, and it was for that
> specific concern that initially, I proposed the fwnode solution.
> Honestly, the fwnode conversion represent a lot of work (hundreds of
> lines easily) + requires a conversion of all the subsystem that are not
> fwnode ready (spoiler: almost all of them are not ready). 
> 
> After implementing Rob's solution, the device-tree overlay really seems
> the cleaner to me and requires much less modifications.
> 
>>
>> More to come later as I finish reading through the various threads.
> 
> Ok, thanks for your time !

Your welcome.  I'll keep looking deeper into the previous threads.

-Frank

> 
> Clément
> 
>>
>> -Frank
> 
> .


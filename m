Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796025205D8
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiEIUaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiEIUaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 16:30:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7B2878E0;
        Mon,  9 May 2022 13:11:56 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i20so16566658ion.0;
        Mon, 09 May 2022 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=30uTAtTdESWAxrQ1din34mMJXjVpP1+AQMtPldKr0Ro=;
        b=gyx42r12ZWOa0jIaRvU6Tmt6ZdJdxHVv55TWtTM9lvmcBbZuP+O8/E+5HMTQGdcJNP
         +/asehHkwYGDZglS03uJk5YpBmwtw1UHMbbBbMXbUpIYPEF20LizauWVhmGIg/qyTa02
         zvkglRJEeNtbeu4sKjAsBzpBbNGl0UR1fnEtILhwcMzFJRnv4uXm8F4oTli3DWHzW/CK
         nv1MTA5JvlseRQh6p+EELdjL0gYQw23f2CyZlB5vsW/DS3fcNiSoYiMHieuf1UfC6LGG
         5FybutPI+XzvITzGit9yjHnSl8Jzq8cSscIYewDsJhKj8eSVSg7MFERkZAe8DSLOGKjU
         ZB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=30uTAtTdESWAxrQ1din34mMJXjVpP1+AQMtPldKr0Ro=;
        b=ITu/CzdJa8sE13NmaKGjlIoH6JyoB7ubjk8aOHY5S2bsBHmVNWf+ha6bC1wtN/SXAn
         OT1OoG9Gv7oQYFCAS8SWcTum/BbSDqOFbOn/k8njAKkkSiong1gEnWKD9E/eHxdINRgk
         Tmr69O01IP/r0GGgZCv5rbsX0Y7RmjHgML54altKvSXNuhqLikbePvKoD9yxD9JBJady
         sNgk7INw05sjCtrzCowVfWqHSOv2kBI7c+IIhWt6d9FCEj7igpT7xHfUfR3S+dRuij/5
         dX9r6kQtGdGnJpqfISWVonXZeqHgXm8ZimOFpitGvSLATCpBdHhoXfjzo2koWvNvAZl3
         vVvA==
X-Gm-Message-State: AOAM530Rb8Dy+Q/XWOWaTo6qNwV7oW/AzQjH+8UwJGx6XvtWzX1SD7pr
        F+nZ63uQZ0nTi26yye3PPa8=
X-Google-Smtp-Source: ABdhPJyhi4sIOam3l2MwfJCdm+Mt2h+pvDUPHUKpW9UPlt61O9tE8QIvNM9x3eeHLQbj9dpdMiKllQ==
X-Received: by 2002:a02:ccd0:0:b0:32a:e2da:1e1f with SMTP id k16-20020a02ccd0000000b0032ae2da1e1fmr8105716jaq.313.1652127115768;
        Mon, 09 May 2022 13:11:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:4a3:2265:73fb:e310? ([2600:1700:2442:6db0:4a3:2265:73fb:e310])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638044600b0032b3a781756sm3835862jap.26.2022.05.09.13.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 13:11:55 -0700 (PDT)
Message-ID: <b476913d-896d-309c-f304-3ab37b81b4a9@gmail.com>
Date:   Mon, 9 May 2022 15:11:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <20220509180917.0f0ae851@xps-bootlin> <YnlIs312R4Temgu3@smile.fi.intel.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YnlIs312R4Temgu3@smile.fi.intel.com>
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

On 5/9/22 12:00, Andy Shevchenko wrote:
> On Mon, May 09, 2022 at 06:09:17PM +0200, Clément Léger wrote:
>> Le Mon, 9 May 2022 10:56:36 -0500,
>> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
> ...
> 
>>> On the surface, it appears that your need might be well met by having
>>> a base devicetree that describes all of the pcie nodes, but with each
>>> node having a status of "disabled" so that they will not be used.
>>> Have a devicetree overlay describing the pcie card (as you proposed),
>>> where the overlay also includes a status of "ok" for the pcie node.
>>> Applying the overlay, with a method of redirecting the target to a
>>> specific pcie node would change the status of the pcie node to enable
>>> its use.  (You have already proposed a patch to modify
>>> of_overlay_fdt_apply() to allow a modified target, so not a new
>>> concept from me.)  My suggestion is to apply the overlay devicetree
>>> to the base devicetree before the combined FDT devicetree is passed
>>> to the kernel at boot.  The overlay apply could be done by several
>>> different entities.  It could be before the bootloader executes, it
>>> could be done by the bootloader, it could be done by a shim between
>>> the bootloader and the kernel.  This method avoids all of the issues
>>> of applying an overlay to a running system that I find problematic.
>>> It is also a method used by the U-boot bootloader, as an example.
>>
>> Ok, that is actually possible on a system that is given a device-tree
>> by the bootloader. But on a system that is desrcibed using ACPI (such
>> as the x86), this is much more difficult (at least to my knowledge)...
>> We want this feature to be easy to use for the end user. Adding such
>> configuration which also differs between various architecture is
>> clearly not so easy to setup.
>>
>> Moreover, since the PCI is meant to be "Plug and Play", such
>> configuration would completely break that. If the user switches the
>> PCIe card from one slot to another, the bootloader configuration will
>> need to be modified. This seems a big no way for me (and for the user).
> 
> The main problem here is that Linux does not support hotplugging for the
> devices behind non-hotpluggable buses. You need to develop something to
> say that the device tree (in terms of hardware) can morph at run-time
> transparently to the user. I think the closest one is what FPGA does,
> or at least should do.

That is something I was not aware of yet.  Is the card in question a
hotpluggable card?  Do the systems that you anticipate plugging the
card into support hotplug?

-Frank

> 
>>> The other big issue is mixing ACPI and devicetree on a single system.
>>> Historically, the Linux devicetree community has not been receptive
>>> to the ides of that mixture.  Your example might be a specific case
>>> where the two can be isolated from each other, or maybe not.  (For
>>> disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
>>> ACPI and devicetree is a recipe for disaster in the general case.
>>
>> Agreed, on that fact, it did raised some eyebrows, and it was for that
>> specific concern that initially, I proposed the fwnode solution.
>> Honestly, the fwnode conversion represent a lot of work (hundreds of
>> lines easily) + requires a conversion of all the subsystem that are not
>> fwnode ready (spoiler: almost all of them are not ready). 
> 
> In either case you need to provide a format that would be suitable for
> DT-based as well as ACPI-based platforms.
> 


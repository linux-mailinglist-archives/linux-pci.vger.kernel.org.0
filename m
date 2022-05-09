Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C924A5201C7
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiEIQAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiEIQAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 12:00:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249822704F;
        Mon,  9 May 2022 08:56:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c1so11118731qkf.13;
        Mon, 09 May 2022 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AAey19UwfcuWCtcClnQMzrM9eSrYLQXusxy2rwriRwc=;
        b=TRFRGH85h6xYBHHy0RWAk08Ae8+yT5I0Yo8RUZZtBGJSRBQ93luscxFdOKTwvq2vql
         /HBF1RROmCGt3rTGa8sTJpTD+Fy5fDGnikgiyFirCPai6H3NIDE3KgZobzz5SJRdFIbl
         AIxzEYr5a4hLV2mA9uGhSk/9NoiLHx5qt1mNQg50zd8tzVQ9XFN5drUBNMfaGYgCey7N
         vfsIz/1LlwZb5NIV2J0oCECIiQ8FxQ7j2808voXCSB2KTRxfmjbL2c4CidGRui/Wloda
         Gxjmlc7YgWFEZzVC45OWVUJ8sYHq+Da+YkloMSDPSKLCnLB8XnkbTyHBhk+DPfLoZQu0
         C2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AAey19UwfcuWCtcClnQMzrM9eSrYLQXusxy2rwriRwc=;
        b=NfR+AsTL07h/qNWgI4kHs19+M+QwbAhDWDvLlU5j+1stib+NhGr5QwqJ4mobF7VZxi
         8Py6ESReuJ26dLCv+eHJVtOZKLND+rHlE3sQKi2wGj2Xo44aVo2hhHvLAjTVc7jRtOPv
         l1jX+oNyeC8srHlse3z/dwvZVAg8WiB85bFcOFcW8vz2Iw77Sk8sAAwArfQkLg2bXcVX
         qmTx5dJJ/ONcvJI/QT87rWISMDLZM2RX61Vt0QOs4+fVNLNP/3RTqszJe77+qBsgHxFW
         olKX/GT5SRW9FJCt2gMV6gelB8T2MwLSzGMvE3zNzwN9pGZ5l/OQFCVXtDBVzY7ZaK5G
         6TNQ==
X-Gm-Message-State: AOAM5332POB4UDI+yiKKCgE9687TMJQ0BFgFewEy2eDacU0Iu8YDvUel
        0gHR7j3FUtUktsp8yuQsq5uXrWbgJ9o=
X-Google-Smtp-Source: ABdhPJzImMtOKPG5DLT33drEizJYDECv70gBi9PWnZapeobeIE1/FL1/mY8wdhw7lLZysD9b1rDf6A==
X-Received: by 2002:a05:620a:28d3:b0:6a0:42aa:da87 with SMTP id l19-20020a05620a28d300b006a042aada87mr12114574qkp.118.1652111798695;
        Mon, 09 May 2022 08:56:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:4a3:2265:73fb:e310? ([2600:1700:2442:6db0:4a3:2265:73fb:e310])
        by smtp.gmail.com with ESMTPSA id i3-20020a05620a27c300b0069fc13ce220sm7151595qkp.81.2022.05.09.08.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 08:56:38 -0700 (PDT)
Message-ID: <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
Date:   Mon, 9 May 2022 10:56:36 -0500
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220509141634.16158c38@xps-bootlin>
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

On 5/9/22 07:16, Clément Léger wrote:
> Le Fri, 6 May 2022 13:33:22 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 4/27/22 04:44, Clément Léger wrote:
>>> This series adds foundation work to support the lan9662 PCIe card.
>>> This card is meant to be used an ethernet switch with 2 x RJ45
>>> ports and 2 x 2.5G SFPs. The lan966x SoCs can be used in two
>>> different ways:
>>>
>>>  - It can run Linux by itself, on ARM64 cores included in the SoC.
>>> This use-case of the lan966x is currently being upstreamed, using a
>>>    traditional Device Tree representation of the lan996x HW blocks
>>> [1] A number of drivers for the different IPs of the SoC have
>>> already been merged in upstream Linux.
>>>
>>>  - It can be used as a PCIe endpoint, connected to a separate
>>> platform that acts as the PCIe root complex. In this case, all the
>>> devices that are embedded on this SoC are exposed through PCIe BARs
>>> and the ARM64 cores of the SoC are not used. Since this is a PCIe
>>> card, it can be plugged on any platform, of any architecture
>>> supporting PCIe.
>>>
>>> The problem that arose is that we want to reuse all the existing OF
>>> compatible drivers that are used when in SoC mode to instantiate the
>>> PCI device when in PCIe endpoint mode.
>>>
>>> A previous attempt to tackle this problem was made using fwnode [1].
>>> However, this proved being way too invasive and it required
>>> modifications in both subsystems and drivers to support fwnode.
>>> First series did not lead to a consensus and multiple ideas to
>>> support this use-case were mentioned (ACPI overlay, fwnode,
>>> device-tree overlay). Since it only seemed that fwnode was not a
>>> totally silly idea, we continued on this way.
>>>
>>> However, on the series that added fwnode support to the reset
>>> subsystem, Rob Herring mentioned the fact that OF overlay might
>>> actually be the best way to probe PCI devices and populate platform
>>> drivers using this overlay. He also provided a branch containing
>>> some commits that helped  
>>
>> I need to go look at the various email threads mentioned above before
>> I continue reading this patch series.
>>
>> I do have serious concerns with this approach.  I need to investigate
>> more fully before I can determine whether the concerns are addressed
>> sufficiently.
>>
>> To give some background to my longstanding response to similar
>> proposals, here is my old statement from
>> https://elinux.org/Device_Tree_Reference:
>>
>>    Overlays
>>    Mainline Linux Support
>>    Run time overlay apply and run time overlay remove from user space
>> are not supported in the mainline kernel. There   are out of tree
>> patches to implement this feature via an overlay manager. The overlay
>> manager is used successfully by many users for specific overlays on
>> specific boards with specific environments and use cases. However,
>> there are many issues with the Linux kernel overlay implementation
>> due to incomplete and incorrect code. The overlay manager has not
>> been accepted in mainline due to these issues. Once these issues are
>> resolved, it is expected that some method of run time overlay apply
>> and overlay removal from user space will be supported by the Linux
>> kernel.
>>
>>    There is a possibility that overlay apply and overlay remove
>> support could be phased in slowly, feature by feature, as specific
>> issues are resolved.
> 
> Hi Frank,
> 
> This work uses the kernel space interface (of_overlay_fdt_apply())
> and the device tree overlay is builtin the driver. This interface was
> used until recently by rcu-dcar driver. While the only user (sic),
> this seems to work pretty well and I was able to use it successfully.

Yes, of_overlay_fdt_apply() was used by one driver.  But that driver
was explicitly recognized as a grandfathered exception, and not an
example for other users.  It was finally removed in 5.18-rc1.

You may have used of_overlay_fdt_apply() in a specific use case at
a specific kernel version, but if you read through the references
I provided you will find that applying overlays after the kernel
boots is a fragile endeavor, with expectations of bugs and problems
being exposed as usage is changed (simple example is that my adding
some overlay notifier unittests exposed yet another memory leak).

The reference that I provided also shows how the overlay code is
being improved over time.  Even with improvements, it will remain
fragile.

> 
> Moreover, this support targets at using this with PCI devices. This
> devices are really well contained and do not interfere with other
> devices. This actually consists in adding a complete subtree into the
> existing device-tree and thus it limits the interactions between
> potentially platform provided devices and PCI ones.

Yes, that it is very important that you have described this fact, both
here and in other emails.  Thank you for that information, it does help
understanding the alternatives.

I've hesitated in recommending a specific solution before better
understanding the architecture of your pcie board and drivers, but
I've delayed too long, so I am going to go ahead and mention one
possibility at the risk of not yet fully understanding the situation.

On the surface, it appears that your need might be well met by having
a base devicetree that describes all of the pcie nodes, but with each
node having a status of "disabled" so that they will not be used.
Have a devicetree overlay describing the pcie card (as you proposed),
where the overlay also includes a status of "ok" for the pcie node.
Applying the overlay, with a method of redirecting the target to a
specific pcie node would change the status of the pcie node to enable
its use.  (You have already proposed a patch to modify of_overlay_fdt_apply()
to allow a modified target, so not a new concept from me.)  My suggestion
is to apply the overlay devicetree to the base devicetree before the
combined FDT devicetree is passed to the kernel at boot.  The overlay
apply could be done by several different entities.  It could be before
the bootloader executes, it could be done by the bootloader, it could
be done by a shim between the bootloader and the kernel.  This method
avoids all of the issues of applying an overlay to a running system
that I find problematic.  It is also a method used by the U-boot
bootloader, as an example.

The other big issue is mixing ACPI and devicetree on a single system.
Historically, the Linux devicetree community has not been receptive
to the ides of that mixture.  Your example might be a specific case
where the two can be isolated from each other, or maybe not.  (For
disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
ACPI and devicetree is a recipe for disaster in the general case.

More to come later as I finish reading through the various threads.

-Frank

> 
> Clément
> 
>>
>> Those are my words, not Rob's, but I thought that Rob was somewhat in
>> agreement with those ideas.  Apparently either I misunderstood his
>> thoughts, or his thoughts have evolved, since you say that he
>> suggested overlays in one of the above email threads, and you list
>> him as a co-developer.
>>
>> In the next line of the elinux info above, I provide a link to more
>> detailed information:
>>
>>    Frank's thoughts on what is needed to complete basic overlay
>> support
>>
>> The link goes to:
>>
>>    https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
>>
>> That page provides an incomplete list of issues to be resolved, and
>> a list of "what has been completed".
>>
>> Please read through the elinux.org page to understand the basis of
>> my concerns.
>>
>> If after reading through the related email threads, and this thread,
>> I agree that overlays are a good approach, I am already aware of areas
>> that I will have specific comments about on the patches in this
>> thread.
>>
>> -Frank
>>
>>> to implement this idea on a x86 setup. Due to the dynamic nature of
>>> PCI bus enumeration, some other modifications needs to be applied
>>> on the overlay to apply it correctly. Indeed, it is necessary to
>>> modify the target node of the fragments to apply them correctly on
>>> the PCI device that was probed. Moreover, the 'ranges' must be set
>>> according to the BAR addresses in order to remap devices to the
>>> correct PCI addresses. These modifications are the located into the
>>> driver since the remapping is something that is specific to each
>>> driver.
>>>
>>> After modifications, this proves to be successful and a full
>>> support of the aforementioned lan966x PCI card was added. The
>>> modifications to support that (apply an overlay on a dynamically
>>> created PCI of_node) are actually minimal and only touches a few
>>> places (pci/of.c). This series contains the 3 commits that are
>>> necessary to do that:
>>>
>>> - First commit creates the root node if not present on a x86 setup
>>>   without a firmware provided device-tree.
>>> - Second one dynamically creates the PCI bus/device device-tree node
>>>   hierarchy using changeset API.
>>> - Finally a last commit allows to apply an overlay by targeting a
>>>   specific device-tree node.
>>>
>>> Other problems that might be considered with this series is the fact
>>> that CONFIG_OF is not enabled by default on x86 configuration and
>>> thus the driver can't be used without rebuilding a complete kernel
>>> with CONFIG_OF=y. In order to fully support this PCIe card and
>>> allow lambda user to use this driver, it would be almost mandatory
>>> to enable CONFIG_OF by default on such setup.
>>>
>>> A driver using this support was added and can be seen at [3]. This
>>> driver embeds a builtin overlay and applies it to the live tree
>>> using of_overlay_fdt_apply_to_node(). An interrupt driver is also
>>> included and associated to a node that is added by the overlay. The
>>> driver also insert a specific "ranges" property based on the BAR
>>> values which allows to remap the device-tree node to BAR addresses
>>> dynamically. This is needed to allow applying the overlay without
>>> depending on specific enumeration BAR addresses.
>>>
>>> This series was tested on a x86 kernel using CONFIG_OF under a
>>> virtual machine using PCI passthrough.
>>>
>>> Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>>> Link: [2]
>>> https://lore.kernel.org/lkml/20220408174841.34458529@fixe.home/T/
>>> Link: [3]
>>> https://github.com/clementleger/linux/tree/lan966x/of_support
>>>
>>> Clément Léger (3):
>>>   of: always populate a root node
>>>   PCI: of: create DT nodes for PCI devices if they do not exists
>>>   of: overlay: add of_overlay_fdt_apply_to_node()
>>>
>>>  drivers/of/base.c    |  16 +++-
>>>  drivers/of/overlay.c |  21 +++--
>>>  drivers/pci/of.c     | 184
>>> +++++++++++++++++++++++++++++++++++++++++++ include/linux/of.h   |
>>> 17 +++- 4 files changed, 224 insertions(+), 14 deletions(-)
>>>   
>>
> 


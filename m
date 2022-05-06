Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C651DF27
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 20:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiEFShJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFShI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 14:37:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1F6D4E2;
        Fri,  6 May 2022 11:33:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i22so5335042ila.1;
        Fri, 06 May 2022 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RForlUT1tka3D1tuSnbrKPYqMy4ZhSvtUp48zMmLj58=;
        b=g+I9Ev0qq3OCzb5zVk0ITAEmdVkonfpXJaP/Rh19izrDXm0eqe4yaLAzf9j9aMtnQV
         ZeWfO6UmufVSeBPHFTa/s8zKynaGmJtkHAc1nLPR2qJnbQgT7oKe3hDOpJVR29f8vn3J
         9ypqN46Rik4XTGtabXFDVJK4bE8dFv01Nojlv2RxmDOWdhKTZYqZ5NFEn6tZhrlqprxs
         y4U3FB9/oZWhnTZktchYo3ZeHE6ESh6fURHOd+Tf/EnSQxxTG5+zoCkFho2W+4FQHusk
         +zY7BbPjg7K+a+hd8qyfoyeDogQshu0n9KSwyOKrs/Uv1Af20pnZ5iTjiZN3uVVKbKvc
         5vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RForlUT1tka3D1tuSnbrKPYqMy4ZhSvtUp48zMmLj58=;
        b=6gGkkStqGOWWCo5UMpZPE1zo/5M/HZp6hYoyG3PxxRXAVh67DB7tNxRdQJaPoDAbyN
         02NST8FGM6tcLlHIJxUy8XSiQGGt81YUohl7X+kRO9PIeqjemxQG6KG/vzbnYr7UbgW6
         eE9MSbtc/NpBjMEbwPI9ddw/f1rIpTToNNYFcOYkRirzILtV7jXGUVwKJHQ+SPxFLZh9
         DegoxUm2tv0Qk6eZwk1GvHZ4IB8LXqUnLmOiZ9oeYudWYgqhqS7K6lz12Tv6GXijy+Rm
         Fd8z1LRCJlrXH6zwNlxP7xmWcL0B5nIVhPhR3WNYdRVxQog3YrjedvFxDx0ODAFKFzdf
         AGXw==
X-Gm-Message-State: AOAM533IjwnyB+InZ0+AfTikJg5/ym/E7dGBnc+L1bQZSZ+qv6wqMjgU
        6Ha5nIcJnSga3B5NToTZh0A=
X-Google-Smtp-Source: ABdhPJw72pNhl353Pc98O3yyv12NQwEJD4pCTyRpIjclc3mrGl8JfUF//uk6t6DiiIsz4oa0ucSOqw==
X-Received: by 2002:a05:6e02:15c8:b0:2bd:fdca:18a8 with SMTP id q8-20020a056e0215c800b002bdfdca18a8mr1840552ilu.320.1651862003987;
        Fri, 06 May 2022 11:33:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:cc95:9825:1cd:66f2? ([2600:1700:2442:6db0:cc95:9825:1cd:66f2])
        by smtp.gmail.com with ESMTPSA id a12-20020a02ac0c000000b0032b3a7817desm1501572jao.162.2022.05.06.11.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 11:33:23 -0700 (PDT)
Message-ID: <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
Date:   Fri, 6 May 2022 13:33:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Allan Nielsen <allan.nielsen@microchip.com>,
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220427094502.456111-1-clement.leger@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/27/22 04:44, Clément Léger wrote:
> This series adds foundation work to support the lan9662 PCIe card. This
> card is meant to be used an ethernet switch with 2 x RJ45 ports and
> 2 x 2.5G SFPs. The lan966x SoCs can be used in two different ways:
> 
>  - It can run Linux by itself, on ARM64 cores included in the SoC. This
>    use-case of the lan966x is currently being upstreamed, using a
>    traditional Device Tree representation of the lan996x HW blocks [1]
>    A number of drivers for the different IPs of the SoC have already
>    been merged in upstream Linux.
> 
>  - It can be used as a PCIe endpoint, connected to a separate platform
>    that acts as the PCIe root complex. In this case, all the devices
>    that are embedded on this SoC are exposed through PCIe BARs and the
>    ARM64 cores of the SoC are not used. Since this is a PCIe card, it
>    can be plugged on any platform, of any architecture supporting PCIe.
> 
> The problem that arose is that we want to reuse all the existing OF
> compatible drivers that are used when in SoC mode to instantiate the
> PCI device when in PCIe endpoint mode.
> 
> A previous attempt to tackle this problem was made using fwnode [1].
> However, this proved being way too invasive and it required
> modifications in both subsystems and drivers to support fwnode. First
> series did not lead to a consensus and multiple ideas to support this
> use-case were mentioned (ACPI overlay, fwnode, device-tree overlay).
> Since it only seemed that fwnode was not a totally silly idea, we
> continued on this way.
> 
> However, on the series that added fwnode support to the reset subsystem,
> Rob Herring mentioned the fact that OF overlay might actually be the
> best way to probe PCI devices and populate platform drivers using this
> overlay. He also provided a branch containing some commits that helped

I need to go look at the various email threads mentioned above before I
continue reading this patch series.

I do have serious concerns with this approach.  I need to investigate
more fully before I can determine whether the concerns are addressed
sufficiently.

To give some background to my longstanding response to similar proposals,
here is my old statement from https://elinux.org/Device_Tree_Reference:

   Overlays
   Mainline Linux Support
   Run time overlay apply and run time overlay remove from user space are
   not supported in the mainline kernel. There   are out of tree patches
   to implement this feature via an overlay manager. The overlay manager
   is used successfully by many users for specific overlays on specific
   boards with specific environments and use cases. However, there are many
   issues with the Linux kernel overlay implementation due to incomplete and
   incorrect code. The overlay manager has not been accepted in mainline due
   to these issues. Once these issues are resolved, it is expected that some
   method of run time overlay apply and overlay removal from user space will
   be supported by the Linux kernel.

   There is a possibility that overlay apply and overlay remove support could
   be phased in slowly, feature by feature, as specific issues are resolved.

Those are my words, not Rob's, but I thought that Rob was somewhat in
agreement with those ideas.  Apparently either I misunderstood his
thoughts, or his thoughts have evolved, since you say that he suggested
overlays in one of the above email threads, and you list him as a
co-developer.

In the next line of the elinux info above, I provide a link to more
detailed information:

   Frank's thoughts on what is needed to complete basic overlay support

The link goes to:

   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts

That page provides an incomplete list of issues to be resolved, and
a list of "what has been completed".

Please read through the elinux.org page to understand the basis of
my concerns.

If after reading through the related email threads, and this thread,
I agree that overlays are a good approach, I am already aware of areas
that I will have specific comments about on the patches in this thread.

-Frank

> to implement this idea on a x86 setup. Due to the dynamic nature of PCI
> bus enumeration, some other modifications needs to be applied on the
> overlay to apply it correctly. Indeed, it is necessary to modify the
> target node of the fragments to apply them correctly on the PCI device
> that was probed. Moreover, the 'ranges' must be set according to the
> BAR addresses in order to remap devices to the correct PCI addresses.
> These modifications are the located into the driver since the remapping
> is something that is specific to each driver.
> 
> After modifications, this proves to be successful and a full support of
> the aforementioned lan966x PCI card was added. The modifications to
> support that (apply an overlay on a dynamically created PCI of_node) are
> actually minimal and only touches a few places (pci/of.c). This series
> contains the 3 commits that are necessary to do that:
> 
> - First commit creates the root node if not present on a x86 setup
>   without a firmware provided device-tree.
> - Second one dynamically creates the PCI bus/device device-tree node
>   hierarchy using changeset API.
> - Finally a last commit allows to apply an overlay by targeting a
>   specific device-tree node.
> 
> Other problems that might be considered with this series is the fact
> that CONFIG_OF is not enabled by default on x86 configuration and thus
> the driver can't be used without rebuilding a complete kernel with
> CONFIG_OF=y. In order to fully support this PCIe card and allow lambda
> user to use this driver, it would be almost mandatory to enable
> CONFIG_OF by default on such setup.
> 
> A driver using this support was added and can be seen at [3]. This
> driver embeds a builtin overlay and applies it to the live tree using
> of_overlay_fdt_apply_to_node(). An interrupt driver is also included and
> associated to a node that is added by the overlay. The driver also
> insert a specific "ranges" property based on the BAR values which allows
> to remap the device-tree node to BAR addresses dynamically. This is
> needed to allow applying the overlay without depending on specific
> enumeration BAR addresses.
> 
> This series was tested on a x86 kernel using CONFIG_OF under a virtual
> machine using PCI passthrough.
> 
> Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
> Link: [2] https://lore.kernel.org/lkml/20220408174841.34458529@fixe.home/T/
> Link: [3] https://github.com/clementleger/linux/tree/lan966x/of_support
> 
> Clément Léger (3):
>   of: always populate a root node
>   PCI: of: create DT nodes for PCI devices if they do not exists
>   of: overlay: add of_overlay_fdt_apply_to_node()
> 
>  drivers/of/base.c    |  16 +++-
>  drivers/of/overlay.c |  21 +++--
>  drivers/pci/of.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  17 +++-
>  4 files changed, 224 insertions(+), 14 deletions(-)
> 


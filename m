Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3B5F1D8B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Oct 2022 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAQU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJAQU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 12:20:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7D5F7FA;
        Sat,  1 Oct 2022 09:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2CF7B8070E;
        Sat,  1 Oct 2022 16:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F68C433C1;
        Sat,  1 Oct 2022 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664641252;
        bh=KwEoTl5fcKuoT6KMC2tDFJudsaVilKVIE03GfAP/4jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6VAqRtQuxYKrmskfCBaYe3wScPuRfj1jlqUVwOxQYMLHdMdziQxyQipdVTUcYBTl
         BADX/ndmBGrq35J+/D1RjF1hRBTW+UC8EPA0guM/JYrwrwlpBUpTJjayFXPY+VL1nI
         JE1v1U5rsU+uWcZKpmvSd6Dd2NLk+zRw+pGNk5QzKKEdgXNHz9wWkwWnxOGuwRMoOV
         NQbKojkMaP7WNWN1rdGEhQxa42sF11LoGdg75ba6uHmrGYBqPbQjuVAl9BuT87D3XS
         z0m+XZx0H+t3TIte7v/Pv3HTNixeh8D4+T610IH0rjCryKIhqY1AVfSg3mFAegwQxm
         PZ/Z52sH/ZcAA==
Received: by pali.im (Postfix)
        id 40BCBA15; Sat,  1 Oct 2022 18:20:49 +0200 (CEST)
Date:   Sat, 1 Oct 2022 18:20:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221001162049.ln2qheyyb5muifi7@pali>
References: <20220930192747.21471-1-vidyas@nvidia.com>
 <20221001160025.GB9324@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001160025.GB9324@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 01 October 2022 18:00:25 Lukas Wunner wrote:
> Adding Marek, Pali & Jon to cc as they've worked on somewhat similar
> functionality:
> 
> https://lore.kernel.org/linux-pci/20220927141926.8895-1-kabel@kernel.org/
> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
> 
> On Sat, Oct 01, 2022 at 12:57:43AM +0530, Vidya Sagar wrote:
> > To support the Hot-plug feature, PCIe spec has a well-defined model for 
> > hardware implementation and software programming interface. There are also
> > some architectures/platforms where the Hot-plug feature is implemented in a
> > non-standard way and software support for the respective implementations is
> > available with the kernel. This patch series attempts to add support for one
> > such non-standard way of supporting the Hot-plug feature where a single GPIO
> > is used to detect and report the Hot-Plug and Unplug events to the SW.
> > The platforms that can use this piece of software need to have GPIO routed
> > from the slot to the controller which can indicate the presence/absence of
> > the downstream device through its state. This GPIO should also have the
> > capability to interrupt the system when the connection/disconnection event
> > takes place.
> > A GPIO Hot-plug framework is written which looks for a "hotplug-gpios" named
> > GPIO entry in the corresponding device-tree entry of the controller and
> > registers a hot-pluggable slot with the Hot-plug framework.
> > The platform drivers of the PCIe host bridges/root ports can register with the
> > aforementioned GPIO Hot-Plug framework along with ops to perform any platform
> > specific tasks during Hot-Plug/Unplug events.
> > 
> > Oza Pawandeep made an attempt to upstream support for a similar Hot-plug
> > feature implementation at a platform level, but the implementation as such
> > was very specific to that platform (at least the way I understood it).
> > https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-2-git-send-email-oza.oza@broadcom.com/
> > https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-3-git-send-email-oza.oza@broadcom.com/
> > https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-4-git-send-email-oza.oza@broadcom.com/
> > This current series also attempts to address that by extracting out all the
> > common code to do with GPIO and Hot-plug core framework and expecting the
> > platform drivers to only register/unregister with the GPIO framework. So,
> > @Oza, could you try using the GPIO framework from this series and enable
> > Hot-plug support for your platform if it still makes sense?

Hello!

Would not it better to rather synthesise PCIe Slot Capabilities support
in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
existing PCI hotplug code to take care for hotplugging? Because it
already implements all required stuff for re-scanning, registering and
unregistering PCIe devices for Root Ports with Slot Capabilities. And I
think that there is no need to have just another (GPIO based)
implementation of PCI hotplug.

Similar thing Marek and me have implemented for PCIe link state events
in patch series with Lukas pointed.

> > @Rob,
> > Regarding the DT documentation change to add about 'hotplug-gpios, I'm not
> > sure if pci.txt is the right place or the dt-schema repository
> > i.e https://github.com/devicetree-org/dt-schema
> > But, in the interest of keeping all the changes related to this feature in the
> > the same repository, I made the changes to the pci.txt file in this repo itself.
> > Please let me know if the documentation change needs to be moved to the other
> > repo.
> > 
> > The Changes have been tested on the Tegra234 platform.
> > 
> > Vidya Sagar (4):
> >   dt-bindings: Add "hotplug-gpios" PCIe property
> >   PCI/hotplug: Add GPIO PCIe hotplug driver
> >   PCI: tegra194: Add support to configure a pluggable slot
> >   PCI: tegra194: Enable GPIO based Hot-Plug support
> > 
> >  Documentation/devicetree/bindings/pci/pci.txt |   4 +
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  85 +++++++-
> >  drivers/pci/hotplug/Kconfig                   |  11 +
> >  drivers/pci/hotplug/Makefile                  |   1 +
> >  drivers/pci/hotplug/gpio_php.c                | 200 ++++++++++++++++++
> >  drivers/pci/hotplug/gpiophp.h                 |  40 ++++
> >  6 files changed, 334 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/pci/hotplug/gpio_php.c
> >  create mode 100644 drivers/pci/hotplug/gpiophp.h
> > 
> > -- 
> > 2.17.1
> > 

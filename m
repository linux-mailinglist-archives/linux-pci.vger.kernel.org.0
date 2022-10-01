Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734415F1D6B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Oct 2022 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJAQAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJAQAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 12:00:30 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6ED6CF67;
        Sat,  1 Oct 2022 09:00:27 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E929100DCEEB;
        Sat,  1 Oct 2022 18:00:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4E5BC3123; Sat,  1 Oct 2022 18:00:25 +0200 (CEST)
Date:   Sat, 1 Oct 2022 18:00:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        jszhang@kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221001160025.GB9324@wunner.de>
References: <20220930192747.21471-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding Marek, Pali & Jon to cc as they've worked on somewhat similar
functionality:

https://lore.kernel.org/linux-pci/20220927141926.8895-1-kabel@kernel.org/
https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/

On Sat, Oct 01, 2022 at 12:57:43AM +0530, Vidya Sagar wrote:
> To support the Hot-plug feature, PCIe spec has a well-defined model for 
> hardware implementation and software programming interface. There are also
> some architectures/platforms where the Hot-plug feature is implemented in a
> non-standard way and software support for the respective implementations is
> available with the kernel. This patch series attempts to add support for one
> such non-standard way of supporting the Hot-plug feature where a single GPIO
> is used to detect and report the Hot-Plug and Unplug events to the SW.
> The platforms that can use this piece of software need to have GPIO routed
> from the slot to the controller which can indicate the presence/absence of
> the downstream device through its state. This GPIO should also have the
> capability to interrupt the system when the connection/disconnection event
> takes place.
> A GPIO Hot-plug framework is written which looks for a "hotplug-gpios" named
> GPIO entry in the corresponding device-tree entry of the controller and
> registers a hot-pluggable slot with the Hot-plug framework.
> The platform drivers of the PCIe host bridges/root ports can register with the
> aforementioned GPIO Hot-Plug framework along with ops to perform any platform
> specific tasks during Hot-Plug/Unplug events.
> 
> Oza Pawandeep made an attempt to upstream support for a similar Hot-plug
> feature implementation at a platform level, but the implementation as such
> was very specific to that platform (at least the way I understood it).
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-2-git-send-email-oza.oza@broadcom.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-3-git-send-email-oza.oza@broadcom.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-4-git-send-email-oza.oza@broadcom.com/
> This current series also attempts to address that by extracting out all the
> common code to do with GPIO and Hot-plug core framework and expecting the
> platform drivers to only register/unregister with the GPIO framework. So,
> @Oza, could you try using the GPIO framework from this series and enable
> Hot-plug support for your platform if it still makes sense?
> 
> @Rob,
> Regarding the DT documentation change to add about 'hotplug-gpios, I'm not
> sure if pci.txt is the right place or the dt-schema repository
> i.e https://github.com/devicetree-org/dt-schema
> But, in the interest of keeping all the changes related to this feature in the
> the same repository, I made the changes to the pci.txt file in this repo itself.
> Please let me know if the documentation change needs to be moved to the other
> repo.
> 
> The Changes have been tested on the Tegra234 platform.
> 
> Vidya Sagar (4):
>   dt-bindings: Add "hotplug-gpios" PCIe property
>   PCI/hotplug: Add GPIO PCIe hotplug driver
>   PCI: tegra194: Add support to configure a pluggable slot
>   PCI: tegra194: Enable GPIO based Hot-Plug support
> 
>  Documentation/devicetree/bindings/pci/pci.txt |   4 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  85 +++++++-
>  drivers/pci/hotplug/Kconfig                   |  11 +
>  drivers/pci/hotplug/Makefile                  |   1 +
>  drivers/pci/hotplug/gpio_php.c                | 200 ++++++++++++++++++
>  drivers/pci/hotplug/gpiophp.h                 |  40 ++++
>  6 files changed, 334 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/pci/hotplug/gpio_php.c
>  create mode 100644 drivers/pci/hotplug/gpiophp.h
> 
> -- 
> 2.17.1
> 

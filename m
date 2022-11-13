Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2B626E87
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 09:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKMIf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 03:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 03:35:59 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B1FCCC
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 00:35:57 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 16378100DCEC8;
        Sun, 13 Nov 2022 09:35:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD6461FDA6; Sun, 13 Nov 2022 09:35:55 +0100 (CET)
Date:   Sun, 13 Nov 2022 09:35:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Albert Zhou <albert.zhou.50@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pci: hotplug: add info to Kconfig
Message-ID: <20221113083555.GA26593@wunner.de>
References: <20221113075525.2557-1-albert.zhou.50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113075525.2557-1-albert.zhou.50@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Mika]

On Sun, Nov 13, 2022 at 06:55:25PM +1100, Albert Zhou wrote:
> Add informative comment that Thunderbolt requires PCI Hotplug.
> ---
>  drivers/pci/hotplug/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 840a84bb5ee2..a6dccb958254 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -9,7 +9,7 @@ menuconfig HOTPLUG_PCI
>  	help
>  	  Say Y here if you have a motherboard with a PCI Hotplug controller.
>  	  This allows you to add and remove PCI cards while the machine is
> -	  powered up and running.
> +	  powered up and running. Thunderbolt requires PCI Hotplug.
>  
>  	  When in doubt, say N.

You probably want to add a "default y if USB4" line to the config entries
of HOTPLUG_PCI, HOTPLUG_PCI_PCIE and PCIEPORTBUS in addition to
documenting the dependency.

Thanks,

Lukas

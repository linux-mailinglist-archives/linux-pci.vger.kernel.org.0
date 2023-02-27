Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764F6A3B62
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 07:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjB0Gvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 01:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Gve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 01:51:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8839199C1;
        Sun, 26 Feb 2023 22:51:32 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id nv15so3812788qvb.7;
        Sun, 26 Feb 2023 22:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9PqkTbJaR86+QlcX21Wyd3bjpVVjfCGk3M4h3+4pBI=;
        b=a8Wqgs1ARiiBpDLloMPmNL03xLIYEsr+6kL7+pbPCNVAdz1E2GGdoO1m/RpGomrHbu
         g6cTHbVPv2ofyfn3GTZqWIPTSH680jQxwi2nVxEmPDJ6aDMjFIevGsrIw8kFXmw0IULE
         Fre1vRLYbckTD4H44jwyzAArcB89pbB4/MnMy8v9Ku84aLU8b2lMh8ZLJ6wDYMN6nMNP
         q+YHC0BPR/m42ZyJQUYmzc1zBoLY4BTGTCrZXITUdxDHap5enwrjDwtd/xKdKe9qPK4U
         kmwRru4VanzzV3jpb3XfbEjV4HbyMJHxG+7qV+AIdL7fhYFGhYYVoLbe8XVV45bZenyo
         r47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9PqkTbJaR86+QlcX21Wyd3bjpVVjfCGk3M4h3+4pBI=;
        b=DCF8jiUypOUbBnh8oEKxrtnMPKglLpeTtKsoAEo+kuHb6KtKOlVTBG48utsB4oiaae
         R+GLoCzQOaPL48/MFIslA6WF/V7OhEqix5ss9BDz8B7KL102SqgMkZCrWuhTYXRxGlqr
         05XDIwPB0v8+nS0w22b1lnPWkb/oH0VNJV6s0tp7Z6cPyIY08nDZ/x2nmuyUqg9hrE53
         k+muE8dkQ3Y+6gqdCeIDO9F45O6TD7NVWIqVJdyfI1izMLbfLOUbwXBLGlmySgHAEViP
         +OXhzUazsBm5RW70ePxwJ+F6xF6Gvdw7GX9ZcXHWbwRz6c3Xi3ARwf0dBh6Jth3bfTdw
         GXsg==
X-Gm-Message-State: AO0yUKWAyPKBDaiRwJW+49u10cTk5IReuhh3ZFa2qi27Vq0ioWT6vnaq
        9HydEtf6WfeoEVwkFXJsm5k=
X-Google-Smtp-Source: AK7set+pafXleWx2C7srXpVxsdHlo3G8CEbLurP102ktjIm0oy14tIF2XKYYJRN9EQNkEPe0/t77ZQ==
X-Received: by 2002:a05:6214:528d:b0:537:727f:ac28 with SMTP id kj13-20020a056214528d00b00537727fac28mr43231738qvb.27.1677480691249;
        Sun, 26 Feb 2023 22:51:31 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:319d:ae28:d693:d868? ([2600:1700:2442:6db0:319d:ae28:d693:d868])
        by smtp.gmail.com with ESMTPSA id bm28-20020a05620a199c00b007296805f607sm4421917qkb.17.2023.02.26.22.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 22:51:30 -0800 (PST)
Message-ID: <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
Date:   Mon, 27 Feb 2023 00:51:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/19/23 21:02, Lizhi Hou wrote:
> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. Second, it allows reuse of a OF
> compatible driver -- often used in SoC platforms -- in a PCI host based
> system.
> 
> There are 2 series devices rely on this patch:
> 
>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>   2) Microchip LAN9662 Ethernet Controller
> 
>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> 


> Normally, the PCI core discovers PCI devices and their BARs using the
> PCI enumeration process. However, the process does not provide a way to
> discover the hardware peripherals that are present in a PCI device, and
> which can be accessed through the PCI BARs. Also, the enumeration process

I'm confused.  The PCI Configuration Header Registers should describe the
hardware on the PCI card.

Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
themselves, so I would like to analyze that case separately), does the
second device, "Microchip LAN9662 Ethernet Controller" properly implement
the PCI Configuration Header Registers?  What additional information is
needed that is not provided in those registers?

-Frank

> does not provide a way to associate MSI-X vectors of a PCI device with the
> hardware peripherals that are present in the device. PCI device drivers
> often use header files to describe the hardware peripherals and their
> resources as there is no standard data driven way to do so. This patch
> series proposes to use flattened device tree blob to describe the
> peripherals in a data driven way. Based on previous discussion, using
> device tree overlay is the best way to unflatten the blob and populate
> platform devices. To use device tree overlay, there are three obvious
> problems that need to be resolved.
> 
> First, we need to create a base tree for non-DT system such as x86_64. A
> patch series has been submitted for this:
> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
> 
> Second, a device tree node corresponding to the PCI endpoint is required
> for overlaying the flattened device tree blob for that PCI endpoint.
> Because PCI is a self-discoverable bus, a device tree node is usually not
> created for PCI devices. This series adds support to generate a device
> tree node for a PCI device which advertises itself using PCI quirks
> infrastructure.
> 
> Third, we need to generate device tree nodes for PCI bridges since a child
> PCI endpoint may choose to have a device tree node created.
> 
> This patch series is made up of three patches.
> 
> The first patch is adding OF interface to create or destroy OF node
> dynamically.
> 
> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
> When the option is turned on, the kernel will generate device tree nodes
> for all PCI bridges unconditionally. The patch also shows how to use the
> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
> tree node for a device. Specifically, the patch generates a device tree
> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
> tree nodes do not have any property.
> 
> The third patch adds basic properties ('reg', 'compatible' and
> 'device_type') to the dynamically generated device tree nodes. More
> properties can be added in the future.
> 
> Here is the example of device tree nodes generated within the ARM64 QEMU.
> # lspci -t    
> -[0000:00]-+-00.0
>            +-01.0-[01]--
>            +-01.1-[02]----00.0
>            +-01.2-[03]----00.0
>            +-01.3-[04]----00.0
>            +-01.4-[05]----00.0
>            +-01.5-[06]--
>            +-01.6-[07]--
>            +-01.7-[08]--
>            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>            |                                            \-00.1
>            +-02.1-[0c]--
>            \-03.0-[0d-0e]----00.0-[0e]----01.0
> 
> # tree /sys/firmware/devicetree/base/pcie\@10000000
> /sys/firmware/devicetree/base/pcie@10000000
> |-- #address-cells
> |-- #interrupt-cells
> |-- #size-cells
> |-- bus-range
> |-- compatible
> |-- device_type
> |-- dma-coherent
> |-- interrupt-map
> |-- interrupt-map-mask
> |-- linux,pci-domain
> |-- msi-parent
> |-- name
> |-- pci@1,0
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,1
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,2
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,3
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,4
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,5
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,6
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@1,7
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@2,0
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #size-cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- pci@0,0
> |   |   |   |-- #address-cells
> |   |   |   |-- #size-cells
> |   |   |   |-- compatible
> |   |   |   |-- dev@0,0
> |   |   |   |   |-- compatible
> |   |   |   |   `-- reg
> |   |   |   |-- dev@0,1
> |   |   |   |   |-- compatible
> |   |   |   |   `-- reg
> |   |   |   |-- device_type
> |   |   |   |-- ranges
> |   |   |   `-- reg
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- pci@2,1
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@3,0
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #size-cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- ranges
> `-- reg
> 
> Changes since v6:
> - Removed single line wrapper functions
> - Added Signed-off-by Clément Léger <clement.leger@bootlin.com>
> 
> Changes since v5:
> - Fixed code review comments
> - Fixed incorrect 'ranges' and 'reg' properties and verified address
>   translation.
> 
> Changes since RFC v4:
> - Fixed code review comments
> 
> Changes since RFC v3:
> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
> - Minor changes in commit description and code comment
> 
> Changes since RFC v2:
> - Merged patch 3 with patch 2
> - Added OF interfaces of_changeset_add_prop_* and use them to create
>   properties.
> - Added '#address-cells', '#size-cells' and 'ranges' properties.
> 
> Changes since RFC v1:
> - Added one patch to create basic properties.
> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>   with of_create_node()/of_destroy_node()
> 
> Lizhi Hou (3):
>   of: dynamic: Add interfaces for creating device node dynamically
>   PCI: Create device tree node for selected devices
>   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
> 
>  drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
>  drivers/pci/Kconfig         |  12 ++
>  drivers/pci/Makefile        |   1 +
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            |  71 ++++++++++++
>  drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  19 ++++
>  drivers/pci/quirks.c        |  11 ++
>  drivers/pci/remove.c        |   1 +
>  include/linux/of.h          |  24 ++++
>  12 files changed, 556 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/of_property.c
> 


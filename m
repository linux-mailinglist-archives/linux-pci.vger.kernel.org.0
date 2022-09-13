Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7734E5B684A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIMHAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMHAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:00:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D21570E;
        Tue, 13 Sep 2022 00:00:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d17so6949509qko.13;
        Tue, 13 Sep 2022 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=765RBTHIVr4lJSrq7MpOeNT5T0qDbvjzGqtnHA+6dLY=;
        b=lHn+kun5vFNZw9lq6iAmd/tF3UYyk0BPvoJGd++0yRRXBQubtztslYNyBRyjUH+z9P
         rdMhmtzGLrk8qtdy76Ibz47Ps08MbIGchkkGDRJq6h6AZVBCEBJU4+678i93fsotfq5E
         f3uZ2KDFEb04aqLpbqyHBGProH8GcgH/F9SiLgQvcvSuXhcTnPhFHpDHTVjips8ph3+n
         NPxHmjWn4pPlbwwVCh45iPmnu4NOybLDNxEAYiVee4dQkcfoflISKmOjX9MUlXKOUBMs
         3l8RRdfbT8Wmffk4/H/+0fRSBbVx+lJnLZElQAmgDv00uJCqMSTo3llQc2xzv9o9ANQC
         3MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=765RBTHIVr4lJSrq7MpOeNT5T0qDbvjzGqtnHA+6dLY=;
        b=7pvKW8UjW4AWRBTCGTgDLoPre9K9O8SKR3QTROENamPGPFoL3ZojuzZDe3IHvbOGUQ
         3K4eYVQdmH0IQafabB4DBd1wtWIeJb1TzsMCKu/p5aGx+VFtC6v0CQ9hwQHBBtQKAOjn
         /NEMwAS8Iuk1S7JKYHoHLoNW+DpP0aWNX0/NndjFvjW5m1CZwXwWCUro1t6zrlm+RoFr
         rwdh0IE0Hh58MEftTRY3JGlG/1FYWT8IYJ6PxhM9W4kIz0h3FWB3/kdbFv3aQmA+pXnX
         k3jQFiFfcEQAHIQZJF5J5WaaO5sSk2u0xu3BlOuuBiLusJmtxsZ1g0ZP06L04Dv1Sm9r
         4nkQ==
X-Gm-Message-State: ACgBeo2oP8zXq9Y7AG0IQPkZDl01NQJftc3/DNBaQxAajDKZMWYUYlGp
        xFgfkala8A4l33yeF2smp8M=
X-Google-Smtp-Source: AA6agR6fDy9UM3qotb//TTX9Rq1I9o//vFtLnFlcAXErWRbzqoB6rMtz152VgrlNA/URkng98Cui9Q==
X-Received: by 2002:a37:758:0:b0:6cb:c6e0:f17a with SMTP id 85-20020a370758000000b006cbc6e0f17amr16968540qkh.679.1663052449306;
        Tue, 13 Sep 2022 00:00:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:216d:1a77:16d6:2f68? ([2600:1700:2442:6db0:216d:1a77:16d6:2f68])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006ce622e6c96sm1045426qkp.30.2022.09.13.00.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 00:00:48 -0700 (PDT)
Message-ID: <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
Date:   Tue, 13 Sep 2022 02:00:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/29/22 16:43, Lizhi Hou wrote:
> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. An example device is Xilinx/AMD
> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
> driver -- often used in SoC platforms -- in a PCI host based system. An
> example device is Microchip LAN9662 Ethernet Controller.
> 
> This patch series consolidates previous efforts to define such an
> infrastructure:
> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> 
> Normally, the PCI core discovers PCI devices and their BARs using the
> PCI enumeration process. However, the process does not provide a way to
> discover the hardware peripherals that are present in a PCI device, and
> which can be accessed through the PCI BARs. Also, the enumeration process
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
> This patch series is made up of two patches.
> 
> The first patch is adding OF interface to allocate an OF node. It is copied
> from:
> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
> 
> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
> is turned on, the kernel will generate device tree nodes for all PCI
> bridges unconditionally. The patch also shows how to use the PCI quirks
> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
> a device. Specifically, the patch generates a device tree node for Xilinx
> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
> have any property. Future patches will add the necessary properties.
> 
> Clément Léger (1):
>   of: dynamic: add of_node_alloc()
> 
> Lizhi Hou (1):
>   pci: create device tree node for selected devices
> 
>  drivers/of/dynamic.c        |  50 +++++++++++++----
>  drivers/pci/Kconfig         |  11 ++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  16 ++++++
>  drivers/pci/quirks.c        |  11 ++++
>  drivers/pci/remove.c        |   1 +
>  include/linux/of.h          |   7 +++
>  10 files changed, 200 insertions(+), 13 deletions(-)
> 

The patch description leaves out the most important piece of information.

The device located at the PCI endpoint is implemented via FPGA
   - which is programmed after Linux boots (or somewhere late in the boot process)
      - (A) and thus can not be described by static data available pre-boot because
            it is dynamic (and the FPGA program will often change while the Linux
            kernel is already booted
      - (B) can be described by static data available pre-boot because the FPGA
            program will always be the same for this device on this system

I am not positive what part of what I wrote above is correct and would appreciate
some confirmation of what is correct or incorrect.

-Frank

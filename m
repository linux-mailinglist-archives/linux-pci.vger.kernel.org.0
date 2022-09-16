Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9665BB4B6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIPXPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPXPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 19:15:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95867EFCA;
        Fri, 16 Sep 2022 16:15:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c6so17763820qvn.6;
        Fri, 16 Sep 2022 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+bv5lr59/g1aPozwq5SSmg1kLWkBcrS80IisdYpq8ds=;
        b=WbHEOiZiAG1GeZU84P3nUVJ87vS7kj2ncGiul4s+LkbfxX4BeZH1LsknTAioFVF7tF
         vJzQG99N6DuYi6mjdydEAL78XOzFiZekhypavFZgbBFGEzRN6zPPfCh+I2xGIgbOmh1J
         tybc4KXxIKvXaQwxq2JPsHhup3ZN2fC0k5hfKqychAG9Ghalq2D3WERCsyjxxHfLxwCZ
         6s7769LkbfQ5NglQU0dRuvNEsbYh95QIlV4MFw9+XzvfYZGK25s2gz8cxlTW5xLBqgs3
         ZOQMCoL2D1XBXmQSWVzT7C2EUYvZPaNzZVwNgDN169+j7R8VvQ7DZverJ0b/mEdgLNGP
         rkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+bv5lr59/g1aPozwq5SSmg1kLWkBcrS80IisdYpq8ds=;
        b=k61dQWrzKKJgI40Hi8DYkYTOuuORfF7dK80rvj3lRtuyeyEsWOceQAYb5fkNldOFpH
         T1wWtZFNVHg/1+JG6zYZi+8l8B8X9alYoFyeZ0cmw+q38D5fqQ5pZ204dgTPRbVWG+xK
         Ld2IEVC0Zplzxjw8BmeN/5fI3i2JNBIjRNujRZtVTVwDhRJ4LzOrarhhwjfozETO3mtR
         Fmxny0lAzVQXWDBRACBF3NRLVlC+RszfmN9weTsdW4Sd9JLFS9mwaQH3F2dRjgwpmF36
         dyg4n8qrVdJ8Qnr8NqqujCZYp2qj17g97XFalFEGdxTeEumZqiSyJ7YoRoDu5/e+MpCM
         Ux1g==
X-Gm-Message-State: ACrzQf39Atw8LnNtAINWliDcpvwdl96THwHWh4uVtB7imuXsfztUvYqf
        5xrtjQ9JgGS4THJkgJ5N/j4=
X-Google-Smtp-Source: AMsMyM4mj8y0FfOLKhpY+5s2482ObrhIYlObLAVkaag0S8ugH4uq5lLpx5TUxIwCCxZXYeGdERtG0w==
X-Received: by 2002:a05:6214:2385:b0:474:78de:f8dd with SMTP id fw5-20020a056214238500b0047478def8ddmr5950432qvb.66.1663370116062;
        Fri, 16 Sep 2022 16:15:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:90c9:b1c1:5c9e:9030? ([2600:1700:2442:6db0:90c9:b1c1:5c9e:9030])
        by smtp.gmail.com with ESMTPSA id p11-20020ac8460b000000b003435bb7fe9csm5907640qtn.78.2022.09.16.16.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 16:15:15 -0700 (PDT)
Message-ID: <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
Date:   Fri, 16 Sep 2022 18:15:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> resources as there is no standard data driven way to do so. This patch> series proposes to use flattened device tree blob to describe the
> peripherals in a data driven way.

> Based on previous discussion, using
> device tree overlay is the best way to unflatten the blob and populate
> platform devices.

I still do not agree with this statement.  The device tree overlay
implementation is very incomplete and should not be used until it
becomes more complete.  No need to debate this right now, but I don't want
to let this go unchallenged.

If there is no base system device tree on an ACPI based system, then I
am not convinced that a mixed ACPI / device tree implementation is
good architecture.  I might be more supportive of using a device tree
description of a PCI device in a detached device tree (not linked to
the system device tree, but instead freestanding).  Unfortunately the
device tree functions assume a single system devicetree, with no concept
of a freestanding tree (eg, if a NULL device tree node is provided to
a function or macro, it often defaults to the root of the system device
tree).  I need to go look at whether the flag OF_DETACHED handles this,
or if it could be leveraged to do so.

> To use device tree overlay, there are three obvious
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


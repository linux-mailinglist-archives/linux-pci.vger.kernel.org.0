Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EF6A34C3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Feb 2023 23:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBZWjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Feb 2023 17:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBZWjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Feb 2023 17:39:02 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC486B1;
        Sun, 26 Feb 2023 14:39:01 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bg11so3889286oib.5;
        Sun, 26 Feb 2023 14:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzpBwp3oShh8wVDIYVSkwUb32WyiTPO4uenKxBnQUrA=;
        b=A+J1nW0IPmauykGlF+vygA8nAyR9IwhAHFNuoA/AJ5Rn5npaREFBktMdPOzoP7Tuk9
         JBBXxXdVQR23f2XNXzMd6sVbtAZl0y5MQmKYVDIuLyqdOfsNn+lnvYN3eA/NF2Y7UA6c
         CJG9aphHk8uPqQXqP7kAtbzwnov4DfrFZ98Wr95YTwwMZsARDVbnDrbWEfnPxfjmNMU2
         ukhStosgdkiUo8PwUyPBkwzdd711xvDA2vQHmRiTvS2FTuv1Tpr5RmFSF0NyIRbGeJNO
         CTSz9LDb/bjAIGSrtomyD3POjQw4F0rrHt/GpHVvdJD4ad28RmzzXXMpzwc44A+W5EJd
         1w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzpBwp3oShh8wVDIYVSkwUb32WyiTPO4uenKxBnQUrA=;
        b=azJYm85q6MFHqk+kumGbAwYCBQQGqqkht8/XJ/5XTabOY6lWHnDIU9mZsYK9pRQRph
         ze+C2e+k55xqymjsR7DayL6SwtcSYbbI9/PVgCsWOJUJwXNIShe4vBJ0vj87xbGpbBAg
         zRk8+6eVYKqMDpYhZHaP59Vx5zaYapwwYJfDpHW3oKsjvd7+mbtRdiVVfpZE7pG3YEEj
         QAfRpVU8Nj3iyqa9n8EYGyQtP88kcPN5UK9Q1lXOAgp2YsAPJ0O4Cn/c4Pgc6So+z6PA
         RhYbHuTJcakvLykIrGgQ/h0dGfAswtKXNa19GRojryP7Nx+5N39GNX/6Jnrp31EFlLyQ
         /m8g==
X-Gm-Message-State: AO0yUKX+7iP+16UxVDIT4eaqLvjrZqJiuAgLxBLXIHiPqFwE9XYfOIbw
        J/JVv1PPCXplBmkOcIZ+Ro4=
X-Google-Smtp-Source: AK7set+tmjzbD3ss2mi+MOQD7jFlN1kNftoFakoV2t7t9oBU7H3W8FkZ6zbUkyS/eF0k6gj4DF3qeQ==
X-Received: by 2002:a05:6808:118:b0:383:eaea:7dcb with SMTP id b24-20020a056808011800b00383eaea7dcbmr172358oie.15.1677451140318;
        Sun, 26 Feb 2023 14:39:00 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:319d:ae28:d693:d868? ([2600:1700:2442:6db0:319d:ae28:d693:d868])
        by smtp.gmail.com with ESMTPSA id ec12-20020a056808638c00b00383e12bedebsm2434628oib.9.2023.02.26.14.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 14:38:59 -0800 (PST)
Message-ID: <954cc40b-c484-5ba9-9039-eed3c1c722c3@gmail.com>
Date:   Sun, 26 Feb 2023 16:38:58 -0600
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

Hi Clément, Hi Lizhi,

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

Digging back through some history:

>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

(I am selectively pulling two fragments, see the above link for the
full email.)

Includes the following:

   A driver using this support was added and can be seen at [3]. This
   driver embeds a builtin overlay and applies it to the live tree using
   of_overlay_fdt_apply_to_node(). An interrupt driver is also included and

and

   This series was tested on a x86 kernel using CONFIG_OF under a virtual
   machine using PCI passthrough.

   Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
   Link: [2] https://lore.kernel.org/lkml/20220408174841.34458529@fixe.home/T/
   Link: [3] https://github.com/clementleger/linux/tree/lan966x/of_support

Following link 3 to see how the driver implemented the concept, I arrived
at a git tree, with the commit be42efa "mfd: lan966x: add pci driver",
and have been looking at the code there.

Clément, is this still the best example of a driver implementation that
would use the framework proposed in the "[PATCH V7 0/3] Generate device
tree node for pci devices" patch series? And this is the driver for the
device listed as item 2 above "2) Microchip LAN9662 Ethernet Controller"?

-Frank

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
> This patch series is made up of three patches.

< snip >


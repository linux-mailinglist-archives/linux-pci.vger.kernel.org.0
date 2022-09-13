Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377865B7964
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiIMSZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiIMSYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 14:24:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC667CAA0;
        Tue, 13 Sep 2022 10:41:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c11so9214180qtw.8;
        Tue, 13 Sep 2022 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=N8R0atdOLEWvc76kU0fgN1ovoaLrW08WX3jj0aJOZA4=;
        b=HiR5n74+ff3SII0q7xXAEwsQRXpm98oDXr3ZoHBzxSrruIhCCTZofQ5CaPcxqqwOde
         1QGnQQvmXlPKMEkMkQVyPFlMYC5VBYmMvU9lP+3txO4ZHNOErGmlLRtL2Jwz+Qv7AF/x
         ntONk2hVXKkjyEOFXpxKFN1GXhHQSFAkvEjyPBpelvM/ExNHRVGhCYOUQiMCeLf/tlWK
         Yw8djgk+Up56Y+I1K3UmIln/6BqVuZvaexctzXwaGd/4fZifiSDN8+FozclpCj+TFpb3
         1TXSeLlc51l+LdEB1j1bH4H7zvuzcx+VglFfuznK/UkGINDqI5owREt0MTHS5rzG+3Cx
         O0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N8R0atdOLEWvc76kU0fgN1ovoaLrW08WX3jj0aJOZA4=;
        b=rb3V2UsdEn+ffoAxrdtoxsVTZ7xZmHXWg74Krq94K4U5+8qyj+gT8sd3HW8yoGTjko
         9/PqGmmtyXGCsT6L51Koww1IqAhp+OLSx3Sx6uNeJHzPuhN9c8G0thNw+CF8NFrEDs9Q
         lyVOz1woAzE69bm7oetpOi6sKCuOj7b1auTJ+AmL7Auoab0NFW6+4yvtgYW1xeBQKbtL
         BYrBK1Rcwq0JqFjPJSIfzpPBbms4U87KrMMsO0jF6bzlhkp6LDBzwgcVTc0I9CPExJWl
         8LVZHhYz58CmrCyo/dJEjV4vQXNye9vNc6FLq2gY0fKW+ChWdGOXL0U9ysleC8SjGACm
         GnBg==
X-Gm-Message-State: ACgBeo3GD40RbRARi+NpG9JRPrYli+CE+X+An5t0QpE5NhLiQCmnysNP
        mHETPl2O6Yb+LF56MRqryTM=
X-Google-Smtp-Source: AA6agR7TsnDo7iBQEE3+/gCXWUzJNyaLxQosYBiLU/wQniPtDyfREYTSpS9q4YZCmjSvAQewzn/h+A==
X-Received: by 2002:a05:622a:289:b0:344:9844:ba5b with SMTP id z9-20020a05622a028900b003449844ba5bmr30232448qtw.234.1663090890966;
        Tue, 13 Sep 2022 10:41:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:216d:1a77:16d6:2f68? ([2600:1700:2442:6db0:216d:1a77:16d6:2f68])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b006ce2c3c48ebsm5721454qkb.77.2022.09.13.10.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:41:30 -0700 (PDT)
Message-ID: <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
Date:   Tue, 13 Sep 2022 12:41:28 -0500
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
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/22 12:10, Lizhi Hou wrote:
> 
> On 9/13/22 00:00, Frank Rowand wrote:
>> On 8/29/22 16:43, Lizhi Hou wrote:
>>> This patch series introduces OF overlay support for PCI devices which
>>> primarily addresses two use cases. First, it provides a data driven method
>>> to describe hardware peripherals that are present in a PCI endpoint and
>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>> example device is Microchip LAN9662 Ethernet Controller.
>>>
>>> This patch series consolidates previous efforts to define such an
>>> infrastructure:
>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>
>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>> PCI enumeration process. However, the process does not provide a way to
>>> discover the hardware peripherals that are present in a PCI device, and
>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>> hardware peripherals that are present in the device. PCI device drivers
>>> often use header files to describe the hardware peripherals and their
>>> resources as there is no standard data driven way to do so. This patch
>>> series proposes to use flattened device tree blob to describe the
>>> peripherals in a data driven way. Based on previous discussion, using
>>> device tree overlay is the best way to unflatten the blob and populate
>>> platform devices. To use device tree overlay, there are three obvious
>>> problems that need to be resolved.
>>>
>>> First, we need to create a base tree for non-DT system such as x86_64. A
>>> patch series has been submitted for this:
>>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>>
>>> Second, a device tree node corresponding to the PCI endpoint is required
>>> for overlaying the flattened device tree blob for that PCI endpoint.
>>> Because PCI is a self-discoverable bus, a device tree node is usually not
>>> created for PCI devices. This series adds support to generate a device
>>> tree node for a PCI device which advertises itself using PCI quirks
>>> infrastructure.
>>>
>>> Third, we need to generate device tree nodes for PCI bridges since a child
>>> PCI endpoint may choose to have a device tree node created.
>>>
>>> This patch series is made up of two patches.
>>>
>>> The first patch is adding OF interface to allocate an OF node. It is copied
>>> from:
>>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>>
>>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>>> is turned on, the kernel will generate device tree nodes for all PCI
>>> bridges unconditionally. The patch also shows how to use the PCI quirks
>>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>>> a device. Specifically, the patch generates a device tree node for Xilinx
>>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>>> have any property. Future patches will add the necessary properties.
>>>
>>> Clément Léger (1):
>>>    of: dynamic: add of_node_alloc()
>>>
>>> Lizhi Hou (1):
>>>    pci: create device tree node for selected devices
>>>
>>>   drivers/of/dynamic.c        |  50 +++++++++++++----
>>>   drivers/pci/Kconfig         |  11 ++++
>>>   drivers/pci/bus.c           |   2 +
>>>   drivers/pci/msi/irqdomain.c |   6 +-
>>>   drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>>   drivers/pci/pci-driver.c    |   3 +-
>>>   drivers/pci/pci.h           |  16 ++++++
>>>   drivers/pci/quirks.c        |  11 ++++
>>>   drivers/pci/remove.c        |   1 +
>>>   include/linux/of.h          |   7 +++
>>>   10 files changed, 200 insertions(+), 13 deletions(-)
>>>
>> The patch description leaves out the most important piece of information.
>>
>> The device located at the PCI endpoint is implemented via FPGA
>>     - which is programmed after Linux boots (or somewhere late in the boot process)
>>        - (A) and thus can not be described by static data available pre-boot because
>>              it is dynamic (and the FPGA program will often change while the Linux
>>              kernel is already booted
>>        - (B) can be described by static data available pre-boot because the FPGA
>>              program will always be the same for this device on this system
>>
>> I am not positive what part of what I wrote above is correct and would appreciate
>> some confirmation of what is correct or incorrect.
> 
> There are 2 series devices rely on this patch:
> 
>     1) Xilinx Alveo Accelerator cards (FPGA based device)
> 
>     2) lan9662 PCIe card
> 
>           please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

Thanks.  Please include this information in future versions of the patch series.

For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
device tree.  I realize that this suggestion is only a partial solution if one wants to
use hotplug to change system configuration (as opposed to using hotplug only to replace
an existing device (eg a broken device) with another instance of the same device).  I
also realize that this increased the system administration overhead.  On the other hand
an overlay based solution is likely to be fragile and possibly flaky.

> 
> For Xilinx Alveo device, it is (A). The FPGA partitions can be programmed dynamically after boot.

I looked at the Xilinx Alveo web page, and there are a variety of types of Alveo cards
available.  So the answer to my next question may vary by type of card.

Is it expected that the fpga program on a given card will change frequently (eg multiple
times per day), where the changed program results in a new device that would require a
different hardware description in the device tree?

Or is the fpga program expected to change on an infrequent basis (eg monthly, quarterly,
annually), in the same way as device firmware and operating systems are updated on a regular
basis for bug fixes and new functionality?


> 
> 
> Thanks,
> 
> Lzhi
> 
>>
>> -Frank


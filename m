Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAD6AA5C1
	for <lists+linux-pci@lfdr.de>; Sat,  4 Mar 2023 00:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCCXm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 18:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCCXmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 18:42:25 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30D6780A;
        Fri,  3 Mar 2023 15:42:21 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w23so4780939qtn.6;
        Fri, 03 Mar 2023 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677886941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPsYvTP2kzrR4HGbSxvXwsR54JLEt6G4NhiweQE7Pcg=;
        b=XLCrtvWHfH5eKn9xcFaYOK/WOkjAq4RCgFYsehJnFJNYlhCQzN744BLl9E/FAg9bR8
         0sMWAd/YHSPDjtmCpu4v3MrHIuoF+VKllCeqTlHbDGDsL2Nj48V9dh0FJqZ4rzY5d1GW
         xXCgit+Acakr6voK2VvCL567UX41GGCpE1kUxiGObxh4yfOIGM+Xsq0MS2lHM+FhBLe6
         n+miLvTNqLQOQSkaqMYAq2qP+QoJ37XL6hVl1hj/tK9sjJJHOqOhndebiDaDYC/IFguc
         +NxhWhXMIaTVs6MFi5KfikOI0RGgj9KFz4NZ/SprZ+a1QDfKkgBWfCERvFR3vqO8BFXm
         bB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677886941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPsYvTP2kzrR4HGbSxvXwsR54JLEt6G4NhiweQE7Pcg=;
        b=p6dZ87dyN4H78drD+9noZBAMUZmd+HT74svHLpISlacbxeYnHqOG4DiiyBhzFs78jq
         c15AhFpbI+hkf6CVC5w9XrljIFbd9ci3C6Y502TMioMXfOt9PPtgnF+O4hne1bHgOLFn
         xPOoyJAFvRLbWuZEz4vPDz0kRBBSjbOZELxSeDwcTKGq/bquPn0th8yW9QbZKOzqRyQj
         RIkQcn5iBuuXL7NdBJzdjCl3yVerH8+uHoJW3/Gj0ZJZQ4U0JBjVQRcDGQ2f9iURKipd
         9IOuQHkeTcZ3w+S0nJSzO0e8XooK7HBSFn4QrYUfo8tyMHsc6nRL1DSeV/zwGTjPnFW8
         HNyQ==
X-Gm-Message-State: AO0yUKWlCQQ0+3GyA/xAC7HEdNR+9uCpsEqpD8CwmWsa/thH09hJXMHm
        xdhhIh4riSxDvlray77s4QM=
X-Google-Smtp-Source: AK7set+KUzZCGmm/sWCrpO6b1S39F57LVDY9xZSCINKBf2s3mf6VzeTQpw76rZQZPEDZF2qXLHT7Mw==
X-Received: by 2002:a05:622a:4d4:b0:3bf:b614:bcba with SMTP id q20-20020a05622a04d400b003bfb614bcbamr6307742qtx.42.1677886940938;
        Fri, 03 Mar 2023 15:42:20 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id l6-20020ac84a86000000b003ba11bfe4fcsm2642446qtq.28.2023.03.03.15.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:42:20 -0800 (PST)
Message-ID: <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
Date:   Fri, 3 Mar 2023 17:42:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
 <20230227113150.398dcfa7@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230227113150.398dcfa7@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/27/23 04:31, Clément Léger wrote:
> Le Mon, 27 Feb 2023 00:51:29 -0600,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 1/19/23 21:02, Lizhi Hou wrote:
>>> This patch series introduces OF overlay support for PCI devices which
>>> primarily addresses two use cases. First, it provides a data driven method
>>> to describe hardware peripherals that are present in a PCI endpoint and
>>> hence can be accessed by the PCI host. Second, it allows reuse of a OF
>>> compatible driver -- often used in SoC platforms -- in a PCI host based
>>> system.
>>>
>>> There are 2 series devices rely on this patch:
>>>
>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>   2) Microchip LAN9662 Ethernet Controller
>>>
>>>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>   
>>
>>
>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>> PCI enumeration process. However, the process does not provide a way to
>>> discover the hardware peripherals that are present in a PCI device, and
>>> which can be accessed through the PCI BARs. Also, the enumeration process  
>>
>> I'm confused.  The PCI Configuration Header Registers should describe the
>> hardware on the PCI card.
>>
>> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
>> themselves, so I would like to analyze that case separately), does the
>> second device, "Microchip LAN9662 Ethernet Controller" properly implement
>> the PCI Configuration Header Registers?  What additional information is
>> needed that is not provided in those registers?
> 
> Hi Frank,
> 
> I guess Lizhi wanted to say that it does not provide a way to describe
> all the "platform" devices that are exposed by this PCI device. Which
> is of course the whole point of the work we are doing right now. But
> all the BARs are correctly described by the LAN9662 PCI card.
> 
> Clément

I remain confused.

[RFC 00/10] add support for fwnode in i2c mux system and sfp
https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/

  references a PCIe driver:
  [2] https://github.com/clementleger/linux/blob/fwnode_support/drivers/mfd/lan966x_pci_mfd.c

So there is a PCIe driver that works.

However, the RFC patch series was proposing adding fwnode support to the driver.  My first
surface reading (just part of that one email, not the entire series or the replies yet),
notes:

  ... However, when
  plugged in a PCIe slot (on a x86), there is no device-tree support and
  the peripherals that are present must be described in some other way.

I am assuming that the peripherals are what you mentioned above as '"platform"
devices'.  This is where my current confusion lies.  Are the "platform"
devices accessed via the PCI bus or is there some other electrical connection
between the host system and the PCIe card?

If the "platform" devices are accessed via the PCI bus, then I would expect them
to be described by PCI configuration header registers.  Are the PCI configuration
registers to describe the "platform" devices not present?

I'll read through the fwnode RFC thread to add to see what happened to the proposal.

-Frank

> 
>>
>> -Frank
>>
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
>>> This patch series is made up of three patches.
>>>
>>> The first patch is adding OF interface to create or destroy OF node
>>> dynamically.
>>>
>>> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
>>> When the option is turned on, the kernel will generate device tree nodes
>>> for all PCI bridges unconditionally. The patch also shows how to use the
>>> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
>>> tree node for a device. Specifically, the patch generates a device tree
>>> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
>>> tree nodes do not have any property.
>>>
>>> The third patch adds basic properties ('reg', 'compatible' and
>>> 'device_type') to the dynamically generated device tree nodes. More
>>> properties can be added in the future.
>>>
>>> Here is the example of device tree nodes generated within the ARM64 QEMU.
>>> # lspci -t    
>>> -[0000:00]-+-00.0
>>>            +-01.0-[01]--
>>>            +-01.1-[02]----00.0
>>>            +-01.2-[03]----00.0
>>>            +-01.3-[04]----00.0
>>>            +-01.4-[05]----00.0
>>>            +-01.5-[06]--
>>>            +-01.6-[07]--
>>>            +-01.7-[08]--
>>>            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>>>            |                                            \-00.1
>>>            +-02.1-[0c]--
>>>            \-03.0-[0d-0e]----00.0-[0e]----01.0
>>>
>>> # tree /sys/firmware/devicetree/base/pcie\@10000000
>>> /sys/firmware/devicetree/base/pcie@10000000
>>> |-- #address-cells
>>> |-- #interrupt-cells
>>> |-- #size-cells
>>> |-- bus-range
>>> |-- compatible
>>> |-- device_type
>>> |-- dma-coherent
>>> |-- interrupt-map
>>> |-- interrupt-map-mask
>>> |-- linux,pci-domain
>>> |-- msi-parent
>>> |-- name
>>> |-- pci@1,0
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,1
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,2
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,3
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,4
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,5
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,6
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@1,7
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@2,0
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- pci@0,0
>>> |   |   |-- #address-cells
>>> |   |   |-- #size-cells
>>> |   |   |-- compatible
>>> |   |   |-- device_type
>>> |   |   |-- pci@0,0
>>> |   |   |   |-- #address-cells
>>> |   |   |   |-- #size-cells
>>> |   |   |   |-- compatible
>>> |   |   |   |-- dev@0,0
>>> |   |   |   |   |-- compatible
>>> |   |   |   |   `-- reg
>>> |   |   |   |-- dev@0,1
>>> |   |   |   |   |-- compatible
>>> |   |   |   |   `-- reg
>>> |   |   |   |-- device_type
>>> |   |   |   |-- ranges
>>> |   |   |   `-- reg
>>> |   |   |-- ranges
>>> |   |   `-- reg
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@2,1
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- pci@3,0
>>> |   |-- #address-cells
>>> |   |-- #size-cells
>>> |   |-- compatible
>>> |   |-- device_type
>>> |   |-- pci@0,0
>>> |   |   |-- #address-cells
>>> |   |   |-- #size-cells
>>> |   |   |-- compatible
>>> |   |   |-- device_type
>>> |   |   |-- ranges
>>> |   |   `-- reg
>>> |   |-- ranges
>>> |   `-- reg
>>> |-- ranges
>>> `-- reg
>>>
>>> Changes since v6:
>>> - Removed single line wrapper functions
>>> - Added Signed-off-by Clément Léger <clement.leger@bootlin.com>
>>>
>>> Changes since v5:
>>> - Fixed code review comments
>>> - Fixed incorrect 'ranges' and 'reg' properties and verified address
>>>   translation.
>>>
>>> Changes since RFC v4:
>>> - Fixed code review comments
>>>
>>> Changes since RFC v3:
>>> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
>>> - Minor changes in commit description and code comment
>>>
>>> Changes since RFC v2:
>>> - Merged patch 3 with patch 2
>>> - Added OF interfaces of_changeset_add_prop_* and use them to create
>>>   properties.
>>> - Added '#address-cells', '#size-cells' and 'ranges' properties.
>>>
>>> Changes since RFC v1:
>>> - Added one patch to create basic properties.
>>> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>>>   with of_create_node()/of_destroy_node()
>>>
>>> Lizhi Hou (3):
>>>   of: dynamic: Add interfaces for creating device node dynamically
>>>   PCI: Create device tree node for selected devices
>>>   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
>>>
>>>  drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
>>>  drivers/pci/Kconfig         |  12 ++
>>>  drivers/pci/Makefile        |   1 +
>>>  drivers/pci/bus.c           |   2 +
>>>  drivers/pci/msi/irqdomain.c |   6 +-
>>>  drivers/pci/of.c            |  71 ++++++++++++
>>>  drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pci-driver.c    |   3 +-
>>>  drivers/pci/pci.h           |  19 ++++
>>>  drivers/pci/quirks.c        |  11 ++
>>>  drivers/pci/remove.c        |   1 +
>>>  include/linux/of.h          |  24 ++++
>>>  12 files changed, 556 insertions(+), 3 deletions(-)
>>>  create mode 100644 drivers/pci/of_property.c
>>>   
>>
> 
> 
> 


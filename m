Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175C869F7B3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBVP0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 10:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVP0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 10:26:45 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418036FDA;
        Wed, 22 Feb 2023 07:26:44 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1723ab0375eso5894550fac.1;
        Wed, 22 Feb 2023 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTqrDSHcqeuTh6ZKl+ymWOpiBpf5Ecyz5dKu3SfTSrg=;
        b=HLOdsRruj9kn9EnO0UGwICDX/11TuWi7kkeZpGlBcli6nR+kR2QkSu+HsD3lac9sbi
         EX2wPreHwCNecOOvFmJlyVcFGPwzbj6gDdt2Mn5/ojSYtEeo3CoEaz7BrD1ae4M7J4lS
         QcaAxW++Yjoa4u5Vn8aDPHjwVHswjUHZKTcWG9fL8CUvhp6arBGafb9VQe337wMXmRcS
         ZaYkuH6hHxuom4Zl8qyidE6px5yKjbznoIHeK6nJL6X2GNX6h/XfekvRB6Z5y3ysY2R+
         I4A8i2Js0y6galbPcrF6hLeFAN5epgjagBRDoW9xw5oaoA8mNSDKSu4k2M9RpeYGm4hM
         qLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTqrDSHcqeuTh6ZKl+ymWOpiBpf5Ecyz5dKu3SfTSrg=;
        b=bPJyPbc/XB+g593SWbQiyk57c1v3Kd0vLdvAo+bwnZ2dNHZnhxsTlw4JqI1TCinBhZ
         H9sP+6cOdDVKEEJhIImXEgAzFadTH2JhRZAFTo1xea0DrPP/ZyZi0oWAwKqfG+O+X5Wu
         zr2oyhb/K0XbkQgrOZANB7B034MptgFiM/n+iDj2tl7Gv50F9zW2iDPxNkJLStXjd+/X
         uC5OTzYEfIgsdVmQVkFOSIh7tdV0hLzlq+BVCyIqSOJ/QBzzpDr3FiWJQf6mj2BLRffJ
         EO2d8AI3tkWyHR+dKdhWBzUULsZpIpX6q1iaw7x0yVzCcJf7m1Zw3rqKL683YLkZvDWS
         2tBg==
X-Gm-Message-State: AO0yUKWL7Go3OGAo0Xma8osGniTWiYnizExHSQUlDsXqFEajrWrHZJX7
        I2aTAXurnT6BFuW9bwLktts=
X-Google-Smtp-Source: AK7set9ufltdOl0Yg6gCO9WYBbhFu04A4wRFE2iZ+JP/IQ8v2/pmKb4L0kn+YBKToM0dQjSnChsFhQ==
X-Received: by 2002:a05:6871:20c:b0:16e:759a:6ad9 with SMTP id t12-20020a056871020c00b0016e759a6ad9mr10346801oad.25.1677079603164;
        Wed, 22 Feb 2023 07:26:43 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:31c9:f7f0:2383:8447? ([2600:1700:2442:6db0:31c9:f7f0:2383:8447])
        by smtp.gmail.com with ESMTPSA id u6-20020a056870440600b0016e49af5815sm6231471oah.51.2023.02.22.07.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:26:42 -0800 (PST)
Message-ID: <3b74b383-68d0-0a9f-55d3-9fd389b4497e@gmail.com>
Date:   Wed, 22 Feb 2023 09:26:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <0b44ec45-a5d8-87ff-34e9-cfed58eb060c@gmail.com>
 <140e5073-f0d9-f561-dee0-08ad28169085@gmail.com>
In-Reply-To: <140e5073-f0d9-f561-dee0-08ad28169085@gmail.com>
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

Hi Lizhi,

On 1/23/23 17:40, Frank Rowand wrote:
> On 1/22/23 22:32, Frank Rowand wrote:
>> Hi Rob, Lizhi,
>>
>> On 1/19/23 21:02, Lizhi Hou wrote:
>>> This patch series introduces OF overlay support for PCI devices which
>>> primarily addresses two use cases. First, it provides a data driven method
>>> to describe hardware peripherals that are present in a PCI endpoint and
>>> hence can be accessed by the PCI host. Second, it allows reuse of a OF
>>> compatible driver -- often used in SoC platforms -- in a PCI host based
>>> system.
>>
>> I had hoped to review this series by today, but have not yet due to working
>> on some new unittest features.  I hope to get to this series Monday.
> 
> I have skimmed through the series, and dug more deeply into portions of
> the patches, but have not yet fully examined the full series.
> 
> I will be on vacation for a week or so, and will resume the detailed
> reading of the series.

I am back from vacation, and I have completed the other devicetree
related tasks that were also at the top of my devicetree todo list.

I will resume the detailed reading of the series as the item that is
now at the top of my devicetree todo list.  But I consider any review
comments coming out of this as trivial compared to the issue raised in
the following paragraph:

> 
> One overall comment at this point, is that this series is somewhat
> duplicating portions of the (incomplete and fragile) overlay functionality
> but not fully.  One trivial example is no locking to prevent interference
> between tree modification by overlay code that could be occurring
> asynchronously at the same time this new code is modifying the tree.

Since there was no reply to the above paragraph, I am guessing that what
I wrote was not clear enough.  As far as I am concerned, this issue is
critical.  This patch series creates a body of code that is _more fragile_
and _more incomplete_ than the existing overlay code.  I have been very
clear over many years that the overlay code is not usable in its current
implementation.

Further, the body of code in this patch series will interact with the
overlay code in a manner that makes the overlay code even more fragile
and not usable.

-Frank

> 
> -Frank
> 
>>
>> -Frank
>>
>>>
>>> There are 2 series devices rely on this patch:
>>>
>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>   2) Microchip LAN9662 Ethernet Controller
>>>
>>>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
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


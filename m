Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648E678C2A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjAWXkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 18:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWXko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 18:40:44 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8981207B;
        Mon, 23 Jan 2023 15:40:43 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x5so11784840qti.3;
        Mon, 23 Jan 2023 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbRGdOx4p3JEVYkO0WTJCtgnWG6duG6KkJ3keeiEF3U=;
        b=bYqejAE7wxsfjqD2G6UdWRpmT8GhOIj5ID7Pvr2fro5Z9IWVciGcQQxPcEc3DA6Nr0
         NDyWk5FCOEURfJjsw70GSTYSxHyI853x/F8tRm6aoPWPnSTV5MKNtvo5GFCGLK/3IKul
         MU8HvPgeXbs7dJtdpEcJM3RN0AXl+7hc4NZn5YNRo1BdN9aUEESp+1w2QJIMuajqeWyI
         Az0E/iwul08JpaKSsBfhYIbRM7MQFqbtnF5Yj4fZnqAJWAgleiS1lheWc0Y+qPA7XJtj
         v5IyMYIVnHAT6ONI4PP36sPxMULbKuGi2pLjfdh0nwJ6px091GDv70XbGINEbf524uh4
         xXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbRGdOx4p3JEVYkO0WTJCtgnWG6duG6KkJ3keeiEF3U=;
        b=bkhzEiva5E4cXgbtARC0by1Q4zVpcXAy6Q32QxKkQGa8VTLowElhjjj7l2gHwGW6Qc
         r5r8O2yL7RaxLKyvoA23uVGtkbhEo002zsbHDiA/+ZwhAB969c82r0xTiY/EKnSuOXul
         yiPyGOHL7OM6c8WEo699A8X2Z1WpFS8IAzAss2F4aXYwo5xrcnprIidqjfhQzWgac/MJ
         IUcfrRAsPbtVf24D12AzvVX2YJ5TnaWGJ1CgVixGB2iosEea7McihkhgOXJuEbz3UcoJ
         NQWxNV82r5YXC4mtTXqEvHekeIHN5UIIkWfft8he76Cn2LIZIul5ZjIRZuia7/yV7adn
         K7QQ==
X-Gm-Message-State: AFqh2kpR2PkiWGwDgLYcxzHoAjKL6yMbgJYFhTpiZ2q/N/eJfI3oSrRV
        DOsQQ4ZDpLrVP09PyWihS68=
X-Google-Smtp-Source: AMrXdXvNJDXL6R9QsPJdCUgNSuEWSgwTQdRwcualuA8HvSJkFBZGj7ESsQq4gIy8zrPxaQOjMXZPcQ==
X-Received: by 2002:ac8:7746:0:b0:3b6:89b6:fb6e with SMTP id g6-20020ac87746000000b003b689b6fb6emr26461752qtu.21.1674517242700;
        Mon, 23 Jan 2023 15:40:42 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:d106:41:3c8c:68f0? ([2600:1700:2442:6db0:d106:41:3c8c:68f0])
        by smtp.gmail.com with ESMTPSA id b23-20020ac85417000000b003b635009149sm185286qtq.72.2023.01.23.15.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 15:40:42 -0800 (PST)
Message-ID: <140e5073-f0d9-f561-dee0-08ad28169085@gmail.com>
Date:   Mon, 23 Jan 2023 17:40:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
In-Reply-To: <0b44ec45-a5d8-87ff-34e9-cfed58eb060c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/22/23 22:32, Frank Rowand wrote:
> Hi Rob, Lizhi,
> 
> On 1/19/23 21:02, Lizhi Hou wrote:
>> This patch series introduces OF overlay support for PCI devices which
>> primarily addresses two use cases. First, it provides a data driven method
>> to describe hardware peripherals that are present in a PCI endpoint and
>> hence can be accessed by the PCI host. Second, it allows reuse of a OF
>> compatible driver -- often used in SoC platforms -- in a PCI host based
>> system.
> 
> I had hoped to review this series by today, but have not yet due to working
> on some new unittest features.  I hope to get to this series Monday.

I have skimmed through the series, and dug more deeply into portions of
the patches, but have not yet fully examined the full series.

I will be on vacation for a week or so, and will resume the detailed
reading of the series.

One overall comment at this point, is that this series is somewhat
duplicating portions of the (incomplete and fragile) overlay functionality
but not fully.  One trivial example is no locking to prevent interference
between tree modification by overlay code that could be occurring
asynchronously at the same time this new code is modifying the tree.

-Frank

> 
> -Frank
> 
>>
>> There are 2 series devices rely on this patch:
>>
>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>   2) Microchip LAN9662 Ethernet Controller
>>
>>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>
>> Normally, the PCI core discovers PCI devices and their BARs using the
>> PCI enumeration process. However, the process does not provide a way to
>> discover the hardware peripherals that are present in a PCI device, and
>> which can be accessed through the PCI BARs. Also, the enumeration process
>> does not provide a way to associate MSI-X vectors of a PCI device with the
>> hardware peripherals that are present in the device. PCI device drivers
>> often use header files to describe the hardware peripherals and their
>> resources as there is no standard data driven way to do so. This patch
>> series proposes to use flattened device tree blob to describe the
>> peripherals in a data driven way. Based on previous discussion, using
>> device tree overlay is the best way to unflatten the blob and populate
>> platform devices. To use device tree overlay, there are three obvious
>> problems that need to be resolved.
>>
>> First, we need to create a base tree for non-DT system such as x86_64. A
>> patch series has been submitted for this:
>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>
>> Second, a device tree node corresponding to the PCI endpoint is required
>> for overlaying the flattened device tree blob for that PCI endpoint.
>> Because PCI is a self-discoverable bus, a device tree node is usually not
>> created for PCI devices. This series adds support to generate a device
>> tree node for a PCI device which advertises itself using PCI quirks
>> infrastructure.
>>
>> Third, we need to generate device tree nodes for PCI bridges since a child
>> PCI endpoint may choose to have a device tree node created.
>>
>> This patch series is made up of three patches.
>>
>> The first patch is adding OF interface to create or destroy OF node
>> dynamically.
>>
>> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
>> When the option is turned on, the kernel will generate device tree nodes
>> for all PCI bridges unconditionally. The patch also shows how to use the
>> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
>> tree node for a device. Specifically, the patch generates a device tree
>> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
>> tree nodes do not have any property.
>>
>> The third patch adds basic properties ('reg', 'compatible' and
>> 'device_type') to the dynamically generated device tree nodes. More
>> properties can be added in the future.
>>
>> Here is the example of device tree nodes generated within the ARM64 QEMU.
>> # lspci -t    
>> -[0000:00]-+-00.0
>>            +-01.0-[01]--
>>            +-01.1-[02]----00.0
>>            +-01.2-[03]----00.0
>>            +-01.3-[04]----00.0
>>            +-01.4-[05]----00.0
>>            +-01.5-[06]--
>>            +-01.6-[07]--
>>            +-01.7-[08]--
>>            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>>            |                                            \-00.1
>>            +-02.1-[0c]--
>>            \-03.0-[0d-0e]----00.0-[0e]----01.0
>>
>> # tree /sys/firmware/devicetree/base/pcie\@10000000
>> /sys/firmware/devicetree/base/pcie@10000000
>> |-- #address-cells
>> |-- #interrupt-cells
>> |-- #size-cells
>> |-- bus-range
>> |-- compatible
>> |-- device_type
>> |-- dma-coherent
>> |-- interrupt-map
>> |-- interrupt-map-mask
>> |-- linux,pci-domain
>> |-- msi-parent
>> |-- name
>> |-- pci@1,0
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,1
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,2
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,3
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,4
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,5
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,6
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,7
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@2,0
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- pci@0,0
>> |   |   |-- #address-cells
>> |   |   |-- #size-cells
>> |   |   |-- compatible
>> |   |   |-- device_type
>> |   |   |-- pci@0,0
>> |   |   |   |-- #address-cells
>> |   |   |   |-- #size-cells
>> |   |   |   |-- compatible
>> |   |   |   |-- dev@0,0
>> |   |   |   |   |-- compatible
>> |   |   |   |   `-- reg
>> |   |   |   |-- dev@0,1
>> |   |   |   |   |-- compatible
>> |   |   |   |   `-- reg
>> |   |   |   |-- device_type
>> |   |   |   |-- ranges
>> |   |   |   `-- reg
>> |   |   |-- ranges
>> |   |   `-- reg
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@2,1
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@3,0
>> |   |-- #address-cells
>> |   |-- #size-cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- pci@0,0
>> |   |   |-- #address-cells
>> |   |   |-- #size-cells
>> |   |   |-- compatible
>> |   |   |-- device_type
>> |   |   |-- ranges
>> |   |   `-- reg
>> |   |-- ranges
>> |   `-- reg
>> |-- ranges
>> `-- reg
>>
>> Changes since v6:
>> - Removed single line wrapper functions
>> - Added Signed-off-by Clément Léger <clement.leger@bootlin.com>
>>
>> Changes since v5:
>> - Fixed code review comments
>> - Fixed incorrect 'ranges' and 'reg' properties and verified address
>>   translation.
>>
>> Changes since RFC v4:
>> - Fixed code review comments
>>
>> Changes since RFC v3:
>> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
>> - Minor changes in commit description and code comment
>>
>> Changes since RFC v2:
>> - Merged patch 3 with patch 2
>> - Added OF interfaces of_changeset_add_prop_* and use them to create
>>   properties.
>> - Added '#address-cells', '#size-cells' and 'ranges' properties.
>>
>> Changes since RFC v1:
>> - Added one patch to create basic properties.
>> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>>   with of_create_node()/of_destroy_node()
>>
>> Lizhi Hou (3):
>>   of: dynamic: Add interfaces for creating device node dynamically
>>   PCI: Create device tree node for selected devices
>>   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
>>
>>  drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
>>  drivers/pci/Kconfig         |  12 ++
>>  drivers/pci/Makefile        |   1 +
>>  drivers/pci/bus.c           |   2 +
>>  drivers/pci/msi/irqdomain.c |   6 +-
>>  drivers/pci/of.c            |  71 ++++++++++++
>>  drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci-driver.c    |   3 +-
>>  drivers/pci/pci.h           |  19 ++++
>>  drivers/pci/quirks.c        |  11 ++
>>  drivers/pci/remove.c        |   1 +
>>  include/linux/of.h          |  24 ++++
>>  12 files changed, 556 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/pci/of_property.c
>>
> 


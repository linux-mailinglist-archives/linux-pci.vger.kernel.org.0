Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA01617298
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKBX1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiKBX0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:26:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8513F0B;
        Wed,  2 Nov 2022 16:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6951CB82537;
        Wed,  2 Nov 2022 23:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ECFC433D7;
        Wed,  2 Nov 2022 23:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667431265;
        bh=0K5Lst1NZVSbMpTrV9SZig3D7HzFybj8iwHGE8ITCh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Yb/0r5FvolMYkO5d15jwm2hwsUmmHLjey8LwpzK3iu/zAar5Y40qzaF20KjIJAvc4
         M3iqe6wS1FeZX8uuIz1QyPCMEyIZ4gz4AbFqhEV5wMrHR1n9LZlaGDLRGd7MEXvsW1
         V813CzTOSuY4f5JcXEusuTCGDlP7nNfiOE855+//6eOs2Naa/q41pyIJS5vZH8JLLX
         gTpQ1+KnAKxVxVMwauccjzB5W3/YqqvIW/6l4dmnVZc7otTDP48kMg2gHh9RX2ohR2
         e+hG8O2xRMcSo9YGxGybuWIXp8uRvHOz4Cz+HjsVxg9oStE3AlgA+OmFWvi0qWyc2d
         rzH/z9jWx4vxA==
Date:   Wed, 2 Nov 2022 18:21:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Message-ID: <20221102232103.GA7126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
> Current systems support Firmware-First model for hot-plug. In this model,

I'm familiar with "firmware first" in the context of ACPI APEI.

Is there more "firmware first" language in the spec related to
hotplug?  Or is this just the ACPI hotplug implemented by acpiphp?  Or
is there something in the PCIe spec that talks about some firmware
interfaces needed in pciehp?  If so, please cite the specific
sections.  I see you cite PCIe r6.0, sec 6.7.6, below, but I don't see
the firmware mention there.

> firmware holds the responsibilty for executing the HW sequencing actions on
> an async or surprise add and removal events. Additionally, according to
> Section 6.7.6 of PCIe Base Specification [1], firmware must also handle
> the side-effects (DPC/AER events) reported on an async removal and is
> abstract to the OS.
> 
> This model however, poses issues while rolling out updates or fixing bugs
> as the servers need to be brought down for firmware updates. Hence,
> introduce support for OS-First hot-plug and AER/DPC. Here, OS is
> responsible for handling async add and remove along with handling of
> AER/DPC events which are generated as a side-effect of async remove.
> 
> The implementation is as follows: On an async remove a DPC is triggered as
> a side-effect along with an MSI to the OS. Determine it's an async remove
> by checking for DPC Trigger Status in DPC Status Register and Surprise
> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
> treat the DPC event as a side-effect of async remove, clear the error
> status registers and continue with hot-plug tear down routines. If not,
> follow the existing routine to handle AER/DPC errors.
> 
> Dmesg before:
> 
> pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
> pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
> pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
> pcieport 0000:00:01.4:    [ 5] SDES (First)
> nvme nvme2: frozen state error detected, reset controller
> pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
> pcieport 0000:00:01.4: AER: subordinate device reset failed
> pcieport 0000:00:01.4: AER: device recovery failed
> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
> nvme2n1: detected capacity change from 1953525168 to 0
> pci 0000:04:00.0: Removing from iommu group 49
> 
> Dmesg after:
> 
> pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
> nvme1n1: detected capacity change from 1953525168 to 0
> pci 0000:04:00.0: Removing from iommu group 37
> pcieport 0000:00:01.4: pciehp: Slot(16): Card present
> pci 0000:04:00.0: [8086:0a54] type 00 class 0x010802
> pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> pci 0000:04:00.0: Max Payload Size set to 512 (was 128, max 512)
> pci 0000:04:00.0: enabling Extended Tags
> pci 0000:04:00.0: Adding to iommu group 37
> pci 0000:04:00.0: BAR 0: assigned [mem 0xf2400000-0xf2403fff 64bit]
> pcieport 0000:00:01.4: PCI bridge to [bus 04]
> pcieport 0000:00:01.4:   bridge window [io 0x1000-0x1fff]
> pcieport 0000:00:01.4:   bridge window [mem 0xf2400000-0xf24fffff]
> pcieport 0000:00:01.4:   bridge window [mem 0x20080800000-0x200809fffff 64bit pref]
> nvme nvme1: pci function 0000:04:00.0
> nvme 0000:04:00.0: enabling device (0000 -> 0002)
> nvme nvme1: 128/0/0 default/read/poll queues

Remove any lines that are not specifically relevant, e.g., I'm not
sure whether the BARs, iommu, MPS, extended tags info is essential.

Please indent the quoted material two spaces so it doesn't look like
the narrative text.

Thanks for working on this!

Bjorn

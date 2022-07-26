Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10683581BEE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiGZWDK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 18:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A432DAF;
        Tue, 26 Jul 2022 15:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78841616D4;
        Tue, 26 Jul 2022 22:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674ADC433C1;
        Tue, 26 Jul 2022 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658872986;
        bh=YAlRM5ikZwskDhCxJ6jfhkvNahSdq2ZlIn13XXhrgyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bWSUQjxOLmeiTDVyaWQXbxsvaJc0NkZiZCCGTU+s/0G7/hH1eBFUvYeK3UgF7yTZN
         vPjVY4+Ua9s7K99AtQh85O/4Y3TRGsyjLbl73BSGFv8HA233TmxKgQq6KJwJ6bCQPK
         auAL2TDnVse4/KCxoyYhQGc93j/phThxMNfPxf4qvYWOcv0R6ZARQYpcqwrLDTqagB
         EDiFzXmG3KK9BP9m2FRp417wR3iBQtM5t/VvZFZXz7t+M1xz24VgGDgUFcL55c4sb3
         Mz45Q7LPh37mgXQZICRsD4beuAoNM+UQh94r+FofbJGvf+DV1c1kbP5YIofy8uHNLT
         uDW2yt1aPEfhw==
Date:   Tue, 26 Jul 2022 17:03:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220726220303.GA109624@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
> ...
> Jim Quinlan (7):
>   PCI: brcmstb: Remove unnecessary forward declarations
>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
>   PCI: brcmstb: Gate config space access on link status
>   PCI: brcmstb: Add mechanism to turn on subdev regulators
>   PCI: brcmstb: Add control of subdevice voltage regulators
>   PCI: brcmstb: Do not turn off WOL regulators on suspend
>   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
> 
>  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
>  1 file changed, 341 insertions(+), 135 deletions(-)

I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
proposal, not something set in stone.  But time is of the essence to
figure out how we want to proceed.

I changed a lot of stuff and it's likely I broke something in the
process, so please take a look and test this out.  Here's an outline
of what I changed:

  - Moved the config access "link up" check earlier because it's not
    related to the power regulator patches.

  - Changed config access "link up" checks to use PCIE_ECAM_REG()
    instead of hard-coding 0xfff masks.  The 32-bit accessors already
    mask out the low two bits, so we don't need to do that here.

  - Squashed pci_subdev_regulators_add_bus() directly into
    brcm_pcie_add_bus() for readability.  Similarly for
    pci_subdev_regulators_remove_bus().

  - This makes a clear split between:

    * A patch that adds get/enable of regulators, and starting the
      link after enabling regulators, and

    * A patch that disables/enables regulators for suspend/resume.

  - Since we only support one set of subregulator info (for one Root
    Port, and brcm_pcie_suspend_noirq() depends on this since it uses
    the pcie->sr pointer), use pcie->sr always instead of
    dev->driver_data.

  - Squashed wakeup device checking into the suspend/resume patch so
    there's not a time when suspend might turn off power to a wakeup
    device.

  - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
    ends in "_map_bus()" like other drivers.  Also,
    brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.

Bjorn

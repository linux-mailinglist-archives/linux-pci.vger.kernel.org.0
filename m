Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF47CB15C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJPRb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPRb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 13:31:56 -0400
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76383;
        Mon, 16 Oct 2023 10:31:53 -0700 (PDT)
Date:   Mon, 16 Oct 2023 19:31:50 +0200
From:   Tomasz Pala <gotar@polanet.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-2?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231016173150.GA22012@polanet.pl>
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-3-helgaas@kernel.org>
 <20231012153347.GA26695@polanet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20231012153347.GA26695@polanet.pl>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 12, 2023 at 17:33:47 +0200, Tomasz Pala wrote:

> I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.
> 
> efi: Remove mem63: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> [...]
> [mem 0x7f800000-0xfed1bfff] available for PCI devices
> [...]
> PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
> [...]
> ixgbe 0000:02:00.0: enabling device (0140 -> 0142)
> ixgbe 0000:02:00.0: BAR 0: can't reserve [mem 0x80000000-0x8007ffff 64bit]
> ixgbe 0000:02:00.0: pci_request_selected_regions failed 0xfffffff0
> ixgbe: probe of 0000:02:00.0 failed with error -16

FWIW, as I got no response - there were other people facing the issue as
well:

https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-driver-fails-to-load-due-to-pci-device-probing-failure.131203/


Apparently this might be some hardware quirk, therefore I'm not sure if
the internal EfiMemoryMappedIO reservation logic should be reviewed, or
some quirk handling to be added, or maybe some CONFIG_option introduced.

Anyone please?

-- 
Tomasz Pala <gotar@pld-linux.org>

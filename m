Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7D65D77A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 16:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjADPqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjADPpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 10:45:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B334751;
        Wed,  4 Jan 2023 07:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD5446177A;
        Wed,  4 Jan 2023 15:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B1C433EF;
        Wed,  4 Jan 2023 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672847113;
        bh=29csCBF4JURyjYpQuuNuLUTGmcuSnO2zlMmXA5Fr9S8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T9FVM8BYsffWLFQL4gRKaT+HXpTeg+IisPbGJEOvE1FH9C8LLaWYfRE6hY1+Den3T
         PBKP/QmqvfvUk469Y0lE/YJ7+ShrIs890yEwnJQp+VZIvfnW3sY4SDQ2YT3AhS+RYS
         sEF6XaVa0O6rnaW40pF9mAAwlMdlh3k8lOiTzlRM4ejQ/967p1izRv4Uvkobi3Qa4x
         ijyIokZbqQm7Csjld8Rp+KTxYFZbGBl37EaPuW6rCx/Unle6FOR1RzxefEctk+u3yT
         YNVxmD8IZxTemK/KfbMcOXOh421/pmpFKa/FdbrHy0K5Gea3buSg3Lx74pFm572kQ4
         y4rMeaHOJ4ITg==
Date:   Wed, 4 Jan 2023 09:45:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     bhelgaas@google.com, hdegoede@redhat.com, kernelorg@undead.fr,
        kjhambrick@gmail.com, 2lprbe78@duck.com,
        nicholas.johnson-opensource@outlook.com.au, benoitg@coeus.ca,
        mika.westerberg@linux.intel.com, wse@tuxedocomputers.com,
        mumblingdrunkard@protonmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.e.box@intel.com,
        yunying.sun@intel.com
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230104154511.GA1071195@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104145032.GA1069244@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 08:50:32AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
> > Hi Bjorn,
> > 
> > Happy new year!
> > 
> > We found some PCI issues with the latest 6.2-rc2.
> > 
> > - Using the lspci -xxxx, the extended PCI config space of all PCI
> > devices are missed with the latest 6.2-rc2. The system we used had 932
> > PCI devices, at least 800 which have extended space as seen when booted
> > into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> > - The drivers which rely on the information in the extended PCI config
> > space don't work anymore. We have confirmed that the perf uncore driver
> > (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> > work in 6.2-rc2. There could be more drivers which are impacted.
> > 
> > After a bisect, we found the regression is caused by the below commit
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> > After reverting the commit, the issues are gone.
> > 
> > Could you please take a look at the issues?
> 
> Certainly.  Can you capture the complete dmesg log, please?

Thanks!  Comparing v5.19 and v6.2-rc2, I see these:

  --- v5.19
  +++ v6.2-rc2

  +efi: Remove mem458: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
  +e820: remove [mem 0x80000000-0x8fffffff] reserved
  -PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
  +PCI: not using MMCONFIG
  +PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
  +[Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
  +PCI: not using MMCONFIG
   system 00:01: [mem 0xff000000-0xffffffff] has been reserved
   system 00:02: [mem 0xfd000000-0xfd69ffff] could not be reserved
   system 00:02: [mem 0xfd6c0000-0xfd6cffff] has been reserved
   system 00:02: [mem 0xfd6f0000-0xfdffffff] has been reserved
   system 00:02: [mem 0xfe000000-0xfe01ffff] could not be reserved
   system 00:02: [mem 0xfe200000-0xfe7fffff] has been reserved
   system 00:02: [mem 0xff000000-0xffffffff] has been reserved

I think this is a firmware defect.  MCFG says the ECAM space is at
[mem 0x80000000-0x8fffffff].  Per the PCI Firmware Spec, r3.3, Note 2
of Table 4-2, this space should be reserved by a motherboard resource,
i.e., a PNP0C02 device (which would appear as "system 00:01" or
similar above) with _CRS that includes [mem 0x80000000-0x8fffffff].

This firmware supplies an EfiMemoryMappedIO region
[0x80000000-0x8fffffff] for the ECAM space (this could be confirmed by
adding "efi=debug"), and the bootloader or EFI stub converted that to
an E820 entry that Linux consumes.

On v5.19, Linux treated that EfiMemoryMappedIO region as a reservation
of the ECAM space, but starting with v6.2-rc1, Linux removes
EfiMemoryMappedIO regions from E820.

My understanding is that EfiMemoryMappedIO tells the OS to map the
area for use by runtime services, but is not intended to prevent the
OS from using the area.  Some platforms use EfiMemoryMappedIO for PCI
host bridge apertures, and of course the OS needs to use those.

If your firmware folks disagree and think Linux should be able to
figure this out differently, I would love to have a conversation about
how to do this.

Bjorn

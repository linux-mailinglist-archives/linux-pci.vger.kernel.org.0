Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482037F001C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Nov 2023 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjKROVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Nov 2023 09:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKROVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Nov 2023 09:21:52 -0500
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB488F;
        Sat, 18 Nov 2023 06:21:47 -0800 (PST)
Date:   Sat, 18 Nov 2023 15:21:43 +0100
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Manciulea <manciuleas@protonmail.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231118142143.GA14101@polanet.pl>
References: <20231103191858.GA163196@bhelgaas>
 <20231109184405.GA488882@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20231109184405.GA488882@bhelgaas>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 09, 2023 at 12:44:05 -0600, Bjorn Helgaas wrote:

>> https://bugzilla.kernel.org/show_bug.cgi?id=218050
>> 
>> I think the problem is that the MMCONFIG region is at
>> [mem 0x80000000-0x8fffffff], and that is *also* included in one of the
>> host bridge windows reported via _CRS:
>> 
>>   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>>   pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]
>> 
>> I'll try to figure out how to deal with that.  In the meantime, would
>> you mind attaching the contents of /proc/iomem to the bugzilla?  I
> 
> I attached a debug patch to both bugzilla entries.  If you could
> attach the "acpidump" output and (if practical) boot a kernel with the
> debug patch and attach the dmesg logs, that would be great.

I've posted the files. There are signs of buggy BIOS, but I don't expect
any firmware update to be released for this hw anymore.

DMI: Supermicro X9DRi-LN4+/X9DR3-LN4+/X9DRi-LN4+/X9DR3-LN4+, BIOS 3.4 11/20/2019

.text .data .bss are not marked as E820_TYPE_RAM!
tboot: non-0 tboot_addr but it is not of type E820_TYPE_RESERVED

DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000df243000-0x00000000df251fff], contact BIOS vendor for fixes
DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000000df243000-0x00000000df251fff]



BTW is there a reason for this logging discrepancy?

efi: Remove mem173: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
efi: Not removing mem71: MMIO range=[0xe0000000-0xefffffff] (262144KB) from e820 map

efi: Not removing mem74: MMIO range=[0xff000000-0xffffffff] (16384KB) from e820 map
efi: Remove mem176: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map

This is arch/x86/platform/efi/efi.c:
static void __init efi_remove_e820_mmio(void)

Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) ... size >> 20
Not removing mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluKB) ... size >> 10

-- 
Tomasz Pala <gotar@pld-linux.org>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA12447E0D6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhLWJ1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 04:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhLWJ1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 04:27:19 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050BC061401;
        Thu, 23 Dec 2021 01:27:19 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C010522246;
        Thu, 23 Dec 2021 10:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1640251636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlMDJ9bXqxykliuXyFIOvVoMPRwjLuBybvKEe/SqbUk=;
        b=Ds/DAzbwBso52saig2DEac2R4aIvhEuSvqPkoTAm1T3t7wIODivddoIjTk4gKwpTOgyqgQ
        vZ0M847HjhMQXYxXwc6ojzp6BWp+2MWlCDfPd+gUb77AqyttirpbHl9WXkh3LGFX01HuVA
        OiCMLg97ao3XYo1joApgu2CIJoHIPXY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Dec 2021 10:27:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <20211221174808.GA1094860@bhelgaas>
References: <20211221174808.GA1094860@bhelgaas>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <39ecedffaf8e2ee931379de7e2f7924f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am 2021-12-21 18:48, schrieb Bjorn Helgaas:
> [+to Jesse, Tony for Intel advice;
> beginning of thread:
> https://lore.kernel.org/all/20201230185317.30915-1-michael@walle.cc/]
> 
> On Mon, Dec 20, 2021 at 06:43:03PM +0100, Michael Walle wrote:
>> ...
>> ping #4
>> 
>> In a few days this is a year old. Please have a look at it and
>> either add my quirk patch or apply your patch. This is still
>> breaking i210 on my board.
>> 
>> TBH, this is really frustrating.
> 
> You are right to be frustrated.  I'm very sorry that I have dropped
> the ball on this.  Thanks for reminding me *again*.
> 
> I think we agree that this looks like an I210 defect.  I210 should
> ignore the ROM BAR contents unless PCI_ROM_ADDRESS_ENABLE is set.  It
> would be great if an Intel person could confirm/deny this and supply
> an erratum reference and verify the affected device IDs.
> 
> It seems that when the BARs are programmed like this:
> 
>   BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
>   BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
>   ROM:   0x40200000 (disabled) [size=1M]
> 
> networking doesn't work at all and the transmit queue times out.
> 
> Linux assigns non-overlapping address space to the ROM BAR, but
> pci_std_update_resource() currently doesn't update the BAR itself
> unless it is enabled.
> 
> My proposal [1] worked around the defect by always updating the BAR,
> but there's no clue that this covers up the I210 issue, so it remains
> as sort of a land mine.  A future change could re-expose the problem,
> so I don't think this was a good approach.
> 
> Your original patch [2] makes it clear that it's an issue with I210,
> but there's an implicit connection between the normal BAR update path
> (which skips the actual BAR write) and the quirk that does the BAR
> write:
> 
>   <enumeration resource assignment>
>     ...
>       pci_assign_resource
>         pci_update_resource
>           pci_std_update_resource
>             if (ROM && ROM-disabled)
>               return
>             pci_write_config_dword      # ROM BAR update (skipped)
> 
>   pci_fixup_write_rom_bar               # final fixup
>     pci_write_config_dword              # ROM BAR update
> 
> In the boot-time resource assignment path, this works fine, but if
> pci_assign_resource() is called from pci_map_rom(), the fixup will not
> happen, so we could still have problem.

I'm not sure I follow. pci_map_rom() should work fine. That was also
the workaround IIRC, that is, enable the rom via sysfs. pci_map_rom()
will call pci_enable_rom(), which should be the same as the fixup.
If memory serves correctly, that is where I shamelessly copied the
code from ;)

btw. the problem is not in pci_assign_resource() which assigns the
correct offsets, but that they are not written to the PCI card.
Eg. see lspci:

# lspci -s 2:1:0 -v
0002:01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network 
Connection (rev 03)
	Subsystem: Hewlett-Packard Company Ethernet I210-T1 GbE NIC
	Flags: bus master, fast devsel, latency 0, IRQ 34, IOMMU group 8
	Memory at 8840000000 (32-bit, non-prefetchable) [size=1M]
	Memory at 8840200000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 8840100000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-de-ad-ff-ff-be-ef-04
	Capabilities: [1a0] Transaction Processing Hints
	Kernel driver in use: igb
lspci: Unable to load libkmod resources: error -2

# lspci -s 2:1:0 -xx
0002:01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network 
Connection (rev 03)
00: 86 80 33 15 06 04 10 00 03 00 00 02 08 00 00 00
10: 00 00 00 40 00 00 00 00 00 00 00 00 00 00 20 40
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 03 00
30: 00 00 20 40 40 00 00 00 00 00 00 00 22 01 00 00

Note the difference between "Expansion ROM at 8840100000" (assigned
by pci_assign_resource() I guess) and the actual value at offset
0x30: 0x40200000. The latter will be updated either by pci_enable_rom()
or my pci fixup quirk.

> If we tweaked pci_std_update_resource() to take account of this
> defect, I think we could cover that path, too.
> 
> Can you try the patch below?

I tried, but it doesn't work because the fixup function is called
after pci_std_update_resource(), thus dev->rom_bar_overlap is still
0.

Thanks,
-michael

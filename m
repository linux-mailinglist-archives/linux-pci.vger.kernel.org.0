Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1E5FB9D1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJKRkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJKRkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 13:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439A1D335;
        Tue, 11 Oct 2022 10:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3753B80EBA;
        Tue, 11 Oct 2022 17:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A443C433C1;
        Tue, 11 Oct 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665510012;
        bh=KaRRQ0zEo6fkZau+WuXLKCbpNGUQqaK9pTZCEvEomP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aS7WAXPHCjisnrP/cEfZm1Q85BgfdoIusX3DDOhjwaCGBENR9KrlDbWmpu5xj4g8X
         A9vNJay6Q24cH7p9qWC9bv3Z6kc9PgX6HZLH3ohRDmOgm5ZGTFlAuuzg9VSv9MCGaN
         X6qarav9X7EBHUISmhaEXUDdO2vRzJ5zoraY41XRLP79qCGTtLiiGGgj80DzqzlyAx
         Vx08fGNxmdS9fY1Q9oVAK4DA8DdRDbOBcMy2bv+8/KCFLGAgvrwXElJGXlb6auuKas
         MA9LvRtmq3KY5uxf/c56dYGuyo7MlTl2ekMI+DgeWy+MfUDR727r3Yxqx7LYBkt8zW
         otC4QUL7b93Vg==
Date:   Tue, 11 Oct 2022 12:40:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxkernelml@undead.fr,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo
 NL4XLU laptops
Message-ID: <20221011174010.GA3001067@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010150206.142615-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
> Clevo NL4XLU barebones have the same E820 reservation covering
> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
> 
>  BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x6d800000-0xbfffffff window]
> 
> Note how the e820 reservation covers the entire PCI root mem window.
> 
> Add a no_e820 quirk for these models to fix the touchpad not working
> (due to Linux being unable to assign a PCI BAR for the i2c-controller).

I do plan to apply this, but a little food for thought below.

I explored this issue a little bit with the ACPI/UEFI folks (see
https://members.uefi.org/wg/aswg/mail/thread/9265 if you have access).  

One aspect I had glossed over earlier is that on most recent machines,
the "E820 map" Linux uses is actually constructed internally by Linux
based on the UEFI memory map, and that construction conflates several
EFI types into E820_TYPE_RESERVED; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/x86-stub.c?id=v5.19#n576

We don't have a dmesg log with "efi=debug" for this case, but in most
cases where E820 says the entire root mem window is reserved, I think
it's because an EfiMemoryMappedIO entry was converted to
E820_TYPE_RESERVED.

From a response in the ACPI/UEFI discussion:

  The reason EfiMemoryMappedIO[1] exist in the UEFI memory map is to
  request a virtual mapping for UEFI Runtime Services.
  
  For example if the EFI Runtime Service needed to write to FLASH then
  the NOR FLASH would need a mapping. Also the NOR FLASH controller
  might also need a mapping and this could include PCI Config Space if
  needed registers existed in that space.
  
  Thus the EfiMemoryMappedIO entries just exist to pass up the
  EFI_MEMORY_RUNTIME attribute in the UEFI Memory Map. This is the part
  of the contract for UEFI Runtime Service to use virtual mappings
  provided by the OS. So from an OS point of view EfiMemoryMappedIO has
  no other purpose.
  
  [1] UEFI: Table 7-5 Memory Type Usage before ExitBootServices() "Used
  by system firmware to request that a memory-mapped IO region be
  mapped by the OS to a virtual address so it can be accessed by EFI
  runtime services."

So the point here is that Linux currently converts EfiMemoryMappedIO
to E820_TYPE_RESERVED, and that likely attaches more meaning to those
regions than firmware intended.

I'm a little leery of changing that UEFI->E820 conversion because of
other possible implications, but it may be that omitting
EfiMemoryMappedIO entries from the E820 map and keeping the original
"avoid E820 regions" (4dc2287c1805) would also solve this problem.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/x86/pci/acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 2f82480fd430..45ef65d31a40 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
> +
> +	/*
> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
> +	 */
> +	{
> +		.callback = set_no_e820,
> +		.ident = "Clevo NL4XLU Barebone",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
> +		},
> +	},
>  	{}
>  };
>  
> -- 
> 2.37.3
> 

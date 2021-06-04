Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418CA39C3AC
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFDXEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 19:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhFDXEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 19:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F19D61369;
        Fri,  4 Jun 2021 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622847779;
        bh=XO9nv9QXvdaG3dMxlVOsYtl/uCJxC2srzlqSDKoeHe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kjYNDofnJQW7zDju8wzJBK/usLBEDQtqGNg+QixAW+jOi6XGEXsCOzCtm8uBKqaX2
         2kvWA5hB4T9qMYRrL+A4KEaGbDOphdCReGjz0/GQNwe3YFqXFsupbN4djU15YjYlmx
         Vi1FoFZxQkkn804pPf8iewtgfedf7ROB0pw7KGa4KWeAkcVv/m1WEgB1vcImNTN7o5
         KSpoLGtmFQ4CuE7lkYUmlUkzh2yfki2XUxVR8+7yiVfujeJPnsAcjSNZ3RF2hN3zcq
         CB+7SaDhQof1IqLlKWznipThn95f5OGQzfy2IVdIR2SGlHpD2JCRhwwB5Jc06WV2cB
         w59FD5uKQDjqg==
Date:   Fri, 4 Jun 2021 18:02:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org
Subject: Re: [PATCH] PCI: Add quirk for 64-bit DMA on RS690 chipset
Message-ID: <20210604230257.GA2241499@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527214521.23923-1-mikel@mikelr.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc x86]

On Thu, May 27, 2021 at 05:45:21PM -0400, Mikel Rychliski wrote:
> Although the AMD RS690 chipset has 64-bit DMA support, BIOS implementations
> sometimes fail to configure the memory limit registers correctly.

> Currently, the ahci driver has quirks to enable or disable 64-bit DMA
> depending on the BIOS version (see ahci_sb600_enable_64bit() in ahci.c).
> snd_hda_intel always disables 64-bit DMA with the paired SB600 chipset.

This patch applies to RS690.  Is there a connection between SB600 and
RS690?  Trying to figure out why the above two sentences are here.

What is the implication of this patch for ahci_sb600_enable_64bit()
and snd_hda_intel?  (BTW, "git grep snd_hda_intel" turns up no useful
pointers; a specific function name would be more useful.)

> The Acer F690GVM mainboard uses this chipset and a Marvell 88E8056 NIC. The
> sky2 driver attempts to use 64-bit DMA the NIC, which will not work:

"attempts to use 64-bit DMA the NIC" doesn't quite parse.  Maybe
"programs the NIC to use 64-bit DMA"?

> 	sky2 0000:02:00.0: error interrupt status=0x8
> 	sky2 0000:02:00.0 eth0: tx timeout
> 	sky2 0000:02:00.0 eth0: transmit ring 0 .. 22 report=0 done=0
> 
> Avoid the issue by configuring the memory limit registers correctly if the
> BIOS failed to. If the kernel is aware of physical memory above 4GB, but
> the BIOS never configured the PCI host with this information, update the
> register with our value.

I'm guessing RS690 is only applicable for x86.  We do have a bunch of
obviously x86-specific stuff in drivers/pci/quirks.c, but I think this
could probably go in arch/x86/pci/fixup.c, where it won't get compiled
for all the arches that can never use it.

Or it's conceivable it might fit in arch/x86/pci/amd_bus.c, since
there's some code there dealing with the memory map.

> Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> ---
>  drivers/pci/quirks.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dcb229de1acb..cd98a01de908 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5601,3 +5601,47 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +#define RS690_LOWER_TOP_OF_DRAM2	0x30
> +#define RS690_LOWER_TOP_OF_DRAM2_VALID	0x1
> +#define RS690_UPPER_TOP_OF_DRAM2	0x31
> +#define RS690_HTIU_NB_INDEX		0xA8
> +#define RS690_HTIU_NB_INDEX_WR_ENABLE	0x100
> +#define RS690_HTIU_NB_DATA		0xAC
> +
> +/*
> + * Some BIOS implementations support RAM above 4GB, but do not configure the
> + * PCI host to respond to bus master accesses for these addresses. These
> + * implementations set the TOP_OF_DRAM_SLOT1 register correctly, so PCI DMA
> + * works as expected for addresses below 4GB.
> + *
> + * Reference: "AMD RS690 ASIC Family Register Reference Guide" (public)

The NB_TOP_OF_DRAM_SLOT1 section talks about incoming PCI DMA, but
unfortunately the public spec I found (P/N 43372) says nothing at all
about NB_UPPER_TOP_OF_DRAM2.

> + */
> +static void rs690_fix_64bit_dma(struct pci_dev *pdev)
> +{
> +	u32 val = 0;
> +	phys_addr_t top_of_dram = __pa(high_memory - 1) + 1;
> +
> +	if (top_of_dram <= (1ULL << 32))
> +		return;
> +
> +	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
> +				RS690_LOWER_TOP_OF_DRAM2);
> +	pci_read_config_dword(pdev, RS690_HTIU_NB_DATA, &val);
> +
> +	if (val)
> +		return;
> +
> +	pci_info(pdev, "Adjusting top of DRAM to support 64-bit DMA\n");

Maybe include the top_of_dram value in the message?

> +	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
> +		RS690_UPPER_TOP_OF_DRAM2 | RS690_HTIU_NB_INDEX_WR_ENABLE);
> +	pci_write_config_dword(pdev, RS690_HTIU_NB_DATA, top_of_dram >> 32);
> +
> +	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
> +		RS690_LOWER_TOP_OF_DRAM2 | RS690_HTIU_NB_INDEX_WR_ENABLE);
> +	pci_write_config_dword(pdev, RS690_HTIU_NB_DATA,
> +		top_of_dram | RS690_LOWER_TOP_OF_DRAM2_VALID);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS690,
> +			rs690_fix_64bit_dma);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..0a7fe2ed520b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -381,6 +381,7 @@
>  #define PCI_DEVICE_ID_ATI_RS400_166     0x5a32
>  #define PCI_DEVICE_ID_ATI_RS400_200     0x5a33
>  #define PCI_DEVICE_ID_ATI_RS480         0x5950
> +#define PCI_DEVICE_ID_ATI_RS690         0x7910
>  /* ATI IXP Chipset */
>  #define PCI_DEVICE_ID_ATI_IXP200_IDE	0x4349
>  #define PCI_DEVICE_ID_ATI_IXP200_SMBUS	0x4353
> -- 
> 2.13.7
> 

Return-Path: <linux-pci+bounces-514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0648059C8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39645B210F9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D660B9B;
	Tue,  5 Dec 2023 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcuDl8jI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCD63DCC;
	Tue,  5 Dec 2023 16:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC70C43397;
	Tue,  5 Dec 2023 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701793035;
	bh=z37uNL6IIU4NauPVaUDXZWwyCByspD3QAo4UgtuVbOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mcuDl8jI+PwKHmlQ9yZ/pc0f4DAqmj5xvmsYiC6++IzGyRxVSHRQzH4xa0CPA+8Iy
	 1jvmwXwkKKQAjz0R9Nmha+2/D+c4QzcmOJ7yRQRt4Mqlrq4tMmAw62TFU2xt0xuB75
	 CNPZfZMhcE8injQ3wiR+ZniXn81CY+G3ldXqJffuBW+u3iMK8x9xdn+4bgUdapCpyz
	 U4UxrIpjiLgNatf2fRO0R97oJE+jVqj/hCJik0N96zr7F0ZdczlUtrgmVzUFmo+d5a
	 BbBM+QLHbp5KGMGC4WWaobp8wWC2YvdRtvAiZaKDyhJbX/DzXdNO/iknl9slYlFoJk
	 WAIdNKyVhJhvg==
Date: Tue, 5 Dec 2023 10:17:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Message-ID: <20231205161713.GA674824@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205154845.44463-1-mario.limonciello@amd.com>

On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
> introduced checks for ensuring that MCFG table also has memory region
> reservations to ensure no conflicts were introduced from a buggy BIOS.
> 
> This has proceeded over time to add other types of reservation checks
> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
> however says that these checks are only required when the operating system
> doesn't comprehend the firmware region:
> 
> ```
> If the operating system does not natively comprehend reserving the MMCFG
> region, the MMCFG region must be reserved by firmware. The address range
> reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
> reserved by declaring a motherboard resource. For most systems, the
> motherboard resource would appear at the root of the ACPI namespace
> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
> in this case should not be claimed in the root PCI bus’s _CRS. The
> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
> as reserved memory but must always be reported through ACPI as a
> motherboard resource.
> ```

My understanding is that native comprehension would mean Linux knows
how to discover and/or configure the MMCFG base address and size in
the hardware and that Linux would then reserve that region so it's not
used for anything else.

Linux doesn't have that, at least for x86.  It relies on the MCFG
table to discover the MMCFG region, and it relies on PNP0C02 _CRS to
reserve it.

> Running this check causes problems with accessing extended PCI
> configuration space on OEM laptops that don't specify the region in PNP
> resources or in the EFI memory map. That later manifests as problems with
> dGPU and accessing resizable BAR.

Is there a problem report we can reference here?

Does the problem still occur with this series?
https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org

This appeared in linux-next 20231130.

> Similar problems don't exist in Windows 11 with exact same
> laptop/firmware stack, and in discussion with AMD's BIOS team
> Windows doesn't have similar checks.

I would love to know AMD BIOS team's take on this.  Does the BIOS
reserve the MMCFG space in any way?

> As this series of checks was first introduced as a mitigation for buggy
> BIOS before EFI was introduced add a BIOS date range to only enforce the
> checks on hardware that predates the release of Windows 11.

Many of the MMCFG checks in Linux are historical artifacts that are
likely related to Linux defects, not BIOS defects, so I wouldn't
expect to see them in Windows.  But it's hard to remove them now.

> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>       PCI Firmware Specification 3.3
>       Section 4.1.2 MCFG Table Description Note 2
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/pci/mmconfig-shared.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 4b3efaa82ab7..e4594b181ebf 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -570,9 +570,13 @@ static void __init pci_mmcfg_reject_broken(int early)
>  
>  	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>  		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
> -			pr_info(PREFIX "not using MMCONFIG\n");
> -			free_all_mmcfg();
> -			return;
> +			if (dmi_get_bios_year() >= 2021) {
> +				pr_info(PREFIX "MMCONFIG wasn't reserved by ACPI or EFI\n");

I think this leads to using the MMCONFIG area without reserving it
anywhere, so we may end up assigning that space to something else,
which won't work, i.e., the problem described here:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=5cef3014e02d

> +			} else {
> +				pr_info(PREFIX "not using MMCONFIG\n");
> +				free_all_mmcfg();
> +				return;
> +			}
>  		}
>  	}
>  }
> -- 
> 2.34.1
> 


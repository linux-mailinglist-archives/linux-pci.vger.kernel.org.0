Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25166491D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjAJSSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjAJSR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:17:27 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D6DEF;
        Tue, 10 Jan 2023 10:15:54 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id f305e4161af3989d; Tue, 10 Jan 2023 19:15:52 +0100
Received: from kreacher.localnet (unknown [213.134.183.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 113FD262495C;
        Tue, 10 Jan 2023 19:15:51 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan J Williams <dan.j.williams@intel.com>,
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
        Benoit =?ISO-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
Date:   Tue, 10 Jan 2023 19:15:50 +0100
Message-ID: <1860250.tdWV9SEqCh@kreacher>
In-Reply-To: <20230110180243.1590045-3-helgaas@kernel.org>
References: <20230110180243.1590045-1-helgaas@kernel.org> <20230110180243.1590045-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.108
X-CLIENT-HOSTNAME: 213.134.183.108
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeefrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedruddtkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepvddupdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopehkrghnrdhlihgrnhhgsehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepthhonhihrdhluhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdgvrdgsohigsehinhhtvghlrdgtohhmpdhrtghpthhtohephihunhihihhnghdrshhunhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhiohhvrghnnhhirdgtrggsihguughusehinhhtvghlrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugihkvghrnhgvlhhmlhesuhhnuggvrggurdhfrhdprhgtphhtthhopehkjhhhrghmsghrihgtkhesghhmrghilhdrtghomhdprhgtphhtthhopedvlhhprhgsvgejkeesughutghkrdgtohhmpdhrtghpthhtohepnhhitghhohhlrghsrdhjohhhnhhsohhnqdhophgvnhhsohhurhgtvgesohhuthhlohhokhdrtghomhdrrghupdhrtghpthhtohepsggvnhhoihhtghestghovghushdrtggrpdhrtghpthhtohepfihsvgesthhugigvughotghomhhpuhhtvghrshdrtghomhdprhgtphhtthhopehmuhhmsghlihhnghgurhhunhhkrghrugesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqk
 hgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=21 Fuz1=21 Fuz2=21
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, January 10, 2023 7:02:43 PM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Normally we reject ECAM space unless it is reported as reserved in the E820
> table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> 
> Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> normally converted to an E820 entry by a bootloader or EFI stub.
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> E820 entries that correspond to EfiMemoryMappedIO regions because some
> other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> E820 entries prevent Linux from allocating BAR space for hot-added devices.
> 
> Allow use of ECAM for extended config space when the region is covered by
> an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> _CRS.
> 
> Reported by Kan Liang, Tony Luck, and Giovanni Cabiddu.
> 
> Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Reported-by: Tony Luck <tony.luck@intel.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/pci/mmconfig-shared.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index cd16bef5f2d9..da4b6e8e9df0 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/bitmap.h>
> @@ -442,6 +443,32 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  	return mcfg_res.flags;
>  }
>  
> +static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
> +{
> +#ifdef CONFIG_EFI
> +	efi_memory_desc_t *md;
> +	u64 size, mmio_start, mmio_end;
> +
> +	for_each_efi_memory_desc(md) {
> +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> +			size = md->num_pages << EFI_PAGE_SHIFT;
> +			mmio_start = md->phys_addr;
> +			mmio_end = mmio_start + size;
> +
> +			/*
> +			 * N.B. Caller supplies (start, start + size),
> +			 * so to match, mmio_end is the first address
> +			 * *past* the EFI_MEMORY_MAPPED_IO area.
> +			 */
> +			if (mmio_start <= start && end <= mmio_end)
> +				return true;
> +		}
> +	}
> +#endif
> +
> +	return false;
> +}
> +
>  typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
> @@ -513,6 +540,10 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
>  			       "MMCONFIG at %pR not reserved in "
>  			       "ACPI motherboard resources\n",
>  			       &cfg->res);
> +
> +		if (is_mmconf_reserved(is_efi_mmio, cfg, dev,
> +				       "EfiMemoryMappedIO"))
> +			return true;
>  	}
>  
>  	/*
> 





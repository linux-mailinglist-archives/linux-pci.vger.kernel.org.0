Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8551DDE6
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350324AbiEFQy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346165AbiEFQy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 12:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EE633A9;
        Fri,  6 May 2022 09:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD3761FEF;
        Fri,  6 May 2022 16:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90B5C385AC;
        Fri,  6 May 2022 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651855872;
        bh=JLOPe7is6n6Rmcoo4s0ssyBJhamRXROIw2bTQJTX4u4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qElFZ11li7gXN1H+bAlgkcrSrCJ0uRCkHCB9jwQKD/r9hOaTKUVZobEeLhILWPDY8
         QQCwWagoimnRG3zfDjEBKY5HsiTq3IroD7PBtnndHQ4gdDzRItrc99Mj2SGhXcEAqc
         MrTgLn3NEt5iRtGt21i6HDUfU9/EzPbSuL1PWh2zpfZg3/mZseoHDWS2CBxJb5fF9K
         2n/HcLahg7iU3X3F6At9IbCWgpN1exT94uIwJA/A50xm4s1GvXsZNaP0cCt3i8EId0
         nZM6SGEk2hPyl1ZZIgt8aQtjOp1yxaK9dBhftQH9fifYuHtBmuJ92JU6QAh49ILwQF
         g7pejc3Hlbhxw==
Date:   Fri, 6 May 2022 11:51:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Message-ID: <20220506165110.GA509329@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505152016.5059-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
> Some BIOS-es contain bugs where they add addresses which are already
> used in some other manner to the PCI host bridge window returned by
> the ACPI _CRS method. To avoid this Linux by default excludes
> E820 reservations when allocating addresses since 2010, see:
> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space").
> 
> Recently (2019) some systems have shown-up with E820 reservations which
> cover the entire _CRS returned PCI bridge memory window, causing all
> attempts to assign memory to PCI BARs which have not been setup by the
> BIOS to fail. For example here are the relevant dmesg bits from a
> Lenovo IdeaPad 3 15IIL 81WE:
> 
>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> The ACPI specifications appear to allow this new behavior:
> 
> The relationship between E820 and ACPI _CRS is not really very clear.
> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
> 
>   This range of addresses is in use or reserved by the system and is
>   not to be included in the allocatable memory pool of the operating
>   system's memory manager.
> 
> and it may be used when:
> 
>   The address range is in use by a memory-mapped system device.
> 
> Furthermore, sec 15.2 says:
> 
>   Address ranges defined for baseboard memory-mapped I/O devices, such
>   as APICs, are returned as reserved.
> 
> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
> and its apertures are in use and certainly should not be included in
> the general allocatable pool, so the fact that some BIOS-es reports
> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
> 
> So it seems that the excluding of E820 reserved addresses is a mistake.
> 
> Ideally Linux would fully stop excluding E820 reserved addresses,
> but then various old systems will regress.
> Instead keep the old behavior for old systems, while ignoring
> the E820 reservations for any systems from now on.
> 
> Old systems are defined here as BIOS year < 2018, this was chosen to
> make sure that pci_use_e820 will not be set on the currently affected
> systems, the oldest known one is from 2019.
> 
> Testing has shown that some newer systems also have a bad _CRS return.
> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
> from the bridge window on these systems.
> 
> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> the BIOS year + DMI matching logic.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugs.launchpad.net/bugs/1878279
> BugLink: https://bugs.launchpad.net/bugs/1931715
> BugLink: https://bugs.launchpad.net/bugs/1932069
> BugLink: https://bugs.launchpad.net/bugs/1921649
> Cc: Benoit Grégoire <benoitg@coeus.ca>
> Cc: Hui Wang <hui.wang@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> +	 * Ideally Linux would fully stop using E820 reservations, but then
> +	 * various old systems will regress. Instead keep the old behavior for
> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
> +	 */
> +	if (year >= 0 && year < 2018)
> +		pci_use_e820 = true;

How did you pick 2018?  Prior to this patch, we used E820 reservations
for all machines.  This patch would change that for 2019-2022
machines, so there's a risk of breaking some of them.

I'm hesitant about changing the behavior for machines already in the
field because if they were tested at all with Linux, it was without
this patch.  So I would lean toward preserving the current behavior
for BIOS year < 2023.

> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 9e1e6b8d8876..7e6f79aab6a8 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>  	} else if (!strcmp(str, "nocrs")) {
>  		pci_probe |= PCI_ROOT_NO_CRS;
>  		return NULL;
> +	} else if (!strcmp(str, "use_e820")) {
> +		pci_probe |= PCI_USE_E820;

I think we should add_taint(TAINT_FIRMWARE_WORKAROUND) for both these
cases.

We probably should do it for *all* the parameters here, but that would
be a separate discussion.

> +		return NULL;
> +	} else if (!strcmp(str, "no_e820")) {
> +		pci_probe |= PCI_NO_E820;
> +		return NULL;
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  	} else if (!strcmp(str, "big_root_window")) {
>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
> -- 
> 2.36.0
> 

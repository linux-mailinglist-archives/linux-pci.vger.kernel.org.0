Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFD423272
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhJEU6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhJEU6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 16:58:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAAFC061749;
        Tue,  5 Oct 2021 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=kmomRx0MWiWwMhds3Qf0OPR0SiP4275qlsODlT8KAeY=; b=rXkBoSln3QjUtM+muTTXybBqLI
        62T9XF2/fxutRkU7qcpza92mn+wfv5oRKTauJJKaRebgbl6v79VrOYgbu6IFhWC5RtcADzrDJh/5f
        MrChG4q/h5VVfOAnfW8C3/TRIMsypAtOXRBc0a1CGGaDQzWUWy35V7habfBDIpgj9illAeiB87x3k
        CE5h/V7CO0lsBnoxbxWuAwPXzRN4H9HPe1u5bRvQQ3k1EhClrJgMiHRwtWg+Rvrpedek+bAbEH56p
        BQ7SrX/hTsfcEMl86I0lyDfGIV/A6aGoORBtFujjGIbfsSTR9497+WWHn/gtvmYDnW5XDHF/u501U
        ymm8TkGg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXrTx-00BsC6-Ln; Tue, 05 Oct 2021 20:56:13 +0000
Subject: Re: [PATCH] x86/PCI: Add pci=no_e820 cmdline option to ignore E820
 reservations for bridge windows
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211005150956.303707-1-hdegoede@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0320b854-327b-397f-ba26-e69ea321dd1b@infradead.org>
Date:   Tue, 5 Oct 2021 13:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005150956.303707-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/21 8:09 AM, Hans de Goede wrote:
> Some BIOS-es contain a bug where they add addresses which map to system RAM
> in the PCI bridge memory window returned by the ACPI _CRS method, see
> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space").
> 
> To avoid this Linux by default excludes E820 reservations when allocating
> addresses since 2010. Windows however ignores E820 reserved regions for PCI
> mem allocations, instead it avoids these BIOS bugs by allocates addresses
> top-down.
> 
> Recently (2020) some systems have shown-up with E820 reservations which
> cover the entire _CRS returned PCI bridge memory window, causing all
> attempts to assign memory to PCI bars which have not been setup by the BIOS
> to fail. For example here are the relevant dmesg bits from a
> Lenovo IdeaPad 3 15IIL 81WE:
> 
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> Add a pci=no_e820 option which allows disabling the E820 reservations
> check, while still honoring the _CRS provided resources.
> 
> And automatically enable this on the "Lenovo IdeaPad 3 15IIL05" to fix
> the touchpad not working on this laptop.
> 
> Also add a pci=use_e820 option to allow overruling the results of
> DMI quirks defaulting to no_e820 on some systems.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans,

Please update Documentation/admin-guide/kernel-parameters.txt also.

> ---
>   arch/x86/include/asm/pci_x86.h | 10 ++++++++++
>   arch/x86/kernel/resource.c     | 17 +++++++++++++++++
>   arch/x86/pci/acpi.c            | 26 ++++++++++++++++++++++++++
>   arch/x86/pci/common.c          |  6 ++++++
>   4 files changed, 59 insertions(+)
> 

> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9b9fb7882c20..6069d86021f0 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c

> @@ -23,11 +24,27 @@ static void resource_clip(struct resource *res, resource_size_t start,
>   		res->start = end + 1;
>   }
>   
> +/*
> + * Some BIOS-es contain a bug where they add addresses which map to system RAM
> + * in the PCI bridge memory window returned by the ACPI _CRS method, see
> + * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
> + * To avoid this Linux by default excludes E820 reservations when allocating
> + * addresses since 2010. Windows however ignores E820 reserved regions for PCI
> + * mem allocations, instead it avoids these BIOS bugs by allocates addresses
> + * top-down.
> + * Recently (2020) some systems have shown-up with E820 reservations which
> + * cover the entire _CRS returned PCI bridge memory window, causing all
> + * attempts to assign memory to PCI bars which have not been setup by the BIOS

                     preferably:        BARs

> + * to fail. The pci_use_e820 check is there as a workaround for these systems.
> + */



thanks.
-- 
~Randy

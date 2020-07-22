Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2E22A2ED
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGVXTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 19:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVXTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 19:19:32 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566B4207BB;
        Wed, 22 Jul 2020 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595459971;
        bh=Oiq+K8SOngY6f3NFNsUo76+Kiqk3fEginVJvQHM8cOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1ZGjGy9u+OuLMV8lVWX+O52Z81EyGKFD8g2Fmg5mNJ5+PCNGBMSE+bp1e1JHZKjTO
         c8o5n6AEoJtPKpNJdbPpxrswYjgHd4o1S9lQ0wi1WIV1OyetlRMe9uPoUsRt6XpKmA
         BUlZ+yeojM69nbZ4GOVUCFzShdyZu92fPY0EW5EQ=
Date:   Wed, 22 Jul 2020 18:19:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
Message-ID: <20200722231929.GA1314067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722001513.298315-1-jusual@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> Scanning for PCI devices at boot takes a long time for KVM guests. It
> can be reduced if KVM will handle all configuration space accesses for
> non-existent devices without going to userspace [1]. But for this to
> work, all accesses must go through MMCONFIG.
> This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> guests making MMCONFIG the default access method.

The above *looks* like it's intended to be two paragraphs, which would
be easier to read with a blank line between.

The last sentence should say what the patch actually *does*, e.g.,
"Use pci_mmcfg as raw_pci_ops ..."

> [1] https://lkml.org/lkml/2020/5/14/936

Please use a lore.kernel.org URL instead because it's more usable and
I'd rather depend on kernel.org than lkml.org.

> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  arch/x86/pci/direct.c      | 5 +++++
>  arch/x86/pci/mmconfig_64.c | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> index a51074c55982..8ff6b65d8f48 100644
> --- a/arch/x86/pci/direct.c
> +++ b/arch/x86/pci/direct.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/dmi.h>
> +#include <linux/kvm_para.h>
>  #include <asm/pci_x86.h>
>  
>  /*
> @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
>  {
>  	if (type == 0)
>  		return;
> +
> +	if (raw_pci_ext_ops && kvm_para_available())
> +		return;
>  	printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
>  		 type);
>  	if (type == 1) {
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 0c7b6e66c644..9eb772821766 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/bitmap.h>
> +#include <linux/kvm_para.h>
>  #include <linux/rcupdate.h>
>  #include <asm/e820/api.h>
>  #include <asm/pci_x86.h>
> @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
>  		}
>  
>  	raw_pci_ext_ops = &pci_mmcfg;
> +	if (kvm_para_available())
> +		raw_pci_ops = &pci_mmcfg;

The idea of using MMCONFIG for *all* config space, not just extended
config space, makes sense to me, although the very long discussion at
https://lore.kernel.org/lkml/20071225032605.29147200@laptopd505.fenrus.org/
makes me wary.  Of course I realize you're talking specifically about
KVM, not doing this in general.

But it doesn't seem right to make this specific to KVM, since it's not
obvious to me that there's a basis in PCI for making this distinction.

>  	return 1;
>  }
> -- 
> 2.25.4
> 

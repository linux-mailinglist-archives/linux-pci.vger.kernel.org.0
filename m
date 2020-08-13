Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52F3243FB7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMUOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 16:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgHMUOe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 16:14:34 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756FE20675;
        Thu, 13 Aug 2020 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597349673;
        bh=hGkSuc10QjCyDoZEHEmNWkXKjIZx24dgsOUsDjIFXac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BChaOOfNuZg5/4N1BNXB+Z99vuLu0ZszO2nk00pSmSPJ0tcwq3tJgDn4gXnFJffRN
         48H3yKKRUjd+b/HN6D2PZnKzzvEI6SDSWTvYG21n2eu4OLdoRMtr90gelFozvs1rrV
         b3I34kpeXcXMZ0uB9utsG7UGQVqJ9ZgqecjLlrLU=
Date:   Thu, 13 Aug 2020 15:14:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, jsbarnes@google.com,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is
 not enabled
Message-ID: <20200813201432.GA1185885@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andy]

On Thu, Aug 13, 2020 at 12:58:38PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error when CONFIG_ACPI is not set/enabled by adding
> the header file <asm/acpi.h> which contains a stub for the function
> in the build error.
> 
> ../arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
> ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
>   acpi_noirq_set();

Fixes: a912a7584ec3 ("x86/platform/intel-mid: Move PCI initialization to arch_init()")

Possibly
Cc: stable@vger.kernel.org	# v4.16+

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> ---
> Found in linux-next, but applies to/exists in mainline also.
> 
> Alternative.1: X86_INTEL_MID depends on ACPI
> Alternative.2: drop X86_INTEL_MID support
> 
>  arch/x86/pci/intel_mid_pci.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20200813.orig/arch/x86/pci/intel_mid_pci.c
> +++ linux-next-20200813/arch/x86/pci/intel_mid_pci.c
> @@ -33,6 +33,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/io_apic.h>
>  #include <asm/intel-mid.h>
> +#include <asm/acpi.h>
>  
>  #define PCIE_CAP_OFFSET	0x100
>  
> 

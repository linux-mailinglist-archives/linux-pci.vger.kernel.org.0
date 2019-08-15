Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69A08E93C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfHOKsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 06:48:10 -0400
Received: from foss.arm.com ([217.140.110.172]:41804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfHOKsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 06:48:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2DAA28;
        Thu, 15 Aug 2019 03:48:08 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685A23F694;
        Thu, 15 Aug 2019 03:48:07 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:47:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Message-ID: <20190815104748.GB9511@e121166-lin.cambridge.arm.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 12, 2019 at 08:53:19AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when building almost-allmodconfig but with SYSFS
> not set (not enabled).  Fixes these build errors:
> 
> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> 
> drivers/pci/slot.o is only built when SYSFS is enabled, so
> pci-hyperv.o has an implicit dependency on SYSFS.
> Make that explicit.
> 
> Also, depending on X86 && X86_64 is not needed, so just change that
> to depend on X86_64.
> 
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
> information")

Fixed line break on Fixes tag, FYI.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jake Oshins <jakeo@microsoft.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org
> Cc: Dexuan Cui <decui@microsoft.com>
> ---
> v3: corrected Fixes: tag [Dexuan Cui <decui@microsoft.com>]
>     This is the Microsoft-preferred version of the patch.
> 
>  drivers/pci/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/hv for v5.4.

Thanks,
Lorenzo

> --- lnx-52.orig/drivers/pci/Kconfig
> +++ lnx-52/drivers/pci/Kconfig
> @@ -181,7 +181,7 @@ config PCI_LABEL
>  
>  config PCI_HYPERV
>          tristate "Hyper-V PCI Frontend"
> -        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> +        depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
>          help
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
> 
> 

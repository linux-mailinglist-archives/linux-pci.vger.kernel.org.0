Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35854F2AEB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKGJls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:41:48 -0500
Received: from foss.arm.com ([217.140.110.172]:52772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGJls (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:41:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D388F46A;
        Thu,  7 Nov 2019 01:41:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391723F71A;
        Thu,  7 Nov 2019 01:41:47 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:41:45 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5/5] PCI: Allow building PCIe things without PCIEPORTBUS
Message-ID: <20191107094144.GT9723@e119886-lin.cambridge.arm.com>
References: <20191106222420.10216-1-helgaas@kernel.org>
 <20191106222420.10216-6-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-6-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:21PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some things in drivers/pci/pcie (aspm.c and ptm.c) do not depend on the
> PCIe portdrv, so we should be able to build them even if PCIEPORTBUS is not
> selected.  Remove the PCIEPORTBUS guard from building pcie/.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 28cdd8c0213a..522d2b974e91 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
>  				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
>  				   setup-bus.o vc.o mmap.o setup-irq.o
>  
> +obj-$(CONFIG_PCI)		+= pcie/
> +
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)		+= proc.o
>  obj-$(CONFIG_SYSFS)		+= slot.o
> @@ -15,7 +17,6 @@ endif
>  
>  obj-$(CONFIG_OF)		+= of.o
>  obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
> -obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
>  obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
>  obj-$(CONFIG_PCI_MSI)		+= msi.o
>  obj-$(CONFIG_PCI_ATS)		+= ats.o

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

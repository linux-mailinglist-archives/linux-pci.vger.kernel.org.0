Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC28010B32B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfK0Q0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 11:26:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0Q0U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 11:26:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90AC30E;
        Wed, 27 Nov 2019 08:26:19 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943073F68E;
        Wed, 27 Nov 2019 08:26:18 -0800 (PST)
Date:   Wed, 27 Nov 2019 16:26:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>, eswara.kota@linux.intel.com,
        bhelgaas@google.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: linux-next: Tree for Nov 27
 (drivers/pci/controller/dwc/pcie-designware-host.c)
Message-ID: <20191127162614.GA6423@e121166-lin.cambridge.arm.com>
References: <20191127155717.400a60de@canb.auug.org.au>
 <fc3586ef-a0a1-84b3-2e0e-b8ba5c41f229@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc3586ef-a0a1-84b3-2e0e-b8ba5c41f229@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 27, 2019 at 07:55:57AM -0800, Randy Dunlap wrote:
> On 11/26/19 8:57 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do not add any material for v5.6 to your linux-next included
> > trees until after v5.5-rc1 has been released.
> > 
> > Changes since 20191126:
> > 
> 
> on i386:
> # CONFIG_PCI_MSI is not set
> 
> 
> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
> 
> and related build errors:

Dilip,

I will have to drop your series which unfortunately forces Bjorn to pull
my pci/dwc branch again, I don't think there is time for fixing it,
given release timing and Stephen's request above.

Lorenzo

> ../drivers/pci/controller/dwc/pcie-designware-host.c:72:15: error: variable ‘dw_pcie_msi_domain_info’ has initializer but incomplete type
>  static struct msi_domain_info dw_pcie_msi_domain_info = {
>                ^~~~~~~~~~~~~~~
> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:3: error: ‘struct msi_domain_info’ has no member named ‘flags’
>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>    ^~~~~
> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:12: error: ‘MSI_FLAG_USE_DEF_DOM_OPS’ undeclared here (not in a function); did you mean ‘SIMPLE_DEV_PM_OPS’?
>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>             ^~~~~~~~~~~~~~~~~~~~~~~~
>             SIMPLE_DEV_PM_OPS
> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:39: error: ‘MSI_FLAG_USE_DEF_CHIP_OPS’ undeclared here (not in a function); did you mean ‘MSI_FLAG_USE_DEF_DOM_OPS’?
>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>                                        MSI_FLAG_USE_DEF_DOM_OPS
> ../drivers/pci/controller/dwc/pcie-designware-host.c:74:6: error: ‘MSI_FLAG_PCI_MSIX’ undeclared here (not in a function); did you mean ‘SS_FLAG_BITS’?
>       MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>       ^~~~~~~~~~~~~~~~~
>       SS_FLAG_BITS
> ../drivers/pci/controller/dwc/pcie-designware-host.c:74:26: error: ‘MSI_FLAG_MULTI_PCI_MSI’ undeclared here (not in a function); did you mean ‘MSI_FLAG_PCI_MSIX’?
>       MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>                           ^~~~~~~~~~~~~~~~~~~~~~
>                           MSI_FLAG_PCI_MSIX
> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: warning: excess elements in struct initializer
>   .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>            ^
> ../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: note: (near initialization for ‘dw_pcie_msi_domain_info’)
> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:3: error: ‘struct msi_domain_info’ has no member named ‘chip’
>   .chip = &dw_pcie_msi_irq_chip,
>    ^~~~
> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: warning: excess elements in struct initializer
>   .chip = &dw_pcie_msi_irq_chip,
>           ^
> ../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: note: (near initialization for ‘dw_pcie_msi_domain_info’)
> ../drivers/pci/controller/dwc/pcie-designware-host.c: In function ‘dw_pcie_allocate_domains’:
> ../drivers/pci/controller/dwc/pcie-designware-host.c:267:19: error: implicit declaration of function ‘pci_msi_create_irq_domain’; did you mean ‘pci_msi_get_device_domain’? [-Werror=implicit-function-declaration]
>   pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
>                    pci_msi_get_device_domain
> ../drivers/pci/controller/dwc/pcie-designware-host.c:267:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>                  ^
> ../drivers/pci/controller/dwc/pcie-designware-host.c: At top level:
> ../drivers/pci/controller/dwc/pcie-designware-host.c:72:31: error: storage size of ‘dw_pcie_msi_domain_info’ isn’t known
>  static struct msi_domain_info dw_pcie_msi_domain_info = {
>                                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

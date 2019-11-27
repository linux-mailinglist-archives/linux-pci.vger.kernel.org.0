Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00310B2CD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0P4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 10:56:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0P4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 10:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3iLIidMssZl9d6PrGezfyNaB0BMUcnGVIulOgI4kuAE=; b=PzOTKkC7unuoES0OGlMuf21uf
        xroZeZ83LZ/s43XO2hmGm6VZOm3wxokxseSI+a/nkev26HRxbhxNCXqzuqzUrC2jgMAalU8W0brsQ
        ZsryDSyHaq2yJ/Y4MsvRbQPGi6o45CAG89PTE257mW93scnxt2sKj8XxzhkT+uEl8nmub88ZFLZcG
        Y3CrpvqOESne3xp1NItxbfhvzvtxXxcdggKZfUkda/ruNVvc/u2mPlRbzzEgaj+Rnex/OtuuENONY
        UZDqdgOdx3Kc+OkWT2uz1/vbYU3ObLUnHcKMH9nNQQ9yAZyjh4EWgcZ8tRwb4KPCg9s9Wjcdx3jjH
        L+dHlHPLA==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZzfb-0000rZ-Tn; Wed, 27 Nov 2019 15:56:00 +0000
Subject: Re: linux-next: Tree for Nov 27
 (drivers/pci/controller/dwc/pcie-designware-host.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20191127155717.400a60de@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc3586ef-a0a1-84b3-2e0e-b8ba5c41f229@infradead.org>
Date:   Wed, 27 Nov 2019 07:55:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127155717.400a60de@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/26/19 8:57 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material for v5.6 to your linux-next included
> trees until after v5.5-rc1 has been released.
> 
> Changes since 20191126:
> 

on i386:
# CONFIG_PCI_MSI is not set


WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])

and related build errors:

../drivers/pci/controller/dwc/pcie-designware-host.c:72:15: error: variable ‘dw_pcie_msi_domain_info’ has initializer but incomplete type
 static struct msi_domain_info dw_pcie_msi_domain_info = {
               ^~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:73:3: error: ‘struct msi_domain_info’ has no member named ‘flags’
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
   ^~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:73:12: error: ‘MSI_FLAG_USE_DEF_DOM_OPS’ undeclared here (not in a function); did you mean ‘SIMPLE_DEV_PM_OPS’?
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
            ^~~~~~~~~~~~~~~~~~~~~~~~
            SIMPLE_DEV_PM_OPS
../drivers/pci/controller/dwc/pcie-designware-host.c:73:39: error: ‘MSI_FLAG_USE_DEF_CHIP_OPS’ undeclared here (not in a function); did you mean ‘MSI_FLAG_USE_DEF_DOM_OPS’?
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
                                       MSI_FLAG_USE_DEF_DOM_OPS
../drivers/pci/controller/dwc/pcie-designware-host.c:74:6: error: ‘MSI_FLAG_PCI_MSIX’ undeclared here (not in a function); did you mean ‘SS_FLAG_BITS’?
      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
      ^~~~~~~~~~~~~~~~~
      SS_FLAG_BITS
../drivers/pci/controller/dwc/pcie-designware-host.c:74:26: error: ‘MSI_FLAG_MULTI_PCI_MSI’ undeclared here (not in a function); did you mean ‘MSI_FLAG_PCI_MSIX’?
      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
                          ^~~~~~~~~~~~~~~~~~~~~~
                          MSI_FLAG_PCI_MSIX
../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: warning: excess elements in struct initializer
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
           ^
../drivers/pci/controller/dwc/pcie-designware-host.c:73:11: note: (near initialization for ‘dw_pcie_msi_domain_info’)
../drivers/pci/controller/dwc/pcie-designware-host.c:75:3: error: ‘struct msi_domain_info’ has no member named ‘chip’
  .chip = &dw_pcie_msi_irq_chip,
   ^~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: warning: excess elements in struct initializer
  .chip = &dw_pcie_msi_irq_chip,
          ^
../drivers/pci/controller/dwc/pcie-designware-host.c:75:10: note: (near initialization for ‘dw_pcie_msi_domain_info’)
../drivers/pci/controller/dwc/pcie-designware-host.c: In function ‘dw_pcie_allocate_domains’:
../drivers/pci/controller/dwc/pcie-designware-host.c:267:19: error: implicit declaration of function ‘pci_msi_create_irq_domain’; did you mean ‘pci_msi_get_device_domain’? [-Werror=implicit-function-declaration]
  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   pci_msi_get_device_domain
../drivers/pci/controller/dwc/pcie-designware-host.c:267:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                 ^
../drivers/pci/controller/dwc/pcie-designware-host.c: At top level:
../drivers/pci/controller/dwc/pcie-designware-host.c:72:31: error: storage size of ‘dw_pcie_msi_domain_info’ isn’t known
 static struct msi_domain_info dw_pcie_msi_domain_info = {
                               ^~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

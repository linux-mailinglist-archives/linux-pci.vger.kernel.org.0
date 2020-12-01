Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0170A2C9699
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 05:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgLAEpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 23:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgLAEpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 23:45:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF7C0613CF;
        Mon, 30 Nov 2020 20:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=G6GpRZBGfBzMDHCdfX5TBRig+PVhgeBkRdlB8ph/yWk=; b=sRwZuiXdhi+oD6/GhAIQA4HDEl
        w4/SxKgmYQbMxdwu9BD5pQelzpeh0GzFxwPJaqf05HVR73h1Iaque1fvRKP15o/CIf+fwcHLL5kBp
        Fe5tCimv7GRdfd682K4pkKk7uAHQmw04xIhRLkzhx8DtjjETl/LNlnOkD992cQ8Fy7iTCtJ1s5sAq
        ulD+YOyvYeuH8XO/BL9uy7BDVfMvuDUem9fyhTuj2dM+ZfHXErrAxoq1PqMafmtNSwm2z5kUaGPfN
        iPic3Up2lTdgh7DPT+s3lG6iB1wx0gcrpD4nXef7kZr4NHxb/Xg8FM127fUcLKqRvBZcjnCiZzwV0
        gbPRfyoA==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjxX8-0000AZ-SY; Tue, 01 Dec 2020 04:45:00 +0000
Subject: Re: linux-next: Tree for Nov 30
 (drivers/pci/controller/dwc/pcie-designware-host.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20201130193626.1c408e47@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc0f6da9-6dd4-c1ad-f2f3-dc1a5cd6a51b@infradead.org>
Date:   Mon, 30 Nov 2020 20:44:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130193626.1c408e47@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/30/20 12:36 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20201127:
> 

on x86_64:

WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])

../drivers/pci/controller/dwc/pcie-designware-host.c:49:15: error: variable ‘dw_pcie_msi_domain_info’ has initializer but incomplete type
 static struct msi_domain_info dw_pcie_msi_domain_info = {
               ^~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:50:3: error: ‘struct msi_domain_info’ has no member named ‘flags’
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
   ^~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:50:12: error: ‘MSI_FLAG_USE_DEF_DOM_OPS’ undeclared here (not in a function); did you mean ‘SIMPLE_DEV_PM_OPS’?
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
            ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:50:39: error: ‘MSI_FLAG_USE_DEF_CHIP_OPS’ undeclared here (not in a function); did you mean ‘MSI_FLAG_USE_DEF_DOM_OPS’?
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:51:6: error: ‘MSI_FLAG_PCI_MSIX’ undeclared here (not in a function); did you mean ‘SS_FLAG_BITS’?
      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
      ^~~~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:51:26: error: ‘MSI_FLAG_MULTI_PCI_MSI’ undeclared here (not in a function); did you mean ‘MSI_FLAG_PCI_MSIX’?
      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
                          ^~~~~~~~~~~~~~~~~~~~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:50:11: warning: excess elements in struct initializer
  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
           ^
../drivers/pci/controller/dwc/pcie-designware-host.c:52:3: error: ‘struct msi_domain_info’ has no member named ‘chip’
  .chip = &dw_pcie_msi_irq_chip,
   ^~~~
../drivers/pci/controller/dwc/pcie-designware-host.c:52:10: warning: excess elements in struct initializer
  .chip = &dw_pcie_msi_irq_chip,
          ^
../drivers/pci/controller/dwc/pcie-designware-host.c: In function ‘dw_pcie_allocate_domains’:
../drivers/pci/controller/dwc/pcie-designware-host.c:247:19: error: implicit declaration of function ‘pci_msi_create_irq_domain’; did you mean ‘pci_msi_get_device_domain’? [-Werror=implicit-function-declaration]
  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   pci_msi_get_device_domain
../drivers/pci/controller/dwc/pcie-designware-host.c:247:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                 ^
../drivers/pci/controller/dwc/pcie-designware-host.c: At top level:
../drivers/pci/controller/dwc/pcie-designware-host.c:49:31: error: storage size of ‘dw_pcie_msi_domain_info’ isn’t known
 static struct msi_domain_info dw_pcie_msi_domain_info = {


caused by:
commit f0a6743028f938cdd34e0c3249d3f0e6bfa04073
Author: Jaehoon Chung <jh80.chung@samsung.com>
Date:   Fri Nov 13 18:01:39 2020 +0100

    PCI: dwc: exynos: Rework the driver to support Exynos5433 varian


which removed "depends on PCI_MSI_IRQ_DOMAIN from config PCI_EXYNOS.



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21C18BBBA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 16:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCSP6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 11:58:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgCSP6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=OxAIrmey4C0YRsE2gxX4uEJ1AoeGQvrX7XbqXnuRRGQ=; b=SS21Ri6AI/QcjhEjmkH4XMs+LX
        MHaQjiSIXbxc4uM5Eezigo6iamuArW4BQF4x0AtBpMlF5mgei/46l69NWK7DSjh2jbaL9vsCda9DQ
        E8sZrdNUne60khwf9unff+DjKN636SHrR3M784/2HpbRfBI1G0OGTjdJSCmepSZPMeuFRt797pOU+
        GuqxeuOLewyWATNrWiz/3oadlM19+04OOJKkf8biIJg03KFx6hI1v0wX9eX3EYs0NMxGZIf89KPHI
        MxpIVU8pQVuhP6+x5VEm2uMpuruJCYfDGzfYTLint2coCUwJIrw/b+VIg7q08QIgpob4UXlBM48la
        ZQwg7Bbw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jExYW-0001u0-Kp; Thu, 19 Mar 2020 15:58:01 +0000
Subject: Re: [PATCH v5] PCI: Microchip: Add host driver for Microchip PCIe
 controller
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20200319154917.GA1232@IRE-LT-TRAIN04.mchp-main.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb7ec107-5be4-b65c-f366-45fc695cad6b@infradead.org>
Date:   Thu, 19 Mar 2020 08:57:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319154917.GA1232@IRE-LT-TRAIN04.mchp-main.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/19/20 8:49 AM, Daire McNamara wrote:
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> --
> This v5 patch series adds support for PCIe IP block on Microchip PolarFire SoC.
> 
> Updates since v4:
> * Fix compile issues
> 
> Updates since v3:
> * Update all references to Microsemi to Microchip
> * Separate MSI functionality from legacy PCIe interrupt handling functionality
> 
> Updates since v2:
> * Split out DT bindings and Vendor ID updates into their own patch
>   from PCIe driver.
> * Updated Change Log
> 
> Updates since v1:
> * Incorporate feedback from Bjorn Helgaas
> 
> 
> Daire McNamara (1):
>   PCI: microchip: Add host driver for Microchip PCIe controller
> 
>  .../bindings/pci/microchip-pcie.txt           |  64 ++
>  drivers/pci/controller/Kconfig                |   7 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip.c       | 789 ++++++++++++++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip-pcie.txt
>  create mode 100644 drivers/pci/controller/pcie-microchip.c
> 

Hi,
Is the Kconfig symbol "PC" below a typo?



diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6671946dbf66..7141d26e668c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -280,5 +280,15 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
 
+config PCIE_MICROCHIP
+	bool "Microchip AXI PCIe host bridge support"
+	depends on PCI_MSI && OF
+	select PCI_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ_DOMAIN
+	select PC   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+



-- 
~Randy


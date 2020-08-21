Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA624D844
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHUPPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHUPPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 11:15:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A5C061573;
        Fri, 21 Aug 2020 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ahg5nela1JUC9KKhjqVH9llbBwk/SBHjRly3x+0Iphs=; b=ExF9oePk725V3Fkj0cDJnMOL29
        fRGLS/wZGNIy8iKl6MYajnMRsjNpX14e78K4xXUyBRfLvSm22SPfN9WA0jxJ3W+GXb3CXb1xps5ME
        MRreSSGlboy+cQ3W9cryCB49lfytJEK/O568Hc+KXtvEgmmtBMSzj5j+BHXPRLV/ZwqzOaX3p9jci
        njbH6fgXL8Z3IjBIo6h98RVM5elwbjZP5n4pjj/TL1bwAzd7xatpSLHUa6MhKp4oZ2YNhNhIYle4l
        XM8c7RmwQp9Dk2+wOi4qbBhh+pcTkDtZl2qIBqDhJKea8RlVQIlPxVbZfGa7QijyV/AeN/SCpLjdh
        cgPg0tAw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k98lK-0003zK-K7; Fri, 21 Aug 2020 15:15:26 +0000
Subject: Re: [PATCH 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe
 controller
To:     Hongtao Wu <wuht06@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
References: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
 <1598003509-27896-3-git-send-email-wuht06@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9e4caef-08b5-51c7-848d-1f360c9f3ea2@infradead.org>
Date:   Fri, 21 Aug 2020 08:15:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598003509-27896-3-git-send-email-wuht06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/21/20 2:51 AM, Hongtao Wu wrote:
> From: Billows Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe controller driver for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Billows Wu <billows.wu@unisoc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  12 ++
>  drivers/pci/controller/dwc/Makefile    |   1 +
>  drivers/pci/controller/dwc/pcie-sprd.c | 256 +++++++++++++++++++++++++++++++++
>  3 files changed, 269 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

Hi,

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a376..d26ce94 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -311,4 +311,16 @@ config PCIE_AL
>  	  required only for DT-based platforms. ACPI platforms with the
>  	  Annapurna Labs PCIe controller don't need to enable this.
> 
> +config PCIE_SPRD
> +       tristate "Unisoc PCIe controller - RC mode"
> +       depends on ARCH_SPRD
> +       depends on PCI_MSI_IRQ_DOMAIN
> +       select PCIE_DW_HOST
> +       help
> +         Some Uisoc SoCs contain two PCIe controllers as RC: One is gen2,

	         Unisoc

> +         and the other is gen3. While other Unisoc SoCs may have only one
> +         PCIe controller which can be configured as an Endpoint(EP) or a Root
> +         complex(RC). In order to enable host-specific features PCIE_SPRD must

	    complex (RC).

> +         be selected, which uses the Designware core.
> +
>  endmenu

Also, please follow Documentation/process/coding-style.rst for
Kconfig entries:

  For all of the Kconfig* configuration files throughout the source tree,
  the indentation is somewhat different.  Lines under a ``config`` definition
  are indented with one tab, while help text is indented an additional two
  spaces.


-- 
~Randy


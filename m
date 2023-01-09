Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7618C661D15
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 04:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjAIDz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 22:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjAIDzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 22:55:18 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867E9FCB;
        Sun,  8 Jan 2023 19:53:58 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3093rfgG126582;
        Sun, 8 Jan 2023 21:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673236421;
        bh=iTkO1kJivHhXYaPsMyNQdCqrZFAjoK4UkcZDHr5UEZo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JXLdnjAI86CosCWwO9cdrAVnxKNW/7GMDhWEFtf4yQXg6hoj3tjuypY1Uz09Rdb1D
         SmmaKPJYUU90/gkLfBAG6BU/nZdeB+GrKt0OrlY41MjLadOdZV7Eu0tJK5wNHSQ2py
         qCwkFUkb0qpf18d50F+g/CDIR4IlTWC1fgCIPCvI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3093rfQ6044902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Jan 2023 21:53:41 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 8
 Jan 2023 21:53:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 8 Jan 2023 21:53:41 -0600
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3093rbKc023652;
        Sun, 8 Jan 2023 21:53:38 -0600
Message-ID: <8dc31852-3d1c-860d-7844-15205f8fd6c6@ti.com>
Date:   Mon, 9 Jan 2023 09:23:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] PCI: j721e: Add support to build pci-j721e as
 module.
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>
References: <20230108155755.2614147-1-a-verma1@ti.com>
 <20230108155755.2614147-3-a-verma1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230108155755.2614147-3-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Achal,

On 08/01/23 21:27, Achal Verma wrote:
> Add support to build pci-j721e as module.
> 
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/Kconfig     | 10 +++++-----
>  drivers/pci/controller/cadence/pci-j721e.c |  6 +++++-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 693c41fe32ce..51edf723586c 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -43,12 +43,13 @@ config PCIE_CADENCE_PLAT_EP
>  	  different vendors SoCs.
>  
>  config PCI_J721E
> -	bool
> +	tristate
> +	select PCIE_CADENCE_HOST
> +	select PCIE_CADENCE_EP
>  

Please don't use select when symbol being selected, depends on
additional configs

Documentation/kbuild/kconfig-language.rst::

select should be used with care. select will force
a symbol to a value without visiting the dependencies.
By abusing select you are able to select a symbol FOO even
if FOO depends on BAR that is not set.


>  config PCI_J721E_HOST
> -	bool "TI J721E PCIe platform host controller"
> +	tristate "TI J721E PCIe platform host controller"
>  	depends on OF
> -	select PCIE_CADENCE_HOST
>  	select PCI_J721E
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
> @@ -56,10 +57,9 @@ config PCI_J721E_HOST
>  	  core.
>  
>  config PCI_J721E_EP
> -	bool "TI J721E PCIe platform endpoint controller"
> +	tristate "TI J721E PCIe platform endpoint controller"
>  	depends on OF
>  	depends on PCI_ENDPOINT
> -	select PCIE_CADENCE_EP
>  	select PCI_J721E
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index cc83a8925ce0..c4017fa6ae61 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -13,6 +13,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pci.h>
> @@ -565,4 +566,7 @@ static struct platform_driver j721e_pcie_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  };
> -builtin_platform_driver(j721e_pcie_driver);
> +module_platform_driver(j721e_pcie_driver);
> +
> +MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> +MODULE_LICENSE("GPL v2");

-- 
Regards
Vignesh

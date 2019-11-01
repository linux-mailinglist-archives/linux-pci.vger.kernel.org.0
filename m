Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E867EC465
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 15:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfKAOMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 10:12:34 -0400
Received: from foss.arm.com ([217.140.110.172]:36628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfKAOMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 10:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764B8337;
        Fri,  1 Nov 2019 07:12:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1CC93F718;
        Fri,  1 Nov 2019 07:12:32 -0700 (PDT)
Date:   Fri, 1 Nov 2019 14:12:30 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: cadence: Create new folder 'cadence' and
 move all cadence files to it
Message-ID: <20191101141230.GH9723@e119886-lin.cambridge.arm.com>
References: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
 <1572349512-7776-3-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572349512-7776-3-git-send-email-tjoseph@cadence.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 11:45:12AM +0000, Tom Joseph wrote:
> Cadence core library files may be used by various platform drivers.
> Add a new directory "cadence" to group all the Cadence core library files
> and the platforms using Cadence core library.
> 
> Signed-off-by: Tom Joseph <tjoseph@cadence.com>

I'm not very keen on the commit title, perhaps something like this
is better:

PCI: cadence: Move all files to per-device cadence directory

With that (or similar) you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

(I think my dislike is the length of it, and the word 'folder' instead
of directory).

> ---
>  drivers/pci/controller/Kconfig                     | 44 +--------------------
>  drivers/pci/controller/Makefile                    |  5 +--
>  drivers/pci/controller/cadence/Kconfig             | 45 ++++++++++++++++++++++
>  drivers/pci/controller/cadence/Makefile            |  5 +++
>  .../pci/controller/{ => cadence}/pcie-cadence-ep.c |  0
>  .../controller/{ => cadence}/pcie-cadence-host.c   |  0
>  .../controller/{ => cadence}/pcie-cadence-plat.c   |  0
>  .../pci/controller/{ => cadence}/pcie-cadence.c    |  0
>  .../pci/controller/{ => cadence}/pcie-cadence.h    |  0
>  9 files changed, 52 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/Kconfig
>  create mode 100644 drivers/pci/controller/cadence/Makefile
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence-ep.c (100%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence-host.c (100%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence-plat.c (100%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence.c (100%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence.h (100%)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 57d52f6..2aab586 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -22,49 +22,6 @@ config PCI_AARDVARK
>  	 controller is part of the South Bridge of the Marvel Armada
>  	 3700 SoC.
>  
> -menu "Cadence PCIe controllers support"
> -
> -config PCIE_CADENCE
> -	bool
> -
> -config PCIE_CADENCE_HOST
> -	bool
> -	depends on OF
> -	select IRQ_DOMAIN
> -	select PCIE_CADENCE
> -
> -config PCIE_CADENCE_EP
> -	bool
> -	depends on OF
> -	depends on PCI_ENDPOINT
> -	select PCIE_CADENCE
> -
> -config PCIE_CADENCE_PLAT
> -	bool
> -
> -config PCIE_CADENCE_PLAT_HOST
> -	bool "Cadence PCIe platform host controller"
> -	depends on OF
> -	select PCIE_CADENCE_HOST
> -	select PCIE_CADENCE_PLAT
> -	help
> -	  Say Y here if you want to support the Cadence PCIe platform controller in
> -	  host mode. This PCIe controller may be embedded into many different
> -	  vendors SoCs.
> -
> -config PCIE_CADENCE_PLAT_EP
> -	bool "Cadence PCIe platform endpoint controller"
> -	depends on OF
> -	depends on PCI_ENDPOINT
> -	select PCIE_CADENCE_EP
> -	select PCIE_CADENCE_PLAT
> -	help
> -	  Say Y here if you want to support the Cadence PCIe  platform controller in
> -	  endpoint mode. This PCIe controller may be embedded into many
> -	  different vendors SoCs.
> -
> -endmenu
> -
>  config PCIE_XILINX_NWL
>  	bool "NWL PCIe Core"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
> @@ -297,4 +254,5 @@ config VMD
>  	  module will be called vmd.
>  
>  source "drivers/pci/controller/dwc/Kconfig"
> +source "drivers/pci/controller/cadence/Kconfig"
>  endmenu
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 676a41e..8a59829 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -1,8 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> -obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> -obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> -obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> +obj-$(CONFIG_PCIE_CADENCE) += cadence/
>  obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
>  obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> new file mode 100644
> index 0000000..b76b3cf
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menu "Cadence PCIe controllers support"
> +	depends on PCI
> +
> +config PCIE_CADENCE
> +	bool
> +
> +config PCIE_CADENCE_HOST
> +	bool
> +	depends on OF
> +	select IRQ_DOMAIN
> +	select PCIE_CADENCE
> +
> +config PCIE_CADENCE_EP
> +	bool
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE
> +
> +config PCIE_CADENCE_PLAT
> +	bool
> +
> +config PCIE_CADENCE_PLAT_HOST
> +	bool "Cadence PCIe platform host controller"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCIE_CADENCE_PLAT
> +	help
> +	  Say Y here if you want to support the Cadence PCIe platform controller in
> +	  host mode. This PCIe controller may be embedded into many different
> +	  vendors SoCs.
> +
> +config PCIE_CADENCE_PLAT_EP
> +	bool "Cadence PCIe platform endpoint controller"
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE_EP
> +	select PCIE_CADENCE_PLAT
> +	help
> +	  Say Y here if you want to support the Cadence PCIe  platform controller in
> +	  endpoint mode. This PCIe controller may be embedded into many
> +	  different vendors SoCs.
> +
> +endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> new file mode 100644
> index 0000000..232a3f2
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> +obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> similarity index 100%
> rename from drivers/pci/controller/pcie-cadence-ep.c
> rename to drivers/pci/controller/cadence/pcie-cadence-ep.c
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> similarity index 100%
> rename from drivers/pci/controller/pcie-cadence-host.c
> rename to drivers/pci/controller/cadence/pcie-cadence-host.c
> diff --git a/drivers/pci/controller/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> similarity index 100%
> rename from drivers/pci/controller/pcie-cadence-plat.c
> rename to drivers/pci/controller/cadence/pcie-cadence-plat.c
> diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> similarity index 100%
> rename from drivers/pci/controller/pcie-cadence.c
> rename to drivers/pci/controller/cadence/pcie-cadence.c
> diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> similarity index 100%
> rename from drivers/pci/controller/pcie-cadence.h
> rename to drivers/pci/controller/cadence/pcie-cadence.h
> -- 
> 2.2.2
> 

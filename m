Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4750320FB61
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgF3SH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 14:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgF3SH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 14:07:57 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9EF206C0;
        Tue, 30 Jun 2020 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593540475;
        bh=u+0u+x6NuWZ3Cmb5vrkn8tyqSXo8Tj3lpziJ5cLZ0tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MfOT350eg2bbv6SlWjf9ZMlcIS4JXkWUnsCP7ginNQn1YtYl2a2U7ySfp3Pks4Qi8
         /UHRcPMDpBWosJJdLK/jLy/L9kLtlwum9uebUsNHEwXrsDPqvcEmGP5eUnHaZ6MNNl
         Lq9JsVK8EFNJ47uHUcmsfUQezirBEtLGekiryEqE=
Date:   Tue, 30 Jun 2020 13:07:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     bhelgaas@google.com, corbet@lwn.net, robh+dt@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: PCI
Message-ID: <20200630180753.GA3455118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627103050.71712-1-grandmaster@al2klimov.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 27, 2020 at 12:30:50PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied to pci/misc for v5.9, thanks!

I also updated some samsung.com links and dropped the http://
sourceforge link completely since it's no longer the home and there's
also an https://github.com link.

> ---
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/PCI/pci.rst                     |  4 ++--
>  Documentation/devicetree/bindings/pci/pci.txt |  4 ++--
>  arch/x86/pci/fixup.c                          |  4 ++--
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-imx6.c         |  2 +-
>  drivers/pci/controller/dwc/pci-keystone.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c       |  2 +-
>  drivers/pci/pci-label.c                       |  2 +-
>  drivers/pci/pcie/Kconfig                      |  2 +-
>  drivers/pci/pcie/aer_inject.c                 |  2 +-
>  drivers/pci/quirks.c                          | 10 +++++-----
>  11 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index 8c016d8c9862..8abac7d5244b 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -17,7 +17,7 @@ PCI device drivers.
>  A more complete resource is the third edition of "Linux Device Drivers"
>  by Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman.
>  LDD3 is available for free (under Creative Commons License) from:
> -http://lwn.net/Kernel/LDD3/.
> +https://lwn.net/Kernel/LDD3/.
>  
>  However, keep in mind that all documents are subject to "bit rot".
>  Refer to the source code if things are not working as described here.
> @@ -514,7 +514,7 @@ your driver if they're helpful, or just use plain hex constants.
>  The device IDs are arbitrary hex numbers (vendor controlled) and normally used
>  only in a single location, the pci_device_id table.
>  
> -Please DO submit new vendor/device IDs to http://pci-ids.ucw.cz/.
> +Please DO submit new vendor/device IDs to https://pci-ids.ucw.cz/.
>  There are mirrors of the pci.ids file at http://pciids.sourceforge.net/
>  and https://github.com/pciutils/pciids.
>  
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 29bcbd88f457..6a8f2874a24d 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -1,12 +1,12 @@
>  PCI bus bridges have standardized Device Tree bindings:
>  
>  PCI Bus Binding to: IEEE Std 1275-1994
> -http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> +https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>  
>  And for the interrupt mapping part:
>  
>  Open Firmware Recommended Practice: Interrupt Mapping
> -http://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
> +https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
>  
>  Additionally to the properties specified in the above standards a host bridge
>  driver implementation may support the following properties:
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 0c67a5a94de3..b8c9a5b87f37 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -557,12 +557,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_z
>   * Device [8086:2fc0]
>   * Erratum HSE43
>   * CONFIG_TDP_NOMINAL CSR Implemented at Incorrect Offset
> - * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
> + * https://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
>   *
>   * Devices [8086:6f60,6fa0,6fc0]
>   * Erratum BDF2
>   * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
> - * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
> + * https://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
>   */
>  static void pci_invalid_bar(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 6184ebc9392d..1b2e6e6fb818 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -2,7 +2,7 @@
>  /*
>   * pcie-dra7xx - PCIe controller driver for TI DRA7xx SoCs
>   *
> - * Copyright (C) 2013-2014 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2013-2014 Texas Instruments Incorporated - https://www.ti.com
>   *
>   * Authors: Kishon Vijay Abraham I <kishon@ti.com>
>   */
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 8f08ae53f53e..4e5c379ae418 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -3,7 +3,7 @@
>   * PCIe host controller driver for Freescale i.MX6 SoCs
>   *
>   * Copyright (C) 2013 Kosagi
> - *		http://www.kosagi.com
> + *		https://www.kosagi.com
>   *
>   * Author: Sean Cross <xobs@kosagi.com>
>   */
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 790679fdfa48..5191cad906ca 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -3,7 +3,7 @@
>   * PCIe host controller driver for Texas Instruments Keystone SoCs
>   *
>   * Copyright (C) 2013-2014 Texas Instruments., Ltd.
> - *		http://www.ti.com
> + *		https://www.ti.com
>   *
>   * Author: Murali Karicheri <m-karicheri2@ti.com>
>   * Implementation based on pci-exynos.c and pcie-designware.c
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index c19617a912bd..7b86c1608b04 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -3,7 +3,7 @@
>   * PCIe host controller driver for Kirin Phone SoCs
>   *
>   * Copyright (C) 2017 HiSilicon Electronics Co., Ltd.
> - *		http://www.huawei.com
> + *		https://www.huawei.com
>   *
>   * Author: Xiaowei Song <songxiaowei@huawei.com>
>   */
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 707dd9808676..781e45cf60d1 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -18,7 +18,7 @@
>   * the instance number and string from the type 41 record and exports
>   * it to sysfs.
>   *
> - * Please see http://linux.dell.com/files/biosdevname/ for more
> + * Please see https://linux.dell.com/files/biosdevname/ for more
>   * information.
>   */
>  
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 9cd31331aee9..3946555a6042 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -43,7 +43,7 @@ config PCIEAER_INJECT
>  	  error injection can fake almost all kinds of errors with the
>  	  help of a user space helper tool aer-inject, which can be
>  	  gotten from:
> -	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
> +	     https://www.kernel.org/pub/linux/utils/pci/aer-inject/
>  
>  #
>  # PCI Express ECRC
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 21cc3d3387f7..c2cbf425afc5 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -6,7 +6,7 @@
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> - *   http://www.kernel.org/pub/linux/utils/pci/aer-inject/
> + *   https://www.kernel.org/pub/linux/utils/pci/aer-inject/
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 812bfc32ecb8..54ebbef850be 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4620,11 +4620,11 @@ static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
>   *
>   * 0x9d10-0x9d1b PCI Express Root port #{1-12}
>   *
> - * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
> - * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
> - * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> - * [4] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
> - * [5] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
> + * [1] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
> + * [2] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
> + * [3] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> + * [4] https://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
> + * [5] https://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
>   * [6] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-spec-update.html
>   * [7] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.html
>   */
> -- 
> 2.27.0
> 

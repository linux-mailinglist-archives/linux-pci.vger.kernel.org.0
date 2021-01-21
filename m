Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6A2FF526
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhAUTx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 14:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbhAUTwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 14:52:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A896A224B2;
        Thu, 21 Jan 2021 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258729;
        bh=5h26ZqruEotl0zDmBUHsSpYMoFr6DyQrAE/VtmEyMuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nQ0gW5cA4KI6m7Ho28hv7DmcfqZGSDVYiY+WLAe+yTrI1dmwPw9MrBta8a8fDseU2
         Rv7akH8Xkqi7LsUS6y7avti3zYkna4x8qkczvWKfCIEVyfEWqUpnpTIF+Z0osTJ89S
         r0kHjMwFDL2E83ePD8mf1MO4wpRXM6Tds7ScuOHkgY9FZihIOd2rECDv+IB0QMJFqp
         Da2+y7DeL5V1SMJZiC1u6osMTOOZFWT6Ki07mr8mWIGe0BhZ1lmPJLfV+qbq3q0Mq4
         7XAVYBSQ1gubptJ98jj2z4fTsVdDrTrpcUBmU4jgCHsi0cNCbQ9vINmoZE8B69H3VA
         kHUNglsofIjaA==
Date:   Thu, 21 Jan 2021 13:52:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     srikanth.thokala@intel.com
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210121195206.GA2678455@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122032610.4958-3-srikanth.thokala@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 22, 2021 at 08:56:10AM +0530, srikanth.thokala@intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
> 
> In root complex mode, only internal reference clock is possible for
> Keem Bay A0. For Keem Bay B0, external reference clock can be used
> and will be the default configuration. Currently, keembay_pcie_of_data
> structure has one member. It will be expanded later to handle this
> difference.
> 
> Endpoint mode link initialization is handled by the boot firmware.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS                               |   7 +
>  drivers/pci/controller/dwc/Kconfig        |  28 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-keembay.c | 446 ++++++++++++++++++++++
>  4 files changed, 482 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00836f6452f0..2fc0fb03c430 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13852,6 +13852,13 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*spear*
>  
> +PCI DRIVER FOR INTEL KEEM BAY
> +M:	Srikanth Thokala <srikanth.thokala@intel.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
> +F:	drivers/pci/controller/dwc/pcie-keembay.c

<checks MAINTAINERS> ... yep, all previous entries are in alphabetical
order.  This new one just got dropped at the end.

I feel like a broken record, but please, please, take a look at the
surrounding code/text/whatever, and MAKE YOUR NEW STUFF MATCH THE
EXISTING STYLE.  We want the whole thing to be reasonably consistent
so readers can make sense of it without being confused by the
idiosyncrasies of every contributor.

Also, probably s/PCI DRIVER/PCIE DRIVER/.  We have both (an existing
inconsistency), but pick one, put it in the section that matches, and
alphabetize.

> +
>  PCMCIA SUBSYSTEM
>  M:	Dominik Brodowski <linux@dominikbrodowski.net>
>  S:	Odd Fixes

> +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
> +{
> +	msleep(100);

Please note the spec section that requires this sleep.  Otherwise it's
just an unmaintainable magic number.

> +	gpiod_set_value_cansleep(pcie->reset, 0);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}

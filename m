Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024F5F2AA3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfKGJ3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:29:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbfKGJ3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:29:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A02746A;
        Thu,  7 Nov 2019 01:29:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947BD3F71A;
        Thu,  7 Nov 2019 01:29:45 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:29:43 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/5] PCI: Remove PCIe Kconfig dependencies on PCI
Message-ID: <20191107092943.GS9723@e119886-lin.cambridge.arm.com>
References: <20191106222420.10216-1-helgaas@kernel.org>
 <20191106222420.10216-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-5-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:20PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> drivers/pci/pcie/Kconfig is only sourced by drivers/pci/Kconfig, and only
> when PCI is defined, so there's no need to depend on PCI again.  Remove the
> unnecessary dependencies.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b196ad816129..207dac2fd588 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -4,7 +4,6 @@
>  #
>  config PCIEPORTBUS
>  	bool "PCI Express Port Bus support"
> -	depends on PCI
>  	help
>  	  This enables PCI Express Port Bus support. Users can then enable
>  	  support for Native Hot-Plug, Advanced Error Reporting, Power
> @@ -63,7 +62,6 @@ config PCIE_ECRC
>  #
>  config PCIEASPM
>  	bool "PCI Express ASPM control" if EXPERT
> -	depends on PCI
>  	default y
>  	help
>  	  This enables OS control over PCI Express ASPM (Active State

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

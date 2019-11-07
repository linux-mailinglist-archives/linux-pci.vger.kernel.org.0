Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D6F2A9D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfKGJ3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:29:08 -0500
Received: from foss.arm.com ([217.140.110.172]:52536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfKGJ3I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:29:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D03646A;
        Thu,  7 Nov 2019 01:29:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7ADC3F71A;
        Thu,  7 Nov 2019 01:29:06 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:29:04 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Yong <jonathan.yong@intel.com>
Subject: Re: [PATCH 2/5] PCI/PTM: Remove dependency on PCIEPORTBUS
Message-ID: <20191107092904.GQ9723@e119886-lin.cambridge.arm.com>
References: <20191106222420.10216-1-helgaas@kernel.org>
 <20191106222420.10216-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-3-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:18PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PTM support does not depend on the portdrv, so remove the Kconfig
> dependency.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Yong <jonathan.yong@intel.com>
> ---
>  drivers/pci/pcie/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 362eb8cfa53b..b0d781d72d1b 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -135,7 +135,6 @@ config PCIE_DPC
>  
>  config PCIE_PTM
>  	bool "PCI Express Precision Time Measurement support"
> -	depends on PCIEPORTBUS
>  	help
>  	  This enables PCI Express Precision Time Measurement (PTM)
>  	  support.
> -- 

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

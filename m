Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C887130F007
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhBDJ7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 04:59:07 -0500
Received: from foss.arm.com ([217.140.110.172]:55134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhBDJ7G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 04:59:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0044511D4;
        Thu,  4 Feb 2021 01:58:21 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F8263F719;
        Thu,  4 Feb 2021 01:58:20 -0800 (PST)
Date:   Thu, 4 Feb 2021 09:58:15 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>, kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: fix build error, EP NTB driver uses
 configfs
Message-ID: <20210204095815.GA26804@e121166-lin.cambridge.arm.com>
References: <20210202201255.26768-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202201255.26768-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 12:12:55PM -0800, Randy Dunlap wrote:
> The pci-epf-ntb driver uses configfs APIs, so it should depend on
> CONFIGFS_FS to prevent build errors.
> 
> ld: drivers/pci/endpoint/functions/pci-epf-ntb.o: in function `epf_ntb_add_cfs':
> pci-epf-ntb.c:(.text+0x1b): undefined reference to `config_group_init_type_name'
> 
> Fixes: 7dc64244f9e9 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-pci@vger.kernel.org
> ---
> You may switch to 'select CONFIG_FS_FS' if you feel strongly about it.

Kishon ?

Thanks,
Lorenzo

>  drivers/pci/endpoint/functions/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210202.orig/drivers/pci/endpoint/functions/Kconfig
> +++ linux-next-20210202/drivers/pci/endpoint/functions/Kconfig
> @@ -16,6 +16,7 @@ config PCI_EPF_TEST
>  config PCI_EPF_NTB
>  	tristate "PCI Endpoint NTB driver"
>  	depends on PCI_ENDPOINT
> +	depends on CONFIGFS_FS
>  	help
>  	  Select this configuration option to enable the NTB driver
>  	  for PCI Endpoint. NTB driver implements NTB controller

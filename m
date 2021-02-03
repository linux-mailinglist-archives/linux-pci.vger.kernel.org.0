Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB630E606
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhBCW1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBCW1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 17:27:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD66264E4D;
        Wed,  3 Feb 2021 22:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612391198;
        bh=5PBHMw6ojmDEik1O+vyfstveI5h3euncpBTbWsEG0IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfR81MJDOx97I1rvLMV7pygVL24LKw5wRzd1kOtVQ6kpOKDrT+kmlnBsvUlR03uxT
         JvCfH126UV65czpUaYkh8V5eqbHUbclGGoY8FHrZaCePp3MbiURnpdccWGbsfMeK+h
         xkTVYu5Cy1/FEVWbtK8nkW2Na8N9wglk72cfBPVk=
Date:   Wed, 3 Feb 2021 23:26:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 3/6] misc: Add Synopsys DesignWare xData IP driver to
 Kconfig
Message-ID: <YBsjG1D4SJBG2X5Z@kroah.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <81f95c6ff0faaf8cbb56430320abb76af772a339.1612390291.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f95c6ff0faaf8cbb56430320abb76af772a339.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 11:12:48PM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver to Kconfig.
> 
> This driver enables/disables the PCIe traffic generator module
> pertain to the Synopsys DesignWare prototype.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0..6d5783f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -423,6 +423,17 @@ config SRAM
>  config SRAM_EXEC
>  	bool
>  
> +config DW_XDATA_PCIE
> +	depends on PCI
> +	tristate "Synopsys DesignWare xData PCIe driver"
> +	default	n

That's already the default, no need for this line at all.

> +	help
> +	  This driver allows controlling Synopsys DesignWare PCIe traffic
> +	  generator IP also known as xData, present in Synopsys Designware
> +	  PCIe Endpoint prototype.

Module name?

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805A8274A3B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIVUjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVUjx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:39:53 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5B920773;
        Tue, 22 Sep 2020 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600807192;
        bh=VMhYD8wA9VtjwwXPmnWdhVOn1288X+KtbZOD3bBWTrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=abdYS1WPtMVAHVfSY1AMKJsdsQIOfiw6ST1pEINR+8n8Cptu2tjZmTjtD9Ef+g024
         KXNK833ylDcvaXAsDMMlj+t6r4TPFDeldAyHRdWNfs/fqqIHk7B9UEF3AQHf8t4/8h
         rxD4Dig3zuoAzBjrtAi9k9MmQWo1XORGemdmNw1g=
Date:   Tue, 22 Sep 2020 15:39:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v9 1/5] PCI: Conditionally initialize host bridge
 native_* members
Message-ID: <20200922203950.GA2227863@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I got 1/5, 3/5, and 5/5 (and no cover letter).  Is there a 2/5 and a
4/5?  Not sure if I should wait for more, or review these three as-is?

On Fri, Sep 18, 2020 at 12:58:30PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
> struct pci_host_bridge PCIe specific native_* members to "1" is
> incorrect. So protect the PCIe specific member initialization
> with CONFIG_PCIEPORTBUS.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/probe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d37128a24f..0da0fc034413 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> +#ifdef CONFIG_PCIEPORTBUS
>  	bridge->native_aer = 1;
>  	bridge->native_pcie_hotplug = 1;
> -	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
> -	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> +#endif
> +	bridge->native_ltr = 1;
> +	bridge->native_shpc_hotplug = 1;
>  
>  	device_initialize(&bridge->dev);
>  }
> -- 
> 2.17.1
> 

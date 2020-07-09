Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1788D21A9DF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIVp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 17:45:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40872 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIVp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 17:45:58 -0400
Received: by mail-io1-f66.google.com with SMTP id q8so3934712iow.7;
        Thu, 09 Jul 2020 14:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cm4M9dwes8x03niEEdU7bFOP7a6MNWa2UIuDCHSOETA=;
        b=fg4qaRmWeRM8GTogI0OfWx9OnPQHO+x6FhWY5D7zDPJP8l9WXBOGXVcI60VfszqSxo
         I8Aj1TWav1yXZXQ4FiXDVJEIJlrO2OSLs+DWCTQluLKgUFAofynl8zPeamULGUmw405q
         dFq/NrmFYeVFWYkC7ww63DQgg0YO4FeQ31gcLKiQ1dOFc3rYWqL8nHv/Qj4vQ//3FrUR
         AatVarlX1hcBGQuYku1hHfyFmOXvCLLslwK+wvj31uxB4x4VBu4VVoVniHm6m2lIaHLj
         03d9dVPmVmYbVkcxiSu+xmWP2k/0q52kB7U+wDqj4DTmBbHjMb00vmrs+s+ydRUIWGaf
         4WPA==
X-Gm-Message-State: AOAM532Rfw7Dz8QO/UuXI1geGG7c9hApSTyBUM6WmQGzNctvd18rdYVu
        FAb5zjVjaxWE5wmxmLG+ew==
X-Google-Smtp-Source: ABdhPJxMyLOsUDzCdfKL53+BYbKXk7Kr9ScXgbUfbqOa4CSYjACMyINv95ZFOb6Qxjd9sFBEAddj1Q==
X-Received: by 2002:a05:6638:25cf:: with SMTP id u15mr65297352jat.19.1594331156767;
        Thu, 09 Jul 2020 14:45:56 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t6sm2725359ioi.20.2020.07.09.14.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:45:56 -0700 (PDT)
Received: (nullmailer pid 942496 invoked by uid 1000);
        Thu, 09 Jul 2020 21:45:55 -0000
Date:   Thu, 9 Jul 2020 15:45:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 08/14] PCI: cadence: Fix updating Vendor ID and
 Subsystem Vendor ID register
Message-ID: <20200709214555.GA939109@bogus>
References: <20200708093018.28474-1-kishon@ti.com>
 <20200708093018.28474-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708093018.28474-9-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 03:00:12PM +0530, Kishon Vijay Abraham I wrote:
> Commit 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe
> controller") in order to update Vendor ID, directly wrote to
> PCI_VENDOR_ID register. However PCI_VENDOR_ID in root port configuration
> space is read-only register and writing to it will have no effect.
> Use local management register to configure Vendor ID and Subsystem Vendor
> ID.
> 
> Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 10127ea71b83..8935f7a37e5a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -82,6 +82,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
> +	u32 id;
>  
>  	/*
>  	 * Set the root complex BAR configuration register:
> @@ -101,8 +102,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>  
>  	/* Set root port configuration space */
> -	if (rc->vendor_id != 0xffff)
> -		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);

If this is read-only, then...

> +	if (rc->vendor_id != 0xffff) {
> +		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
> +			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> +	}
> +
>  	if (rc->device_id != 0xffff)
>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);

...isn't this read-only too?

>  
> -- 
> 2.17.1
> 

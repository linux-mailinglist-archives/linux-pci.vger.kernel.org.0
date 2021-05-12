Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804A37EE16
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhELVJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhELT6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 15:58:51 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0DC06137D
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 12:54:56 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 18A80300002D8;
        Wed, 12 May 2021 21:54:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0DB704E704; Wed, 12 May 2021 21:54:48 +0200 (CEST)
Date:   Wed, 12 May 2021 21:54:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Use link bandwidth notification capability
 bit
Message-ID: <20210512195448.GA20519@wunner.de>
References: <20210512184050.2915-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512184050.2915-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 12:10:50AM +0530, Stuart Hayes wrote:
> The pcieport driver can fail to attach to a downstream port that doesn't
> support bandwidth notificaion.  This can happen when, in
                    ^^^^^^^^^^^
		    notification

> pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
> set up a bandwidth notificaion IRQ for a device that doesn't support it.
                     ^^^^^^^^^^^
		     notification

> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		u32 linkcap;
> +
> +		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +			services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	}

This *could* be #ifdef'ed to CONFIG_PCIE_BW (like CONFIG_PCIEAER a bit
further above in this function).

Apart from those nits,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

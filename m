Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490232CBEAD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgLBNtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 08:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgLBNtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 08:49:45 -0500
Date:   Wed, 2 Dec 2020 07:49:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606916944;
        bh=b/Xu8QFJnFffNq+YXrCB3fOxEiWxD3U0avrdF1PeCVQ=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=O1HEZyDTBcrhaOHEmudAXKJuxUTiKzsV6vBtEG6fiPd7TZNPtXd6NHjbPlW9dftgo
         zrrwWLOw1lTT0+YrZqnWuW6jxIvxIOXUwXM4vRLbXFFe6VlEitzJAVPRi9Ed5ajptY
         WcqxutReaW5Vlyyno0RnDmtkDFcw10kgjIEKrC8c=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, youlin.pei@mediatek.com,
        Sj Huang <sj.huang@mediatek.com>
Subject: Re: [v1] PCI: Export pci_pio_to_address() for module use
Message-ID: <20201202134903.GA1419281@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202131255.6541-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 02, 2020 at 09:12:55PM +0800, Jianjun Wang wrote:
> This interface will be used by PCI host drivers for PIO translation,
> export it to support compiling those drivers as kernel modules.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Please include this in a series that adds a modular host driver or
converts an existing one to be modular.  That way we know we have at
least one user and things get merged in the right order.

> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..509008899182 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4003,6 +4003,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>  
>  	return address;
>  }
> +EXPORT_SYMBOL(pci_pio_to_address);
>  
>  unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  {
> -- 
> 2.25.1
> 

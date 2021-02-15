Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2431C374
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBOVNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 16:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhBOVNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 16:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34A3C64DE0;
        Mon, 15 Feb 2021 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613423582;
        bh=HKzNmrEZwWl4gA6FiJSt/SCldemDIPw8NQrBl4nmKO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b1FMGpwhpcgdFTlPf+HCZm7lHhQaJuf49Kbaf1cvH9DcYvgu+lJRrtqCe+Yzl2MRr
         C5ko1HQsnykxLzaFc7P4G2rnz51E6qSxMieoUA31t0Eot8X0KPe7ms7k/kESJBfXr1
         cgRcA5IziOqqX7doY2YdwKRYBNf4kcA7+4SBrBmodGjHwkW2DyWtjzRyKMFlDMclXk
         4/mmRhtuzv3o6IEUU9bJWLFAzbLgSVZnE3nilbj5CPh7rtn7WZVweLDzKsjO1rIs2e
         APbIiy0NZCoaGGRV8/fMjN1E+zmeP8dDd9OmYuDGp5XoE6zqj9ZdRa9bi3C9hpyO1s
         +DIIq398BazOQ==
Date:   Mon, 15 Feb 2021 15:13:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH] PCI : check if type 0 devices have all BARs of size zero
Message-ID: <20210215211300.GA748236@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212100856.473415-1-wasim.khan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 12, 2021 at 11:08:56AM +0100, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> Log a message if all BARs of type 0 devices are of
> size zero. This can help detecting type 0 devices
> not reporting BAR size correctly.

I could be missing something, but I don't think we can do this.  I
would think the simplest possible presilicon testing would find errors
like this, and the first attempt to have a driver claim the device
would fail if required BARs were missing, so I'm not sure what this
would add.

While the subject line says "type 0 devices," this code path is also
used for type 1 devices (bridges), and it's quite common for bridges
to have no BARs, which means they would all be hardwired to zero.

It is also legal for even type 0 devices to implement no BARs.  They
may be operated entirely via config space or via device-specific BARs
that are unknown to the PCI core.

> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> ---
>  drivers/pci/probe.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..6438d6d56777 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -321,6 +321,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  {
>  	unsigned int pos, reg;
> +	bool found = false;
>  
>  	if (dev->non_compliant_bars)
>  		return;
> @@ -333,8 +334,12 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
>  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
> +		found |= res->flags ? 1 : 0;
>  	}
>  
> +	if (!dev->hdr_type && !found)
> +		pci_info(dev, "BAR size is 0 for BAR[0..%d]\n", howmany - 1);
> +
>  	if (rom) {
>  		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
>  		dev->rom_base_reg = rom;
> -- 
> 2.25.1
> 

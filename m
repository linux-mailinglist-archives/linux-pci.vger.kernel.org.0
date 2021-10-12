Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4642A7C9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhJLPE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 11:04:29 -0400
Received: from rosenzweig.io ([138.197.143.207]:46918 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhJLPE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 11:04:28 -0400
Date:   Tue, 12 Oct 2021 11:02:20 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Colin King <colin.king@canonical.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Message-ID: <YWWjfIYLyyTMLaJX@sunset>
References: <20211012133235.260534-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012133235.260534-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It looks like 

        port_pdev = pcie_find_root_port(pdev);

might've meant to read

        port_pdev = pcie_find_root_port(port_pdev);

in which case the assignment would be used. I have no strong opinions
either way.

Full context for those following along at home:

```
static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
{
        struct pci_config_window *cfg = pdev->sysdata;
        struct apple_pcie *pcie = cfg->priv;
        struct pci_dev *port_pdev = pdev;
        struct apple_pcie_port *port;

        /* Find the root port this device is on */
        port_pdev = pcie_find_root_port(pdev);

        /* If finding the port itself, nothing to do */
        if (WARN_ON(!port_pdev) || pdev == port_pdev)
                return NULL;

        list_for_each_entry(port, &pcie->ports, entry) {
                if (port->idx == PCI_SLOT(port_pdev->devfn))
                        return port;
        }

        return NULL;
}
```

On Tue, Oct 12, 2021 at 02:32:35PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer port_pdev is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index b4db7a065553..19fd2d38aaab 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -634,7 +634,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
>  {
>  	struct pci_config_window *cfg = pdev->sysdata;
>  	struct apple_pcie *pcie = cfg->priv;
> -	struct pci_dev *port_pdev = pdev;
> +	struct pci_dev *port_pdev;
>  	struct apple_pcie_port *port;
>  
>  	/* Find the root port this device is on */
> -- 
> 2.32.0
> 

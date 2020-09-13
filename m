Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34518267DFE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 07:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIMFBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 01:01:34 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:35751 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgIMFBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2020 01:01:32 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E36F22800B3E0;
        Sun, 13 Sep 2020 07:01:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 94B9A1DEA2; Sun, 13 Sep 2020 07:01:29 +0200 (CEST)
Date:   Sun, 13 Sep 2020 07:01:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Message-ID: <20200913050129.GA10736@wunner.de>
References: <1599818977-25425-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599818977-25425-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 06:09:36PM +0800, Huacai Chen wrote:
> As Bjorn Helgaas said, portdrv can only be built statically (not as a
> module), so the .remove() method in pcie_portdriver is useless. So just
> remove it.

No, PCIe switches (containing upstream and downstream PCIe ports)
can be hot-plugged and hot-removed at runtime.  Every Thunderbolt
device contains a PCIe switch and is hot-pluggable.  We do want to
clean up a hot-removed PCIe port properly.

Thanks,

Lukas

> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -134,7 +134,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	return 0;
>  }
>  
> -static void pcie_portdrv_remove(struct pci_dev *dev)
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  {
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
> @@ -210,8 +210,7 @@ static struct pci_driver pcie_portdriver = {
>  	.id_table	= &port_pci_ids[0],
>  
>  	.probe		= pcie_portdrv_probe,
> -	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,

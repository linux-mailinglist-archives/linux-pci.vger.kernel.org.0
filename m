Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BD49529A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbiATQtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 11:49:10 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45028 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377115AbiATQtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:49:07 -0500
Received: by mail-oi1-f175.google.com with SMTP id s9so9663092oib.11;
        Thu, 20 Jan 2022 08:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=atLkBu3N/RFCjhoQCUPCGUzf/CIlAjhcm9ghJHrFyPo=;
        b=vdj5H5oD+ne7oZ0BEDBwdzYI/W1h1pb1MMlykWJbuRICt4odO0XEBSBDa/262BvKHR
         BEJLXoAPVleHUTBv7Wfn1l/Z83qv3x059UXv+ofR1j1ZjsJIMHvhJkVsbEUINulbI0Li
         CZ69+75TjO025haxQRQfDpKuNQxdMHQL3DIXW/tcLgNx1yxMqoci6HVayRT1rEHtFoxM
         vAr0M42R6Ev66Y+R9rtsXARYf4ZdU2+FMfQ7fQG4jMtsuqGsAzK5GHT+rkgd2c5uN6dX
         l7ngLP8Hh0I92JUTZWB3xJ15pBkrpB9uKWscLTue3qJoaziSt3I7yQmzb495E4p26Ngi
         J/6Q==
X-Gm-Message-State: AOAM531fA/1jRF6Gw1Ev6rBKDKY1aUY1TFxV0y//hU6KzBD3I3iDk7lI
        AWVD+MRtY7MGYseEOTjVqw==
X-Google-Smtp-Source: ABdhPJw6rfhYcEudPb8hkyG0JB3JIC9ChkgIAC4YvkyUefFiL3rdFzoA/qLdUPkxtT08jmgKVIoVkA==
X-Received: by 2002:a05:6808:11c5:: with SMTP id p5mr8329266oiv.51.1642697346626;
        Thu, 20 Jan 2022 08:49:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay14sm2096888oib.5.2022.01.20.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:49:06 -0800 (PST)
Received: (nullmailer pid 1580253 invoked by uid 1000);
        Thu, 20 Jan 2022 16:49:05 -0000
Date:   Thu, 20 Jan 2022 10:49:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] PCI: mvebu: Use child_ops API
Message-ID: <YemSgTfl7NiTfcKc@robh.at.kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-9-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112151814.24361-9-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 04:18:11PM +0100, Pali Rohár wrote:
> Split struct pci_ops between ops and child_ops. Member ops is used for
> accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
> accessing real PCIe cards.
> 
> There is no need to mix these two struct pci_ops into one as PCI core code
> already provides separate callbacks via bridge->ops and bridge->child_ops.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 9ea2f6a7c2b0..1e90ab888075 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -294,11 +294,29 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	mvebu_writel(port, mask, PCIE_MASK_OFF);
>  }
>  
> -static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> -				 struct pci_bus *bus,
> -				 u32 devfn, int where, int size, u32 *val)
> +static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> +						    struct pci_bus *bus,
> +						    int devfn);
> +
> +static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> +				    int size, u32 *val)
>  {
> -	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
> +	struct mvebu_pcie *pcie = bus->sysdata;
> +	struct mvebu_pcie_port *port;
> +	void __iomem *conf_data;
> +
> +	port = mvebu_pcie_find_port(pcie, bus, devfn);
> +	if (!port) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	if (!mvebu_pcie_link_up(port)) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	conf_data = port->base + PCIE_CONF_DATA_OFF;
>  
>  	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
>  		     PCIE_CONF_ADDR_OFF);
> @@ -321,11 +339,21 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
> -				 struct pci_bus *bus,
> -				 u32 devfn, int where, int size, u32 val)
> +static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
> +				    int where, int size, u32 val)
>  {
> -	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
> +	struct mvebu_pcie *pcie = bus->sysdata;
> +	struct mvebu_pcie_port *port;
> +	void __iomem *conf_data;
> +

> +	port = mvebu_pcie_find_port(pcie, bus, devfn);
> +	if (!port)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (!mvebu_pcie_link_up(port))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	conf_data = port->base + PCIE_CONF_DATA_OFF;

Again, the same setup code in read and write is a sign to use 
.map_bus(). You can copy it from my version I pointed you to.

Rob

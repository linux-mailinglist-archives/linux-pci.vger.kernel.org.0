Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CED4952E4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 18:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377215AbiATRJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 12:09:19 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45585 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377203AbiATRJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 12:09:19 -0500
Received: by mail-ot1-f41.google.com with SMTP id v8-20020a9d6048000000b005960952c694so8359538otj.12;
        Thu, 20 Jan 2022 09:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Euwjo6CgoOD4aO0544Go5k7bgAvjOJGkS5qDpA3RUSc=;
        b=cdQYEKMNjQnDmCDxj5d7aXmc/U5J0ZVeNi9apCWGD+skO354oajSamNhwuUIjDxSNz
         jVuRLmKWWVMetR37g9Achs4liAAldBFA+ubIx8dpSMaxgfEZAGjNkZAsrtc7aDNeO2Iu
         wAaKG9KdCe1kMObVzaYKXF11wYQP7DemLC+TjqBfXTjRo+DTAjU7IyYlSkZwx6rTKutP
         AZdqjODeXEedAdXVhrtT2J6uMCiXnSVD6VsLeTX7aTMfrhCSzSVZsRlfFiTum8NXncv6
         rpmJH1Na1zDYbymJGRoZrwJ6seC7M722wKIiFKgW/bzcDaDR3568nAwZtS8zLVwUHrTJ
         Yrig==
X-Gm-Message-State: AOAM530Ssbgt48ZC3SjufASO8eqmKpJLw/7dLq0Mwf9IGIR9/KyxJM+h
        rM51WoeNDYZgfSou/hz/WT3QDPDmKQ==
X-Google-Smtp-Source: ABdhPJz4bpxpNcmiI8YWg3qvT0F0SvrpJ4m2JLdSJmUlrVteXsDv4EbixpwWMFD7H2CVINSHcnvp2A==
X-Received: by 2002:a9d:22c3:: with SMTP id y61mr431937ota.248.1642698558566;
        Thu, 20 Jan 2022 09:09:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c20sm1747132ots.50.2022.01.20.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:09:17 -0800 (PST)
Received: (nullmailer pid 1607218 invoked by uid 1000);
        Thu, 20 Jan 2022 17:09:17 -0000
Date:   Thu, 20 Jan 2022 11:09:17 -0600
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
Subject: Re: [PATCH v2 05/11] PCI: mvebu: Correctly configure x1/x4 mode
Message-ID: <YemXPQx4F1eRtLxO@robh.at.kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112151814.24361-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 04:18:08PM +0100, Pali Rohár wrote:
> If x1/x4 mode is not set correctly then link with endpoint card is not
> established.
> 
> Use DTS property 'num-lanes' to deteriminate x1/x4 mode.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index a075ba26cff1..0f2ec0a17874 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -93,6 +93,7 @@ struct mvebu_pcie_port {
>  	void __iomem *base;
>  	u32 port;
>  	u32 lane;
> +	bool is_x4;

I would just store the number of lanes.

>  	int devfn;
>  	unsigned int mem_target;
>  	unsigned int mem_attr;
> @@ -233,13 +234,25 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  
>  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  {
> -	u32 ctrl, cmd, dev_rev, mask;
> +	u32 ctrl, lnkcap, cmd, dev_rev, mask;
>  
>  	/* Setup PCIe controller to Root Complex mode. */
>  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
>  	ctrl |= PCIE_CTRL_RC_MODE;
>  	mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
>  
> +	/*
> +	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
> +	 * Capability register. This register is defined by PCIe specification
> +	 * as read-only but this mvebu controller has it as read-write and must
> +	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
> +	 * not set correctly then link with endpoint card is not established.
> +	 */
> +	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> +	lnkcap |= (port->is_x4 ? 4 : 1) << 4;

then this is just: lanes << 4

> +	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> +
>  	/* Disable Root Bridge I/O space, memory space and bus mastering. */
>  	cmd = mvebu_readl(port, PCIE_CMD_OFF);
>  	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> @@ -986,6 +999,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  	struct device *dev = &pcie->pdev->dev;
>  	enum of_gpio_flags flags;
>  	int reset_gpio, ret;
> +	u32 num_lanes;
>  
>  	port->pcie = pcie;
>  
> @@ -998,6 +1012,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  	if (of_property_read_u32(child, "marvell,pcie-lane", &port->lane))
>  		port->lane = 0;
>  
> +	if (!of_property_read_u32(child, "num-lanes", &num_lanes) && num_lanes == 4)
> +		port->is_x4 = true;

And this can be:

num_lanes = 1;
of_property_read_u32(child, "num-lanes", &num_lanes);

If you want to validate the DT is only 1 or 4, make the DT schema do 
that.


> +
>  	port->name = devm_kasprintf(dev, GFP_KERNEL, "pcie%d.%d", port->port,
>  				    port->lane);
>  	if (!port->name) {
> -- 
> 2.20.1
> 
> 

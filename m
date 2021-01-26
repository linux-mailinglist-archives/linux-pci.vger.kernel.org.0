Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B154303E95
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbhAZMpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:45:20 -0500
Received: from foss.arm.com ([217.140.110.172]:59324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391803AbhAZKDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 05:03:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07718101E;
        Tue, 26 Jan 2021 02:03:04 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F8A3F66B;
        Tue, 26 Jan 2021 02:03:02 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:02:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
Message-ID: <20210126100256.GA20547@e121166-lin.cambridge.arm.com>
References: <20210120105246.23218-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120105246.23218-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 11:52:46AM +0100, Michael Walle wrote:
> fw_devlink will defer the probe until all suppliers are ready. We can't
> use builtin_platform_driver_probe() because it doesn't retry after probe
> deferral. Convert it to builtin_platform_driver().
> 
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")

I will have to drop this Fixes: tag if you don't mind, it is not
in the mainline.

Lorenzo

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 44ad34cdc3bc..5b9c625df7b8 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -232,7 +232,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>  	{ },
>  };
>  
> -static int __init ls_pcie_probe(struct platform_device *pdev)
> +static int ls_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
> @@ -271,10 +271,11 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver ls_pcie_driver = {
> +	.probe = ls_pcie_probe,
>  	.driver = {
>  		.name = "layerscape-pcie",
>  		.of_match_table = ls_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  	},
>  };
> -builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
> +builtin_platform_driver(ls_pcie_driver);
> -- 
> 2.20.1
> 

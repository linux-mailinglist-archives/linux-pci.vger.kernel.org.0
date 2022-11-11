Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97F16259F5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 13:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiKKMAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 07:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKKMAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 07:00:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9416665862;
        Fri, 11 Nov 2022 04:00:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F4A61F48;
        Fri, 11 Nov 2022 12:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8602C433D6;
        Fri, 11 Nov 2022 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668168044;
        bh=s3z2wj2Bw1bcimUZuVqCXmXtg1REFMatJH32Ha72MX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDyjjhEBRpUyEGmOm2vfi832Rqr1t7+qsA16JvJtx4Ft5krUAppWOioN9grwShsvM
         /sEx/iARNY6trDH0pSBEuANEwozmNSVHx05zqYqNgb/oCCqiUNc+QuEPkERMd5difq
         q0hcm6Fgh5Ky26/KoB3WtrG7mt7fMH1DCwA5IdTfsIHbIKv0zZH7htDqQ5JgrJGkZJ
         d/nRL197X1KncpxFPa7C6RONOUx3ZzM5YJSkhrjAzC09IiUeZZIYoa39y5BsgSV+l7
         ERjwjEoXeSQOSqbKiZ9g+oTvgY6jMzsdtjObdtA7WUeyfDFx/GL+VarPnXz+pSsV74
         +yBvUHJ5c6GrA==
Date:   Fri, 11 Nov 2022 13:00:38 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kishon@kernel.org
Cc:     robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzk+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 05/10] PCI: designware-ep: Add ep_pre_init() callback
 to dw_pcie_ep_ops
Message-ID: <Y245ZtqqqelXif+Y@lpieralisi>
References: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
 <20220922080647.3489791-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922080647.3489791-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Kishon]

On Thu, Sep 22, 2022 at 05:06:42PM +0900, Yoshihiro Shimoda wrote:
> Some PCIe endpoint controllers need vendor-specific initialization
> before the common code initialization. Add a new callback function
> ep_pre_init() for it.

It would be better to add code where it is used.

Kishon, please review if/when possible.

Thanks,
Lorenzo

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
>  drivers/pci/controller/dwc/pcie-designware.h    | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index ca8f1804ee10..1b7e9e1b8d52 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -709,6 +709,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_version_detect(pci);
>  
> +	if (ep->ops->ep_pre_init)
> +		ep->ops->ep_pre_init(ep);
> +
>  	dw_pcie_iatu_detect(pci);
>  
>  	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b541f653c209..9ed9621a12e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -317,6 +317,7 @@ struct dw_pcie_rp {
>  };
>  
>  struct dw_pcie_ep_ops {
> +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
> -- 
> 2.25.1
> 

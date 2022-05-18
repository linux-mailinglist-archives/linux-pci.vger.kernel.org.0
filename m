Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E024B52B6C6
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiERJbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiERJbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 05:31:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904D369EB;
        Wed, 18 May 2022 02:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEBA661750;
        Wed, 18 May 2022 09:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F751C385A5;
        Wed, 18 May 2022 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652866258;
        bh=b4q3S3ZcO++qVR3+aQzsJTMPphy/skbkPZkqxWVncyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgpRgGOy1a/znb9d0DcSINs7GhDv52mrkrt7T1oYOgrfhGKyFHrHz/nwAKLf/tbr/
         x244g17W59LFsC1/mOp+eP8kWq0l4hfT+nF2w4x2UCh5k/48VTl2K/g1aNRO/R4NDR
         ykc3yeOkZ4YTU+4AY9uOGZ6tVRqFOoRPC/EoTLUOeNwiUk+NlQRZTihCUFOWUdoltK
         zySoeo9FndIR04I6Y7or1b8eqeY/gPkrETEdwER7Z7eju6kZgDwwzqtihIoDowzj1i
         ApdoyJI40lC40GNnx5GKRBe/tbJUqnQK+C2rfSocvpNKFoqq7cRaJ1z+v7paKPC3P9
         mefs8Hdn8IvoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrG1C-0003Ne-Bg; Wed, 18 May 2022 11:30:59 +0200
Date:   Wed, 18 May 2022 11:30:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 02/10] PCI: dwc: Propagate error from
 dma_mapping_error()
Message-ID: <YoS80vek6UrN1XbG@hovoldconsulting.com>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513172622.2968887-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:26:14PM +0300, Dmitry Baryshkov wrote:
> If dma mapping fails, dma_mapping_error() will return an error.
> Propagate it to the dw_pcie_host_init() return value rather than
> incorrectly returning 0 in this case.
> 
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f32d964..a9a31e9e7b6e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -396,8 +396,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  						      sizeof(pp->msi_msg),
>  						      DMA_FROM_DEVICE,
>  						      DMA_ATTR_SKIP_CPU_SYNC);
> -			if (dma_mapping_error(pci->dev, pp->msi_data)) {
> -				dev_err(pci->dev, "Failed to map MSI data\n");
> +			ret = dma_mapping_error(pci->dev, pp->msi_data);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
>  				pp->msi_data = 0;
>  				goto err_free_msi;
>  			}

This has already been fixed by commit 88557685cd72 ("PCI: dwc: Fix
setting error return on MSI DMA mapping failure"), which prevents the
series from applying cleanly.

Johan

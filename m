Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AA77DE82
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjHPKUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbjHPKUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 06:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64180198E;
        Wed, 16 Aug 2023 03:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02701659A6;
        Wed, 16 Aug 2023 10:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE55C433C7;
        Wed, 16 Aug 2023 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692181216;
        bh=ow9tRMf0gu4FTJ9byjkAVUH5QDlP42E17BJRLDwt9RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjXMvG819bch8IgneZCLWkZCSJF80daxdWAssagyRcUVBv9nv+bDoyLEX+1ChG936
         Wy/wuHLaFGAClxUGHX6RmKDlbUyFZGU0o2Sz3ZeiyvZoezDdxbjjBN60nxF71esZIi
         Kri3fioFD/PVEcYygkhx3SR8gOCiY4fDc8RwmBwzC+gH7o4118PgMZ4Cnn1bhUmA8L
         qdsGVM4nW1ZrA97aCAWP/f3CDFXAP/SNQZ7melJAj8mnx9q8mUi6V3AkxExjw6ecLI
         xHb0eQB7Ftjz6u3TDq6TFpEFTKwAwSMCBMx1aTwyzh391k1DhguZhqL6hO/OhbHgNi
         Oj3t4RFxl2RrA==
Date:   Wed, 16 Aug 2023 12:20:08 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>, bhelgaas@google.com
Cc:     helgaas@kernel.org, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        mani@kernel.org, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v11 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Message-ID: <ZNyi2BkInSyUPYEU@lpieralisi>
References: <20230809153540.834653-1-Frank.Li@nxp.com>
 <20230809153540.834653-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809153540.834653-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 11:35:38AM -0400, Frank Li wrote:
> Introduce the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
> L2 ready timeout in the PCI subsystem.
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/pci.h | 6 ++++++
>  1 file changed, 6 insertions(+)

This patch requires Bjorn's ACK.

Lorenzo

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c3974340576..da8156663c825 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,12 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +/*
> + * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
> + * Recommends 1ms to 10ms timeout to check L2 ready.
> + */
> +#define PCIE_PME_TO_L2_TIMEOUT_US	10000
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.34.1
> 

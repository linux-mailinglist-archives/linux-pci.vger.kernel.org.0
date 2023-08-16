Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1977E0AE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbjHPLpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbjHPLpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 07:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15E1FC3;
        Wed, 16 Aug 2023 04:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595EA61FFD;
        Wed, 16 Aug 2023 11:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECC2C433C7;
        Wed, 16 Aug 2023 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692186301;
        bh=zWNrCC9D/ZGZLVx6/MNogtB5y4I71xfms58Io+1Vxhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HrMr+pjtgrAkRbb4vE11dFmpCmp9zzwJcqbmWnO65g9F9hiJULyc+WCzKGCpYC3Md
         Axw/XJr/4JIvfHpZOmweW9sE5CuNBU9eaCF/nClsBnP2Z/vld/akXe+48yD11fRSsX
         lokhOaE5gwkDzCSo57oXRtIdksNfOSA9WgdOIFQTh1bzacBKdaPfxgpeo3DsDuFVdq
         unf8bLX4SSuQWYMMQi5PAG7ycVEaY3y1uKebUKpSaDcc5I8MMI/5j3C1TjYFhxq/rH
         t8yHKkAOnzlh9h1BNG0IdQwA0YZ5xVjR6gICiQVShzPBIr1itAYMDOZ/AYx5yw9a42
         S5+WU9npF/slg==
Date:   Wed, 16 Aug 2023 06:44:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v11 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Message-ID: <20230816114459.GA284194@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809153540.834653-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Looks good, thanks!

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

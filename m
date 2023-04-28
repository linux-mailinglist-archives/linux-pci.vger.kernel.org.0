Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D86F1F21
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjD1UJY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjD1UJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 16:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9626A1;
        Fri, 28 Apr 2023 13:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCA76446A;
        Fri, 28 Apr 2023 20:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE2DC433D2;
        Fri, 28 Apr 2023 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682712559;
        bh=audxmFyFfzKOzyoEf7CTSzuG77aOVueJU+fs+OT6QdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gmwmeh3nYlaOJciNrWIxTRgwUw5/hXOkHvvVy1aYvbFtfN5+EpxW2zz6bXYD2JtY5
         r/iFRuaIJFNiHddfPEXA0VigK56abay3652iAhmUYyWDFYQM1abYps8AqZ0G8u9HkQ
         JBTf+moZ3ny3l2ZNWzXp0Vff6iDJ+7KMiNOiSiumbHO1Z0tRwax1Icf1eTRVAM0OxE
         5ApUk8Vcc0TY4MrfIeXzxMOFIKdyto5geze7Aiktfv0DL/bkSlUeTwv3McX1Ep41Io
         XCVbfWDK3dKw1OdOSRlJXogNkh7YfZTLkBVNqPD7Z3uE0vgrxVLxiNHEEwBZlzT6cw
         C7ckCPuGonLMg==
Date:   Fri, 28 Apr 2023 15:09:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Message-ID: <20230428200916.GA361406@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402131347.99268-1-linux@fw-web.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 02, 2023 at 03:13:47PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> De-assert PERST in separate step after reset signals to fully comply
> the PCIe CEM clause 2.2.

I guess this refers to PCIe CEM r5.0, sec 2.2.

> This fixes some NVME detection issues on mt7986.
> 
> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> Patch is taken from user Ruslan aka RRKh61 (permitted me to send it
> with me as author).
> 
> https://forum.banana-pi.org/t/bpi-r3-nvme-connection-issue/14563/17
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index b8612ce5f4d0..176b1a04565d 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	msleep(100);
>  
>  	/* De-assert reset signals */
> -	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +
> +	msleep(100);

There should be a #define for the 100ms value since it is required by
the generic PCIe CEM spec, not by anything specific to mediatek.  If
one already exists, we should use it.  If not, we should add one.

pcie-tegra194.c and pcie-mediatek.c (at least) also have similar
delays and should also use the same #define.  There are several other
drivers that contain "msleep(100)", but I didn't look to see their
purpose.

> +	/* De-assert PERST# signals */
> +	val &= ~(PCIE_PE_RSTB);
>  	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  
>  	/* Check if the link is up or not */
> -- 
> 2.34.1
> 
> 

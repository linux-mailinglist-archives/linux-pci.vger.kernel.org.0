Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C06F394A
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEAUgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 16:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAUgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 16:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C2A6
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 13:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA1961FAD
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 20:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E61C433D2;
        Mon,  1 May 2023 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682973364;
        bh=jyOGTiSApmoehsmF7hhH5QektLULZmpZCzDhCeQn5sE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S4XSsrl8I6CSPEvENLmJR92Lm+NcljETS9B6fqdNvhI6/EcMgixNbtkvojqlcNwrj
         0PPeuNRJyoYM0M4tsIDwJGK9ibPtmTOnxQot1Xz4Al5CVTVl+sfXx9ysik9rthWc8J
         +niv0ZP/3Fa6BPQhbi7a3h4WysX72DcqjSdqFSBgfVwxlyMkPeeTPX3Qex4dBIqEdg
         RVGB2u6WmijsTyeTiOri9LwQyMp7dj6cGFe2H8RaELPBdcg9S5hOA+XqowjSCsUa/q
         qd7gRnYgwK0wg4/ZjefhY5iORm2xYpdy9dSoPwwukZI1TAR7R7SAa/+W0rhjH2NwNO
         uDGqqhP0oZCHQ==
Date:   Mon, 1 May 2023 15:36:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek: increase link training timeout
Message-ID: <20230501203602.GA604568@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326121217.2664953-1-oskari@lemmela.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 26, 2023 at 03:12:17PM +0300, Oskari Lemmela wrote:
> Some PCI devices fail to complete link training in 100ms.
> Increase link training timeout by 20ms to 120ms.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

Doesn't look like this went anywhere, probably because we really don't
have enough information about why and where this is needed.

Does this mean some *endpoints* don't train fast enough?  Or is this
something to do with MediaTek host controllers?

If some endpoints don't train correctly, maybe it's a defect that
we should have a quirk for so we can wait longer for all host
controllers, not just MediaTek.  Or maybe it's a signal integrity
problem or something on systems using MediaTek?

Is the 100ms (or 120ms) based on some requirement from the spec?
If so, it would be good to include the reference.

> ---
>  drivers/pci/controller/pcie-mediatek.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index ae5ad05ddc1d..67b8cf0dc9f7 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -720,10 +720,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	if (soc->need_fix_device_id)
>  		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
>  
> -	/* 100ms timeout value should be enough for Gen1/2 training */
> +	/* 120ms timeout value should be enough for Gen1/2 training */

There are a lot of 100ms-ish delays in PCIe.  It would be nice to have
a #define for this so we can connect this back to something in the
spec and potentially share it across host controller drivers.

Bjorn

>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
>  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> -				 100 * USEC_PER_MSEC);
> +				 120 * USEC_PER_MSEC);
>  	if (err)
>  		return -ETIMEDOUT;
>  
> @@ -785,10 +785,10 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>  	val &= ~PCIE_PORT_PERST(port->slot);
>  	writel(val, pcie->base + PCIE_SYS_CFG);
>  
> -	/* 100ms timeout value should be enough for Gen1/2 training */
> +	/* 120ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS, val,
>  				 !!(val & PCIE_PORT_LINKUP), 20,
> -				 100 * USEC_PER_MSEC);
> +				 120 * USEC_PER_MSEC);
>  	if (err)
>  		return -ETIMEDOUT;
>  
> -- 
> 2.34.1
> 

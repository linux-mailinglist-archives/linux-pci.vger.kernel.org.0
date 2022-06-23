Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8E558386
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiFWRbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiFWR3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 13:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0527FD2E;
        Thu, 23 Jun 2022 10:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DF06159A;
        Thu, 23 Jun 2022 17:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB65C341C4;
        Thu, 23 Jun 2022 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656003888;
        bh=BP4Xv9dfnQL4kdsgB8BI3/j5qp9scN2TAD2M43SlNGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q72PuRrXL7nDVD9DV1RLOXs8DwuEn3Kgm5QD5hV37f02hNz22kxfEz8XcLkDd45N4
         n0PtknVBeTm8Xmsc/ZGvqA5xItJ+kxtXDNHJiUkFOqrQIaerDorlGZAx5Lqaw1GdA3
         /Kjh767WR5eWM2JDFKm7I1yYJVQ6F1RRkOOQPDeK+5BQTzcW6gsJiij85mVqVNGgNp
         Ewa+Baj13XAlVHtay+FaYcByFCjCuChzMeUe6AcEjiQNOHBB7dL870JmcM31ee20d9
         cW9EbjD0RKNNHD7N5Icv2BdSYCHk9fXvtJk/x4RX+FQzb1J7mnUvQ28RSACeUr+R1y
         9MuANq23ru/fQ==
Date:   Thu, 23 Jun 2022 12:04:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] PCI: rcar-ep: Simplify bitmap allocation.
Message-ID: <20220623170447.GA1458028@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd98d56871f6f08ca82dcc76bfa2052368a8926.1655814557.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jingoo, Gustavo, Serge, in case dwc should do something similar]

On Tue, Jun 21, 2022 at 02:31:46PM +0200, Christophe JAILLET wrote:
> MAX_NR_INBOUND_MAPS is small (i.e. 6), so there is no real point in
> dynamic allocation for a bitmap of this size.
> Moreover, it is linked with the use of the 'bar_to_atu' field which is
> already statically declared.
> 
> Declare it statically instead.
> 
> This saves some LoC, reduces the size of the module and saves a few bytes
> of memory at run-time.
> 
> Before: (gcc 11.2.0 / allyesconfig)
>    text	   data	    bss	    dec	    hex	filename
>   11514	   5232	      0	  16746	   416a	drivers/pci/controller/pcie-rcar-ep.o
> 
> After: (gcc 11.2.0 / allyesconfig)
>    text	   data	    bss	    dec	    hex	filename
>   11183	   5064	      0	  16247	   3f77	drivers/pci/controller/pcie-rcar-ep.o
> 
> 
> Also replace the mostly useless 'num_ib_windows' and use
> MAX_NR_INBOUND_MAPS directly instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looking for an ack from Marek or Yoshihiro here ...

I'm guessing struct dw_pcie.ib_window_map and .ob_window_map are
probably similar, though the limit is not hard-coded as it is for
rcar-ep.

> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index f9682df1da61..64682876e93e 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -25,8 +25,7 @@ struct rcar_pcie_endpoint {
>  	struct pci_epc_mem_window *ob_window;
>  	u8			max_functions;
>  	unsigned int		bar_to_atu[MAX_NR_INBOUND_MAPS];
> -	unsigned long		*ib_window_map;
> -	u32			num_ib_windows;
> +	DECLARE_BITMAP(ib_window_map, MAX_NR_INBOUND_MAPS);
>  	u32			num_ob_windows;
>  };
>  
> @@ -205,8 +204,8 @@ static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int idx;
>  	int err;
>  
> -	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
> -	if (idx >= ep->num_ib_windows) {
> +	idx = find_first_zero_bit(ep->ib_window_map, MAX_NR_INBOUND_MAPS);
> +	if (idx >= MAX_NR_INBOUND_MAPS) {
>  		dev_err(pcie->dev, "no free inbound window\n");
>  		return -EINVAL;
>  	}
> @@ -502,15 +501,7 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
>  		goto err_pm_put;
>  	}
>  
> -	ep->num_ib_windows = MAX_NR_INBOUND_MAPS;
> -	ep->ib_window_map =
> -			devm_kcalloc(dev, BITS_TO_LONGS(ep->num_ib_windows),
> -				     sizeof(long), GFP_KERNEL);
> -	if (!ep->ib_window_map) {
> -		err = -ENOMEM;
> -		dev_err(dev, "failed to allocate memory for inbound map\n");
> -		goto err_pm_put;
> -	}
> +	bitmap_zero(ep->ib_window_map, MAX_NR_INBOUND_MAPS);
>  
>  	ep->ob_mapped_addr = devm_kcalloc(dev, ep->num_ob_windows,
>  					  sizeof(*ep->ob_mapped_addr),
> -- 
> 2.32.0
> 

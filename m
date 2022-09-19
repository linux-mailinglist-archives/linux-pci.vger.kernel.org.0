Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81A5BD3AF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiISR3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISR3W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:29:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496743D594;
        Mon, 19 Sep 2022 10:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0A9B81EF0;
        Mon, 19 Sep 2022 17:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66097C433D6;
        Mon, 19 Sep 2022 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608558;
        bh=uAaDMBR6wdaIdoGJly4nKlVmMPFF45TGloJtwL9jCQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WS4pPJw6ZjGnVbVrKKmm0gRGZT/xqQLvhHeIzfGUu7y8sPBpLRVJ8BIaEpgk8bLtn
         cmlG0Z6qwPlS08fSNaHElASfXrK5vywcJvkGE6QH8+5O/G7QttS7iZTScH4A5VIyao
         lrDCUXClOgpQ/aG8izxixdHhx9MEvJc4ZbP4jNYlodjvspRR4aLRDbcmXmQ868OorQ
         SvHjwFDpW2lVBBM2AC8vb0ZYYvgbe73/gJxt/QcyLlrLPsV8P3uskgmnyRYBmJnfgS
         +1jylAC83Mf+CeT73Lrs1GvV6iKEzyfpm8ac6tFsDhIZynjars2KBWh62RY6bOV6o4
         gH88aWOHedQAQ==
Date:   Mon, 19 Sep 2022 12:29:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Fixes N_FTS setup
Message-ID: <20220919172916.GA1012108@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919143123.28250-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, "Fix" (not "Fixes") so it's an imperative verb.  Maybe
"Fix n_fts[] array overrun" to be more specific.

On Mon, Sep 19, 2022 at 08:01:23PM +0530, Vidya Sagar wrote:
> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> unnecessarily uses pci->link_gen in deriving the index to the

Not just "unnecessarily"; using pci->link_gen is *incorrect* since
only [0] and [1] are defined.

> n_fts[] array also introducing the issue of accessing beyond the
> boundaries of array for greater than Gen-2 speeds. This change fixes
> that issue.
> 
> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c6725c519a47..9e4d96e5a3f5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -641,7 +641,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	if (pci->n_fts[1]) {
>  		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  		val &= ~PORT_LOGIC_N_FTS_MASK;
> -		val |= pci->n_fts[pci->link_gen - 1];
> +		val |= pci->n_fts[1];
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>  	}
>  
> -- 
> 2.17.1
> 

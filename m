Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28B553EB3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354008AbiFUWt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFUWt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 18:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B11EED5;
        Tue, 21 Jun 2022 15:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EEA61751;
        Tue, 21 Jun 2022 22:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BECC3411C;
        Tue, 21 Jun 2022 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655851794;
        bh=S8AJMDPQvnWDK4RahqwN098Ni4YLzb9Wd07uSaNuGok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eTGz6L4kA48Wrl3e0Yf7md34NbBtsEwow9/b2efRVFJMycOz66tK1d8QbPzJgs9kS
         tqbWmTERX+OlVi8A/z8lo3A/7qT1hhjegWoQwmJ51bPlSOk6xIOJKIJac0pGjCacgH
         8P70Xb0DWyBpp/CD2fPtQl+1jE9Uh2aMIPGRWhcLldSr6m4ckeNjoc77Mzkm6Ip6ru
         /Eg0NA98+vIXumy/7kYKJkHC/DapI6I0JVvNbJp1qAhn6doDrpoW86xggD0qC0ez4P
         Nu9HxNaVOnjGiQ2v3XWPiD57U/UugQOz8qD0fpSWrPR36Wa00O+lqJtkme4RdFey2A
         C7B5nk/gqQmKg==
Date:   Tue, 21 Jun 2022 17:49:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pci/controller/pcie-rcar-host: Hold the reference
 returned by of_find_matching_node
Message-ID: <20220621224952.GA1340618@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621070145.4080147-1-windhl@126.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 03:01:45PM +0800, Liang He wrote:
> In rcar_pcie_init(), we need to hold the reference returned by
> of_find_matching_node() which is used to call of_node_put() for
> refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 997c4df6a1e7..405ec3d64f30 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -1158,7 +1158,10 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
>  
>  static int __init rcar_pcie_init(void)
>  {
> -	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> +	struct device_node *np = of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
> +
> +	if (np) {
> +		of_node_put(np);

I think this is correct, but it would be nicer to update the way this
driver uses of_device_get_match_data(), e.g.,

  struct rcar_variant {
    int (*phy_init_fn)(struct rcar_pcie_host *host);
    bool hook_abort;
  };

  struct rcar_pcie_host {
    ...
    const struct rcar_variant *variant;
  };

  static int rcar_pcie_probe(...)
  {
    host->variant = of_device_get_match_data(dev);
    err = host->variant->phy_init_fn(host);
    ...

  #ifdef CONFIG_ARM
    if (host->variant->hook_abort) {
  #ifdef CONFIG_ARM_LPAE
      hook_fault_code(17, ...);
  # else
      hook_fault_code(22, ...);
  #endif
    }
  #endif
  }

Or keep the hook in a separate function called from rcar_pcie_probe()
if you think that's cleaner.

I'm not sure hook_fault_code() needs to be called separately as a
device_initcall().  The pci-ixp4xx.c driver does it in
ixp4xx_pci_probe(), so I assume rcar could do it in probe as well.

>  #ifdef CONFIG_ARM_LPAE
>  		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>  				"asynchronous external abort");
> -- 
> 2.25.1
> 

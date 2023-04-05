Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111C96D7DC7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjDENeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjDENeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 09:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04740C8
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 06:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DBF63CC9
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 13:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E24C433D2;
        Wed,  5 Apr 2023 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680701644;
        bh=f6gkHaTc+CjcGgUiWVYWOkA9T6plF3FiYzVAO3BHDII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VulJbng19+ds/o7e2X8dt2HNaIGjXiJVL92Szr8T4upPUZcoA20sLH3pApk7CwBkn
         psWXcJd6f7Fh7O9v0NhFsroFnWPAhWd0CePDpiTaf7tqDJm3owxunVHKE/xOMaQ2HE
         lLAw6tbdPStmGcabmjrKZF5q0mYf9/+du/lCnTHlYSLt24DElTYyIAFEQt5ylFvEbK
         O0/LIOoDhwYvo+OuujW7ervM0sErBy9/iAH0+7OIQscdvmvRblRitg9EREI4oNsoT7
         WJfssW8SBYGEvDnMCjUmmIttK6tDmq3dnLPxWFa3aCXA1VJtYBnQa0KTd72X0u2Q35
         8Es7yv9LpAKJQ==
Date:   Wed, 5 Apr 2023 15:33:58 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, nikhilnd@google.com,
        manugautam@google.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Allow platform driver to skip the wait for link
Message-ID: <ZC14xhSc9e9nt72k@lpieralisi>
References: <20230404174141.4091634-1-ajayagarwal@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404174141.4091634-1-ajayagarwal@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 04, 2023 at 11:11:41PM +0530, Ajay Agarwal wrote:
> Currently as a part of device probe, the driver waits for the
> link to come up for up to 1 second. If the link training is not
> enabled by default or as a part of host_init, then this wait for
> the link can be skipped to save the 1 second of wait time.
> 
> Allow the platform driver to skip this wait for the link up by
> setting a flag `skip_wait_for_link`. This flag will be false by
> default, thereby preserving the legacy behavior for existing
> platform drivers.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

A previous patch handles this change, dropping this one,
please chime in in this thread if needed:

https://lore.kernel.org/linux-pci/ZC12lN9Cs0QlPhVh@lpieralisi

> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..3425eb17b467 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -491,8 +491,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_remove_edma;
>  	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +	/*
> +	 * If the platform driver sets `skip_wait_for_link` because it knows the
> +	 * link will not be up, do not wait for it. Save 1 sec of wait time.
> +	 * Else, test for the link. Ignore errors, the link may come up later
> +	 */
> +	if (!pp->skip_wait_for_link)
> +		dw_pcie_wait_for_link(pci);
>  
>  	bridge->sysdata = pp;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..f8f6dad5c948 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -297,6 +297,7 @@ struct dw_pcie_host_ops {
>  struct dw_pcie_rp {
>  	bool			has_msi_ctrl:1;
>  	bool			cfg0_io_shared:1;
> +	bool			skip_wait_for_link:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
>  	u32			cfg0_size;
> -- 
> 2.40.0.348.gf938b09366-goog
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97AC614AF5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKAMmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiKAMmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA05193D4;
        Tue,  1 Nov 2022 05:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A0EB81C89;
        Tue,  1 Nov 2022 12:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B20C433D7;
        Tue,  1 Nov 2022 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667306531;
        bh=2T8WNwxqXqc4RLKndjcY8hK2X8Sm42uT6q5iYuYCI0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oowB+qf809zDTaZa0PPPDXyXF8gVHv3RUCeKkugeClUsyVcP0fGXJarruWLLHoTC8
         qaEK9kBgy81uuL2eA523sDFI23RmldTXqawWSakleZU7HQtVebd57dWtbeUWyoUX9u
         mgQAG1SDTUg59Mn2uPMZ2DXdj91zerl3s7yYQOAfoYJUFIFTmRQ67TiFvVA+TmYLNG
         Iv6eEn0y2ARROfoFiHU3lQtu+wmREdyx+rXzCr3IDrK0xjaeKBBho/H15xX2Ctb93n
         YyuEoBbvIZKVMJ4f9D+FmHZugN/aqNuKnQ2rMuLI8CB8BRJ2+mJklgboMcL7gX+uLG
         qwejXkxAJ9Lzg==
Date:   Tue, 1 Nov 2022 18:12:00 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@ti.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/4] PCI: endpoint: Add core_deinit() callback support
Message-ID: <20221101124200.GL54667@thinkpad>
References: <20221013181815.2133-1-vidyas@nvidia.com>
 <20221013181815.2133-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013181815.2133-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:48:12PM +0530, Vidya Sagar wrote:
> The endpoint function driver should undo the things done in core_init()
> and stop hardware access before deinitializing the controller. Add
> core_deinit() callback support for function driver to do this cleanup.
> This core_deinit() callback should be invoked by the controller driver
> before deinitializing the controller.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Reworded the commit message
> 
>  drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  1 +
>  include/linux/pci-epf.h             |  2 ++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5dac1496cf16..689450f01f75 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -732,6 +732,32 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>  
> +/**
> + * pci_epc_deinit_notify() - Notify the EPF device that EPC device's core
> + *			     deinitialization is scheduled.
> + * @epc: the EPC device whose core deinitialization is scheduled
> + *
> + * Invoke to Notify the EPF device that the EPC device's deinitialization
> + * is scheduled.
> + */
> +void pci_epc_deinit_notify(struct pci_epc *epc)
> +{
> +	struct pci_epf *epf;
> +
> +	if (!epc || IS_ERR(epc))
> +		return;
> +
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops->core_deinit)

I've added a check for the existence of the "event_ops" in latest series.
Please rebase on top of that and add the check here too.

Thanks,
Mani

> +			epf->event_ops->core_deinit(epf);
> +		mutex_unlock(&epf->lock);
> +	}
> +	mutex_unlock(&epc->list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
> +
>  /**
>   * pci_epc_destroy() - destroy the EPC device
>   * @epc: the EPC device that has to be destroyed
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 301bb0e53707..b95dc4b3e302 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -204,6 +204,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>  		    enum pci_epc_interface_type type);
>  void pci_epc_linkup(struct pci_epc *epc);
>  void pci_epc_init_notify(struct pci_epc *epc);
> +void pci_epc_deinit_notify(struct pci_epc *epc);
>  void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>  			enum pci_epc_interface_type type);
>  int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index a215dc8ce693..fa51579951db 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -70,10 +70,12 @@ struct pci_epf_ops {
>  /**
>   * struct pci_epf_event_ops - Callbacks for capturing the EPC events
>   * @core_init: Callback for the EPC initialization complete event
> + * @core_deinit: Callback for the EPC deinitialization schedule event
>   * @link_up: Callback for the EPC link up event
>   */
>  struct pci_epc_event_ops {
>  	int (*core_init)(struct pci_epf *epf);
> +	int (*core_deinit)(struct pci_epf *epf);
>  	int (*link_up)(struct pci_epf *epf);
>  };
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

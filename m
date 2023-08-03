Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825776F0DE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjHCRtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHCRtD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44126B0;
        Thu,  3 Aug 2023 10:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9CF461E5C;
        Thu,  3 Aug 2023 17:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA3C433A9;
        Thu,  3 Aug 2023 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691084941;
        bh=C3EhZYhj82BKeLNH1HhVbGXNirtaaI5YpWmbbR1WRck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iltd8JX2GG8nsjTGgqHnRTAmEKwmHNZsEm6WyHfv2tNCXf8cd7Ksi1kW/E87veKpb
         EirQDclO6R1A+i1RNq8lNfz+fTbJeFBzKwqE02vLFsAHUldYstKxYMS79Ng60w3FNt
         EN9hNED5IxKGpKB2xqL1eC3WhfKnbPXcKrxzEA+czDIQvpTqkByTpi1dLotJQ2ol/5
         G7wmft1DHdDbfxUEdg4wClCU+o35OPMezubtwLDE2xvmLqvwcVpvAUWrLjPniY+29Q
         /Tj8GSZHUPK7nvIjMY28zSX84RI+rtFeLqpPTKAUtvythrewrictw6mLAtC2Ekfx0K
         I5TXHgJOcdGEg==
Date:   Thu, 3 Aug 2023 12:48:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
Message-ID: <20230803174858.GA103086@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690948281-2143-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 09:21:18AM +0530, Krishna chaitanya chundru wrote:
> Add support to notify the EPF device about the D-state change event
> from the EPC device.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst |  4 ++++
>  drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
>  include/linux/pci-epc.h                     |  1 +
>  include/linux/pci-epf.h                     |  1 +
>  4 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4f5622a..66f3191 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -78,6 +78,10 @@ by the PCI controller driver.
>     Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
>  
>  
> +* pci_epc_dstate_notity()

s/notity/notify/ (several instances)

> +
> +   Notify all the function drivers that the EPC device has changed its D-state.
> +
>  EPC APIs for the PCI Endpoint Function Driver
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c54fa5..4cf9c82 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>  
>  /**
> + * pci_epc_dstate_notity() - Notify the EPF driver that EPC device D-state
> + *			has changed
> + * @epc: the EPC device which has change in D-state
> + * @state: the changed D-state
> + *
> + * Invoke to Notify the EPF device that the EPC device has D-state has
> + * changed.

s/device has D-state/device D-state/

> + */
> +void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
> +{
> +	struct pci_epf *epf;
> +
> +	if (!epc || IS_ERR(epc))
> +		return;

Is this needed?  Looks like a programming error if we return here.  I
don't like silently ignoring errors like this.  I generally prefer
taking the NULL pointer dereference oops so we know the caller is
broken and can fix it.

> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops && epf->event_ops->dstate_notify)
> +			epf->event_ops->dstate_notify(epf, state);
> +		mutex_unlock(&epf->lock);
> +	}
> +	mutex_unlock(&epc->list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_dstate_notity);
> +
> +/**
>   * pci_epc_destroy() - destroy the EPC device
>   * @epc: the EPC device that has to be destroyed
>   *
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb6940..26a1108 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -251,4 +251,5 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size);
> +void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state);
>  #endif /* __LINUX_PCI_EPC_H */
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 3f44b6a..529075b 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
>  	int (*link_up)(struct pci_epf *epf);
>  	int (*link_down)(struct pci_epf *epf);
>  	int (*bme)(struct pci_epf *epf);
> +	int (*dstate_notify)(struct pci_epf *epf, pci_power_t state);
>  };
>  
>  /**
> -- 
> 2.7.4
> 

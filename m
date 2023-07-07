Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8274AABA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGGFpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 01:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGGFpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 01:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054F1BE9;
        Thu,  6 Jul 2023 22:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8812B6172F;
        Fri,  7 Jul 2023 05:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A9C433C7;
        Fri,  7 Jul 2023 05:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688708710;
        bh=JCAAcs0eH4fcBRh9GiWMIDfHTh9vSCIDK0dDnFUrOdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4i6mHxi4K5AXjJVKN2O71jAe7SeWukkMNI5oPd8abjnKa9ysGdNuxRHNjHob0lep
         kniWKEImQ14AADEDOOSrjnwmORZa2RaXq89sdCq94L3JHhG5OSb+bqtb0vcGOtP9dS
         Pb48Qlr7JnDgnNIGMTnHNvSGR5NIfc7i7R5YVKu79UqLOB+0uznvTvieKLCVUYxogk
         vz/A+DSAVEAozbApszTGQKAbI5xEwSzIuZSx6rDEpU137VXbNFlKOFqp1hbXPCYXWy
         dTIzNS5fw5pr/NxZQtuqF4txt/9nK4IUs4kx5TLGFk+yp5Ure7UdEeko1ePvcQdHxe
         5BuHrC2Pw1PXQ==
Date:   Fri, 7 Jul 2023 11:14:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] PCI: endpoint: Add dstate change notifier support
Message-ID: <20230707054454.GA6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:04PM +0530, Krishna chaitanya chundru wrote:
> Add support to notify the EPF device about the D-state change event
> from the EPC device.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst |  5 +++++
>  drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
>  include/linux/pci-epc.h                     |  1 +
>  include/linux/pci-epf.h                     |  1 +
>  4 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4f5622a..0538cdc 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -78,6 +78,11 @@ by the PCI controller driver.
>     Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
>  
>  
> +* pci_epc_dstate_change()
> +
> +   In order to notify all the function devices that the EPC device has
> +   changed its D-state.
> +
>  EPC APIs for the PCI Endpoint Function Driver
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c54fa5..cad360f 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>  
>  /**
> + * pci_epc_dstate_change() - Notify the EPF device that EPC device D-state
> + *			has changed
> + * @epc: the EPC device which has change in D-state
> + * @state: the changed D-state
> + *
> + * Invoke to Notify the EPF device that the EPC device has D-state has
> + * changed.
> + */
> +void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state)

How about "pci_epc_dstate_notity()"?

Rest looks good.

- Mani

> +{
> +	struct pci_epf *epf;
> +
> +	if (!epc || IS_ERR(epc))
> +		return;
> +
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops && epf->event_ops->dstate_change)
> +			epf->event_ops->dstate_change(epf, state);
> +		mutex_unlock(&epf->lock);
> +	}
> +	mutex_unlock(&epc->list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_dstate_change);
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
> index 4b52807..1d3c2a2 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
>  	int (*link_up)(struct pci_epf *epf);
>  	int (*link_down)(struct pci_epf *epf);
>  	int (*bme)(struct pci_epf *epf);
> +	int (*dstate_change)(struct pci_epf *epf, pci_power_t state);
>  };
>  
>  /**
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

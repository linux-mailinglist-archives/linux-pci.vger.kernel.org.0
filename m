Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177374AAED
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGGGEo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 02:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGGEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 02:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4343183;
        Thu,  6 Jul 2023 23:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3140661378;
        Fri,  7 Jul 2023 06:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1495C433C8;
        Fri,  7 Jul 2023 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709881;
        bh=owEQVoU9nK4o1pE8uT729xxgr3HziVjaMVnqjf3zqfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI37CYcDHTk1v1yTLzi4lZ41KiKweHWOYJoEcF/AZylBbTvBFTAh7jVLkraTb44f/
         hmvuMJ7fMjUrb2L6QNp6xW9pQA4Wun+jdemxefCMZ0Wkfd08DGQBjPObzRjBir3I6L
         Z9NVTbBNCN5h0l3DRiw2p9kNPZjeYHwZg7vUHkA9lPkig6L0opbqLHD9UR0SsLxW0A
         nGoGafk7xXbZH9SUx/TYRS6CEWnKTpRHaDSdQwmzgFPUkDbta65dOFNFsiJGnL48d+
         wp1AdcvVgAsQoe+UUkp8DlLHrZq359FLpvMCYTVJqY5iYlaS1bNf7p48oHQR7ZbjNo
         tnBrxzr7B3p2g==
Date:   Fri, 7 Jul 2023 11:34:25 +0530
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
Subject: Re: [PATCH v2 4/8] PCI: endpoint: Add wakeup host API to EPC core
Message-ID: <20230707060425.GD6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-5-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-5-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:07PM +0530, Krishna chaitanya chundru wrote:
> Endpoint cannot send any data/MSI when the D-state is in
> D3cold or D3hot. Endpoint needs to bring the host back to D0

Endpoint needs to wake up the host to bring the D-state to D0

> to send any kind of data.
> 
> Endpoint can toggle wake signal when the D-state is in D3cold and vaux is
> not supplied or can send inband PME.
> 
> To support this adding wake up host to epc core.
> 

"add wakeup_host() callback to the EPC core".


> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst |  6 ++++++
>  drivers/pci/endpoint/pci-epc-core.c         | 31 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h                     | 11 ++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 0538cdc..186ce3b 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -53,6 +53,7 @@ by the PCI controller driver.
>  	 * raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
>  	 * start: ops to start the PCI link
>  	 * stop: ops to stop the PCI link
> +	 * wakeup_host: ops to wake host

wakeup

>  
>     The PCI controller driver can then create a new EPC device by invoking
>     devm_pci_epc_create()/pci_epc_create().
> @@ -122,6 +123,11 @@ by the PCI endpoint function driver.
>     The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>     free the memory space allocated using pci_epc_mem_alloc_addr().
>  
> +* pci_epc_wakeup_host()
> +
> +   The PCI endpoint function driver should use pci_epc_wakeup_host() to wake

wakeup

> +   host.
> +
>  Other EPC APIs
>  ~~~~~~~~~~~~~~
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index cad360f..23599b8 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -167,6 +167,37 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>  
>  /**
> + * pci_epc_wakeup_host() - Wakeup the host
> + * @epc: the EPC device which has to wake the host

wakeup

> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @type: specify the type of wakeup: WAKEUP_FROM_D3COLD, WAKEUP_FROM_D3HOT
> + *
> + * Invoke to wakeup host
> + */
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			enum pci_epc_wakeup_host_type type)

Why can't you use a bool?

- Mani

> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +
> +	if (!epc->ops->wakeup_host)
> +		return 0;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no, type);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);
> +
> +/**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
>   *
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 26a1108..2323a10 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -26,6 +26,12 @@ enum pci_epc_irq_type {
>  	PCI_EPC_IRQ_MSIX,
>  };
>  
> +enum pci_epc_wakeup_host_type {
> +	PCI_WAKEUP_UNKNOWN,
> +	PCI_WAKEUP_SEND_PME,
> +	PCI_WAKEUP_TOGGLE_WAKE,
> +};
> +
>  static inline const char *
>  pci_epc_interface_string(enum pci_epc_interface_type type)
>  {
> @@ -59,6 +65,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @wakeup_host: ops to wakeup the host
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -88,6 +95,8 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				enum pci_epc_wakeup_host_type type);
>  	struct module *owner;
>  };
>  
> @@ -234,6 +243,8 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +					enum pci_epc_wakeup_host_type type);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

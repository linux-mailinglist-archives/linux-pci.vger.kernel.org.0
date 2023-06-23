Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622D73B032
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFWFna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWFn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 01:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B054E46;
        Thu, 22 Jun 2023 22:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D8D061987;
        Fri, 23 Jun 2023 05:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA4C433C0;
        Fri, 23 Jun 2023 05:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687499007;
        bh=MYGG5cGrVBYsNDfhjkbhLquFlj7sZGMulbxa+VzidYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSahqqew1oabjk0qHPGkyWZkQbRye24+ZmhkAmK31tjBf34wBGPvyfhujOmgUipPy
         uv753O6l+9Ti3s6XqElDRbPB9oZHTUjYkRZAwH6kuYApgZm4kJDCe4zTBoruEvZMo5
         julQg7+6lMEdNCwv02fD//PaNuW7pPkFewQlSimO4W9xFgV3Vt1egrd+uz+kiPNqhI
         WUyrBzGvBHZU1hcLQBO1pV9+2fQJyseB1BFhttCO7JU2GJgiEWLZLdVaRGx9Us/jlL
         KNSJrmqrM729cMtMHQ2eQKntRU06OOUNH2qewiBZWMox+qSXNfGOGm8bcOjFw5s93h
         apbrPh/FfI9Yw==
Date:   Fri, 23 Jun 2023 11:13:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 1/3] PCI: endpoint: Add wakeup host API to EPC core
Message-ID: <20230623054313.GB5611@thinkpad>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 08:30:47PM +0530, Krishna chaitanya chundru wrote:
> Endpoint cannot send any data/MSI when the device state is in
> D3cold or D3hot. Endpoint needs to bring the device back to D0
> to send any kind of data.
> 
> For this endpoint can send inband PME the device is in D3hot or
> toggle wake when the device is D3 cold.
> 

Are you referring to "host" as the "device"? If so, then it is a wrong
terminology.

> To support this adding wake up host to epc core.
> 

Commit message should be imperative.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 29 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 46c9a5c..d203947 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -167,6 +167,35 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>  
>  /**
> + * pci_epc_wakeup_host() - interrupt the host system

s/interrupt the host system/Wakeup the host

> + * @epc: the EPC device which has to interrupt the host

s/interrupt/wake

> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + *
> + * Invoke to wakeup host
> + */
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +

Use proper errno for both of the above.

- Mani

> +	if (!epc->ops->wakeup_host)
> +		return 0;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no);
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
> index 301bb0e..a8496be 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -59,6 +59,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @wakeup_host: ops to wakeup the host
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -88,6 +89,7 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>  	struct module *owner;
>  };
>  
> @@ -232,6 +234,7 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C736D3077BA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhA1ONu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 09:13:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45074 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhA1ONt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 09:13:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SEC2pA032804;
        Thu, 28 Jan 2021 08:12:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611843122;
        bh=AudpKSlaZboe1uf2RLBPZd0j5l8pLIG2KQCVcoHb/Pk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uPJ7p4RKAidWFI38PN1NVSopf6Q7AB8r16q1edIU8BR6ItGm+4Fdt1N/Y0DtJXhvi
         q4K257lDVAD5/IKRGm5H8F/CauOzOtcX1Ac6+XDTM5ToStp5yrE69X1RJEFqxm5lw4
         GBgIKOUbMCy0nGkR07Nk0IT2mcN8fYDJN6RbIFFY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SEC2n4026339
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 08:12:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 08:12:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 08:12:02 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SEBwH7081595;
        Thu, 28 Jan 2021 08:11:59 -0600
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Add 'started' to pci_epc to set
 whether the controller is started
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1611500977-24816-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1253c4c9-4e5e-1456-6475-0334f3bb8634@ti.com>
Date:   Thu, 28 Jan 2021 19:41:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611500977-24816-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kunihiko,

On 24/01/21 8:39 pm, Kunihiko Hayashi wrote:
> This adds a member 'started' as a boolean value to struct pci_epc to set
> whether the controller is started, and also adds a function to get the
> value.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 2 ++
>  include/linux/pci-epc.h             | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index cc8f9eb..2904175 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -174,6 +174,7 @@ void pci_epc_stop(struct pci_epc *epc)
>  
>  	mutex_lock(&epc->lock);
>  	epc->ops->stop(epc);
> +	epc->started = false;
>  	mutex_unlock(&epc->lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_stop);
> @@ -196,6 +197,7 @@ int pci_epc_start(struct pci_epc *epc)
>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->start(epc);
> +	epc->started = true;
>  	mutex_unlock(&epc->lock);
>  
>  	return ret;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index b82c9b1..5808952 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -131,6 +131,7 @@ struct pci_epc_mem {
>   * @lock: mutex to protect pci_epc ops
>   * @function_num_map: bitmap to manage physical function number
>   * @notifier: used to notify EPF of any EPC events (like linkup)
> + * @started: true if this EPC is started
>   */
>  struct pci_epc {
>  	struct device			dev;
> @@ -145,6 +146,7 @@ struct pci_epc {
>  	struct mutex			lock;
>  	unsigned long			function_num_map;
>  	struct atomic_notifier_head	notifier;
> +	bool				started;
>  };
>  
>  /**
> @@ -191,6 +193,11 @@ pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
>  	return atomic_notifier_chain_register(&epc->notifier, nb);
>  }
>  
> +static inline bool pci_epc_is_started(struct pci_epc *epc)
> +{
> +	return epc->started;
> +}

This should also be protected.

Thanks
Kishon
> +
>  struct pci_epc *
>  __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  		      struct module *owner);
> 

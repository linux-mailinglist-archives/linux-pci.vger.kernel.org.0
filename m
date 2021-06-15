Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7393A8384
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFOPEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 11:04:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44818 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFOPED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 11:04:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FF1r1a077794;
        Tue, 15 Jun 2021 10:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623769313;
        bh=SMNC3bHLVtX6F1a9DdwqvZyoa3Nt8WWDSWIEdLIOPoU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BGdXCCgwQv70d7YqQ/UoGt5nRhae0NBbQ91+EnLDmTQQZkG7h/VGg4ZHtTHv8Hb96
         i79DIbeKTWxcRoCDOqSQq2rwdzM63C7Z3zrgzDVz8juJ7iUqoXmph6tXY9ftJZ5Qdk
         M3hRqtJrVI7Z9Mm7tmWEsBiNUHYV+Uiuyu78EjIU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FF1rWn003443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 10:01:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 10:01:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 10:01:53 -0500
Received: from [10.250.233.8] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FF1nb2003998;
        Tue, 15 Jun 2021 10:01:50 -0500
Subject: Re: [PATCH] PCI: endpoint: Add custom notifier support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <smohanad@codeaurora.org>
References: <20210615133704.88169-1-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9021212f-aa5d-770d-c455-c632dd79e7f8@ti.com>
Date:   Tue, 15 Jun 2021 20:31:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210615133704.88169-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

On 15/06/21 7:07 pm, Manivannan Sadhasivam wrote:
> Add support for passing the custom notifications between the endpoint
> controller and the function driver. This helps in passing the
> notifications that are more specific to the controller and corresponding
> function driver. The opaque `data` arugument in pci_epc_custom_notify()
> function can be used to carry the event specific data that helps in
> differentiating the events.
> 
> For instance, the Qcom EPC device generates specific events such as
> MHI_A7, BME, DSTATE_CHANGE, PM_TURNOFF etc... These events needs to be
> passed to the function driver for proper handling. Hence, this custom
> notifier can be used to pass these events.

Bus master enable and PME events sounds generic events and not QCOM
specific. Also this patch should be sent along with how it's going to be
used in function driver.

In general my preference would be to add only well defined notifiers
given that the endpoint function drivers are generic.

Thanks
Kishon

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 19 +++++++++++++++++++
>  include/linux/pci-epc.h             |  1 +
>  include/linux/pci-epf.h             |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index adec9bee72cf..86b6934c6297 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -658,6 +658,25 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>  
> +/**
> + * pci_epc_custom_notify() - Notify the EPF device about the custom events
> + *			     in the EPC device
> + * @epc: EPC device that generates the custom notification
> + * @data: Data for the custom notifier
> + *
> + * Invoke to notify the EPF device about the custom events in the EPC device.
> + * This notifier can be used to pass the EPC specific custom events that are
> + * shared with the EPF device.
> + */
> +void pci_epc_custom_notify(struct pci_epc *epc, void *data)
> +{
> +	if (!epc || IS_ERR(epc))
> +		return;
> +
> +	atomic_notifier_call_chain(&epc->notifier, CUSTOM, data);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_custom_notify);
> +
>  /**
>   * pci_epc_destroy() - destroy the EPC device
>   * @epc: the EPC device that has to be destroyed
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index b82c9b100e97..13140fdbcdf6 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -203,6 +203,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>  		    enum pci_epc_interface_type type);
>  void pci_epc_linkup(struct pci_epc *epc);
>  void pci_epc_init_notify(struct pci_epc *epc);
> +void pci_epc_custom_notify(struct pci_epc *epc, void *data);
>  void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>  			enum pci_epc_interface_type type);
>  int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..8d740c5cf0e3 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -20,6 +20,7 @@ enum pci_epc_interface_type;
>  enum pci_notify_event {
>  	CORE_INIT,
>  	LINK_UP,
> +	CUSTOM,
>  };
>  
>  enum pci_barno {
> 

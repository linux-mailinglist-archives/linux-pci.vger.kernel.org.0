Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA65FB2BB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJKM6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJKM6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 08:58:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCFD915FB;
        Tue, 11 Oct 2022 05:57:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BCvf5l074097;
        Tue, 11 Oct 2022 07:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665493061;
        bh=4QaEQ1R82eVCDdFcuqQYOfjMLD/kzAy79NfsUuxoHeY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KD2ZPsLvWvuHgclLcmIDfEiwu3a1Nrl4hvNBdYT57yFX8wAnWHuT809lB34khCUdv
         vIXA7iyi1IFL9VngsZvv1+L8cxCA4MxVkY/HVzvGLDsaujfl+4/0WbPj7mbAtsOyGL
         IWZE+YkBDM0jrz0GKDS22Ikg7rj+0aNWdbRO9EI0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BCvfBR034977
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 07:57:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 07:57:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 07:57:41 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BCvbBO019814;
        Tue, 11 Oct 2022 07:57:38 -0500
Subject: Re: [PATCH v3 4/5] PCI: endpoint: Use callback mechanism for passing
 events from EPC to EPF
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kishon@kernel.org>, <lpieralisi@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <vidyas@nvidia.com>,
        <vigneshr@ti.com>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-5-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b6001af6-4c41-a678-b3cb-4c1d874425bf@ti.com>
Date:   Tue, 11 Oct 2022 18:27:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221006134927.41437-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 06/10/22 7:19 pm, Manivannan Sadhasivam wrote:
> Instead of using the notifiers for passing the events from EPC to EPF,
> let's introduce a callback based mechanism where the EPF drivers can
> populate relevant callbacks for EPC events they want to subscribe.
> 
> The use of notifiers in kernel is not recommended if there is a real link
> between the sender and receiver, like in this case. Also, the existing
> atomic notifier forces the notification functions to be in atomic context
> while the caller may be in non-atomic context. For instance, the two
> in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
> calling the notifier functions in non-atomic context (from threaded IRQ
> handlers). This creates a sleeping in atomic context issue with the
> existing EPF_TEST driver that calls the EPC APIs that may sleep.
> 
> For all these reasons, let's get rid of the notifier chains and use the
> simple callback mechanism for signalling the events from EPC to EPF
> drivers. This preserves the context of the caller and avoids the latency
> of going through a separate interface for triggering the notifications.
> 
> As a first step of the transition, the core_init() callback is introduced
> in this commit, that'll replace the existing CORE_INIT notifier used for
> signalling the init complete event from EPC.
> 
> During the occurrence of the event, EPC will go over the list of EPF
> drivers attached to it and will call the core_init() callback if available.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
>   drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
>   include/linux/pci-epf.h                       | 11 ++++++++++-
>   3 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index a6f906a96669..868de17e1ad2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>   	return 0;
>   }
>   
> +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> +	.core_init = pci_epf_test_core_init,
> +};
> +
>   static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
>   				 void *data)
>   {
>   	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -	int ret;
>   
>   	switch (val) {
> -	case CORE_INIT:
> -		ret = pci_epf_test_core_init(epf);
> -		if (ret)
> -			return NOTIFY_BAD;
> -		break;
> -
>   	case LINK_UP:
>   		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>   				   msecs_to_jiffies(1));
> @@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
>   
>   	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>   
> +	epf->event_ops = &pci_epf_test_event_ops;

Doesn't this ignore epc_features input from the controller driver?
> +
>   	epf_set_drvdata(epf, epf_test);
>   	return 0;
>   }
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6cce430d431b..ba54f17ae06f 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
>    */
>   void pci_epc_init_notify(struct pci_epc *epc)
>   {
> +	struct pci_epf *epf;
> +
>   	if (!epc || IS_ERR(epc))
>   		return;
>   
> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops->core_init)

This would result in abort if the endpoint function driver is not bound 
to endpoint device and the notify is called.

This would also require all function drivers to have event_ops 
populated. IOW this could break pci-epf-ntb.c.

Thanks,
Kishon

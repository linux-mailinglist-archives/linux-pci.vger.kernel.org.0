Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926785A0DB8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiHYKRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiHYKRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:17:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6750F96FD8;
        Thu, 25 Aug 2022 03:17:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27PAHD1O116134;
        Thu, 25 Aug 2022 05:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661422634;
        bh=Cy6RaOYnfZ+sWBkIUc4EoPTKkVnPN7ENJ5BB3QKRBh0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=A9FYR9ONqXevXMXSvrMalCunotd7+bvncGqdAaeLFeen1qTu5dOSYSn/7nYWFUbTe
         Ht+7zmzP7tooR1qG2tvxkZqZ4v4PfzeZTCY7btV6Qe8qZ9naYBQHYBlWajcuDYisb0
         LVZ3RrI+kWfADN4tbCv/ZSbctmPFopNNNNRmqpPA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27PAHDFj018752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Aug 2022 05:17:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 25
 Aug 2022 05:17:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 25 Aug 2022 05:17:13 -0500
Received: from [172.24.147.145] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27PAHAMb093711;
        Thu, 25 Aug 2022 05:17:11 -0500
Message-ID: <c200a544-31fe-b660-82bb-4bbed5acf135@ti.com>
Date:   Thu, 25 Aug 2022 15:47:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>
CC:     <kw@linux.com>, <robh@kernel.org>, <vidyas@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
 <20220811094237.77632-3-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220811094237.77632-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On 11/08/22 15:12, Manivannan Sadhasivam wrote:
> As a part of the transition towards callback mechanism for signalling the
> events from EPC to EPF, let's use the link_up() callback in the place of
> the LINK_UP notifier. This also removes the notifier support completely
> from the PCI endpoint framework.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
>  drivers/pci/endpoint/pci-epc-core.c           |  8 +++--
>  include/linux/pci-epc.h                       |  8 -----
>  include/linux/pci-epf.h                       |  8 ++---
>  4 files changed, 18 insertions(+), 39 deletions(-)
> 

.
.
<snip>
.
.
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 805f3d64f93b..a51ba9f158c3 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -690,10 +690,15 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>   */
>  void pci_epc_linkup(struct pci_epc *epc)
>  {
> +	struct pci_epf *epf;
> +
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		if (epf->event_ops->link_up)
> +			epf->event_ops->link_up(epf);
> +	}

how do you ensure there is no race while invoking the call back
functions during add/remove of epf?

Thanks,
Kishon

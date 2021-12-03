Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2D46712F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 05:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbhLCEja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 23:39:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54764 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhLCEja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 23:39:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B34ZpCr004751;
        Thu, 2 Dec 2021 22:35:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638506151;
        bh=tHOb1/Ot8tnRiuha9yDJRa7nKoMVTneKl4bdf5cHG4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jinjlWOPwewDFjXW8TmrO90isdWlqOxXh8mAD6EW0tqSNlaGsp3jhPnMxeGUMsD4N
         j1rVhB7pzjoUxmYL78r0G0tvrlJ/vMHTxm/LMmF76A+66qI83pts+3VP2QjPS+8bWK
         L6ica782piRFoKaA5/2sLzPYb0ugERO86B870f48=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B34Zpgi053245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 22:35:51 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 22:35:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 22:35:50 -0600
Received: from [10.250.234.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B34ZkPL127255;
        Thu, 2 Dec 2021 22:35:47 -0600
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: register notifier if
 only core_init_notifier is enabled
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <465e7382-5ba5-e380-142d-bffbb0337574@ti.com>
Date:   Fri, 3 Dec 2021 10:05:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630473361-27198-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 01/09/21 10:46 am, Kunihiko Hayashi wrote:
> Need to register pci_epf_test_notifier function even if only
> core_init_notifier is enabled.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Om Prakash Singh <omp@nvidia.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3..80456ad 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -874,7 +874,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		epf_test->dma_supported = false;
>  
> -	if (linkup_notifier) {
> +	if (linkup_notifier || core_init_notifier) {
>  		epf->nb.notifier_call = pci_epf_test_notifier;
>  		pci_epc_register_notifier(epc, &epf->nb);
>  	} else {
> 

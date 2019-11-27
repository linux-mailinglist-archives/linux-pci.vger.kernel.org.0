Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFA10AB8B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 09:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfK0IT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 03:19:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 03:19:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR8JJ3J067346;
        Wed, 27 Nov 2019 02:19:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574842759;
        bh=JD1B6cKRhzsHcZyvChJ7/JL9GOsyPba3BplB3CG9oLA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YIqEU0TVVkXMEdqSAl0bZWoxdsk3K4t9NF7bEAhUO2Zss7uBVsVqHCaa10tLvQEBw
         ay1/9r6e/T9qNToilCbYmV0VSPBizKMHGHxA3uTmnngM0XfgfNer5W2gMeVGTHm54X
         UB8kJg5JoHqa19Ds2e7uv1yKEweGoseLfHvIqifg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR8JJNZ035536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Nov 2019 02:19:19 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 27
 Nov 2019 02:19:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 27 Nov 2019 02:19:19 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR8JEMM117536;
        Wed, 27 Nov 2019 02:19:15 -0600
Subject: Re: [PATCH 2/4] PCI: endpoint: Add notification for core init
 completion
To:     Vidya Sagar <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-3-vidyas@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <122c1625-2075-d34a-80da-8b73a03096d3@ti.com>
Date:   Wed, 27 Nov 2019 13:48:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113090851.26345-3-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/11/19 2:38 PM, Vidya Sagar wrote:
> Add support to send notifications to EPF from EPC once the core
> registers initialization is complete.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 19 ++++++++++++++++++-
>  include/linux/pci-epc.h             |  1 +
>  include/linux/pci-epf.h             |  5 +++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2f6436599fcb..fcc3f7fb19c0 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -542,10 +542,27 @@ void pci_epc_linkup(struct pci_epc *epc)
>  	if (!epc || IS_ERR(epc))
>  		return;
>  
> -	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
> +	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkup);

Is this based on upstream kernel? or did you create this after applying [1]?


[1] -> https://lkml.org/lkml/2019/6/4/633

Thanks
Kishon

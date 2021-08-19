Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4B3F1993
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhHSMix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 08:38:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43278 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbhHSMiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 08:38:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JCc3Nf108100;
        Thu, 19 Aug 2021 07:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629376683;
        bh=z1nW+g9zIkHpaw+tccxrzmsOSrGAMOhi/urgSnCFWcM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hu6jzrWizw+T2dcaXZNxO7qrJ6h4jSnEeCRr6C8ca3+ownMWYEacHq5wbVt0aiYkk
         wqjL+N9oCgPX6l9RTPR4RqEzsOA6J4hSRSxhtLngTi56G1spPooOOTsRD7zb+B82CH
         3nAlvpG/n6bBYMAS4XCcPcRGPqMe5M1b5NRriqpg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JCc2NP032752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 07:38:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 07:38:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 07:38:01 -0500
Received: from [10.250.233.2] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JCbxBQ038396;
        Thu, 19 Aug 2021 07:37:59 -0500
Subject: Re: [PATCH -next] PCI: endpoint: Fix missing unlock on error in
 pci_epf_add_vepf()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20210819080655.316468-1-weiyongjun1@huawei.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b0e3a9b9-3a7b-6d17-aa5d-16001677aca7@ti.com>
Date:   Thu, 19 Aug 2021 18:07:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210819080655.316468-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wei,

On 19/08/21 1:36 pm, Wei Yongjun wrote:
> Add the missing unlock before return from function pci_epf_add_vepf()
> in the error handling case.
> 
> Fixes: b64215ff2b5e ("PCI: endpoint: Add support to add virtual function in endpoint core")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for the patch. Since I had to resend the series, I squashed this
patch into the original series

https://lore.kernel.org/r/20210819123343.1951-3-kishon@ti.com

Thanks
Kishon

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index ec286ee5d04c..8aea16380870 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -200,8 +200,10 @@ int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
>  	mutex_lock(&epf_pf->lock);
>  	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
>  				       BITS_PER_LONG);
> -	if (vfunc_no >= BITS_PER_LONG)
> +	if (vfunc_no >= BITS_PER_LONG) {
> +		mutex_unlock(&epf_pf->lock);
>  		return -EINVAL;
> +	}
>  
>  	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
>  	epf_vf->vfunc_no = vfunc_no;
> 

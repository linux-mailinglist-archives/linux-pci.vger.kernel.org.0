Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAA4AD1F0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiBHHKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 02:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiBHHKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 02:10:49 -0500
X-Greylist: delayed 687 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 23:10:48 PST
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F8C0401EF;
        Mon,  7 Feb 2022 23:10:48 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2186xC14083292;
        Tue, 8 Feb 2022 00:59:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644303552;
        bh=m9vylJW8tDirQfEfr95So3OwXtr11viMpTd50k/FbGs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=xHrIwhbGZcGxu2PcsHKEh2vnA3OCAMEWMxeanFdtwvDYTd8kzL+A2Q4DMqy5oUUTt
         4fZS9VigGUEXsLcW4boqxgFAUML+1s7HAqcvW4aEMjSkxFxA8OELB9CzDIa1W4+7aR
         oyJNCGxSYuvmqlMMBPp+WXhsHWsi29zWMn2LgwxU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2186xCVt130953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 00:59:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 00:59:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 00:59:07 -0600
Received: from [10.250.234.143] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2186x45n108177;
        Tue, 8 Feb 2022 00:59:04 -0600
Subject: Re: [PATCH] PCI: endpoint fix misused goto label
To:     Li Chen <lchen.firstlove@zohomail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fbe4db1f-ce55-8329-f1d0-77511e77e2be@ti.com>
Date:   Tue, 8 Feb 2022 12:29:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/01/22 1:18 pm, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> If we goto err_map_addr here, buf allocated
> via kmalloc won't get freeed, then memoryleak.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 96489cfdf58db..60303223976a1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -441,7 +441,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  		if (!epf_test->dma_supported) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> -			goto err_map_addr;
> +			goto err_dma_map;
>  		}
>  
>  		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
> 

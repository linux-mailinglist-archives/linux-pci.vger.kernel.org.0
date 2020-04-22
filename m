Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51201B36ED
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDVFpj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 01:45:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33566 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVFpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2020 01:45:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03M5jVOj112418;
        Wed, 22 Apr 2020 00:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587534331;
        bh=2ilW87E05nTjAAOgTS7k5+ZAG8XgF67p21mgb9nw34Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ULK5gx34uMiK2sP+W7pwtINzTESkDmx4nb8Sfu45QGkj+uR4Ci/a1e8JjjWELN+fO
         Scl1c6spCFGDPDWt+tqty+ko2DHd+gYHufVqL1boF8YLhE6Dt+4VtidfkuUdPEv574
         Wv0zT0Iu2uB7WTZlqpDVxsY2qd6sbSVVuF88XDdg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03M5jVlP060894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 00:45:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Apr 2020 00:45:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Apr 2020 00:45:30 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M5jS8V075989;
        Wed, 22 Apr 2020 00:45:29 -0500
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Avoid DMA release
 when DMA is unsupported
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1584956747-9273-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <948ae2b0-825e-4557-7e43-16d95d26e9f4@ti.com>
Date:   Wed, 22 Apr 2020 11:15:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1584956747-9273-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kunihiko,

On 3/23/2020 3:15 PM, Kunihiko Hayashi wrote:
> When unbinding pci_epf_test, pci_epf_test_clean_dma_chan() is called in
> pci_epf_test_unbind() even though epf_test->dma_supported is false.
> As a result, dma_release_channel() will occur null pointer access because
> dma_chan isn't set.
> 
> This avoids calling dma_release_channel() if epf_test->dma_supported
> is false.
> 
> Fixes: a1d105d4ab8e ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3b4cf7e..8b4f136 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -609,7 +609,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	int bar;
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
> -	pci_epf_test_clean_dma_chan(epf_test);
> +	if (epf_test->dma_supported)
> +		pci_epf_test_clean_dma_chan(epf_test);

Can you add this check inside the pci_epf_test_clean_dma_chan()?

Thanks
Kishon

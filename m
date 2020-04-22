Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E071B36B5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 07:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDVFMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 01:12:19 -0400
Received: from mx.socionext.com ([202.248.49.38]:9231 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgDVFMT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 01:12:19 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Apr 2020 14:12:17 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 8F37F60057;
        Wed, 22 Apr 2020 14:12:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Apr 2020 14:12:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 49F681A168B;
        Wed, 22 Apr 2020 14:12:17 +0900 (JST)
Received: from [10.213.29.177] (unknown [10.213.29.177])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 9B495120131;
        Wed, 22 Apr 2020 14:12:16 +0900 (JST)
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Avoid DMA release
 when DMA is unsupported
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1584956747-9273-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <d620fbc8-32e9-d722-ce13-d5217331255c@socionext.com>
Date:   Wed, 22 Apr 2020 14:12:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1584956747-9273-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/03/23 18:45, Kunihiko Hayashi wrote:
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
>   drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3b4cf7e..8b4f136 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -609,7 +609,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>   	int bar;
>   
>   	cancel_delayed_work(&epf_test->cmd_handler);
> -	pci_epf_test_clean_dma_chan(epf_test);
> +	if (epf_test->dma_supported)
> +		pci_epf_test_clean_dma_chan(epf_test);
>   	pci_epc_stop(epc);
>   	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>   		epf_bar = &epf->bar[bar];
> 

Gentle ping.
Are there any comments about that?

Thank you,

---
Best Regards
Kunihiko Hayashi

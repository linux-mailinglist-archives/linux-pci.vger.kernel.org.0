Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E826DEA58
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 06:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLEX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 00:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLEX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 00:23:27 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37848268A;
        Tue, 11 Apr 2023 21:23:25 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Apr 2023 13:23:23 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D426D2059053;
        Wed, 12 Apr 2023 13:23:23 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 12 Apr 2023 13:23:23 +0900
Received: from [10.212.156.72] (unknown [10.212.156.72])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id F1E7BB6341;
        Wed, 12 Apr 2023 13:23:22 +0900 (JST)
Message-ID: <ada2062d-c857-97c1-41fe-a2eedde1b832@socionext.com>
Date:   Wed, 12 Apr 2023 13:23:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 02/13] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-3-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230310123510.675685-3-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On 2023/03/10 21:34, Yoshihiro Shimoda wrote:
> In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> results of pcitest with enabled DMA will be "NOT OKAY" on eDMA
> environment.

I also encounted this issue and found this patch before sending my fixes patch
for the same diff as this one.
And I confirmed the issue is fixed using pcitest with eDMA on UniPhier SoCs.

For 02/13 patch if not already merged:

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

> 
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with
> DMA capabilities")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0f9d2ec822ac..172e5ac0bd96 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -112,7 +112,7 @@ static int pci_epf_test_data_transfer(struct
> pci_epf_test *epf_test,
>   				      size_t len, dma_addr_t dma_remote,
>   				      enum dma_transfer_direction dir)
>   {
> -	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ?
> +	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
>   				 epf_test->dma_chan_tx :
> epf_test->dma_chan_rx;
>   	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src :
> dma_dst;
>   	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;

---
Best Regards
Kunihiko Hayashi

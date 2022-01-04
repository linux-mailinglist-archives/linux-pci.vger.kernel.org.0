Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F00483EB9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiADJEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 04:04:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45936 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiADJEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 04:04:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20494WBh110377;
        Tue, 4 Jan 2022 03:04:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641287072;
        bh=We3dvzK5GrcT4Ae0TTa+3toTAl46R4VDvGJazgXnUs4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ceU83156UsJKnOKSSpW8Hln86C+1MOk3+mxLTuoySx4dhQ2/XnbRyfTJYLuipRDS1
         /ket2hLOcezKuj9F3WRlL7ry9NH9H1OgOcAVCARvQBp4j2fAOGlTRgvjKEh1WUOhzf
         3aBqI2Q/gGZwYzQAPv6earNQnS12zf3eFBWFm+ZE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20494WZf102604
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 03:04:32 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 03:04:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 03:04:32 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20494TID097728;
        Tue, 4 Jan 2022 03:04:30 -0600
Subject: Re: [PATCH v2] PCI: endpoint: Use DMA channel's 'dev' for
 dma_map_single()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211116142342.21689-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5589ccbc-af34-e5ff-ff2e-f694c4ea696e@ti.com>
Date:   Tue, 4 Jan 2022 14:34:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116142342.21689-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 16/11/21 7:53 pm, Kishon Vijay Abraham I wrote:
> For the case where the pci-epf-test driver uses DMA for transferring
> data to the root complex device, dma_map_single() is used to map virtual
> address to a physical address (address accessible by DMA controller) and
> provided to the DMAengine API for transferring data. Here instead of
> using the PCIe endpoint controller's 'dev' for dma_map_single(), provide
> DMA channel's 'dev' for dma_map_single() since the data transfer is
> actually done by DMA.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Can this patch be merged?

Thanks,
Kishon

> ---
> Changes from v1:
> Use dmaengine_get_dma_device() to get dma device from channel
> V1: https://lore.kernel.org/r/20211115044944.31103-1-kishon@ti.com
>  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868..51f5b0b7b225 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -314,12 +314,12 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	u32 crc32;
>  	bool use_dma;
>  	phys_addr_t phys_addr;
> +	struct device *dma_dev;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
> @@ -353,6 +353,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  			goto err_dma_map;
>  		}
>  
> +		dma_dev = dmaengine_get_dma_device(epf_test->dma_chan);
>  		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> @@ -402,12 +403,12 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	void *buf;
>  	bool use_dma;
>  	phys_addr_t phys_addr;
> +	struct device *dma_dev;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
> @@ -444,6 +445,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  			goto err_map_addr;
>  		}
>  
> +		dma_dev = dmaengine_get_dma_device(epf_test->dma_chan);
>  		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_TO_DEVICE);
>  		if (dma_mapping_error(dma_dev, src_phys_addr)) {
> 

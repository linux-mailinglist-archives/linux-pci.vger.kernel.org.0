Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D91B397F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgDVH4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 03:56:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57958 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgDVH4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2020 03:56:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03M7ubO6066220;
        Wed, 22 Apr 2020 02:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587542197;
        bh=20AKh3G777jQFV57EX4UtFeCp7GDZMZq/5EgmU1NXL8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bpp8EBJE4ahCgNIXCcNZzdAxhLeuDYXiuLRfSKvXjD9kE9RzPVGxACBpCSbEhpInW
         d0OlYcECAif/vO/MYWsgbdKhM2o7ShEJIqrmRD+jzURcfFHDny1bb09xAOzmg2tDqe
         6PEkmH8DDdIF6ztQ3AfAcOcSDtthMZhj22zLhoD8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M7ubID092056;
        Wed, 22 Apr 2020 02:56:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Apr 2020 02:56:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Apr 2020 02:56:37 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M7uYD8041618;
        Wed, 22 Apr 2020 02:56:35 -0500
Subject: Re: [PATCH v2] PCI: endpoint: functions/pci-epf-test: Avoid DMA
 release when DMA is unsupported
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <95116fe1-7908-1948-9f1e-bf4c8b5f2e2d@ti.com>
Date:   Wed, 22 Apr 2020 13:26:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kunihiko,

On 4/22/2020 12:54 PM, Kunihiko Hayashi wrote:
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

Thank you for fixing this.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Regards
Kishon

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 60330f3e..c89a956 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -187,6 +187,9 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>   */
>  static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>  {
> +	if (!epf_test->dma_supported)
> +		return;
> +
>  	dma_release_channel(epf_test->dma_chan);
>  	epf_test->dma_chan = NULL;
>  }
> 

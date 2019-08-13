Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542138B129
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfHMHcc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 03:32:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHMHcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 03:32:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D7W5l9029662;
        Tue, 13 Aug 2019 02:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565681525;
        bh=e7AMG7951ev/gSm/ZxwAc/vUz78yJRoIOR38wJvbsEQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=vA15E2KqDhUxCEbktr0kOiqPlkw8NiaBaTgfCmxxJkTNzB0Lhu0RghagoH9aJqXAX
         +WwI4mW0eHJ/ijU2MDoMixPk0w1x5C/E3uHJFzmnyrJtaPyKNNB1YlmLu6rkMA3PoP
         VGRI6DJKie0DljFNzjfGu1lhIuZiNFn3OJ+UMMgI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D7W5IJ127313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 02:32:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 02:32:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 02:32:03 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D7Vwjb086106;
        Tue, 13 Aug 2019 02:31:58 -0500
Subject: Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit property
 in EP driver.
To:     Xiaowei Bao <xiaowei.bao@nxp.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <minghuan.Lian@nxp.com>,
        <mingkai.hu@nxp.com>, <roy.zang@nxp.com>, <l.stach@pengutronix.de>,
        <tpiepho@impinj.com>, <leonard.crestez@nxp.com>,
        <andrew.smirnov@gmail.com>, <yue.wang@amlogic.com>,
        <hayashi.kunihiko@socionext.com>, <dwmw@amazon.co.uk>,
        <jonnyc@amazon.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190813062840.2733-1-xiaowei.bao@nxp.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <61e6df1c-a0dc-8f05-f74a-85a3cac9823f@ti.com>
Date:   Tue, 13 Aug 2019 13:00:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813062840.2733-1-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 13/08/19 11:58 AM, Xiaowei Bao wrote:
> The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1
> is 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware,
> so set the bar_fixed_64bit with 0x14.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> v2:
>  - Replace value 0x14 with a macro.
> v3:
>  - No change.
> v4:
>  - send the patch again with '--to'.
> v5:
>  - fix the commit message.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index be61d96..ca9aa45 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -44,6 +44,7 @@ static const struct pci_epc_features ls_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = false,
> +	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
>  };
>  
>  static const struct pci_epc_features*
> 

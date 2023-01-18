Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB91671859
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjARJ7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 04:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjARJyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 04:54:37 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0728F7D2;
        Wed, 18 Jan 2023 01:06:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30I969TF104115;
        Wed, 18 Jan 2023 03:06:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674032769;
        bh=/da+ssa5GDD6vweT7++x50Ek4g6HrX+yJTbxHpmjcwM=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=VyNGN4/1efZ4VWOZP9XZ1ZoGXQAyENpXrPzInwoHAhnEOEfgizsU16ssgE562PMRp
         DRdaKZV1+uC3V60HC9/3mwet8bCBCpAsqqzpLNdjz041VRpbvZ+0nJ8aaXFTTPaMMW
         AkWwnDK2F2Zs2UjXTcVAAcBLeltrPztSxf8LEASw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30I969HG007343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 03:06:09 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 18
 Jan 2023 03:06:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 18 Jan 2023 03:06:08 -0600
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30I963Jf062854;
        Wed, 18 Jan 2023 03:06:04 -0600
Message-ID: <998410e8-7856-2b15-4312-e8f6fe868587@ti.com>
Date:   Wed, 18 Jan 2023 14:36:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>,
        Jian Wang <jian-wang@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: cadence: Fix next function value in case of ARI
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>
References: <20230118072035.3381993-1-a-verma1@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230118072035.3381993-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Achal,

On 18/01/23 12:50, Achal Verma wrote:
> From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> 
> Next function field in ARI_CAP_AND_CTR field register for last
> function should be zero but thats not the case, so this patch
> programs the next function field for last function as zero.
> 
> Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 15 ++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..6b6904cf0123 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
>  	int max_epfs = sizeof(epc->function_num_map) * 8;
> -	int ret, value, epf;
> +	int ret, epf, last_fn;
> +	u32 reg, value;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -573,6 +574,18 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	 */
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
>  
> +	/* Setup ARI Next Function Number.

Please follow the standard multi-line commenting style with the first line being
"/*" followed by the comment on the next line.

> +	 * This field should point to the next physical Function and 0 for
> +	 * last Function.
> +	 */
> +	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
> +	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
> +
> +	// Clear Next Function Number for the last function used.

Please enclose the comment within /* and */.

Regards,
Siddharth.

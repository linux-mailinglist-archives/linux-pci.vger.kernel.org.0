Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAB60CB4A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJYLxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYLxn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 07:53:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1389F4180
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 04:53:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PBrPQm004136;
        Tue, 25 Oct 2022 06:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666698805;
        bh=wPviLyeeh5X5fOM3dnOhHtMhQSkj25EiurKlQflyc8s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Phi3uYdtrJM2SBA+ix9Yr0jHKVkfUnb0bwfW0XxWXkge8Iw0mLsH4IzKExMprau0M
         Vukd1rPHb2GYuGh4IThTgHETXZndA0FMcP98cyN/cwsqEKTgKdYeQ/jgzjuUCVntvr
         pVJ6URUcoFTxBNUHLFa85jvveXN/v/CTtaSg9vsA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PBrPaV080355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 06:53:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 06:53:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 06:53:24 -0500
Received: from [10.250.233.85] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PBrK3w043890;
        Tue, 25 Oct 2022 06:53:21 -0500
Message-ID: <e33dc6fd-1227-e01f-715e-947fac2fd233@ti.com>
Date:   Tue, 25 Oct 2022 17:23:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/3] PCI: j721e: Add PCIe 4x lane selection support
To:     Matt Ranostay <mranostay@ti.com>, <robh@kernel.org>,
        <tjoseph@cadence.com>, <nm@ti.com>, <a-verma1@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <20221020012911.305139-1-mranostay@ti.com>
 <20221020012911.305139-2-mranostay@ti.com>
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221020012911.305139-2-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matt,

On 20/10/22 6:59 am, Matt Ranostay wrote:
> Add support for setting of two-bit field that allows selection of 4x
> lane PCIe which was previously limited to only 2x lanes.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index a82f845cc4b5..d9b1527421c3 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -43,7 +43,6 @@ enum link_status {
>  };
>  
>  #define J721E_MODE_RC			BIT(7)
> -#define LANE_COUNT_MASK			BIT(8)
>  #define LANE_COUNT(n)			((n) << 8)
>  
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
> @@ -207,11 +206,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>  {
>  	struct device *dev = pcie->cdns_pcie->dev;
>  	u32 lanes = pcie->num_lanes;
> +	u32 mask = GENMASK(8, 8);
>  	u32 val = 0;
>  	int ret;
>  
> +	if (lanes == 4)
> +		mask = GENMASK(9, 8);


Shouldn't we decide "mask" based on max_lanes added in 2/3 (ie how many
lanes HW can support and thus width of this bit field) instead of
num_lanes? Hypothetically, what if bootloader / other entity has set MSb
but Linux is restricted to 2 lanes in DT?

> +
>  	val = LANE_COUNT(lanes - 1);
> -	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
> +	ret = regmap_update_bits(syscon, offset, mask, val);
>  	if (ret)
>  		dev_err(dev, "failed to set link count\n");
>  

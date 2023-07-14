Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8175323C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjGNGrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjGNGq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 02:46:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED430E2;
        Thu, 13 Jul 2023 23:46:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E6kBnn116158;
        Fri, 14 Jul 2023 01:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689317171;
        bh=51ygtQqbjia4BNqCGeTzY/PWLEnrB51JEBAW1iWjYps=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fJ+J0NHdY++G9H2fThwS039bgwc1y5MWHuZByQxeVy3Sow7VUXgkHMEvZkmZ8A4Bg
         M5qln6ojA518kKzyjtG0oaLuqQW9hc1mYIAXCQ8dNlmBx0O2T0jflGRrejO1P8HG1S
         2Wt+ZmSw0O8x2RfviukuPK8JC3dWVXViWUkJHJfM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E6kBwa051681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 01:46:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 01:46:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 01:46:11 -0500
Received: from [172.24.19.15] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E6k7RU097881;
        Fri, 14 Jul 2023 01:46:08 -0500
Message-ID: <eb1dd448-8cec-13a0-c782-92950de52085@ti.com>
Date:   Fri, 14 Jul 2023 12:16:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] PCI: j721e: Delay 100ms T_PVPERL from power stable to
 PERST# inactive
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
References: <20230707095119.447952-1-a-verma1@ti.com>
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230707095119.447952-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/7/2023 3:21 PM, Achal Verma wrote:
> As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
> signal should be de-asserted after minimum 100ms from the time power-rails
> become stable. So, to ensure 100ms delay to give sufficient time for
> power-rails and refclk to become stable, change delay from 100us to 100ms.
> 
>  From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
> TPVPERL: Power stable to PERST# inactive - 100ms
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Achal Verma <a-verma1@ti.com>
Hello Bjorn,

Could you please bless this with "Reviewed-by" tag.

Thanks,
Achal Verma
> ---
> 
> Changes from v2:
> * Fix commit message.
> 
> Change from v1:
> * Add macro for delay value.
> 
>   drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
>   drivers/pci/pci.h                          |  2 ++
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..32b6a7dc3cff 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -498,14 +498,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>   
>   		/*
>   		 * "Power Sequencing and Reset Signal Timings" table in
> -		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> -		 * indicates PERST# should be deasserted after minimum of 100us
> -		 * once REFCLK is stable. The REFCLK to the connector in RC
> -		 * mode is selected while enabling the PHY. So deassert PERST#
> -		 * after 100 us.
> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
> +		 * indicates PERST# should be deasserted after minimum of 100ms
> +		 * after power rails achieve specified operating limits and
> +		 * within this period reference clock should also become stable.
>   		 */
>   		if (gpiod) {
> -			usleep_range(100, 200);
> +			msleep(PCIE_TPVPERL_DELAY_MS);
>   			gpiod_set_value_cansleep(gpiod, 1);
>   		}
>   
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..6ab2367e5867 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,8 @@
>   
>   #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>   
> +#define PCIE_TPVPERL_DELAY_MS	100	/* see PCIe CEM r5.0, sec 2.9.2 */
> +
>   extern const unsigned char pcie_link_speed[];
>   extern bool pci_early_dump;
>   

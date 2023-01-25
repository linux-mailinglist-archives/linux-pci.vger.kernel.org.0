Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B567B40D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAYOQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjAYOQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 09:16:37 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46C59269;
        Wed, 25 Jan 2023 06:16:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30PEFpX5078732;
        Wed, 25 Jan 2023 08:15:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674656151;
        bh=jRRc/TwCn2Ab7SzgY7gDKwVopy46rdstAXyfHcFys4A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vALcbRAguG9MxIGMrgaTsbC/nmS3Zl5vRKmpPO3OtwUXKdb1Nhjz88nyeS6A5rLvD
         9jfOGnkOwgTpsKKr4V382r4WOFSc0YOsNN28iCbd6NMyWJBDCOFZq/p/aJVS9Xztl0
         ENYcBdLWK/w2oMVUj0kMciAd6lF2IAtUMO7uGv24=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30PEFpFh070481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 08:15:51 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 08:15:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 08:15:51 -0600
Received: from [10.250.234.92] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30PEFlUE084111;
        Wed, 25 Jan 2023 08:15:48 -0600
Message-ID: <a9e3fc94-cf0d-2cfd-640f-c81dfe35f05a@ti.com>
Date:   Wed, 25 Jan 2023 19:45:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <tjoseph@cadence.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <nm@ti.com>
References: <20230102075656.260333-1-s-vadapalli@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230102075656.260333-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 02/01/23 1:26 pm, Siddharth Vadapalli wrote:
> The Link Retraining process is initiated to account for the Gen2 defect in
> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> is i2085, documented at:
> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> 
> The existing workaround implemented for the errata waits for the Data Link
> initialization to complete and assumes that the link retraining process
> at the Physical Layer has completed. However, it is possible that the
> Physical Layer training might be ongoing as indicated by the
> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> 
> Fix the existing workaround, to ensure that the Physical Layer training
> has also completed, in addition to the Data Link initialization.
> 
> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 940c7dd701d6..5b14f7ee3c79 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -12,6 +12,8 @@
>  
>  #include "pcie-cadence.h"
>  
> +#define LINK_RETRAIN_TIMEOUT HZ
> +
>  static u64 bar_max_size[] = {
>  	[RP_BAR0] = _ULL(128 * SZ_2G),
>  	[RP_BAR1] = SZ_2G,
> @@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> +static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> +{
> +	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	unsigned long end_jiffies;
> +	u16 lnk_stat;
> +
> +	/* Wait for link training to complete. Exit after timeout. */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
> +			break;
> +		usleep_range(0, 1000);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> @@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>  		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
>  				    lnk_ctl);
>  
> +		ret = cdns_pcie_host_training_complete(pcie);
> +		if (ret)
> +			return ret;
> +
>  		ret = cdns_pcie_host_wait_for_link(pcie);
>  	}
>  	return ret;

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

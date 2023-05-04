Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1AF6F69FF
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEDLd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDLd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:33:26 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640B448F;
        Thu,  4 May 2023 04:33:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344BXCR1073790;
        Thu, 4 May 2023 06:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683199992;
        bh=juKPFRKMHa82z52nTO0B81EmQn29Ea6vYVqKEamOZeE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LFTVacYWxxi/uvGUIora7CB930KW/tmINc3mvM1Fe0rXBM0Ruprg8Lm0ozYtyXvXc
         VPB/82all7291U9I2ixeD4PEWJBuxqrh3enn4qfAEesTZ/eZ71tnAXlqhzhX2eoMsy
         dRQ0ZYpu3t0+QqKDbadUjuFgdY+HQHfvtZJts/fA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344BXCa9055547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 06:33:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 06:33:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 06:33:11 -0500
Received: from [10.249.131.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344BX7oe005307;
        Thu, 4 May 2023 06:33:08 -0500
Message-ID: <81b04da2-587c-9b17-38ac-df174793e77c@ti.com>
Date:   Thu, 4 May 2023 17:03:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/3] PCI: cadence: Use DT bindings to set PHY latencies
Content-Language: en-US
To:     Dominic Rath <rath@ibv-augsburg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <tjoseph@cadence.com>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <christian.gmeiner@gmail.com>, <bahle@ibv-augsburg.de>
References: <20230427055032.85015-1-rath@ibv-augsburg.de>
 <20230427055032.85015-3-rath@ibv-augsburg.de>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230427055032.85015-3-rath@ibv-augsburg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/27/2023 11:20 AM, Dominic Rath wrote:
> From: Alexander Bahle <bahle@ibv-augsburg.de>
> 
> Use optional "tx-phy-latency-ps" and "rx-phy-latency-ps"
> DeviceTree bindings to set the CDNS_PCIE_LM_PTM_LAT_PARAM(_IDX)
> register(s) during PCIe host and endpoint setup.
> 
> The properties are lists of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:
> 
>    tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>    rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> 
> There should be a value for every supported speed, otherwise a info
> message is emitted to let users know that the PTM timestamps from this
> PCIe device may not be precise enough for some applications.
> 
> Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
> Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
> ---
>   .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +
>   .../controller/cadence/pcie-cadence-host.c    |  1 +
>   drivers/pci/controller/cadence/pcie-cadence.c | 92 +++++++++++++++++++
>   drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..6e39126922d1 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -664,6 +664,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>   	}
>   	pcie->mem_res = res;
>   
> +	cdns_pcie_init_ptm_phy_latency(dev, pcie);
> +
>   	ep->max_regions = CDNS_PCIE_MAX_OB;
>   	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 940c7dd701d6..8933002f828e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -510,6 +510,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>   		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>   
>   	cdns_pcie_host_enable_ptm_response(pcie)
Hi Dominic,
Shouldn't cdns_pcie_init_ptm_phy_latency() called before 
cdns_pcie_host_enable_ptm_response(), enabling host to reply PTM 
requests. However host could receive PTM requests later only after 
cdns_pcie_start_link().
> +	cdns_pcie_init_ptm_phy_latency(dev, pcie);
>   
>   	ret = cdns_pcie_start_link(pcie);
>   	if (ret) {
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 13c4032ca379..1a282ed9b888 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -5,8 +5,100 @@
>   
>   #include <linux/kernel.h>
>   
> +#include "../../pci.h"
>   #include "pcie-cadence.h"
>   
> +void cdns_pcie_set_ptm_phy_latency_param(struct cdns_pcie *pcie, bool rx,
> +					 u32 speed_index, u32 latency)
> +{
> +	u32 val;
> +
> +	/* Set the speed index */
> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM_IDX);
> +	val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK) |
> +		CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN(speed_index));
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM_IDX, val);
> +
> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM);
> +	if (rx)	{
> +		/* Set the RX direction latency */
> +		val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK) |
> +			CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT(latency));
> +	} else {
> +		/* Set TX direction latency */
> +		val = ((val & ~CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK) |
> +			CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT(latency));
> +	}
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_LAT_PARAM, val);
> +}
> +
> +static int cdns_pcie_set_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie,
> +					 bool rx, const char *key)
> +{
> +	struct device_node *np;
> +	int max_link_speed;
> +	int param_count;
> +	u32 latency;
> +	int ret;
> +	int i;
> +
> +	/* Do nothing if there is no phy */
> +	if (pcie->phy_count < 1)
> +		return 0;
> +
> +	np = dev->of_node;
> +	max_link_speed = of_pci_get_max_link_speed(np);
> +	if (max_link_speed < 1)
> +		return -EINVAL;
> +
> +	/* Only check and use params of the first phy */
> +	np = pcie->phy[0]->dev.of_node;
> +	param_count = of_property_count_u32_elems(np, key);
> +	if (param_count < 0 || param_count < max_link_speed) {
> +		dev_info(dev,
> +			 "PTM: no %s set for one or more speeds: %d\n",
> +			 key, param_count);
> +	}
> +
> +	/* Don't set param for unsupported speed */
> +	if (param_count > max_link_speed)
> +		param_count = max_link_speed;
> +
> +	for (i = 0; i < param_count; i++) {
> +		ret = of_property_read_u32_index(np, key, i, &latency);
> +		if (ret != 0) {
> +			dev_err(dev, "failed to read PTM latency for speed %d from %s\n",
> +				i, key);
> +			return ret;
> +		}
> +
> +		/* convert ps to ns */
> +		latency /= 1000;
> +
> +		cdns_pcie_set_ptm_phy_latency_param(pcie, rx,
> +						    i, latency);
> +
> +		dev_dbg(dev, "PTM: %s phy latency Gen.%d: %uns\n",
> +			rx ? "rx" : "tx", i+1, latency);
> +	}
> +
> +	return 0;
> +}
> +
> +int cdns_pcie_init_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret = cdns_pcie_set_ptm_phy_latency(dev, pcie, false,
> +					    "tx-phy-latency-ps");
> +	if (ret)
> +		return ret;
> +
> +	ret = cdns_pcie_set_ptm_phy_latency(dev, pcie, true,
> +					    "rx-phy-latency-ps");
> +	return ret;
> +}
> +
>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>   {
>   	u32 delay = 0x3;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 190786e47df9..483b957a8212 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -120,6 +120,26 @@
>   #define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
>   #define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
>   
> +/* PTM Latency Parameters Index Register */
> +#define CDNS_PCIE_LM_PTM_LAT_PARAM_IDX \
> +				(CDNS_PCIE_LM_BASE + 0x0db0)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK \
> +					GENMASK(3, 0)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN(a) \
> +	(((a) << 0) & CDNS_PCIE_LM_PTM_LAT_PARAM_IDX_PTMLATIN_MASK)
> +
> +/* PTM Latency Parameters Register */
> +#define CDNS_PCIE_LM_PTM_LAT_PARAM \
> +				(CDNS_PCIE_LM_BASE + 0x0db4)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK \
> +					GENMASK(9, 0)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT(a) \
> +	(((a) << 0) & CDNS_PCIE_LM_PTM_LAT_PARAM_PTMTXLAT_MASK)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK \
> +					GENMASK(19, 10)
> +#define  CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT(b) \
> +	(((b) << 10) & CDNS_PCIE_LM_PTM_LAT_PARAM_PTMRXLAT_MASK)
> +
>   /*
>    * Endpoint Function Registers (PCI configuration space for endpoint functions)
>    */
> @@ -541,6 +561,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>   #endif
>   
>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> +void cdns_pcie_set_ptm_phy_latency_param(struct cdns_pcie *pcie, bool rx,
> +					 u32 speed_index, u32 latency);
> +int cdns_pcie_init_ptm_phy_latency(struct device *dev, struct cdns_pcie *pcie);
>   
>   void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>   				   u32 r, bool is_io,
Acked-by: Achal Verma <a-verma1@ti.com>

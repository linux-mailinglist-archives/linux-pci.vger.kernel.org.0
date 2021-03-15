Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC033B360
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCONMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 09:12:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCONL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 09:11:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12FDBoJU076360;
        Mon, 15 Mar 2021 08:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615813910;
        bh=sIjsgm9ldBHvLkWncjvpoTX93sqqn0mFc2qqBMwO7G4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QLRu2Ye1YQdnsWaK8R2FypJcLiTzblaQv+arJsKeUailzDI0Smfv22ye4QXDgd5aY
         SF/toPP69MMvS4C2cE9x4tHuQ12iJdnF3tdyHXTkywhZKxbBtJMmzJe1Hi+eILXgQq
         mJtzpMjw15uj0KRZEfIqTpncgzD41etpHFenfWdE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12FDBoKH088022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 08:11:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 08:11:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 08:11:50 -0500
Received: from [10.250.235.140] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12FDBjRO115051;
        Mon, 15 Mar 2021 08:11:46 -0500
Subject: Re: [PATCH 2/2] PCI: cadence: Set LTSSM Detect.Quiet state delay.
To:     Nadeem Athani <nadeem@cadence.com>, <tjoseph@cadence.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
References: <20210309073142.13219-1-nadeem@cadence.com>
 <20210309073142.13219-3-nadeem@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7be9dc0c-3161-f0d1-777c-1704ecb3853c@ti.com>
Date:   Mon, 15 Mar 2021 18:41:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309073142.13219-3-nadeem@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nadeem,

On 09/03/21 1:01 pm, Nadeem Athani wrote:
> The parameter detect_quiet_min_delay can be used to program the minimum
> time that LTSSM waits on entering Detect.Quiet state.
> 00 : 0us minimum wait time in Detect.Quiet state.
> 01 : 100us minimum wait time in Detect.Quiet state.
> 10 : 1000us minimum wait time in Detect.Quiet state.
> 11 : 2000us minimum wait time in Detect.Quiet state.
> 
> As per PCIe specification, all Receivers must meet the Z-RX-DC
> specification for 2.5 GT/s within 1000us of entering Detect.Quiet LTSSM
> substate. The LTSSM must stay in this substate until the ZRXDC
> specification for 2.5 GT/s is met.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 22 ++++++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 10 ++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 73dcf8cf98fb..056161b3fe65 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -461,6 +461,20 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return cdns_pcie_host_init_address_translation(rc);
>  }
>  
> +static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 delay = rc->detect_quiet_min_delay;
> +	u32 ltssm_control_cap;
> +
> +	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
> +	ltssm_control_cap = ((ltssm_control_cap &
> +			     ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
> +			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
> +}
> +

The issue is not specific to only host mode.

Thanks
Kishon
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	struct device *dev = rc->pcie.dev;
> @@ -485,6 +499,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	rc->device_id = 0xffff;
>  	of_property_read_u32(np, "device-id", &rc->device_id);
>  
> +	rc->detect_quiet_min_delay = 0;
> +	of_property_read_u32(np, "detect-quiet-min-delay",
> +			     &rc->detect_quiet_min_delay);
> +
>  	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
>  	if (IS_ERR(pcie->reg_base)) {
>  		dev_err(dev, "missing \"reg\"\n");
> @@ -497,6 +515,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  		return PTR_ERR(rc->cfg_base);
>  	rc->cfg_res = res;
>  
> +	/* Default Detect.Quiet state delay is 0 */
> +	if (rc->detect_quiet_min_delay)
> +		cdns_pcie_detect_quiet_min_delay_set(rc);
> +
>  	ret = cdns_pcie_start_link(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 254d2570f8c9..f2d3cca2c707 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -189,6 +189,14 @@
>  /* AXI link down register */
>  #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
>  
> +/* LTSSM Capabilities register */
> +#define CDNS_PCIE_LTSSM_CONTROL_CAP		 (CDNS_PCIE_LM_BASE + 0x0054)
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK	 GENMASK(2, 1)
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
> +	  (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
> +	  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
> +
>  enum cdns_pcie_rp_bar {
>  	RP_BAR_UNDEFINED = -1,
>  	RP_BAR0,
> @@ -289,6 +297,7 @@ struct cdns_pcie {
>   *            single function at a time
>   * @vendor_id: PCI vendor ID
>   * @device_id: PCI device ID
> + * @detect_quiet_min_delay: LTSSM Detect Quite state min. delay
>   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
>   *                available
>   * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
> @@ -299,6 +308,7 @@ struct cdns_pcie_rc {
>  	void __iomem		*cfg_base;
>  	u32			vendor_id;
>  	u32			device_id;
> +	u32			detect_quiet_min_delay;
>  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
>  	bool                    quirk_retrain_flag;
>  };
> 

Return-Path: <linux-pci+bounces-326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C29800918
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 11:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B8A281B62
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958AB20B0B;
	Fri,  1 Dec 2023 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xxt4GRkB"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9B129;
	Fri,  1 Dec 2023 02:53:03 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1Aqmd0031556;
	Fri, 1 Dec 2023 04:52:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701427968;
	bh=/cutW9QPrLFWJk+wnyikwznN80+OCcsK1FqEjatfhaU=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=xxt4GRkBn7rF0fFqACfyn4W9IoiFfYwwvngG1b9DZ2XDTJs/IzXEIIP+lu/SC0r1u
	 tCV3UFINw/8DQTEJfVQz8pczIWyMbMG7ljwnqQ9IqmIUgJSZ930TXo1Awcbv2iQgj4
	 dThykZonyVU558Q2TGjCCVAPYCc68C15yJfOscI4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1Aqmia024019
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Dec 2023 04:52:48 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 04:52:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 04:52:48 -0600
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1AqiTX103167;
	Fri, 1 Dec 2023 04:52:45 -0600
Message-ID: <c671e9f3-c932-4461-bcfc-3b320bf43483@ti.com>
Date: Fri, 1 Dec 2023 16:22:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Krzysztof Wilczy_ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v5] PCI: j721e: Delay T_PVPERL+TPERST_CLK before PERST#
 inactive
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>
References: <20230817093619.1079267-1-a-verma1@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230817093619.1079267-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Lorenzo, Bjorn,

On 17/08/23 15:06, Achal Verma wrote:
> As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
> signal should be de-asserted after minimum 100ms from the time power-rails
> achieve specified operating limits and 100us after reference clock gets
> stable.
> 
> From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
> TPVPERL: Power stable to PERST# inactive - 100ms
> TPERST_CLK: REFCLK stable before PERST# inactive - 100us
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 30 +++++++++++-----------
>  drivers/pci/pci.h                          |  3 +++
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..b09924b010ab 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -34,6 +34,8 @@
>  #define J721E_PCIE_USER_LINKSTATUS	0x14
>  #define LINK_STATUS			GENMASK(1, 0)
>  
> +#define PERST_INACTIVE_US (PCIE_TPVPERL_MS*USEC_PER_MSEC + PCIE_TPERST_CLK_US)

This implementation appears incorrect to me since T_PVPERL already accounts for
T_PERST-CLK according to Figure 2-3 of PCI Express Card Electromechanical
Specification Revision 5.1:
https://members.pcisig.com/wg/PCI-SIG/document/19922

Could you please share your opinion since I wish to post a v6 for this patch,
rebasing it to the latest tree which has the commit:
164f66be0c25 PCI: Add T_PVPERL macro
The macro can be used in the current patch, instead of the PERST_INACTIVE_US macro.

> +
>  enum link_status {
>  	NO_RECEIVERS_DETECTED,
>  	LINK_TRAINING_IN_PROGRESS,
> @@ -359,7 +361,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	struct j721e_pcie *pcie;
>  	struct cdns_pcie_rc *rc = NULL;
>  	struct cdns_pcie_ep *ep = NULL;
> -	struct gpio_desc *gpiod;
> +	struct gpio_desc *perst_gpiod;
>  	void __iomem *base;
>  	struct clk *clk;
>  	u32 num_lanes;
> @@ -468,11 +470,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  	switch (mode) {
>  	case PCI_MODE_RC:
> -		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> -		if (IS_ERR(gpiod)) {
> -			ret = PTR_ERR(gpiod);
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "Failed to get reset GPIO\n");
> +		perst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +		if (IS_ERR(perst_gpiod)) {
> +			ret = PTR_ERR(perst_gpiod);
> +			dev_err(dev, "Failed to get reset GPIO\n");
>  			goto err_get_sync;
>  		}
>  
> @@ -498,16 +499,15 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  		/*
>  		 * "Power Sequencing and Reset Signal Timings" table in
> -		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> -		 * indicates PERST# should be deasserted after minimum of 100us
> -		 * once REFCLK is stable. The REFCLK to the connector in RC
> -		 * mode is selected while enabling the PHY. So deassert PERST#
> -		 * after 100 us.
> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
> +		 * indicates PERST# should be deasserted after minimum of 100ms
> +		 * after power rails achieve specified operating limits and
> +		 * 100us after reference clock gets stable.
> +		 * PERST_INACTIVE_US accounts for both delays.
>  		 */
> -		if (gpiod) {
> -			usleep_range(100, 200);
> -			gpiod_set_value_cansleep(gpiod, 1);
> -		}
> +
> +		fsleep(PERST_INACTIVE_US);
> +		gpiod_set_value_cansleep(perst_gpiod, 1);
>  
>  		ret = cdns_pcie_host_setup(rc);
>  		if (ret < 0) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..80d520be34e6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,9 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +#define PCIE_TPVPERL_MS		100	/* see PCIe CEM r5.0, sec 2.9.2 */
> +#define PCIE_TPERST_CLK_US	100
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  

-- 
Regards,
Siddharth.


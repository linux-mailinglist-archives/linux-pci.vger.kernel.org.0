Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4129222A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 07:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgJSF3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 01:29:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgJSF3C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 01:29:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09J5Sp5t121693;
        Mon, 19 Oct 2020 00:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603085331;
        bh=Nt6J2iPAb8PTvHnsbHTPbbYBVOpsZ3lQkVedU49LieQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QawqnELjTqUmwl2+lFMXix3n9pLyIa9YmiWCPnb+mFVupB/s3EtWFKExXn829WeAU
         KZQcfpvLSGGqjwyr1HQmwSkIK+wwS2MHeN8WfyHuEIwTsTO3E83Nb6Jq5Zl9oS0om0
         dQ8tzDafmjgRab2/bKH4zHXLWI4YMNIq2EYfyMbA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09J5SpXv020329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 00:28:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 00:28:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 00:28:51 -0500
Received: from [10.250.234.189] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09J5SeTE094205;
        Mon, 19 Oct 2020 00:28:41 -0500
Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Nadeem Athani <nadeem@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tjoseph@cadence.com>
CC:     <sjakhade@cadence.com>, <mparab@cadence.com>
References: <20200930182105.9752-1-nadeem@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
Date:   Mon, 19 Oct 2020 10:58:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930182105.9752-1-nadeem@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nadeem,

On 30/09/20 11:51 pm, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if strapped
> as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
> Changes in v3:
> - To set retrain link bit,checking device capability & link status.
> - 32bit read in place of 8bit.
> - Minor correction in patch comment.
> - Change in variable & macro name.
> Changes in v2:
> - 16bit read in place of 8bit.
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 31 ++++++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      |  9 ++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d469ca..2b2ae4e18032 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -77,6 +77,36 @@ static struct pci_ops cdns_pcie_host_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
> +{
> +	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u16 lnk_stat, lnk_ctl;
> +
> +	if (!cdns_pcie_link_up(pcie))
> +		return;
> +

Is there a IP version that can be used to check if that quirk is applicable?
> +	/*
> +	 * Set retrain bit if current speed is 2.5 GB/s,
> +	 * but the PCIe root port support is > 2.5 GB/s.
> +	 */
> +
> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> +				      PCI_EXP_LNKCAP));
> +	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +		return;
> +
> +	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> +		lnk_ctl = cdns_pcie_rp_readw(pcie,
> +					     pcie_cap_off + PCI_EXP_LNKCTL);
> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> +				    lnk_ctl);
> +
> +		if (!cdns_pcie_link_up(pcie))

Should this rather be a cdns_pcie_host_wait_for_link()?

Thanks
Kishon

> +			return;
> +	}
> +}
>  
>  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
> @@ -115,6 +145,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>  	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>  
> +	cdns_pcie_retrain(pcie);
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index feed1e3038f4..5f1cf032ae15 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -119,7 +119,7 @@
>   * Root Port Registers (PCI configuration space for the root port function)
>   */
>  #define CDNS_PCIE_RP_BASE	0x00200000
> -
> +#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
>  
>  /*
>   * Address Translation Registers
> @@ -413,6 +413,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>  	cdns_pcie_write_sz(addr, 0x2, value);
>  }
>  
> +static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
> +{
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	return cdns_pcie_read_sz(addr, 0x2);
> +}
> +
>  /* Endpoint Function register access */
>  static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
>  					  u32 reg, u8 value)
> 

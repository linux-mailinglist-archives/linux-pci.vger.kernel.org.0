Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D871B276793
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 06:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIXEO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 00:14:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIXEO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 00:14:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O4Eo85064904;
        Wed, 23 Sep 2020 23:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600920890;
        bh=GMJPvC24sCbvp8uGIm32LT2BfyBpRHhmvR//qmqmAKw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MDf1TDadMfXGzbt8ZpGTq46cAWoCsJCYzfSvKHIg57BCEI8r5lOcNp0N1Rpy30z8b
         +fJ+QO2RF4Ah+VorIOfaS/H5SgxutdTUfW4qDaId94czOvwpWcjYM2PjZjW2polUO2
         eaArjZ5Qh+dwfgzZINyfhXXNjOJOKxSRTlrMNo9g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O4Eo83102712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 23:14:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 23:14:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 23:14:49 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O4Ek9P027997;
        Wed, 23 Sep 2020 23:14:47 -0500
Subject: Re: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
To:     Nadeem Athani <nadeem@cadence.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>
References: <20200923183427.9258-1-nadeem@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <37fca4c0-1cba-866a-27ed-9a0a0cbe69e6@ti.com>
Date:   Thu, 24 Sep 2020 09:44:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923183427.9258-1-nadeem@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nadeem,

On 24/09/20 12:04 am, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if
> strapped as Gen2. The Retrain bit is set as a quirk to trigger
> this speed change.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 14 ++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d469ca..a2317614268d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -83,6 +83,9 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
>  	u32 id;
> +	u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
> +	u8 sls;
> +	u16 lnk_ctl;
>  
>  	/*
>  	 * Set the root complex BAR configuration register:
> @@ -111,6 +114,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	if (rc->device_id != 0xffff)
>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>  
> +	/* Quirk to enable autonomous speed change for GEN2 controller */
> +	/* Reading Supported Link Speed value */
> +	sls = PCI_EXP_LNKCAP_SLS &
> +		cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
> +	if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
> +		/* Since this a Gen2 controller, set Retrain Link(RL) bit */
> +		lnk_ctl = cdns_pcie_rp_readw(pcie, link_cap + PCI_EXP_LNKCTL);
> +		lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +		cdns_pcie_rp_writew(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);
> +	}

Is this workaround required for all Cadence controller? If not, enable
this workaround only for versions which doesn't do autonomous speed change.

I think this workaround should also be applied only after checking for
link status (cdns_pcie_link_up()).

And this is also applicable for GEN3/GEN4 controller. So the check
should be to see the capability of the connected PCIe device and not the
controller itself.

Thanks
Kishon

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBA373540
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhEEG76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 02:59:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53832 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhEEG75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 02:59:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1456wkTX074114;
        Wed, 5 May 2021 01:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620197926;
        bh=0j77LyqtTpjLqDfexeSMu4rG5MJRswU/vC8VHqp4Cx0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uskr3cn/Fst+OifpPmtFyRcd2mXaTGrszLUDzWQ9gCQE9XbfpKlmse4bsll9AmlSU
         EYzSC1PeoGOKriP+yKG2MzZ4FdjTbiMGJZ4/gnUTs4MNvVnazbTqYOw/J3w0jrtDkd
         U45B/9tjAi68FiqsW1aKrNS7NYCEgbxjLKO9fA40=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1456wkxq040183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 May 2021 01:58:46 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 5 May
 2021 01:58:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 5 May 2021 01:58:46 -0500
Received: from [10.250.235.7] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1456we3U032185;
        Wed, 5 May 2021 01:58:41 -0500
Subject: Re: [PATCH] PCI: cadence: Set LTSSM Detect Quiet state minimum delay
 as workaround for training defect.
To:     Nadeem Athani <nadeem@cadence.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>, Milind Parab <mparab@cadence.com>
References: <20210426051427.15945-1-nadeem@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <152cc214-630f-3d66-9cd5-12909c161dec@ti.com>
Date:   Wed, 5 May 2021 12:28:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426051427.15945-1-nadeem@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nadeem,

On 26/04/21 10:44 am, Nadeem Athani wrote:

How about $subject to "PCI: cadence: Add quirk to set maximum possible
wait time in Detect.Quiet state."?
> Adding a quirk flag "quirk_detect_quiet_flag" to program the minimum
> time that LTSSM waits on entering Detect.Quiet state.
> Setting this to 2ms for specific TI j7200 SOC as a workaround to resolve
> a link training issue in IP.

Please add a more detailed description of the issue here. Something like
below.

PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
another protocol. For example, link training fails if lanes 2 and 3 are
assigned to another protocol while lanes 0 and 1 are used for PCIe to
form a two lane link. This failure is due to an incorrect tie-off on an
internal status signal indicating electrical idle.

Status signals going from SERDES to PCIe Controller are tied-off when a
lane is not assigned to PCIe. Signal indicating electrical idle is
incorrectly tied-off to a state that indicates non-idle. As a result,
PCIe sees unused lanes to be out of electrical idle and this causes
LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
occur. If a receiver is not detected on the first receiver detection
attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
again moves forward to Detect.Active state without waiting for 12ms as
required by PCIe base specification. Since wait time in Detect.Quiet is
skipped, multiple receiver detect operations are performed back-to-back
without allowing time for capacitance on the transmit lines to
discharge. This causes subsequent receiver detection to always fail even
if a receiver gets connected eventually.
> In future revisions this setting will not be required.
> 
> As per PCIe specification, all Receivers must meet the Z-RX-DC
> specification for 2.5 GT/s within 1ms of entering Detect.Quiet LTSSM
> substate. The LTSSM must stay in this substate until the ZRXDC
> specification for 2.5 GT/s is met.
> 
> 00 : 0 minimum wait time in Detect.Quiet state.
> 01 : 100us minimum wait time in Detect.Quiet state.
> 10 : 1ms minimum wait time in Detect.Quiet state.
> 11 : 2ms minimum wait time in Detect.Quiet state.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---

Please note the previous version of the patch here and what changed.
http://lore.kernel.org/r/20210409053832.29512-1-nadeem@cadence.com

>  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 21 +++++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 21 +++++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 12 ++++++++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 897cdde02bd8..245771f03c21 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -552,6 +552,23 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.get_features	= cdns_pcie_ep_get_features,
>  };
>  
> +static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_ep *ep)
> +{
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 delay = 0x3;
> +	u32 ltssm_control_cap;
> +
> +	/*
> +	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
> +	 */
> +
> +	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
> +	ltssm_control_cap = ((ltssm_control_cap &
> +			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
> +			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
> +}
>  
>  int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  {
> @@ -623,6 +640,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
>  	/* Reserve region 0 for IRQs */
>  	set_bit(0, &ep->ob_region_map);
> +
> +	if (ep->quirk_detect_quiet_flag)
> +		cdns_pcie_detect_quiet_min_delay_set(ep);
> +
>  	spin_lock_init(&ep->lock);
>  
>  	return 0;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index ae1c55503513..ffc2dbeb1240 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -462,6 +462,24 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return cdns_pcie_host_init_address_translation(rc);
>  }
>  
> +static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 delay = 0x3;
> +	u32 ltssm_control_cap;
> +
> +	/*
> +	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
> +	 */
> +
> +	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
> +	ltssm_control_cap = ((ltssm_control_cap &
> +			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
> +			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
> +}
> +

Don't repeat this function once for host and once for device. Add this
function pcie-cadence.c and invoked from host and endpoint.

Thanks
Kishon

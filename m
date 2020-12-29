Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3412E7449
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2Vcc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 16:32:32 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52571 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2Vcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 16:32:32 -0500
X-Originating-IP: 91.174.235.35
Received: from windsurf (unknown [91.174.235.35])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C8144240005;
        Tue, 29 Dec 2020 21:31:47 +0000 (UTC)
Date:   Tue, 29 Dec 2020 22:31:46 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, mparab@cadence.com,
        pthombar@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v6 2/2] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Message-ID: <20201229223146.3081aa50@windsurf>
In-Reply-To: <20201228140510.14641-3-nadeem@cadence.com>
References: <20201228140510.14641-1-nadeem@cadence.com>
        <20201228140510.14641-3-nadeem@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Dec 2020 15:05:10 +0100
Nadeem Athani <nadeem@cadence.com> wrote:

> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)

Shouldn't this propagate a return value ?

> +{
> +	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u16 lnk_stat, lnk_ctl;
> +
> +	/*
> +	 * Set retrain bit if current speed is 2.5 GB/s,
> +	 * but the PCIe root port support is > 2.5 GB/s.
> +	 */
> +
> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> +					     PCI_EXP_LNKCAP));
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
> +		if (cdns_pcie_host_wait_for_link(pcie))
> +			return;

Here, shouldn't you return the status of
cdns_pcie_host_wait_for_link(), to propagate whether the PCIe link
indeed came up after the retrain ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-pci+bounces-40045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DCC289EB
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 06:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F433B7D06
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FC244698;
	Sun,  2 Nov 2025 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elnr9edn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FD2376E4;
	Sun,  2 Nov 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762062014; cv=none; b=tJ5iTO99Jy3YUdikyOuvX+hlM/0wrYk7W4wp0Zlel0UzdiS1eIusH2QXYSud+2rs3HaGDCY8McAHkPKwQEFBFoL3MIpxHcha8ZPb07DUpRGa9+FMHfuM7NQ5/9Vq+0yDrrdYMQ0DVaY6yO7wpAcAWyifdkPpY26WAC0OII5i9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762062014; c=relaxed/simple;
	bh=ndr3NTz8fId8h4fZZNgIa0fXwj/KxucCZxVOJ3WgK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrfvsJWgMo+4z/mJH7PhNkJ9UXA7hCVkl4sEXIpDoPjHtXUw5MXNYwc2w+8gtic/vWi7Ri97/Whc1ih9m/WxXiOhLGeXKmLteOPw56KniJvcdD9/b+QB6UPeImvthYoYWxWxQubC3vC7nafodVAj8joswbOPJ8QH/H2cJaBbDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elnr9edn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F19C4CEF7;
	Sun,  2 Nov 2025 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762062013;
	bh=ndr3NTz8fId8h4fZZNgIa0fXwj/KxucCZxVOJ3WgK68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Elnr9ednHXMTm8GAnQmM3LtV1QA92czLHQJVCLy0C3+RxSe1rfhNlytV/AGO2PBvo
	 xWyefzujvKGWXQwDgy+FqQTdCHBL15A0YC9tism8gboGWIpxawbUyXgf2qpivc/x2B
	 3yYDnAo8rKZr/sJWUzeSrB5LbU3897wzzW4U0tasS82tGJNpxynK1ol1jQrTvZBZOp
	 5eLwJ2jrR49v+wP51qrKeYACrckC7iGENW6Jhnh5cI49c7gljSRP/0voEOq1+HkJR9
	 zTx26+oYPNJ0HvlkN2ejtvTCMai+CqLtqa7S0tvIqQEWcl5RhozTmzMBACwlJixS+l
	 LUQASu0v+rScg==
Date: Sun, 2 Nov 2025 11:10:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "helgaas@kernel.org" <helgaas@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"fugang.duan@cixtech.com" <fugang.duan@cixtech.com>, "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>, 
	"peter.chen@cixtech.com" <peter.chen@cixtech.com>, 
	"cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
 <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Sun, Nov 02, 2025 at 04:15:03AM +0000, Manikandan Karunakaran Pillai wrote:
> Hi Mani,
> 
> Pls find my comments inline
> 
> Regards
> 
> >> +
> >> +	/* Clear AXI link-down status */
> >> +	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
> >CDNS_PCIE_HPA_AT_LINKDOWN);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >CDNS_PCIE_HPA_AT_LINKDOWN,
> >> +			     (regval & ~GENMASK(0, 0)));
> >> +
> >> +	/* Update Output registers for AXI region 0 */
> >> +	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> >> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
> >> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0),
> >addr0);
> >> +
> >> +	desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
> >> +
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
> >> +	desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
> >> +	desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
> >> +	ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
> >> +		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
> >> +
> >> +	if (busn == bridge->busnr + 1)
> >> +		desc0 =
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> >> +	else
> >> +		desc0 =
> >CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
> >> +
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> >> +			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
> >> +
> >> +	return rc->cfg_base + (where & 0xfff);
> >> +}
> >> +
> >> +static int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
> >> +{
> >> +	struct device *dev = pcie->dev;
> >> +	struct cdns_pcie_rc *rc;
> >> +	int retries, ret;
> >> +
> >> +	rc = container_of(pcie, struct cdns_pcie_rc, pcie);
> >> +
> >> +	/* Check if the link is up or not */
> >> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >> +		if (cdns_pcie_hpa_link_up(pcie)) {
> >> +			dev_info(dev, "Link up\n");
> >> +			return 0;
> >> +		}
> >> +		usleep_range(LINK_WAIT_USLEEP_MIN,
> >LINK_WAIT_USLEEP_MAX);
> >> +	}
> >> +	if (rc->quirk_retrain_flag)
> >> +		ret = cdns_pcie_retrain(pcie);
> >> +	return ret;
> >
> >If 'quirk_retrain_flag' was not set, you are 'ret' will be uninitialized.
> 
> Ok, Patch set 11 will have the fix.
> 
> >
> >> +}
> >> +
> >> +static struct pci_ops cdns_pcie_hpa_host_ops = {
> >> +	.map_bus	= cdns_pci_hpa_map_bus,
> >> +	.read		= pci_generic_config_read,
> >> +	.write		= pci_generic_config_write,
> >> +};
> >> +
> >> +static void cdns_pcie_hpa_host_enable_ptm_response(struct cdns_pcie
> >*pcie)
> >> +{
> >> +	u32 val;
> >> +
> >> +	val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
> >CDNS_PCIE_HPA_LM_PTM_CTRL);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
> >CDNS_PCIE_HPA_LM_PTM_CTRL,
> >> +			     val | CDNS_PCIE_HPA_LM_PTM_CTRL_PTMRSEN);
> >> +}
> >> +
> >> +static int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
> >> +					    enum cdns_pcie_rp_bar bar,
> >> +					    u64 cpu_addr, u64 size,
> >> +					    unsigned long flags)
> >> +{
> >> +	struct cdns_pcie *pcie = &rc->pcie;
> >> +	u32 addr0, addr1, aperture, value;
> >> +
> >> +	if (!rc->avail_ib_bar[bar])
> >> +		return -ENODEV;
> >> +
> >> +	rc->avail_ib_bar[bar] = false;
> >> +
> >> +	aperture = ilog2(size);
> >> +	if (bar == RP_NO_BAR) {
> >> +		addr0 =
> >CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
> >> +			(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> >> +		addr1 = upper_32_bits(cpu_addr);
> >> +	} else {
> >> +		addr0 = lower_32_bits(cpu_addr);
> >> +		addr1 = upper_32_bits(cpu_addr);
> >> +	}
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> >> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar),
> >addr0);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> >> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar),
> >addr1);
> >> +
> >> +	if (bar == RP_NO_BAR)
> >> +		bar = (enum cdns_pcie_rp_bar)BAR_0;
> >> +
> >> +	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >CDNS_PCIE_HPA_LM_RC_BAR_CFG);
> >> +	value &= ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
> >> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
> >> +		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
> >> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
> >> +		   HPA_LM_RC_BAR_CFG_APERTURE(bar,
> >bar_aperture_mask[bar] + 7));
> >> +	if (size + cpu_addr >= SZ_4G) {
> >> +		value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
> >> +		if ((flags & IORESOURCE_PREFETCH))
> >> +			value |=
> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> >> +	} else {
> >> +		value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> >> +		if ((flags & IORESOURCE_PREFETCH))
> >> +			value |=
> >HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> >> +	}
> >> +
> >> +	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
> >> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> >CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
> >> +					 struct resource_entry *entry)
> >
> >This and other functions are almost same as in 'pcie-cadence-host'. Why don't
> >you reuse them in a common library?
> 
> The function cdns_pcie_hpa_host_bar_config() calls functions cdns_pcie_hpa_host_bar_ib_config()
> which is not common. All functions that are common between the two architecture are moved to the
> common library file based on earlier comments.
> 

This is not a good reason to duplicate the whole function. You could just make
the common function accept the callback ib_config() and pass either
cdns_pcie_host_bar_ib_config() or cdns_pcie_hpa_host_bar_ib_config().

This pattern could be done for other functions as well. Please audit all of them
and move them to common library. Currently, I could see a lot of duplications
that could be avoided.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


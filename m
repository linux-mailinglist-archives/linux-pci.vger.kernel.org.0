Return-Path: <linux-pci+bounces-36652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C277B90581
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F9189B751
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA80304BB7;
	Mon, 22 Sep 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a186c2oz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6EC120;
	Mon, 22 Sep 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540386; cv=none; b=dyH7ywXbXDPN4d4+aqgkgm0YaAQvFK7AK/WgiHspc/sKlVuyu+RIi6kpk2c4tnTzg1Fxd941g9XUSvYb6DdMPnZY2g1XrFKMDXTwIXFuJafvcVoE+cO873NFjHrAF8v0uCDO12flCHQx2bHOHK+r1TEQ5oTiSg4R4CHQfpar7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540386; c=relaxed/simple;
	bh=9JQedTHdHctfJGT11PtE1ZER88ziPva3c5zByj/E2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miDWSicUZL0wjVPLNvLi0zjXysa+q0OvM9PbFGw8lI1LdGskAzS1W+u5rcbf+l68/7NTvAHHSk7W3t8jAI7jq+mAuvbLhjjUVaS8wiEzeLqG3m+A3w93cJ+PxMsE0eP0THjUmsIJsWzc5ItasUD5/y/+/n6+jkm2HWf49WrnkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a186c2oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BAC4CEF0;
	Mon, 22 Sep 2025 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540386;
	bh=9JQedTHdHctfJGT11PtE1ZER88ziPva3c5zByj/E2cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a186c2ozsEjuVX0cAaANqNZGa3frykYXft/EdxosHYevKrOTCM+d0s5O0vQrrN5K7
	 MzMCxNaChm7DVirKgDOBYxulGsvrsYyz8yGMb74fjqEiwEkUs3EKUAAanoF9D3fnB4
	 D462ka0eD9dzNCiolfkCDGnfv9ML12SifwOOE+LyznuqRhm1GTz4p9hnjG5/vnP+T7
	 QeIvFQGs45VhhsUqsEevJw1JawgDX5zDwrhlWuDkb/SacVW25gl4qaW3+ZOdVUSt1K
	 35wOSbgLDicbQ/bryJMAlVp7K3kVZinNRE9fNZ8DbNnHDA5bKm063NQH5dNKz1/wkp
	 8hmar9DpNTAMQ==
Date: Mon, 22 Sep 2025 16:56:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <agtozwcmgwj7kfmzkrglqcba5vaqmd2hv3matzmksbckkrrno3@zdteyblgvpyr>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-3-hongxing.zhu@nxp.com>
 <p4hqjnhpih2uy5hzf7llrd3ah7ov6sijkuqjecpvv5j2iqrsji@kxj5xwb7a5p4>
 <AS8PR04MB88335CEA526C3B5E957EF0C88C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88335CEA526C3B5E957EF0C88C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Mon, Sep 22, 2025 at 09:18:20AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: 2025年9月20日 14:29
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; jingoohan1@gmail.com;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > robh@kernel.org; bhelgaas@google.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
> > is existing in suspend
> > 
> > On Tue, Sep 02, 2025 at 04:01:47PM +0800, Richard Zhu wrote:
> > > Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> > > Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> > >
> > > It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> > > PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3
> > > after a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1
> > > PME Synchronization.
> > >
> > > The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
> > > PME_Turn_Off is sent out.
> > >
> > 
> > This statement is not accurate. A single register read cannot cause hang AFAIK.
> > I'm guessing that the link down (LDn) happens after initiating PME_Turn_Off
> > and the access to CSR register (LTSSM) causes hang.
> > 
> > Is my understanding correct? 
> The access of LTSSM is not relied on the link is up or not. For example,
>  the LTSSM stats can be accessed when the link is in the training
>  and not up yet.
> 
> Per to the discussion with Bjorn, the most possible reason is that the
>  LTSSM isn't powered anymore on i.MX6/7 when PME_Turn_Off is kicked off.
> https://lore.kernel.org/imx/20250819192838.GA526045@bhelgaas/
> 

I'm not sure though. Could you try to read any DBI register at this point and
see if the hang is observed or not?

LTSSM states are expressed through the DBI registers. So as per my
understanding, unless the whole DBI register space is inaccessible, LTSSM
registers should be accessible.

- Mani

> Best Regards
> Richard Zhu
> > 
> > > To support this case, don't poll L2 state and apply a simple delay of
> > > PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag
> > is
> > > set in suspend.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > 
> > We need Fixes tag also and you do need to set the flag in relevant glue driver
> > in this patch itself so that it can cleanly be backported.
> > 
> > - Mani
> > 
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 34
> > > +++++++++++++------  drivers/pci/controller/dwc/pcie-designware.h  |
> > > 4 +++
> > >  2 files changed, 28 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 9d46d1f0334b..57a1ba08c427 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1016,15 +1016,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  			return ret;
> > >  	}
> > >
> > > -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> > > -				val == DW_PCIE_LTSSM_L2_IDLE ||
> > > -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > -	if (ret) {
> > > -		/* Only log message when LTSSM isn't in DETECT or POLL */
> > > -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > -		return ret;
> > > +	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> > > +		/*
> > > +		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
> > > +		 * when LTSSM is not powered in L2/L3/LDn properly.
> > > +		 *
> > > +		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
> > > +		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
> > > +		 * transferred to LDn directly. On the LTSSM states poll broken
> > > +		 * platforms, add a max 10ms delay refer to PCIe r6.0,
> > > +		 * sec 5.3.3.2.1 PME Synchronization.
> > > +		 */
> > > +		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> > > +	} else {
> > > +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> > > +					val == DW_PCIE_LTSSM_L2_IDLE ||
> > > +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > +		if (ret) {
> > > +			/* Only log message when LTSSM isn't in DETECT or POLL */
> > > +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > +			return ret;
> > > +		}
> > >  	}
> > >
> > >  	/*
> > > @@ -1040,7 +1054,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >
> > >  	pci->suspended = true;
> > >
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 00f52d472dcd..4e5bf6cb6ce8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -295,6 +295,9 @@
> > >  /* Default eDMA LLP memory size */
> > >  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
> > >
> > > +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> > > +#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
> > > +
> > >  struct dw_pcie;
> > >  struct dw_pcie_rp;
> > >  struct dw_pcie_ep;
> > > @@ -504,6 +507,7 @@ struct dw_pcie {
> > >  	const struct dw_pcie_ops *ops;
> > >  	u32			version;
> > >  	u32			type;
> > > +	u32			quirk_flag;
> > >  	unsigned long		caps;
> > >  	int			num_lanes;
> > >  	int			max_link_speed;
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்


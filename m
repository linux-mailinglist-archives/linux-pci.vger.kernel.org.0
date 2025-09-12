Return-Path: <linux-pci+bounces-35984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BEBB54552
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8B11CC2C42
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB22D5945;
	Fri, 12 Sep 2025 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4QQCTls"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252C2DC780;
	Fri, 12 Sep 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665662; cv=none; b=SpzHSuWqXaPDEjnAemhQEfQGuBtZ2RlyCAdmteta6I2K8zGgNXpgIkRrFhSJ59OoOpF19QhPaMm2vHyI7UGx9gYgqVwFMQGlpcQ+WNDJpEur8rfsRCYXLAflrLNcYNlb1HDoW9EHoM1v0UTzjVuLq1NrdHbLPgJULwLn6ispjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665662; c=relaxed/simple;
	bh=6xxzzd/ernId8OPpo0sEQcfNMw1jhcfLCa6q7kv32EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiJT0yhbJ61UWMK32e/d0rogI8uLsI0Jpwc4yUrQ5IU40D0wRcQ9VanggiqkZYmEb8NfwDEwYuPnY0ztkUU6paqRI1qOW4pdOGdRz5boZp3uPTsMRAntEydSNXGIfpLTYbMH23TSrObIzzJ/KuVvqutDbvmQjelD5ax/lBtXsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4QQCTls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB056C4CEF4;
	Fri, 12 Sep 2025 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665661;
	bh=6xxzzd/ernId8OPpo0sEQcfNMw1jhcfLCa6q7kv32EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4QQCTls3hEVEbvxLogVWLsmPwqUlMAuTpTowWWWXM/+qphMfQKBOABU+yM5dMtWj
	 ae84y6BbOT/fovVXR+wZlIPtLKXys/5Jhqb5DHlw13M69uyAZroR0mrIZ6n0iarwIl
	 +t2ixIcdZy6kDp5rBgjXoCJDdTRgh6ifdEhruEA7uh2536m5HYeIhGb5dW4Mqg/eTP
	 qO7sqZCBXwBv/0KIzwufRxRpyDncba3zabmcbwlc8yca8UmcDNOFSYyEQ55u58wbTt
	 Pavc5brh/OnI0vsO/0+quZs+20Ydj1FxAs/5gFTcSofITixZF+zHsrW+r3WimXMm1a
	 HENDyOFg6iDzg==
Date: Fri, 12 Sep 2025 13:57:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST#
 for new DT binding
Message-ID: <r7cpjk2jun3h4xnfncqldeyfov4ad3bpq5kcfcxcx3eyg6g2hj@rcajqn7snemy>
References: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>
 <20250908193428.GA1437972@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908193428.GA1437972@bhelgaas>

On Mon, Sep 08, 2025 at 02:34:28PM GMT, Bjorn Helgaas wrote:
> On Wed, Sep 03, 2025 at 12:43:27PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > If the platform is using the new DT binding, let the pwrctrl core toggle
> > PERST# for the device. This is achieved by populating the
> > 'pci_host_bridge::toggle_perst' callback with qcom_pcie_toggle_perst().
> 
> Can we say something here about how to identify a "new DT binding"?
> I assume there is a DT property or something that makes it "new"?

This is taken care now.

> 
> > qcom_pcie_toggle_perst() will find the PERST# GPIO descriptor associated
> > with the supplied 'device_node' and toggles PERST#. If PERST# is not found
> > in the supplied node, the function will look for PERST# in the parent node
> > as a fallback. This is needed since PERST# won't be available in the
> > endpoint node as per the DT binding.
> > 
> > Note that the driver still asserts PERST# during the controller
> > initialization as it is needed as per the hardware documentation. Apart
> > from that, the driver wouldn't touch PERST# for the new binding.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++++++++++++++++++++++-----
> >  1 file changed, 78 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 78355d12f10d263a0bb052e24c1e2d5e8f68603d..3c5c65d7d97cac186e1b671f80ba7296ad226d68 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -276,6 +276,7 @@ struct qcom_pcie_port {
> >  struct qcom_pcie_perst {
> >  	struct list_head list;
> >  	struct gpio_desc *desc;
> > +	struct device_node *np;
> >  };
> >  
> >  struct qcom_pcie {
> > @@ -298,11 +299,50 @@ struct qcom_pcie {
> >  
> >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> >  
> > -static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> > +static struct gpio_desc *qcom_find_perst(struct qcom_pcie *pcie, struct device_node *np)
> > +{
> > +	struct qcom_pcie_perst *perst;
> > +
> > +	list_for_each_entry(perst, &pcie->perst, list) {
> > +		if (np == perst->np)
> > +			return perst->desc;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void qcom_toggle_perst_per_device(struct qcom_pcie *pcie,
> > +					 struct device_node *np, bool assert)
> > +{
> > +	int val = assert ? 1 : 0;
> > +	struct gpio_desc *perst;
> > +
> > +	perst = qcom_find_perst(pcie, np);
> > +	if (perst)
> > +		goto toggle_perst;
> > +
> > +	/*
> > +	 * If PERST# is not available in the current node, try the parent. This
> > +	 * fallback is needed if the current node belongs to an endpoint or
> > +	 * switch upstream port.
> > +	 */
> > +	if (np->parent)
> > +		perst = qcom_find_perst(pcie, np->parent);
> 
> Ugh.  I think we need to fix the data structures here before we go
> much farther.  We should be able to search for PERST# once at probe of
> the Qcom controller.  Hopefully we don't need lists of things.
> 
> See https://lore.kernel.org/r/20250908183325.GA1450728@bhelgaas.
> 

I've added a patch to fix in the next version of this series.

> > +toggle_perst:
> > +	/* gpiod* APIs handle NULL gpio_desc gracefully. So no need to check. */
> > +	gpiod_set_value_cansleep(perst, val);
> > +}
> > +
> > +static void qcom_perst_reset(struct qcom_pcie *pcie, struct device_node *np,
> > +			      bool assert)
> >  {
> >  	struct qcom_pcie_perst *perst;
> >  	int val = assert ? 1 : 0;
> >  
> > +	if (np)
> > +		return qcom_toggle_perst_per_device(pcie, np, assert);
> > +
> >  	if (list_empty(&pcie->perst))
> >  		gpiod_set_value_cansleep(pcie->reset, val);
> >  
> > @@ -310,22 +350,34 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> >  		gpiod_set_value_cansleep(perst->desc, val);
> >  }
> >  
> > -static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > +static void qcom_ep_reset_assert(struct qcom_pcie *pcie, struct device_node *np)
> >  {
> > -	qcom_perst_assert(pcie, true);
> > +	qcom_perst_reset(pcie, np, true);
> >  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> >  }
> >  
> > -static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> > +static void qcom_ep_reset_deassert(struct qcom_pcie *pcie,
> > +				   struct device_node *np)
> >  {
> >  	struct dw_pcie_rp *pp = &pcie->pci->pp;
> >  
> >  	msleep(PCIE_T_PVPERL_MS);
> > -	qcom_perst_assert(pcie, false);
> > +	qcom_perst_reset(pcie, np, false);
> >  	if (!pp->use_linkup_irq)
> >  		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> >  }
> >  
> > +static void qcom_pcie_toggle_perst(struct pci_host_bridge *bridge,
> > +				    struct device_node *np, bool assert)
> > +{
> > +	struct qcom_pcie *pcie = dev_get_drvdata(bridge->dev.parent);
> > +
> > +	if (assert)
> > +		qcom_ep_reset_assert(pcie, np);
> > +	else
> > +		qcom_ep_reset_deassert(pcie, np);
> > +}
> > +
> >  static int qcom_pcie_start_link(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > @@ -1320,7 +1372,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> >  	int ret;
> >  
> > -	qcom_ep_reset_assert(pcie);
> > +	qcom_ep_reset_assert(pcie, NULL);
> >  
> >  	ret = pcie->cfg->ops->init(pcie);
> >  	if (ret)
> > @@ -1336,7 +1388,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >  			goto err_disable_phy;
> >  	}
> >  
> > -	qcom_ep_reset_deassert(pcie);
> > +	/*
> > +	 * Only deassert PERST# for all devices here if legacy binding is used.
> > +	 * For the new binding, pwrctrl driver is expected to toggle PERST# for
> > +	 * individual devices.
> 
> Can we replace "new binding" with something explicit?  In a few
> months, "new binding" won't mean anything.
> 

So I've introduced a new flag, qcom_pcie::legacy_binding, which gets set if the
driver uses qcom_pcie_parse_legacy_binding(). Based on this flag, PERST# will be
deasserted in this driver.

And I've removed references to 'new binding' term.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


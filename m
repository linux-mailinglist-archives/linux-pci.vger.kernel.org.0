Return-Path: <linux-pci+bounces-36153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C0B57C34
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CAC3BA76A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6530149A;
	Mon, 15 Sep 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWgD+ghf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3111D54D8;
	Mon, 15 Sep 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941301; cv=none; b=i1ehLz5lspUiCLCjHodL+8e5wD6MaP/ZrSm9dBPD8fGUU3rOsCn2VNYklkGy7lRrP35EkP9ch8Hn0J1r2cn9Z1AphQLzgcgTW0LlmH/+hcynU3ffDf/5DbwHnhSaPqwKf0HyK7wJw356sOt4kbByzJLwC/pzM8hH+6Y/OlxfML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941301; c=relaxed/simple;
	bh=8gWW727WZSXECV44xZoHkdjLVJ91dkVVKBwBSvg9zXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLcawxbtgtSuAnHB0pDY1Hs6ubjlP3JVmdM7U5NIJ7H8j/UcPqcNENCKd3kfp+KLQPVmZdcg0bpbzLfMZt9HJbgLx9eTjb9bizZuK5dMb6ypox7TRUeorNcWnEOG/2cy/hBv7VMvYsZgulLWh2Jjv5iaU0k12T3sfy2oGDlCz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWgD+ghf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEDC4CEF1;
	Mon, 15 Sep 2025 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757941301;
	bh=8gWW727WZSXECV44xZoHkdjLVJ91dkVVKBwBSvg9zXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWgD+ghfz60mn3Vx7LNSoh+5sjnjN6ToYbh2ivoYvEp+hHotjB7L68uHgtC/JBVao
	 ztdyKE8JoWRzprZHKyRswmyau+8u/LjgGGXWkoRS6NnpQrOKg4vjRRVkzDoTnMB/aS
	 coXRZSeUBX+u5GN32t9rAAtPPorgyqh75lsCV5bjKUoXRAdoqIMoEQ04f5ECw6SVgl
	 1wiKsZ/tZ+OterUjidUMeGvzvDWLSrHGdvirmmbW/qIvpwkvsjvavvVDaeS2RyQZx/
	 IDGfHMhhYWkObk/LSG+Zq2JUcHPtk5cBrUke6MX8INDmP+4h+2JUG+eAmOeC/0ODoT
	 sLnpSeRzipQNA==
Date: Mon, 15 Sep 2025 18:31:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 2/4] PCI: qcom: Move host bridge 'phy' and 'reset'
 pointers to struct qcom_pcie_port
Message-ID: <nhvnnjviqmz2gqgjlqjvnlrvyj7brvjeep4wchhhfxy7pgkbbz@ejqcopawboqp>
References: <20250912-pci-pwrctrl-perst-v3-2-3c0ac62b032c@oss.qualcomm.com>
 <20250912232348.GA1653056@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912232348.GA1653056@bhelgaas>

On Fri, Sep 12, 2025 at 06:23:48PM GMT, Bjorn Helgaas wrote:
> On Fri, Sep 12, 2025 at 02:05:02PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > DT binding allows specifying 'phy' and 'reset' properties in both host
> > bridge and Root Port nodes, though specifying in the host bridge node is
> > marked as deprecated. Still, the pcie-qcom driver should support both
> > combinations for maintaining the DT backwards compatibility. For this
> > purpose, the driver is holding the relevant pointers of these properties in
> > two structs: struct qcom_pcie_port and struct qcom_pcie.
> > 
> > However, this causes confusion and increases the driver complexity. Hence,
> > move the pointers from struct qcom_pcie to struct qcom_pcie_port. As a
> > result, even if these properties are specified in the host bridge node,
> > the pointers will be stored in struct qcom_pcie_port as if the properties
> > are specified in a single Root Port node. This logic simplifies the driver
> > a lot.
> 
> > @@ -297,11 +295,8 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> >  	struct qcom_pcie_port *port;
> >  	int val = assert ? 1 : 0;
> >  
> > -	if (list_empty(&pcie->ports))
> > -		gpiod_set_value_cansleep(pcie->reset, val);
> > -	else
> > -		list_for_each_entry(port, &pcie->ports, list)
> > -			gpiod_set_value_cansleep(port->reset, val);
> > +	list_for_each_entry(port, &pcie->ports, list)
> > +		gpiod_set_value_cansleep(port->reset, val);
> 
> This is so much nicer, thanks for doing this!
> 
> >  static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
> >  {
> >  	struct device *dev = pcie->pci->dev;
> > +	struct qcom_pcie_port *port;
> > +	struct gpio_desc *reset;
> > +	struct phy *phy;
> >  	int ret;
> >  
> > -	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> > -	if (IS_ERR(pcie->phy))
> > -		return PTR_ERR(pcie->phy);
> > +	phy = devm_phy_optional_get(dev, "pciephy");
> > +	if (IS_ERR(phy))
> > +		return PTR_ERR(phy);
> 
> Seems like it would be easier to integrate this fallback into
> qcom_pcie_parse_port() instead if separating it into
> qcom_pcie_parse_legacy_binding().
> 
> What if you did something like this in qcom_pcie_parse_port():
> 
>   qcom_pcie_parse_port
>   {
>       reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> 				    "reset",  GPIOD_OUT_HIGH, "PERST#");
>       if (IS_ERR(reset)) {
> 	  reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> 	  if (IS_ERR(reset))
> 	      return PTR_ERR(reset);
>       }
>       ...
> 
> Then you could share all the port kzalloc and port list management.
> 
> Could do the same with the PHY stuff.
> 

Yeah, we could do something like this, but this will unnecessarily do a lookup
for 'perst-gpios' for every bridge node where there will only be 'reset-gpios'.
It is not a big deal though, since this code is only called in the probe path,
but I find the qcom_pcie_parse_legacy_binding() function to be visually
appealing as it separates legacy binding handling from the Root Port binding
and also makes it easy to drop the support for it in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


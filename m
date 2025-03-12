Return-Path: <linux-pci+bounces-23499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C8A5DFAA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BE11709E1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892C24DFE5;
	Wed, 12 Mar 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I216Xd/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725A22DF9D;
	Wed, 12 Mar 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791869; cv=none; b=DVZ7l4M60koFb8aIg7iAyKEChJ+Kj3lOfczf++BHWUAffF4AFC5kgYKZPMd8oU0ipr33+MhY95fyzZ5jmETjMDBuJXG6XNDGx6Omy/QrkGJV5DdroInSTlF2ohE+QBsZkfL/90sg1gsyNIzX4UoLh5f31RP+MlXTACL+8tnuAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791869; c=relaxed/simple;
	bh=0LPk8+MvfGynbwPGt0NyOytayCc66T5wfAVNQKAjUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ASaR6XEdIYB9bibKRET8fF/Oz1MeydVcH6zRakvKhTwOSoI4RojsyD0AhL1oCwV5ew/HnMuXw9GFMi/QIG8JYSPEWdQ3RsbUXa6qWHpdUFczlqd7JhUF1HtGFdNn7D1EeDZTp1narjJ1L8NGrDnSEamXowqSRysvHwMUwuFqKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I216Xd/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6940BC4CEDD;
	Wed, 12 Mar 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741791868;
	bh=0LPk8+MvfGynbwPGt0NyOytayCc66T5wfAVNQKAjUrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I216Xd/eU3neOxcuswv7lF+WIHdCJHXoZollljYS9f5Sg3tH1cpxwS6+GmLSaHZn5
	 OckHLmef0JjB9F/50Ks/GVtqOQsh1YxNfGc2tBFgovF9H/lNV3QgC8bLD6o+3pZQpI
	 hTV/xrbPwP1m0p5ysSBZ+nzGcPuvNx1KAvA0LAszJqGHrwCivPCwcDiTdDXQpqTJPw
	 I7x79FU3hWDQfscuGsp17s5E067AhXp++KBfhbfZ4uUIgQHG3skB8zkiWGm4y5/p5O
	 Fyeo0kuJkdL7ZD0mYuuwFZ/vr6W3zRW0Un9ilz+8pt2G5BlYMSZepkODtztnP9VRs2
	 S0STqRqv1Ah9Q==
Date: Wed, 12 Mar 2025 10:04:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <20250312150426.GA674002@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb5f09f8e4311c7a6ef60aaf3cb4e3f05a8f05e.camel@pengutronix.de>

On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 2025年3月11日 23:55
> > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: 2025年3月10日 23:11
> > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > Use the domain number replace the hardcodes to uniquely identify
> > > > > > different controller on i.MX8MQ platforms. No function changes.
> > > > > > 
> > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > @@ -41,7 +41,6 @@
> > > > > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > 8)
> > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > > 
> > > > > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > platform_device
> > > > > *pdev)
> > > > > >  	struct dw_pcie *pci;
> > > > > >  	struct imx_pcie *imx_pcie;
> > > > > >  	struct device_node *np;
> > > > > > -	struct resource *dbi_base;
> > > > > >  	struct device_node *node = dev->of_node;
> > > > > >  	int i, ret, req_cnt;
> > > > > >  	u16 val;
> > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > platform_device *pdev)
> > > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > > >  	}
> > > > > > 
> > > > > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev,
> > > 0,
> > > > > &dbi_base);
> > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > -		return PTR_ERR(pci->dbi_base);

> > Use the domain number replace the hardcodes to uniquely identify
> > different controller on i.MX8MQ platforms. No function changes.
> > Please make sure the " linux,pci-domain" is set for i.MX8MQ correctly, since
> >  the controller id is relied on it totally.
> > 
> This breaks running a new kernel on an old DT without the
> linux,pci-domain property, which I'm absolutely no fan of. We tried
> really hard to keep this way around working in the i.MX world.
> 
> I'm fine with using the property if present and even mandating it for
> new platforms, but getting rid of the existing code for the i.MX8MQ
> platform is only a marginal cleanup of the driver code with the obvious
> downside of the above breakage.

I don't know the history of these DTs, but if there are any old DTs
for platforms that use controller 1 but lack 'linux,pci-domain', I
agree that we should not break them.

If we need to retain the dbi_base check so that old DTs continue to
work, I think it should look something like this:

  domain = of_get_pci_domain_nr(node);
  if (domain >= 0) {
      if (domain > 1)
          return dev_err_probe(..., "invalid domain %d\n", domain);
      imx_pcie->controller_id = domain;
  } else {
      dev_warn(..., "DT lacks linux,pci-domain, falling back to DBI addr\n");
      dbi_res = platform_get_resource(pdev, IORESOURCE_MEM, index);
      if (dbi_res->start == IMX8MQ_PCIE2_BASE_ADDR)
          imx_pcie->controller_id = 1;
  }

The previous code used devm_platform_get_and_ioremap_resource() and
set pci->dbi_base, but (1) there's no need to set pci->dbi_base since
the DWC core does that anyway, and (2) I think using ioremap() means
we depend on CPU virt == CPU phys, and I don't think we need to depend
on that.

Bjorn


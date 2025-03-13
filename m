Return-Path: <linux-pci+bounces-23666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10ECA5FB1C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E703B12B6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297326A081;
	Thu, 13 Mar 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocuFDpji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC02690C8;
	Thu, 13 Mar 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882011; cv=none; b=Bx7mhlwPHogboAaw8dnVCAtf0zOCmXr8+q3PILrh961f6sgf6elQTYCW39OxP4HflUa+qw3E/YvKl6H/ebs3phP37S+rXBm4/Pke++pQ0H3J3qA7n8gqvUN5ZUCZTZ8EwHAbP9Onv/O2L3LXkPX67OLMpv40BpKCAufU9dPZAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882011; c=relaxed/simple;
	bh=Mx/+tLwb7T1JrZ/ABp2sKGt2Jj7jvlKNBLxVpfOsVnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DjiNSwh4gksj4LcirrkAS+M9NWm44jHUAcWl+rgdq766w8SzkzLUayyoEB0zw7la7tcBTEHagy0WUG+FdoPdH0Yx8J8LLQaZn92B342qB9qIsF1FAe4KwS9oAWEliqqEwGiMTFgPwPrMzQlDPSAHKs7spj0igM0wEE+IfL/o7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocuFDpji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24824C4CEDD;
	Thu, 13 Mar 2025 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882010;
	bh=Mx/+tLwb7T1JrZ/ABp2sKGt2Jj7jvlKNBLxVpfOsVnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ocuFDpjice0CwzZV+U1r2wGc/B4uqAhc1SLsAhGo3hZOCubtpYEujpWK0xMah00Qx
	 Nkhy4eoJwBeQ04rISAQUc07RqNf8z1clfjRrJjXlpOXTOS0tYGyED432lopKTutbS5
	 IerUm1HplPYC5RsM7OpEJvov9V+kvXHi8PJcKfWfaOj3ht7GfIPTwdVBwyDGfdqHOR
	 KHp/fJsQB7u0+joeFsu3ruw68crrUu/wdrUniAW8SwtRtG+5E9HKiSlR4JHSA0iviI
	 tfjWtOg4fPJTNvZbMJi0Mzuqn/PskRw2flaNg6mxClK5//ywkFwTQgQ36xUL35JB+x
	 iKuTzrcXpm0Ww==
Date: Thu, 13 Mar 2025 11:06:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Frank Li <Frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
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
Message-ID: <20250313160648.GA736867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b425a7c7a7d6508daf23fe7046864a498029a7ac.camel@pengutronix.de>

On Thu, Mar 13, 2025 at 09:54:25AM +0100, Lucas Stach wrote:
> Am Mittwoch, dem 12.03.2025 um 10:22 -0400 schrieb Frank Li:
> > On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> > > Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: 2025年3月11日 23:55
> > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com;
> > > > > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > > > > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > hardcodes
> > > > > 
> > > > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > Sent: 2025年3月10日 23:11
> > > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org;
> > > > > bhelgaas@google.com;
> > > > > > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > > > > imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > > > > > > hardcodes
> > > > > > > 
> > > > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > > > Use the domain number replace the hardcodes to uniquely identify
> > > > > > > > different controller on i.MX8MQ platforms. No function changes.
> > > > > > > > 
> > > > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > > ---
> > > > > > > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > > @@ -41,7 +41,6 @@
> > > > > > > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > > > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > > > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > > > 8)
> > > > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > > > > 
> > > > > > > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > > > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > > > platform_device
> > > > > > > *pdev)
> > > > > > > >  	struct dw_pcie *pci;
> > > > > > > >  	struct imx_pcie *imx_pcie;
> > > > > > > >  	struct device_node *np;
> > > > > > > > -	struct resource *dbi_base;
> > > > > > > >  	struct device_node *node = dev->of_node;
> > > > > > > >  	int i, ret, req_cnt;
> > > > > > > >  	u16 val;
> > > > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > > > > >  	}
> > > > > > > > 
> > > > > > > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev,
> > > > > 0,
> > > > > > > &dbi_base);
> > > > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > > > -		return PTR_ERR(pci->dbi_base);
> > > > > > > 
> > > > > > > This makes me wonder.
> > > > > > > 
> > > > > > > IIUC this means that previously we set controller_id to
> > > > > > > 1 if the first item in devicetree "reg" was 0x33c00000,
> > > > > > > and now we will set controller_id to 1 if the devicetree
> > > > > > > "linux,pci-domain" property is 1.  This is good, but I
> > > > > > > think this new dependency on the correct
> > > > > > > "linux,pci-domain" in devicetree should be mentioned in
> > > > > > > the commit log.
> > > > > > > 
> > > > > > > My bigger worry is that we no longer set pci->dbi_base
> > > > > > > at all.  I see that the only use of pci->dbi_base in
> > > > > > > pci-imx6.c was to determine the controller_id, but this
> > > > > > > is a DWC-based driver, and the DWC core certainly uses
> > > > > > > pci->dbi_base.  Are we sure that none of those DWC core
> > > > > > > paths are important to pci-imx6.c?
> > > > > >
> > > > > > Thanks for your concerns.  Don't worry about the
> > > > > > assignment of pci->dbi_base.  If pci-imx6.c driver doesn't
> > > > > > set it. DWC core driver would set it when
> > > > > >  dw_pcie_get_resources() is invoked.
> > > > > 
> > > > > Great, thanks!  Maybe we can amend the commit log to mention
> > > > > that and the new "linux,pci-domain" dependency.
> > > >
> > > > How about the following updates of the commit log?
> > > > 
> > > > Use the domain number replace the hardcodes to uniquely
> > > > identify different controller on i.MX8MQ platforms. No
> > > > function changes.  Please make sure the " linux,pci-domain" is
> > > > set for i.MX8MQ correctly, since  the controller id is relied
> > > > on it totally.
> > > > 
> > > This breaks running a new kernel on an old DT without the
> > > linux,pci-domain property, which I'm absolutely no fan of. We
> > > tried really hard to keep this way around working in the i.MX
> > > world.
> > 
> > 8MQ already add linux,pci-domain since Jan, 2021
> > 
> > commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> > Author: Peng Fan <peng.fan@nxp.com>
> > Date:   Fri Jan 15 11:26:57 2021 +0800
> > 
> > Only missed is pcie-ep side, which have not been used at all boards dts
> > file in upstream.
> 
> I wasn't aware of this. 2021 is quite a while ago, so I suspect that
> nobody is going to run a new kernel with a DT this old. I retract my
> objection.

Sounds good, thanks, Lucas.  We really do want to avoid breaking old
DTs, so I appreciate your highlighting of it.  Even if we believe none
of them will break, I think it's worth mentioning the
'linux,pci-domain' dependency and the commit that added it to the
.dtsi in the commit log.

Bjorn


Return-Path: <linux-pci+bounces-26053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F370A9136B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984A53A915B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAAF1DE4F6;
	Thu, 17 Apr 2025 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmUP/QO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155301A314B;
	Thu, 17 Apr 2025 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744869702; cv=none; b=M7zqJehqiRLOMID0Ubth4Ac2rUs0wiRGkcLRji9uIuKm8CTycox2IOVY2EOBoSMvqTBfUOfgGbUtx+ennP0HERnOKAimxhmVYtJ22xEveCjnMycoOWBQVd3a5A2t8kZxmao6txGDn0k3i0D43Q+nUlO4dl8gphBgbR+3gXoN0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744869702; c=relaxed/simple;
	bh=4kH/J9yRA5h+U0NTvsYz1RB3H5NWTJgszXCPS/hlPCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+A0GWJIy3S651NTpcSJ67JxzrwN+YYq81boBAJpoYCqMaDcJICXNTuzh+9Teifjz8/LyirH5qnPEexKD7fjkmMfVaK489tB9SiEBe6huxFRfCvfhDsdbSVRqB6EtimvQWtr/weNKAwIfPYH7TLQSilObWcZDMVxsbklL79+Slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmUP/QO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E89EC4CEE4;
	Thu, 17 Apr 2025 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744869701;
	bh=4kH/J9yRA5h+U0NTvsYz1RB3H5NWTJgszXCPS/hlPCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmUP/QO880tjH/2Zpb+If0g44/vQswWmgepdZDjP9akYzXQH0uE/T/Ls2vO58rOCv
	 3ROSjGzNouL2IG1jujMqYJpqOv7DuzbwepOsAgkNfGgMPTNTqOk0+IauwPYWpa4Zuf
	 s3XTSdarSX+bihYVDgB0E0iEULdrXRak1nYXWFhpMYJmo6FD1IhF7j00RT4d7N8Afz
	 1hNoaxaeQjAgJ3vykt0TqbEcFyifUUIDqLpuimu+wF+8wp5yqcPDHOClOuqDmwlZ0r
	 NZZ+3dUueK0OD8QCYpsYJdMtzraAE62ZnwpWi8+U3j6FHRYqSxPzmxNHHF1zPAdlvW
	 8wySxFxE/rn9Q==
Date: Thu, 17 Apr 2025 08:01:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <aACZP48pWk5Y62dK@ryzen>
References: <20250416204051.GA78956@bhelgaas>
 <bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com>

On Thu, Apr 17, 2025 at 10:19:10AM +0800, Hans Zhang wrote:
> On 2025/4/17 04:40, Bjorn Helgaas wrote:
> > On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
> > > The RK3588's PCIe controller defaults to a 128-byte max payload size,
> > > but its hardware capability actually supports 256 bytes. This results
> > > in suboptimal performance with devices that support larger payloads.
> > > 
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index c624b7ebd118..5bbb536a2576 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -477,6 +477,22 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > >   	return IRQ_HANDLED;
> > >   }
> > > +static void rockchip_pcie_set_max_payload(struct rockchip_pcie *rockchip)
> > > +{
> > > +	struct dw_pcie *pci = &rockchip->pci;
> > > +	u32 dev_cap, dev_ctrl;
> > > +	u16 offset;
> > > +
> > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	dev_cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCAP);
> > > +	dev_cap &= PCI_EXP_DEVCAP_PAYLOAD;
> > > +
> > > +	dev_ctrl = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > > +	dev_ctrl &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > +	dev_ctrl |= dev_cap << 5;
> > > +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, dev_ctrl);
> > > +}
> > 
> > I can't really complain too much about this since meson does basically
> > the same thing, but there are some things I don't like about this:
> > 
> >    - I don't think it's safe to set MPS higher in all cases.  If we set
> >      the Root Port MPS=256, and an Endpoint only supports MPS=128, the
> >      Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
> >      that case the RP may respond with a 256-byte payload the Endpoint
> >      can't handle.  The generic code in pci_configure_mps() might be
> >      smart enough to avoid that situation, but I'm not confident about
> >      it.  Maybe I could be convinced.
> > 
> 
> Dear Bjorn,
> 
> Thank you very much for your reply. If we set the Root Port MPS=256, and an
> Endpoint only supports MPS=128. Finally, Root Port is also set to MPS=128 in
> pci_configure_mps.

In you example below, the Endpoint has:
 DevCap: MaxPayload 512 bytes

So at least your example can't be used to prove this specific point.
But perhaps you just wanted to show that your Max Payload Size increase
actually works?


Kind regards,
Niklas


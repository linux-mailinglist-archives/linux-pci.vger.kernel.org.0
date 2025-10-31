Return-Path: <linux-pci+bounces-39924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28700C25008
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4073B316F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62834845F;
	Fri, 31 Oct 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gHKvRPN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E91922DD;
	Fri, 31 Oct 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913796; cv=pass; b=MkZOK1880Pgh0SY0pXL2cHBxD8yRJXhBTYggME9wmMJN9Su1AZUdYDbTMnfFUWXlH/EdgVZePN5EJqx6vndelHvBjevpkGc8+CwnV8rBQkhBUqTraycWpsmjZxInMkIpnUldBrZFMTosUGKWYsCDIvGbXatViVJiX8bhCvhq6+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913796; c=relaxed/simple;
	bh=gEr6wUDalR20obqcCqsJpn2+gnQyfPKeWURJKuUhkQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW9I/qHYi6mpjrtkRlSmEZgojMukJHDg2ewniRYGRTlN+1Pd+y5kfgxyXpV71ZyxfNRaTzu6B+nwakodHg3Wjngbg1SVFK5XGCvcZpPwwS2+O4jLzizQocOhgOf/XmwtvgO7au7zSOknWxZOUTaTXm/7Pv0tXxDBn3gMU/biLh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gHKvRPN9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761913773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lbv+fXr9nldSZ6bg2HxAoLbBLIzWWdu/lCarcLknvjWruEAX72qbG2BejhKPOlAwN5ZzV3YQBkuP5enNXNxGYiE9/9WuEll7ddxT82q8CnApUPaV1j5s+LZpNKN4ZpF7nDuaVpmkpfwF7IEy3VTi9k3hcK0kCyaD/TyASu5t6/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761913773; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i4PdjAgGN9CXMADjTYH6Vrnejj2e5huADOUeceii3Ag=; 
	b=VjjbDznmMFtS6Cmdz6hoJi+GITJJ23e5wz0WnnFjbyGQDdu/BiSFoCwWREhaTtzz6AnZ7vR44hHaJTGEUddxPtHHORjctN2ohZUjzZ/OyBz2hVkgCVvXXcoz1nxLFLhC1bAwz6KUkTVAaznLOo+vqScX8aEqOfqJKDQBfUD/FSo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761913773;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=i4PdjAgGN9CXMADjTYH6Vrnejj2e5huADOUeceii3Ag=;
	b=gHKvRPN9Tr1hv3oHVcXGKSvjBpijr3x2hWyzkr57PZTRUoUfwmZeTlH66YqGOOcc
	jFCdXsJEY9zQRdS/yl7j4HDOrK3i1UMRfiLAZml+Fsh1RltGxyHWeEb2FEjGCd6XTDV
	EfLPRnMBl8EBvnX73mNzngposYFIGN4ax4WCWStA=
Received: by mx.zohomail.com with SMTPS id 1761913772134279.7995112453409;
	Fri, 31 Oct 2025 05:29:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Anand Moon <linux.amoon@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
Date: Fri, 31 Oct 2025 13:29:25 +0100
Message-ID: <15087240.uLZWGnKmhe@workhorse>
In-Reply-To: <b2micr4atfax2sgolsublmjk4kwvbmdnqjlk2lb7cflzeycm5i@bi62lg75ilo6>
References:
 <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
 <b2micr4atfax2sgolsublmjk4kwvbmdnqjlk2lb7cflzeycm5i@bi62lg75ilo6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 31 October 2025 09:36:05 Central European Standard Time Manivannan Sadhasivam wrote:
> On Mon, Oct 27, 2025 at 08:25:29PM +0530, Anand Moon wrote:
> > Introduce a .remove() callback to the Rockchip DesignWare PCIe
> > controller driver to ensure proper resource deinitialization during
> > device removal. This includes disabling clocks and deinitializing the
> > PCIe PHY.
> > 
> 
> How can you remove a driver that is only built-in? You are just sending some
> pointless patches that were not tested and does not make sense at all.

The better question would be: why does Kconfig make PCIE_ROCKCHIP_DW
a bool rather than a tristate? I see other PCIE_DW drivers using
tristate, so this doesn't seem like a technical limitation with the
IP.

> 
> Please stop wasting others time.
> 
> - Mani
> 
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 87dd2dd188b4..b878ae8e2b3e 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > +static void rockchip_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> > +
> > +	/* Perform other cleanups as necessary */
> > +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> > +	rockchip_pcie_phy_deinit(rockchip);
> > +}
> > +
> >  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
> >  	.mode = DW_PCIE_RC_TYPE,
> >  };
> > @@ -754,5 +764,6 @@ static struct platform_driver rockchip_pcie_driver = {
> >  		.suppress_bind_attrs = true,
> >  	},
> >  	.probe = rockchip_pcie_probe,
> > +	.remove = rockchip_pcie_remove,
> >  };
> >  builtin_platform_driver(rockchip_pcie_driver);
> 
> 






Return-Path: <linux-pci+bounces-39455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E07C0F9C6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05A5463CFA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69A31618B;
	Mon, 27 Oct 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="S6bRuYh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B123315A;
	Mon, 27 Oct 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585505; cv=pass; b=fZeoqPjygxIRsoSpwt4cGTxZa7ptyUapLGdq6aIP8Esa2xwwlEIp7iLwjyCfQNrAbRegFbp9jn/NbrHw+cYwky0MceNY2wHmUShGhiE9fRGGhMnXzGs0Qta+zeW/GTmBXUbyfdHnlU/4sXTEqk0wJqz20FlkHyfQd7uSGWnyaJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585505; c=relaxed/simple;
	bh=0j+sx1U/dtxtACHyjk6jN8uOJ9uo/XDr3w3aGWyKD8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDXFscDB0aggK9KMVk6VaEV0NzTmVcqhspJIHImticx3usWtciBu0sQtmgNfR3JqIdl3jXqiPsuFzRMCYlcbmg+7AlBuVGSu6Z0Rc5WrBre+JolTF89jto7YGuU1caSGwHE9RkxITSEmnpFd9xZrUxj97VVLV5EoJLDErd0yYv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=S6bRuYh5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585485; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X1gBeOXii1Wsijnw7Xu6bo8M4CrnCviOuvVZYWbFXBr1aczrloVhMYFB+MikS7pjy2qbb60tvRhENSnwzDgH6J6P1fQkI7A25H+TFVYDrRRki8ysfvS8nl3ZLS0GtRPZ9jD9w6BXOqEhTtTBD3uD0wqNMUIkZauQN5j8Mgb+5ww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585485; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZNW4fieYkSA2lBxgemD0NgMNnHAiHnhoG3/C5j4275U=; 
	b=UNU5V48pqwdNROdHla4ojkPzWnjIVdCJco+lukvORCdLcK0YkTQni+DxtavsNlNxkqw/knoWPPsYVNV0yUgaXBqmz9RG4N5rLNHE1XXMIRHPtHN0LxKLw1g/fdgVmgqnvwhXK55DgkvrNxLle/5qcJT6AYDX3gpwh4c8dJI8wVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585485;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ZNW4fieYkSA2lBxgemD0NgMNnHAiHnhoG3/C5j4275U=;
	b=S6bRuYh5DomXJIJWsJQZRBcZ07/nhdm8EK2gY1MDPYCkTD3dEQEs7p1JJmolgssh
	xNj/Mepmd8VCF1afEJF9O2i/lRT3gfGy3mv5lkuJcHQzsTqYMuIWcYD154ZxDihIhPH
	6wWRJWvxeNxcAuvgvUvncXRL/Clwhw+dKenajAdQ=
Received: by mx.zohomail.com with SMTPS id 1761585483468132.07412147907223;
	Mon, 27 Oct 2025 10:18:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Hans Zhang <18255117159@163.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
Date: Mon, 27 Oct 2025 18:17:58 +0100
Message-ID: <14087628.uLZWGnKmhe@workhorse>
In-Reply-To:
 <CANAwSgTmOvOZ35=3XjhrKu2iPCMOU8c8prK5XVAkf3cF1DHekQ@mail.gmail.com>
References:
 <20251027145602.199154-1-linux.amoon@gmail.com>
 <5235617.GXAFRqVoOG@workhorse>
 <CANAwSgTmOvOZ35=3XjhrKu2iPCMOU8c8prK5XVAkf3cF1DHekQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 27 October 2025 17:31:23 Central European Standard Time Anand Moon wrote:
> Hi Nicolas,
> 
> Thanks for your review comments.
> 
> On Mon, 27 Oct 2025 at 20:42, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > On Monday, 27 October 2025 15:55:29 Central European Standard Time Anand Moon wrote:
> > > Introduce a .remove() callback to the Rockchip DesignWare PCIe
> > > controller driver to ensure proper resource deinitialization during
> > > device removal. This includes disabling clocks and deinitializing the
> > > PCIe PHY.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index 87dd2dd188b4..b878ae8e2b3e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> > >       return ret;
> > >  }
> > >
> > > +static void rockchip_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> > > +
> > > +     /* Perform other cleanups as necessary */
> > > +     clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> > > +     rockchip_pcie_phy_deinit(rockchip);
> >
> > You may want to add a
> >
> >     if (rockchip->vpcie3v3)
> >             regulator_disable(rockchip->vpcie3v3);
> >
> > here, since it's enabled in the probe function if it's found.
> >
> > Not doing so means the regulator core will produce a warning
> > splat when devres removes it I'm fairly sure.
> >
> I've removed the dependency on vpcie3v3 in the following commit:
>  c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator setup with
> devm_regulator_get_enable_optional()")
> Please review this commit and confirm if everything looks good.

I see. In that case, your code is indeed correct, thank you for
pointing this out.

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Kind regards,
Nicolas Frattaroli

> 
> > Kind regards,
> > Nicolas Frattaroli
> >
> Thanks
> -Anand
> 






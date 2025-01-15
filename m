Return-Path: <linux-pci+bounces-19919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B6A12A1D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599D3188AC7F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6E155C96;
	Wed, 15 Jan 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR6bUyQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F514A630;
	Wed, 15 Jan 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963316; cv=none; b=JMMUDgXXVqJpn+ZcWzPmkBLXs9G5bh8jdcsGsfoC43D1iSGt0NlgT180xmCwvLeaJ/2i3H+nvc+VkknFkxihg/NZbyKSI63s+6OAPkXqgjDy8mOgLEclXL8YDk/VTpYlW/4YxegS1fBigJJWIkO2NAvM3x0ik1bUpblmbbfhvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963316; c=relaxed/simple;
	bh=nEpsi2Yg2uzElK6pn63lsWLWfMq1/r33gPIr0bj4FDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l1OV+ruq8IhnW7UtXXVMjvVvqlhvyZMoXTfch02AprlxR1Bqy9kdhmDthYFtCKMKD7LLpTFjq0erZUHuMrsT4UtViQ4ORxHoVsmCDZ2G2yYjnzKr6W8O+wcYHMkLsZgiegSPJ0TISwuJsNN6gihStHrUv/WLfvQs4g+HrKT72vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR6bUyQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF20C4CED1;
	Wed, 15 Jan 2025 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736963316;
	bh=nEpsi2Yg2uzElK6pn63lsWLWfMq1/r33gPIr0bj4FDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pR6bUyQNjMdTUloG+A+LFhM0r1HPHTFHf18a+LYr7WmvgOV78YR0sCLHzGn+Sfg8e
	 odv4JyCWpMlxio4KNaiDMnuJZqYndCmAOL4ESppJyHiHZc4B+76s9F/crzBA7ecNLi
	 Lx0vqC9+snUKwBdyRQ9/WTd8A6zoQxCWSeHN+4RUzoIRfYLHWUVTlspWT4f0Y5HTXC
	 LfLNxiEqRZU7vJ8qyIhokO5/f77Rzp3nyz2+mnnNvinQ68gPBNvYxMsJc+2/iSPMSQ
	 YAZVGljXNddAPfVsqapDhe41yE9HE4t3AuDzf3jcpq+fUjx1oBKCdInys/cHfjJc2Z
	 sASzwyinBTvVA==
Date: Wed, 15 Jan 2025 11:48:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v1] PCI: rockchip: Improve error handling in
 clock return value
Message-ID: <20250115174834.GA538101@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115174012.bdny6nxxr4tuzyis@thinkpad>

On Wed, Jan 15, 2025 at 11:10:12PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 06, 2025 at 09:00:38PM +0530, Anand Moon wrote:
> 
> Subject should include the word 'fix' not 'improve'
> 
> > Updates the error message to include the actual return value of
> 
> s/Updates/Update (imperative form)
> 
> > devm_clk_bulk_get_all, which provides more context for debugging
> > and troubleshooting the root cause of clock retrieval failures.
> 
> Btw, it is not just updating the error message, it also returns the
> actual error code.

Already squashed into
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=abdd4c8ea7d7,
sorry I didn't mention that here.

> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202501040409.SUV09R80-lkp@intel.com/
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index fea867c24f75..ca6163f9d2dd 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -99,7 +99,8 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >  
> >  	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
> >  	if (rockchip->num_clks < 0)
> > -		return dev_err_probe(dev, err, "failed to get clocks\n");
> > +		return dev_err_probe(dev, rockchip->num_clks,
> > +				     "failed to get clocks\n");
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.47.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்


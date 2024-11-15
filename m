Return-Path: <linux-pci+bounces-16934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DB9CF685
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73E41F21973
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4D1D54E1;
	Fri, 15 Nov 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgDUrqx3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E723187876;
	Fri, 15 Nov 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704540; cv=none; b=W/F50oxGYMQV5xvfmgINKyI8LbvhyH+hBlO3cUQTiN6rjkdIl81iPeeMw5A2Rwr+UrfWoVRhr6sPBxd0wAq3nHC7PsEGiH+b5hcuRaCing1lfLUQ6VioGq67bwR/gIrD8hIkXOE0BZ9ykf3VyOQaleiDCZ36gC0pZSNE/IYZHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704540; c=relaxed/simple;
	bh=Ew1PhCixV+cuNmjEbrNSMuBFjg84CIjjuovjx8h8bX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OZ2cLYBCxN8icRK+OULdRl9LSr3kZ18IvXnuOYdKClDsEHtDOsoYVs6MSXWuxBMlHfVSeWhtVYrc5GwEEitjAqjLIWdOC4gQ/Gc8B0z6CtYh26yBBTUKzfQnScbSMj3iRFP7EcTMJzfbj8gxNA+Xk86T/eWPcYvtpfyDTdjp7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgDUrqx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E5FC4CECF;
	Fri, 15 Nov 2024 21:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731704539;
	bh=Ew1PhCixV+cuNmjEbrNSMuBFjg84CIjjuovjx8h8bX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VgDUrqx3HNiQFjxrmU/rFSuneJja4Eey3brpwM0Ga2uhTz162OUOQdEUkZqlUw+zc
	 2uucFFvvu9eXK51/YjaeoPXbiCWsEMbqA4l227f6Ggr5S2ZCcXwkwsunCfU7qXBtrg
	 phXc8LgCgg1yHEDghqf+5B08I52etkks3oobTuEglcXWuyssDrorO+vYCC4+0Hd0+4
	 poGqxUMARsxd8PkExJoJSwzOG93cIScCpwGfEFYCETeQ2mZ8gfv/MMnAHutTubiXfx
	 eWOjHhg/ANs4AXWUYUa4Q2jlLa4zAgRM0H6RzkRVjEIFM6rSdjTLYiofMpBZUVki0m
	 96ChGHPJW1B9Q==
Date: Fri, 15 Nov 2024 15:02:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove IRQF_ONESHOT and handle hardirqs
 instead
Message-ID: <20241115210217.GA2057245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115165717.15233-1-ilpo.jarvinen@linux.intel.com>

On Fri, Nov 15, 2024 at 06:57:17PM +0200, Ilpo Järvinen wrote:
> bwctrl cannot use IRQF_ONESHOT because it shares interrupt with other
> service drivers that are not using IRQF_ONESHOT nor compatible with it.
> 
> Remove IRQF_ONESHOT from bwctrl and convert the irq thread to hardirq
> handler. Rename the handler to pcie_bwnotif_irq() to indicate its new
> purpose.
> 
> The IRQ handler is simple enough to not require not require other
> changes.
> 
> Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Squashed into 058a4cb11620, thanks!

Also added your tested-by, Stefan, thanks very much for doing that!

> ---
>  drivers/pci/pcie/bwctrl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index ff5d12e01f9c..a6c65bbe3735 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -230,7 +230,7 @@ static void pcie_bwnotif_disable(struct pci_dev *port)
>  				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
>  }
>  
> -static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
> +static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  {
>  	struct pcie_device *srv = context;
>  	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
> @@ -302,10 +302,8 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> -					pcie_bwnotif_irq_thread,
> -					IRQF_SHARED | IRQF_ONESHOT,
> -					"PCIe bwctrl", srv);
> +	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> +			       IRQF_SHARED, "PCIe bwctrl", srv);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.39.5
> 


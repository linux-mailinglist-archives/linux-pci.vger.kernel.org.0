Return-Path: <linux-pci+bounces-32137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C2B0562A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897F53BB24D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54062D6405;
	Tue, 15 Jul 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4e/gA/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9CE2D6401;
	Tue, 15 Jul 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571208; cv=none; b=Z0dFEtEWpdcoU7VDSX1vnuYtXkuhfuW9JTh2uwsxsVgSO/ceYqhGI9W3lF7/S7zLGpBwX3aZee/KzUOeb8615ptbhQUnq3jyarkTs5zOOoTMifPJVXo+QqKBnK/u1As9wJsf7pf/SbNj4YVFwm+tULJunZWay+z4/xQmjlg1oXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571208; c=relaxed/simple;
	bh=zMX0HnJ6CCzw8b9lVKy3uhSYJilLYoAhgM5/FrM5H9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8RQ/jVyhF/70LUqW9XWXIcenC1dtg8+HNv+LCEXPIyMcH3eJyjW9jEKEPDOP0ko+pJ+2Ihp8tx+NJl0RbwujxU5ly+xO6e/FB2EHy0PNIbwdvCbYndVWsdnS5kb4Gngd0P5FzswV2of4rFNGW0N7dbwgG+KD8yc61yJrdqByGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4e/gA/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA07C4CEE3;
	Tue, 15 Jul 2025 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752571208;
	bh=zMX0HnJ6CCzw8b9lVKy3uhSYJilLYoAhgM5/FrM5H9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4e/gA/XYvMMld3wapT7zeY1Gk0uwHEwJggXKWAa4A9zBaFmlJPabx3x1jsbR3yNJ
	 R0GpKskCbOugdis7UiMYxXYnDrOzn/3/1+OUIOLoEdjOIsos0z6JrQcMUjNzQlKcre
	 lz1944BNZHo8Y5XDm7f+ywdeXXcX700tfufNkwNk7XQYX5eOLTKfsLSCzXqjpCFC03
	 HjshEiqu1EwEsrzoU5vhtsQruoimF/UqS2FUcQbB60aU0ppgJ5dVZrk8/XJB8ZaWpR
	 hMimgMsxb0vHBX51jmnVu+jjDPdCVfJnQ9diGWXPuuv61GKkWjTE8KGEJ1K7gGO+Hq
	 zs+q6/TELjheg==
Date: Tue, 15 Jul 2025 14:49:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczy??ski <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/4] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
Message-ID: <tfpszamhfxx62vclkfxqfuuda24ps6e4yti7fgywycznpwfj5l@22nggkft2mph>
References: <20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com>
 <20250715-pci-port-reset-v5-1-26a5d278db40@oss.qualcomm.com>
 <aHYOW3P0wvHo5a1j@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHYOW3P0wvHo5a1j@wunner.de>

On Tue, Jul 15, 2025 at 10:16:27AM GMT, Lukas Wunner wrote:
> On Tue, Jul 15, 2025 at 01:29:18PM +0530, Manivannan Sadhasivam wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4964,7 +4964,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> >  
> >  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> >  {
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +	int ret;
> > +
> > +	if (host->reset_root_port) {
> > +		ret = host->reset_root_port(host, dev);
> > +		if (ret)
> > +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> > +
> > +		return;
> > +	}
> > +
> 
> There used to be a pci_is_root_bus() check here:
> 
> https://lore.kernel.org/r/20250524185304.26698-2-manivannan.sadhasivam@linaro.org/
> 

Right. I forgot to include that series, but somehow managed to remember the
s/slot/root_port change.

Will incorporate in next revision, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


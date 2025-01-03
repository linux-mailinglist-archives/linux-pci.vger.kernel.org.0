Return-Path: <linux-pci+bounces-19262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C489A00FEA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7165B3A3187
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784B1B6CF5;
	Fri,  3 Jan 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUQZ4INt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C0145B03;
	Fri,  3 Jan 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940193; cv=none; b=oruTK/TOXOEu18OK5NvH7RO3HMbdgN+L8MKxD/QnSNO+XUC8SRHTnxpUd/jlPLPrH6/sA2ZTZUTTGZU8TEXOGBqtEw1j8URajlHnguooimyK8wjmOX9Ok77n4zW3wnXDPHP+I8NeSCYmtrIrFjsyzZorP1eHVyPWI5h3Lmaz6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940193; c=relaxed/simple;
	bh=4RvZ5/bkQa349eQIKS/B0g5KrNiMZ5x+O7hc+0tHgmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Peu5hNscbOUnKzJaXT4UKAhKMF1jdQoodqFC5b4o01f6lESSFovJkuNhThxQcQmswk2zwYk6DPfFePgm5R61n5Qc6DiHBrHwnJQO6MFYDap5izFTmnZXg0QhxwhQNUsVBASbvotME2wtgYqFmhCti2DXt5Rv0q8GqwA8NLUwo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUQZ4INt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00212C4CECE;
	Fri,  3 Jan 2025 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735940193;
	bh=4RvZ5/bkQa349eQIKS/B0g5KrNiMZ5x+O7hc+0tHgmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dUQZ4INt2Rg9/vN2lUtpONoWNUrNCNJw3CmHU96TAIrOBYAQlsKcDnJBUQFKk3iFU
	 2K5qgB0CJlUTSu0I6SxVmpU+PA+CZLvXLYHdv3i2DFaREOHwHGEp279XW7gEKpUVGj
	 xJMp+i95gSXi08j7lrJUsMSygoJjqc2+8I1xmVqltASTJtO7a3KfvgIQyvZ/axsfiC
	 PYkifSMZWyGadw5hb2m+DAXA9hkg+/zCLH9fDcp2QeB9knCK1k2HPmHBqUr2fzPKST
	 8DGaSyfwOdnSDhSoImy6KI0AyI/5uTQRI35A/SjkM4wT9WffO9ZuMzoLK4PASn2WZa
	 OvtVt2gtMXoJQ==
Date: Fri, 3 Jan 2025 15:36:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: of: Simplify bus range parsing
Message-ID: <20250103213631.GA6246@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103213129.5182-3-helgaas@kernel.org>

On Fri, Jan 03, 2025 at 03:31:28PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> of_pci_parse_bus_range() looks for a DT "bus-range" property.  If none
> exists, devm_of_pci_get_host_bridge_resources() defaults to the [bus 00-ff]
> range supplied by its caller, pci_parse_request_of_pci_ranges().
> 
> devm_of_pci_get_host_bridge_resources() is static and has no other callers,
> so there's no reason to complicate its interface by passing the default bus
> range.

> @@ -343,8 +340,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  
>  	err = of_pci_parse_bus_range(dev_node, bus_range);
>  	if (err) {
> -		bus_range->start = busno;
> -		bus_range->end = bus_max;
> +		bus_range->start = 0;
> +		bus_range->end = 0xff;
>  		bus_range->flags = IORESOURCE_BUS;
>  		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
>  			 dev_node, bus_range);

Hmm, would have been better if I'd compiled this first to notice the
build error, sorry about that:

  drivers/pci/of.c: In function ‘devm_of_pci_get_host_bridge_resources’:
  drivers/pci/of.c:349:57: error: ‘bus_max’ undeclared (first use in this function)
    349 |                 if (bus_range->end > bus_range->start + bus_max)
        |                                                         ^~~~~~~

Will fix.


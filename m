Return-Path: <linux-pci+bounces-36065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D5B558DF
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 00:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D391B2589F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3B274FD1;
	Fri, 12 Sep 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrPPpSTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471E1F416A;
	Fri, 12 Sep 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714974; cv=none; b=JQlfOcPXajMMbCxlRof36O41vHY8Y0IACH/Eex37J3Ca66Y4XjPR7TZtbmc7Z8LIqcjNW3b4FC5lUply1hzZ1gXUOgr4orxAPz2yfy0FP66q9FS/4clePTuMmN99fbpDZVYCgOBDkis2KteV4dAifR3v6cS82uuCxvdBAV1Mr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714974; c=relaxed/simple;
	bh=785dnL1cR503sPXwzjQgs+d32xf0TfDWlI00A3IB32U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GZGBRv7txUVe7yyBDcRsNJega+kBunsHpFenB7tDoqSrJZRltQ/iLnKZRj3iV7MWOwWZ5l2u1Zto6maEWfKNzTnZ5FfhkaNUiUI0timmvqPKpN6B4cgn+OYrnTm4NQ8k1QoOW2z8O3b73gUXx3X+ajYF7OtEVyB/fmwmBS4ut2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrPPpSTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A015DC4CEF1;
	Fri, 12 Sep 2025 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757714973;
	bh=785dnL1cR503sPXwzjQgs+d32xf0TfDWlI00A3IB32U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TrPPpSTdVPuY4ofdfnAp34z/qSX4uirK7BXjuBjCO53vgTS1OE+LaBwfVgdfE1wEQ
	 AtkgulPMm9P/6sxKSGAL3pbO+iziMNa3TzryfHRqqykU3OTLl+dLmzbrhH2MXyswfX
	 Pao+j3QLa9FtTo0kzMzE48UMNECMPfQ5hT5fymptpLfhwnOvG/VAKzwRTOkb3tC4cp
	 dOZsFVbuknxOfJBKN28wP6nOF325Jf3nXpgLNJ/jzEyZPnvC4T0vOKoyxnM4J8axUJ
	 Nc8Zck8IRcL5mbqVFucS5aF0O44HcMD+0NZVajKryUBBaDe8Sikc5T0HV29R4tMx6m
	 MT+kyiWnsgYIQ==
Date: Fri, 12 Sep 2025 17:09:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: plda: Remove the use of dev_err_probe()
Message-ID: <20250912220932.GA1644863@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820085200.395578-1-zhao.xichao@vivo.com>

On Wed, Aug 20, 2025 at 04:52:00PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

Seems sort of weird to avoid dev_err_probe(-ENOMEM) because we have
internal knowledge that dev_err_probe() does nothing in that case.

It leads to patterns where the first few things in a .probe() function
return -ENOMEM directly and later things use dev_err_probe(), and
there's no obvious reason for the difference.

But it's very common, so I guess it's OK with me to follow the common
pattern even though it's a bit strange.

> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 8e2db2e5b64b..3c2f68383010 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -599,8 +599,7 @@ int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
> -		return dev_err_probe(dev, -ENOMEM,
> -				     "failed to alloc bridge\n");
> +		return -ENOMEM;
>  
>  	if (port->host_ops && port->host_ops->host_init) {
>  		ret = port->host_ops->host_init(port);
> -- 
> 2.34.1
> 


Return-Path: <linux-pci+bounces-44306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384EAD0693C
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 00:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B1D301E91B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B51E8836;
	Thu,  8 Jan 2026 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZCir6Z7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A527C8EB;
	Thu,  8 Jan 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916489; cv=none; b=PT6Uik6R0CoL65/V1TUUGPmaPWZw0ESjgvSjSyWA0v69pJ1sJW8dRD0NeQsepkyEd52I6E4t/wvNmbX+mYS2xzltzHNDf/Hs3vkluVL8oaLj+VMh0d9422wvqnN4fi5cS2NdUYM7DeH85btuaROY4jPe5hXMKIIBmPaMTzU7QgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916489; c=relaxed/simple;
	bh=8e10VyQhOHbwrYTM0BWmNbHC5heGy23tIib50sod+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BEzmk4B2a3+Red6Mo1r3UZl7qUvbkrnralJ5oqHxBEHPNKJ8f+A9b1hjDbxx45FepnraN7YjGkE1CXsZ+b0TNa9S9muipnmh/IyTh6YFOVxoREQ72MxVKGFkPQ4q5FxTXNPvZSDQebjCeN7xyx4Hey9bd4e3VpRWtJQrZAWAVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZCir6Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD13C116C6;
	Thu,  8 Jan 2026 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767916488;
	bh=8e10VyQhOHbwrYTM0BWmNbHC5heGy23tIib50sod+lQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YZCir6Z7bKctcLUb6j7MrKWzJsPFeTpz/SXfB4dJeAl+igMa+hqOu4CvIywfjtTL2
	 yrAAxFS6HRS24aN4aSUh6u7V/6JfUziH4I72EcgjMyun0pWPVdiyhDIXdEDNYyZ6h8
	 ZTZv9D7Ck8jAUl/mDpD4xsByEemgup2gKNwnPcz2a6SPz6qhsuus/QUlwwNz0Z4d4D
	 sIG5t3b9UMgmdCB8RT36XYaueJsKqkSOMTNFc2lYgWS8h8jT7UisToKfExZiPBAOH9
	 nHMNfMW7WZiFKF+jH233HmOdBa+IsfYkkxz0U/WauNNoRMgnJsmsy3DX+RLuU5OfAC
	 6yrGTp+QftZQw==
Date: Thu, 8 Jan 2026 17:54:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Message-ID: <20260108235447.GA520211@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112095442.1913258-1-haakon.bugge@oracle.com>

On Wed, Nov 12, 2025 at 10:54:40AM +0100, Håkon Bugge wrote:
> The bit for enabling extended tags is Reserved and Preserved (RsvdP)
> for VFs, according to PCIe r7.0 section 7.5.3.4 table 7.21.  Hence,
> bail out early from pci_configure_extended_tags() if the device is a
> VF.
> 
> Otherwise, we may see incorrect log messages such as:
> 
> 	   kernel: pci 0000:af:00.2: enabling Extended Tags
> 
> (af:00.2 is a VF)
> 
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

Applied to pci/enumeration for v6.20, thanks!

> ---
> 
> v1 -> v2: Added ref to PCIe spec
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a87..014017e15bcc8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2244,7 +2244,8 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
>  	u16 ctl;
>  	int ret;
>  
> -	if (!pci_is_pcie(dev))
> +	/* PCI_EXP_DEVCTL_EXT_TAG is RsvdP in VFs */
> +	if (!pci_is_pcie(dev) || dev->is_virtfn)
>  		return 0;
>  
>  	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -- 
> 2.43.5
> 


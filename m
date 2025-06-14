Return-Path: <linux-pci+bounces-29812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B55AD9C6C
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67623BA599
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479916A395;
	Sat, 14 Jun 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSvO+Rup"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AC8633A;
	Sat, 14 Jun 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749899793; cv=none; b=i3uQdN4KQE3AZo0zm45PZf5nWQ765utcjtz1Z5devqfvSgQF64nVsHh1/LIpS2BVoSnOtnhVRg37M2vPadLqm65nnTrDqEVevYkSBDka0BQB0rainSdmqfljSTOKqwXqSV1lxYrTUC5/JxyXDK5BiME5t5w+MFlN6yh3MJgR9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749899793; c=relaxed/simple;
	bh=X9xDO0up16rT/k7uTrPBb2e9wca60PKhcFhlzmD1abM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMzyD3UuMdIoKuQyPVlePm0bO5cVAdWlG89PTo9mZe45AEjTB86ml97sVlkwWC2QZjuwXuCssZ5pGdfph09qtn/Eyi0IHS8UeX/7/wt3fADtjT0BTqVdRHPeAyHU50laGrJHdv+FMo5f8DhE/yReLr+X4qvpqli2P2DTgbKUY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSvO+Rup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE6EC4CEEB;
	Sat, 14 Jun 2025 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749899792;
	bh=X9xDO0up16rT/k7uTrPBb2e9wca60PKhcFhlzmD1abM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSvO+RupbNq8Amfag+Z0W5P8z7b6LcotkjLyXS9/DZA07+dGP7MnbWmF/QvLSDBNH
	 FXECrjOv4fb9ZBF65GgwPQ+oUkX0D3PNFuqw+vKbfsUD8oSaGfX2tJJtaWA5IrisS6
	 d68PVUtU1Ksw+Zg6EbW9FMNQC/galUqOTiKcm7D4126N8xlWKFSlTIMtliH190JnRP
	 GiuW8BgTBP55NYETzAeKWp/1WEfRJ3VgNJoGfGpU441QapwUMjsxYvngVpBG9xd9He
	 ZILanRzNpsy6tPv62mowDWgTlEfujqqB2z4eNIGbvLU13aJrTa3OSW2bEbYp6cGUxF
	 XR1eFmHUpN+OA==
Date: Sat, 14 Jun 2025 16:46:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition
 to drivers/pci/pwrctrl/
Message-ID: <sy2pxbexfr7nhpd52ml2s4obghsbr7n7bfkym4guv533lxxxyc@pwi6rih5efmh>
References: <20250614052651.15055-1-mani@kernel.org>
 <aE0lGcYO1asrwb9z@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aE0lGcYO1asrwb9z@wunner.de>

On Sat, Jun 14, 2025 at 09:30:33AM +0200, Lukas Wunner wrote:
> On Sat, Jun 14, 2025 at 10:56:51AM +0530, Manivannan Sadhasivam wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2508,36 +2508,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> > -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> > -{
> > -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > -	struct platform_device *pdev;
> > -	struct device_node *np;
> 
> Looks like...
> 
> 	#include <linux/of_platform.h>
> 	#include <linux/platform_device.h>
> 
> ...can also be removed from probe.c, both introduced by 957f40d039a9.
> 

Right. Will send v2 removing these, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


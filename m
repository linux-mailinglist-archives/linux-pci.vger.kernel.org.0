Return-Path: <linux-pci+bounces-16206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B09C0008
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13D51C20D56
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2381DC05F;
	Thu,  7 Nov 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzQjyS4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4531D7985;
	Thu,  7 Nov 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968484; cv=none; b=mb7dV7YbZR85Jgnjj8dioswETsWHmvmI+fxrtAu7x9K61k0VXeTziE0gBF9CsqEi+JXQvlD2I6fHkTRuOrcY5jJVJNlVLGCr4lC1vLUBWbN2oxdSk0uAmvzDXlck9GWGRvJqWtzo7YmHsFAtrmDsaLuHN2PnhWCHZCP+qxp7VpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968484; c=relaxed/simple;
	bh=e1p9ZMW7teYCEnbCKcr1SaIZsmbiLbiyA0aRfo9a4ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt4az2+sNb+ofCzL07r8whPAyQivGnIc2s4LGdbu/NXr6il/Fl3j7DJpjbPMEg7b3eaFxBc0tLJ6vQIEz6/DDqTUXgEOVJdgzVhhyBRbCtUXUgRa52jLVN6/Wtvl1ydUjlYkT/1CC91VrbWKXGIZ59fGYB8JW7WTftK0/epL/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzQjyS4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E930C4CED0;
	Thu,  7 Nov 2024 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730968484;
	bh=e1p9ZMW7teYCEnbCKcr1SaIZsmbiLbiyA0aRfo9a4ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzQjyS4swRtw9uZAsUgKWPt1NpHPotdwa7Ov8LPJB0RozbK0EqW/j1nBtFuY3aJKp
	 6K+5P+ChTG/5Sis5ylhVYIKzG2lDx9xU7sRlUlBqxW8Z6ukAfGh+5RoZqhmHTYb3w7
	 Kpg4842dFA9rM5cvz82UrpI0eEiNEMkrOCfk3UEo=
Date: Thu, 7 Nov 2024 09:17:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Rob Herring <robh@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Anders Roxell <anders.roxell@linaro.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH RESEND] iommu/of: Fix pci_request_acs() before
 enumerating PCI devices
Message-ID: <2024110759-refusal-mayflower-2522@gregkh>
References: <20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com>

On Thu, Nov 07, 2024 at 01:29:15PM +0530, Pavankumar Kondeti wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
> 
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
> Earlier this patch made it to linux-next but got dropped later as it
> broke PCI on ARM Juno R1 board. AFAICT, this issue is never root caused,
> so resending this patch to get attention again.
> 
> https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/

Please don't resend known-broken patches.  Please fix them up before
resending, otherwise we will just ignore this one as well as obviously
we can not take such a thing (nor should you want us to.)

thanks,

greg k-h


Return-Path: <linux-pci+bounces-24038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68495A6717C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6AC3A80F8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F22063EA;
	Tue, 18 Mar 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7J/525N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEB35957
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294296; cv=none; b=LP4sigk+jC7LRSw2gF5Tb7JJYUYV3RYCgEznKRi1OsTnXMrJSxFw2ZamkSo46M94Z83aIdOhcY1PW1GGkH4f62eaqClR7iaRpTMgz9Pu8+LeE7BJN7ETQT8G/vfbxsoOyRPpLEWXNxZ895sEF4nHMn6tk6tI8xTqdGK/DTKwAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294296; c=relaxed/simple;
	bh=e8aYrmYbTeOJWANJtVfcp51amWtVFnk+rPVjECWmRn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8ExC843BnPYhLV78hO0lF+EDTci/kiLPmfIcx++qzHAw/jy3DwHVRH8lXfnfqIIjyLTuIuOipBMnibXe+ANzN/Xa/fYEQoSiZga09GHSpi3DWsa25d5mgTQF90CofwkCbWwXRg+QFnpmmmHdj4oGbI5lYNVds+A6x4rAXU/t2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7J/525N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7AAC4CEDD;
	Tue, 18 Mar 2025 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294295;
	bh=e8aYrmYbTeOJWANJtVfcp51amWtVFnk+rPVjECWmRn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7J/525N9xmA6R6nMIeI4UC9v5jwJ6E9Gw6A6gyjopq8wL5qly6U75dWnAtajh9Nn
	 GhI+59l/NThxmaA8wANQxvsZ1c/wyPRuTg5x3HsiDrRHd0JlhTOx+VyrOKHyvpL3Xd
	 mrTEDRcHEZRc5zuHDquqf1nyogWjfO6EQiw4Hi4q3qVNxF1d8IO7e8n5MLNdViVDlx
	 hf2WjEda/su4bhqJ0tNf2rNAlbNveQuMYxjwIo2n4P28s3LytkuQ8NSJpWYfhRMuJD
	 zVvo0fibmF3QAxe4A4QYBrmqb4sxbc9fp8JyQFqRxnhcP1Nh3MgjeIKNS2K8NYVw1k
	 S0LmcaO3+rKEg==
Date: Tue, 18 Mar 2025 11:38:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/7] misc: pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <Z9lNE68x1CIIUlaM@ryzen>
References: <20250310111016.859445-9-cassel@kernel.org>
 <20250310111016.859445-16-cassel@kernel.org>
 <20250314124548.inffbk3c4kw22rwb@thinkpad>
 <Z9Rmoh_vtrXzFG0X@ryzen>
 <20250318085656.q4aohbdvidhzn6af@thinkpad>
 <Z9lArl5AUA7vbKVA@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lArl5AUA7vbKVA@ryzen>

On Tue, Mar 18, 2025 at 10:45:18AM +0100, Niklas Cassel wrote:
> On Tue, Mar 18, 2025 at 02:26:56PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > I guess one option would be to remove the
> > > "pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);" calls from the test cases that you
> > > added, and then let the test cases themselves set the proper irq_type in
> > > the BAR register. But, wouldn't that be an API change? READ/WRITE/COPY
> > > test ioctls have always respected the (a successful) PCITEST_SET_IRQTYPE,
> > > now all of a sudden, they shouldn't?
> > > 
> > 
> > This makes no difference IMO. The previous behavior which you explained above,
> > ignored the result of 'pcitest -i 1'. And it was not user configurable. I think
> > the original intention was to use MSI for tests if available, else use whatever
> > the platform supports.
> > 
> > If you want to restore the original behavior, you should remove the ASSERT_EQ()
> > from READ/WRITE/COPY tests first. Then to ensure that the tests make use of the
> > supported IRQ type, you can have the logic in the READ/WRITE/COPY tests itself.
> > If test->irq_type != PCITEST_IRQ_TYPE_UNDEFINED, then just use whatever the
> > test->irq_type is. Otherwise, use whatever the platform supports.
> 
> I can submit a patch series that modifies PCITEST_{READ,WRITE,COPY} to always
> figure out the IRQ type to use by themselves.
> 
> But you can't have the cake and eat it too.
> 
> Either PCITEST_{READ,WRITE,COPY} always ignores PCITEST_SET_IRQTYPE or
> they don't always ignore PCITEST_SET_IRQTYPE.
> 
> Only ignoring it "if test->irq_type != PCITEST_IRQ_TYPE_UNDEFINED"
> makes no sense IMO.

Please have a look at:
https://lore.kernel.org/linux-pci/20250318103330.1840678-6-cassel@kernel.org/T/#t

I hope that it addresses your concerns.


Kind regards,
Niklas


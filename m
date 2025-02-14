Return-Path: <linux-pci+bounces-21474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73AA36225
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54445189511F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39326773A;
	Fri, 14 Feb 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7z+ajB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113B267733;
	Fri, 14 Feb 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547875; cv=none; b=czjpBL0jROIIYzwhHB2GXEpotHn41dFooC7nyXftHgV5Om4wrsxc4tGpv8lj/4K0QsWfvw6VpYTfmEz638pZC1mt0Bd0dBTe/7uEwTDK549BSiGsjN4X/6YfRYcQZEFsJ5vTXkcAEV8tjbA9TLsSpmoioQVsZMSSRixbvc0nSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547875; c=relaxed/simple;
	bh=0qPMF2GZH1hf43cYEUxXLAbgzi4XUuPhz9OnFLfkrlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpB0AkrvYLGC+psNVWZWEOB7hcDN159IrTtcVPYAQTUxFnDv5YYvUBQVSCsZsEryb3xQHFWlMSQpDhvmrmR59rtPSy800jshbGaSUXRZSzfX6S1N7oI03csF10LKo/nwoUuCsFPDt6XKEsG3eecp+9WMfXsoM6nOwlOkhSxUbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7z+ajB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC79C4CED1;
	Fri, 14 Feb 2025 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547874;
	bh=0qPMF2GZH1hf43cYEUxXLAbgzi4XUuPhz9OnFLfkrlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7z+ajB5o/TOUvRsTSI9RlPkFmYllMrMCBgdTHF5c+JHAP4oQIMRVxChwjjppjc5Y
	 GGMjJNLy+H2amQc/RAEedrKqUC/+KmpF5jOkgO9n/Eukc9vSgqDtdJkfSA7S0/tmK2
	 KMd/8lf6Czr8i1lOME2IrUY4IbOW+ETMqJyNZ1KovYQB4AjsJkDvP+tcC8fUBiA9y5
	 oHxupsOrIIqiiPwq4zUZnUG3J+P7nsiEZqFmHH7CZsDZ0oxMrAlF8id2hL7VN//4Dw
	 jjva6itCuZH6JmLWJ0Ob7Vt8lTZo7yICycaf4y5Rd0uR9iG/O8QsqC0pwgT48h6DSD
	 RRK3dzwQkSiDA==
Date: Fri, 14 Feb 2025 21:14:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Message-ID: <20250214154415.ns5li3ywlxawmzz6@thinkpad>
References: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>
 <20250211183859.GA51030@bhelgaas>
 <20250211195601.GB810942@robin.jannau.net>
 <20250211220019.GC810942@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211220019.GC810942@robin.jannau.net>

On Tue, Feb 11, 2025 at 11:00:19PM +0100, Janne Grunau wrote:
> On Tue, Feb 11, 2025 at 08:56:04PM +0100, Janne Grunau wrote:
> > On Tue, Feb 11, 2025 at 12:38:59PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 11, 2025 at 01:03:52PM -0500, Alyssa Rosenzweig wrote:
> > > > From: Janne Grunau <j@jannau.net>
> > > > 
> > > > The iommu on Apple's M1 and M2 supports only a page size of 16kB and is
> > > > mandatory for PCIe devices. Mismatched page sizes will render devices
> > > > useless due to non-working DMA. While the iommu prints a warning in this
> > > > scenario, it seems a common and hard to debug problem, so prevent it at
> > > > build-time.
> > > 
> > > Can we include a sample iommu warning here to help people debug this
> > > problem?
> > 
> > I don't remember and it might have changed in the meantime due to iommu
> > subsystem changes. What currently happens is that
> > apple_dart_attach_dev_identity() fails with -EINVAL. I can't say whether
> > that results in a failure to probe now. I'll test and report back.
> 
> Using a kernel with 4K page size It results now in following warning per
> PCI device:
> 
> | ------------[ cut here ]------------
> | WARNING: CPU: 7 PID: 260 at drivers/iommu/iommu.c:2979 iommu_setup_default_domain+0x348/0x590

This should be added to the patch description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


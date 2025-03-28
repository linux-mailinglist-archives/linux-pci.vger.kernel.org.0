Return-Path: <linux-pci+bounces-24960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A93A74E0F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A59E188D29B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293191C4A2D;
	Fri, 28 Mar 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/+W/YuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA81DE4C6;
	Fri, 28 Mar 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177020; cv=none; b=S9Ik6bGXSp6frNE7twwKxkYGFU+YJwLu18ztbJZ9HdTZQ/YulUm9yzLMOE1H348g8Bp5/mSdO7A9jGxKC/FxyMO8ULEwpPW/fV2D05HFYwQJk2mpCs5CnDWw+RqsAZvSX1Zw5P3fULj1UFJbcDN79PZl7IR1ukJ3cSRSEB7HCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177020; c=relaxed/simple;
	bh=XpdgurEEM4pGK+nmglwdfRGJx7e9ro+vyFuyinGGwJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4XoLLnXtni5HhVHfwidIA7/GCQ5pPAcEtPT5/FAfo9NWwBOus02PTQv48Z5T58C8mzaeG16unMPKGCYnMf9F+GLRnXAe8X8VsYNsvhVVCcfwcr9qydBaRKSzlW8peMnqxoyT85d3cHM/bJNdPeHbQXcl/mQApvh3SbuH/7e/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/+W/YuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567E3C4CEE4;
	Fri, 28 Mar 2025 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743177015;
	bh=XpdgurEEM4pGK+nmglwdfRGJx7e9ro+vyFuyinGGwJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/+W/YuSDZSEKfr3TQLkBMnuic/Gx1VKjBmsiasBFVbA8EvKEXxt24hicmGH9DukJ
	 5O54wzgd91elXEKHbSDqEAU+IiA0cx6HjWKgflDkS45vveIsKbnp4m+4eHVpAVm8Tm
	 7ym3HIj/aU0ZIERlEIJt53fTjUm/vQ1Nf3TJv2gdkaSYPqlNouTcfxGj1ACXDBh2/w
	 PtvHKOYPBO8JD3lkxrcLGyuJMMywbAL+NW+fPu/SIuYInFrfRazQsf87Okkkhk77Ej
	 GdSCb+OgH6+E0Ihm1yvhGBrFqCuOu53yXWKT4Vo+ZD0et/sc+5c1w6y/y25TKibNtf
	 nyhMQt//M4miA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tyByO-000000000Hv-0XtU;
	Fri, 28 Mar 2025 16:50:20 +0100
Date: Fri, 28 Mar 2025 16:50:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot
 module
Message-ID: <Z-bFPDk3lziJkUmy@hovoldconsulting.com>
References: <20250328143646.27678-2-johan+linaro@kernel.org>
 <20250328151343.GA1505019@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328151343.GA1505019@bhelgaas>

On Fri, Mar 28, 2025 at 10:13:43AM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 28, 2025 at 03:36:43PM +0100, Johan Hovold wrote:
> > Commits b88cbaaa6fa1 ("PCI/pwrctrl: Rename pwrctl files to pwrctrl") and
> > 3f925cd62874 ("PCI/pwrctrl: Rename pwrctrl functions and structures")
> > renamed the "pwrctl" framework to "pwrctrl" for consistency reasons.
> > 
> > Rename also the Kconfig symbols so that they reflect the new name while
> > adding entries for the deprecated ones. The old symbols can be removed
> > once everything that depends on them has been updated.
> 
> I considered changing the Kconfig symbols at the time, but didn't do
> it because I didn't want to break existing .config files.  Is that not
> a concern?  Or do you think the long-term benefit is worth having
> users re-answer these config questions?

I added entries for the old (deprecated) symbol names that select the
new ones so that should not be a problem.

> If we do want this, I would think we should squash all these so we
> don't have breakage between this patch and the following ones.

The entries using the old names make sure that there is no breakage as
long as the patches are applied in order. They also handle any new
users being added to other subsystem trees.

(As I mentioned in the cover letter we can drop those entries after a
couple of releases.)

Johan


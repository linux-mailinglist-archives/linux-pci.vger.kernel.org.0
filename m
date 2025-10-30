Return-Path: <linux-pci+bounces-39835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E05C21532
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481714F178D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94292FABE0;
	Thu, 30 Oct 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNryWLKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35F2F12BE;
	Thu, 30 Oct 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843077; cv=none; b=nxGBF1lJiXFHIjIoiTsDRyOqRvt+Jh4wGB0SdNczrdjMZK6fOBYLpQAAha1YOLZPT5sqcqvJfxhQhpRaSytzuBSWM7CeTM6CntKfu3eFiS6y+zEDH/S+C6Gk2lli2vKt99PCDVj7/TidG/YmVBvonaiTFv9YPgnNFQTNoTyaR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843077; c=relaxed/simple;
	bh=DQaBE2lmVO34T+rV46bcSxqauqazkISdJ8/lQXgTotE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fZlpxkROxRJouyjujLSbfR7H+tIKPMM8/oZuvPQePwOuwVIkwBPjkFRr7TEP9D9K6Q/HZHxhFkDmsWIVyxNbn8GcNkB+Mz/2fSyAdl8Vni447vKf5bUfdMg0Lccn6RV9yXsL3ofxW6GzNvOY7sVKrXLGvv3ZAUGxpg9FBGLuzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNryWLKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DFC4CEF1;
	Thu, 30 Oct 2025 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761843077;
	bh=DQaBE2lmVO34T+rV46bcSxqauqazkISdJ8/lQXgTotE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aNryWLKKLebNl4fbavImqnkm6E508S58fXqC/6J66BFVqYkKYu7In0RTBu4Ju6oFP
	 IOaTKasX1yKI/dD87owf2NCp6P5RAObDJpabdHwphjgmJuRGcyE6E3vrnqSZ3webrG
	 02pzhBFqURYmEnTt3BIGL6HDA9/A9a6LdNI0Kx0xeEcMLFvD6Iem07ryh4n7GtfcOo
	 YOPytVc9qVyuSXsrQt9IhlJuRkDFf7I9DtY8h4OVBaonNr4dH1lUHUb6ebzaejKow6
	 vD8gCy/7i5TUwioO46DS0IyqmUYuaN7v1O0wbuSCJ5Ptxf6+kqipc1UXgpXbb2tgYP
	 anfcR5IGVvnEg==
Date: Thu, 30 Oct 2025 11:51:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, zhiwang@kernel.org, acourbot@nvidia.com,
	joelagnelf@nvidia.com, jhubbard@nvidia.com, markus.probst@posteo.de
Subject: Re: [PATCH v3 3/5] rust: pci: add a helper to query configuration
 space size
Message-ID: <20251030165115.GA1636169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030154842.450518-4-zhiw@nvidia.com>

On Thu, Oct 30, 2025 at 03:48:40PM +0000, Zhi Wang wrote:
> Expose a safe Rust wrapper for the `cfg_size` field of `struct pci_dev`,
> allowing drivers to query the size of a device's configuration space.
> 
> This is useful for code that needs to know whether the device supports
> extended configuration space (e.g. 256 vs 4096 bytes) when accessing PCI
> configuration registers and apply runtime checks.

What is the value of knowing the config space size, as opposed to just
having config space accessors return PCIBIOS_BAD_REGISTER_NUMBER or
similar when trying to read past the implemented size?

Apart from pci-sysfs and vfio, I don't really see any drivers that use
pdev->cfg_size today.


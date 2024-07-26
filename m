Return-Path: <linux-pci+bounces-10846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4293893D7BF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0309B212E0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45117CA10;
	Fri, 26 Jul 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIck7ywF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2C812;
	Fri, 26 Jul 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015685; cv=none; b=n19YK2RQ7c7/8qp6l1WPdUECm6lvovZekJ/7LAPZHqQT0E3xnE4nHQo3wvdOx7P6unP/pxNGiXzQGXWoTTwfYqKhqpWse1ToVkzH9v8tp+G+qcZH5AJSH1p4pL6PVOUTjuE5nL5/hnAAxPOn529B1yU0ce/f3aMp9Uw3YU+SoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015685; c=relaxed/simple;
	bh=sQbl7cK7/k5EIiUevC9DkFKZSDV3M0fNt1wPoC/OQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UxHNM07ukqTiA+652fzccVvSQlweD8k7N5a/HzNFizr+8aHr8LpVieZOsOKXQPiHvqGhZSepYPxSBgxudE2TwUqvavLnmRtAXS595bnOZDlpEzE7GYqAe1Xot6+fSZ61fXqyPr6qBUcuqAdXGe6eKKTcZrOjkrzSm+0zzV75O+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIck7ywF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB54C32782;
	Fri, 26 Jul 2024 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722015685;
	bh=sQbl7cK7/k5EIiUevC9DkFKZSDV3M0fNt1wPoC/OQqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OIck7ywF4QGtuxhdZF0gLpe6sxp+h5gDjKuIcFX9+g2wA5JKY7G4uqzO7jYxCP4Mp
	 hqbdDHfJscbBUUbGDtvxSCdFktOzf5Siuhzert5QkzhhtIwhWZZJnuTlrBKl5PTWvI
	 CtopMm7zhQoo2reZK4/NvnOvgOyXQw/j1j20dyh2QPrklQ7JDvtCsDeqRA1uvWoHBH
	 9szbsslj7wLYwgqiSUoiJKlSLXwUig2ht+1LMi3h93ajwrmqIOzZmhKuw9Ehg8gyik
	 zuLtzzTRqc/1rbmic20NSIBxp/aU6vM358bo9q/mJdWyykVxh3Dof9meRc+1DYtwIY
	 YVaQ27m+ZEP8w==
Date: Fri, 26 Jul 2024 12:41:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, fancer.lancer@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, conor.dooley@microchip.com,
	pankaj.dubey@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in DWC
Message-ID: <20240726174123.GA907125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625093813.112555-3-shradha.t@samsung.com>

Based on the files touched, this looks DWC-specific, so the subject
prefix should be "PCI: dwc: ", not the very generic "debugfs".
The "debugfs" part could go later, e.g.,

  PCI: dwc: Add RASDES debugfs support

On Tue, Jun 25, 2024 at 03:08:12PM +0530, Shradha Todi wrote:
> Add support to use the RASDES feature of DesignWare PCIe controller
> using debugfs entries.
> 
> RASDES is a vendor specific extended PCIe capability which reads the
> current hardware internal state of PCIe device. Following primary
> features are provided to userspace via debugfs:
> - Debug registers
> - Error injection
> - Statistical counters

This looks like great stuff, thanks a lot for implementing this!

I think this debugfs structure and functionality should be documented
somewhere like Documentation/ABI/testing/.  This functionality is
likely to be used by userspace tools like perf that will depend on
this ABI.  (Oh, sorry, I just saw Jonathan's similar comment, didn't
mean to duplicate it.)

I don't expect other vendors to implement exactly the same
functionality, but we can at least try to use similar structure if
they do.

> +config PCIE_DW_DEBUGFS
> +	bool "DWC PCIe debugfs entries"
> +	help
> +	  Enables debugfs entries for the DWC PCIe Controller.
> +	  These entries make use of the RAS features in the DW
> +	  controller to help in debug, error injection and statistical
> +	  counters

> +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +	int ras_cap;
> +	struct rasdes_info *dump_info;
> +	char dirname[DWC_DEBUGFS_MAX];
> +	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
> +	struct dentry *rasdes_event_counter, *rasdes_events;
> +	int i;
> +	struct rasdes_priv *priv_tmp;
> +
> +	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_RAS_DES_CAP);

Does this look at config space of a DWC Root Port, or is this in a
RCRB or similar?

Bjorn


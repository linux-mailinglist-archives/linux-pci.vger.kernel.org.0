Return-Path: <linux-pci+bounces-2901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7182844D57
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8306B21A3F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F63A8CB;
	Wed, 31 Jan 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqOJnZYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922B3A8C6
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744899; cv=none; b=b1dcFi88pkk1Q/wla9B2hJGOPZxc39NrVQyNvXZZK+hr0Ouq37IfC8mPL5p23Ndwse0tRABHfjKCaUlIEBVCoxhSKDRDSA/eXHLPibufQk/c6rqq/3SgWZihEVgVBFHdKe29jNzaQXGsGyBPwC9sNJJ56VG6pHiWcd+rjZ5OYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744899; c=relaxed/simple;
	bh=h8mOnODsTeFd2xdOHSVSoViTYIm1qVEA+f7PqD5HBHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sSsGjVgurh2l5FYif0Dm+Ii9paWYIY/h/T7xYraCRZkm3mk8O0Bn0fK9Elwz0M1KDs/eABYZAE/rSxBLqE45TZQAtVFTdOf7c9jmwdhmtEN6yxDKYDuIlC2mbwir/hv8v/wT2QSiiJQS7SVsu5rB90Dly6e0jNU6l0DyiywQMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqOJnZYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF5CC433C7;
	Wed, 31 Jan 2024 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706744898;
	bh=h8mOnODsTeFd2xdOHSVSoViTYIm1qVEA+f7PqD5HBHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GqOJnZYXMwy8I51XbtxFDz04yKjuQfnRl/aWHkncYiTmPiI0RJ85M5FwX9LoniZGq
	 09jmpeFO44cpT2g0xtIH2KDk3LR1iOS+92XeWeZlwHBcQN0HCMocxzfzl3UGnNYCxy
	 Ns/RbrtTUvl4qDjZz1kZ1b0dE5PjOBPUXfEr/lr9fbh0Ox3HP/G5vxksRh9L8/0wQf
	 ErKsc1YCj5+QGVIpgApudoVs/UKFZwIxqX01YfNrW1qgD/OhtVnBOtIO6t52wZni8d
	 QgL4c+BpmqhH37Uvj8Z4Ipglq0yR17SDSyfbo5pFDGR9yspOtTUphUp625BEU+HYsh
	 g/5N9Qj54c5kA==
Date: Wed, 31 Jan 2024 17:48:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240131234817.GA607976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119075219.GC2866@thinkpad>

On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > In dw_pcie_host_init() regardless of whether the link has been
> > started or not, the code waits for the link to come up. Even in
> > cases where start_link() is not defined the code ends up spinning
> > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > gets called during probe, this one second loop for each pcie
> > interface instance ends up extending the boot time.
> 
> Which platform you are working on? Is that upstreamed? You should mention the
> specific platform where you are observing the issue.
> 
> Right now, intel-gw and designware-plat are the only drivers not
> defining that callback. First one definitely needs a fixup and I do
> not know how the latter works.

What fixup do you have in mind for intel-gw?

It looks a little strange to me because it duplicates
dw_pcie_setup_rc() and dw_pcie_wait_for_link(): dw_pcie_host_init()
calls them first via pp->ops->init(), and then calls them a second
time directly:

  struct dw_pcie_host_ops intel_pcie_dw_ops = {
    .init = intel_pcie_rc_init
  }

  intel_pcie_probe
    pp->ops = &intel_pcie_dw_ops
    dw_pcie_host_init(pp)
      if (pp->ops->init)
	pp->ops->init
	  intel_pcie_rc_init
	    intel_pcie_host_setup
	      dw_pcie_setup_rc                        # <--
	      dw_pcie_wait_for_link                   # <--
      dw_pcie_setup_rc                                # <--
      dw_pcie_wait_for_link                           # <--

Is that what you're thinking?

Bjorn


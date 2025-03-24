Return-Path: <linux-pci+bounces-24542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5DCA6DFA2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C665188A6E3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB2263C6A;
	Mon, 24 Mar 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTbJDIRl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D917E8E2;
	Mon, 24 Mar 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833737; cv=none; b=o0+fk4y7gT0/QuyeBOLAukADIV/Gj3b3elGZiscaJEbRU2P/UPvHogHSwbACRv3lBtn7+MPxmtO17hb0kCwj/4ZkSNUZfJzU5ZWMiM0n/SnZ9LvmlAlZyDz1MqlI32sETXkOfaR2WpfMQ6SCOp1/z0VIDX1s5b88kVRyfpcd5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833737; c=relaxed/simple;
	bh=R0gPXHbvAqWNDd47lfOaYO5xK+3SNYLwqbTvSnvFKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EzXXvhkGRYTovcjb7g2VIijE0Jf/6FXDj7Ce3dBfOVzTsReI9/cth2KDcrNkvL3tD5TRI4g6Lxx2l7A+4HMg8XVVLwDBft47YxorGRTtRsmtev2YmWtxAAanhE8dXCblS9/WWKRO2Hyt+nZDL+HijlPnS84jecplJS3qGXmoDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTbJDIRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBBCC4CEDD;
	Mon, 24 Mar 2025 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833736;
	bh=R0gPXHbvAqWNDd47lfOaYO5xK+3SNYLwqbTvSnvFKjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RTbJDIRlLFromiiuyfl93KafQWjdzWw92XxE5XUaUNWceSjO/RluUvBLVMtWTc+GA
	 beWRnbhXOPRJ3pmL4f+PL+9uYP4gddWGm2EJA+7SX0CX/yzUsR3MypF00w3SMOD+a1
	 8MVYA/QWcja2KZqtOJXu3Zgk/zA+NW0E4aJhwxgTKRgIOOGxklDx5lYIASpQW8HPbz
	 mo3uIqqXE/+4vInGV44n5WW41E5MuPDtagqikgELNzV/EelHeXvwpJFDSLTsz6mHpQ
	 6G+XZePc0NDu7Y/DfBvrwfQbZFft9t5veL6whEibekQXs71vvGDFL47dNmwZK9BwsN
	 FiF5RQr6IKpIw==
Date: Mon, 24 Mar 2025 11:28:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Add sysfs support for exposing PTM context
Message-ID: <20250324162854.GA1251469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-pcie-ptm-v2-1-c7d8c3644b4a@linaro.org>

On Mon, Mar 24, 2025 at 03:34:35PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
> sec 6.22 allows precise coordination of timing information across multiple
> components in a PCIe hierarchy with independent local time clocks.
> 
> PCI core already supports enabling PTM in the root port and endpoint
> devices through PTM Extended Capability registers. But the PTM context
> supported by the PTM capable components such as Root Complex (RC) and
> Endpoint (EP) controllers were not exposed as of now.
> 
> Hence, add the sysfs support to expose the PTM context to userspace from
> both PCIe RC and EP controllers. Controller drivers are expected to call
> pcie_ptm_create_sysfs() to create the sysfs attributes for the PTM context
> and call pcie_ptm_destroy_sysfs() to destroy them. The drivers should also
> populate the relevant callbacks in the 'struct pcie_ptm_ops' structure
> based on the controller implementation.

Can we include some motivation here, e.g., what is the value of
exposing this information?  Is this for debugging or bringup purposes?
Can users or administrators use this for something?  Obviously they
can read and update some internal PTM state, but it would be nice to
know what that's good for.

It looks like this requires device-specific support, i.e., the context
itself, context update modes, access to the clock values, etc., is not
specified by the generic PCIe spec.  Consequently this probably can't
be done by generic drivers like ACPI, and maybe this is a candidate
for debugfs instead of sysfs.

The merge window is open now, so this will be v6.16 material, so no
hurry about updating before v6.15-rc1.

Bjorn


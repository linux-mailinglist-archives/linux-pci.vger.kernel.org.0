Return-Path: <linux-pci+bounces-22260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560CA42CFC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B53189256B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF918DF73;
	Mon, 24 Feb 2025 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm7y3ZVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320203DBB6;
	Mon, 24 Feb 2025 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426447; cv=none; b=qsNcLNlrlNGX4jbYwntDG61vuZ7cx+7hwo1MoW7usoTFNr0i1bO0aYNRpKp5i7LAosAFUsGz5xqkEIvRoFoyn9S91qxfmpXrk2nWNs9eBqV7tQOiq3JE2YZ3k9m5GtJQoipYcMSaWrE4GO/f4LiVNXCQJ5eN3VgZOKSaTFm2BWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426447; c=relaxed/simple;
	bh=8PPfPNIlrgycO/JJOciWBKiZKIJa1huNNTeyXSWPEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jFIuDtYcnigBMrumlpLM7JlqWVi3UBTH/Mi6mfJuYLqk5q8FZ6LdVwm0sntAMzqwhNJlajg0JK3fQRPWnV7zt+sW1t5S7szQmcEctHiXcUoS9byfwDUg5LhWevZe3MIlSyhLfE+Tav0y0L73Bcnn3C9kjrVRmEnymwesVHPEWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm7y3ZVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70351C4CED6;
	Mon, 24 Feb 2025 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426446;
	bh=8PPfPNIlrgycO/JJOciWBKiZKIJa1huNNTeyXSWPEkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rm7y3ZVXJmB2km9yUEhekLivuQWTkR4g+oJXvvtvZc7PfVLuPVtHC8kJemN55U0GY
	 M48YVPM7boR8Ho2suE++BS9qMY9A0giAcepAvErEaMtIBD7dOnmz7AfRzQMqM8iIcx
	 Mn1D7a/MC17q7i0q6h5Gwfex9j4YI0Wd1sNwgnpd9H+9aAKhN3OuMbPhf86bbQS9/j
	 /G2rX6j2PbUDyqzDqMf/R9zeRAaECbYf+dKa5lO8Prjm+tmx4BxJAgGd0Qzu8Sg7T1
	 i+RaJBFcSHaZxsygIsq7rvgyWnI/owpd0XqwXWQKVEVLh8BpMlpxK+JQmVO9HlGKrs
	 C/o/PvlwdmYDA==
Date: Mon, 24 Feb 2025 13:47:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <20250224194725.GA473475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fanm6m6fx6cqwalhdvrxmjzsluiyptbvrwbi5ufwbqmxsf62xl@lntprhkjv6tm>

On Sat, Feb 22, 2025 at 08:43:46AM +0800, Inochi Amaoto wrote:
> On Fri, Feb 21, 2025 at 05:49:58PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 21, 2025 at 09:37:56AM +0800, Inochi Amaoto wrote:
> > > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> > 
> > > @@ -341,6 +341,16 @@ config PCIE_ROCKCHIP_DW_EP
> > >  	  Enables support for the DesignWare PCIe controller in the
> > >  	  Rockchip SoC (except RK3399) to work in endpoint mode.
> > >  
> > > +config PCIE_SOPHGO_DW
> > > +	bool "SOPHGO DesignWare PCIe controller"
> > 
> > What's the canonical styling of "SOPHGO"?  I see "Sophgo" in the
> > subject line and in Chen Wang's SG2042 series.  Pick the official
> > styling and use it consistently.
> 
> This is my mistake. It should be "Sophgo", I will change it.
> 
> > Reorder this so the menuconfig menu items remain alphabetically
> > sorted.
> 
> I think this order is applied to the entry title in menuconfig,
> and is not the config key? If so, I will change it.

It's the title shown by menuconfig, i.e., "SOPHGO DesignWare PCIe
controller" here.


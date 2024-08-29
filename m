Return-Path: <linux-pci+bounces-12432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3F964510
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918C7289D37
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C531AC8AB;
	Thu, 29 Aug 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KScVkLgI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4ED1AAE06;
	Thu, 29 Aug 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935091; cv=none; b=rW7YXXcj3K+/1ohVWFnzkW6As5FxSjxQypvTYujVm9An505H73w2UszsukMj3kiEZUv+bs9pjDzw9X0TgCkv4go/VFRqGzOF3hvZPqnm2Y7kIKTc/Nc8aTbajWwOZaxTWzHofmg2vXNtpiOaKc9rW+vPsEICEcB8zN2Guj1QHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935091; c=relaxed/simple;
	bh=EP0ieTOayoDdZG/qTLxEmbaztKRTyEXZPutP4iINDFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p+CgF3xrFhxtlPH4tSF03RZlqBA3ulk6bLaJcedVscYQ9mFR4YEyGPrG2vpN63oETVg3uOnuMMVGuZm/del0hwO4mMoYACPcmOWvjO5UGJoXzCz1parfO9oe4janrF67gQWLpGq7X8NUdwauX9PvUJS5QbTGrAxsu9jB011qMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KScVkLgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2827FC4CEC1;
	Thu, 29 Aug 2024 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724935090;
	bh=EP0ieTOayoDdZG/qTLxEmbaztKRTyEXZPutP4iINDFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KScVkLgIC5WkAeYuwO8xRsAXxv/njc1++dyAfFyW/z9yPHGGvSvhMopoj5CrBSop/
	 Y81u47nlLJj/Pf9i9F4Bu36svaIuox7+xAZy6ly0zKaJW196u3eM5OMWNLlgVntLdI
	 JIzSdIYfAwpDb1dx+h/AnjIJtWYj3i3o48kpk+2Qw+xI6/DfqjcerqXf5fO7aTStmq
	 UJomr7xISDd3WIFKqwcnyxGcQsWbpVfm/ayc1k2o4PhKIjEIDvsZhkxotRwly11Ho3
	 kUzAg5R0+q9soyvSKnnx3YT5X07ctT9981+DzS5uTO1q41k0X/BYs+0pPKsin99C8Y
	 ajBoUzq6V6j4Q==
Date: Thu, 29 Aug 2024 07:38:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240829123808.GA56247@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829053720.gmblrai2hkd73el3@thinkpad>

On Thu, Aug 29, 2024 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 28, 2024 at 03:59:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 28, 2024 at 07:31:08PM +0530, Manivannan Sadhasivam wrote:
> > > qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> > > enables the controller resources like clocks, regulator, PHY. On one of the
> > > new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> > > on all of the supported Qcom endpoint SoCs, refclk comes from the host
> > > (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> > > whole SoC crash on the new SoC.
> > > 
> > > qcom_pcie_enable_resources() is already called by
> > > qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> > > available at that time.
> > > 
> > > Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> > > qcom_pcie_ep_probe() to prevent the crash.
> > > 
> > > Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > > 
> > > Changes in v2:
> > > 
> > > - Changed the patch description to mention the crash clearly as suggested by
> > >   Bjorn
> > 
> > Clearly mentioning the crash as rationale for the change is *part* of
> > what I was looking for.
> > 
> > The rest, just as important, is information about what sort of crash
> > this is, because I hope and suspect the crash is recoverable, and we
> > *should* recover from it because PERST# may occur at arbitrary times,
> > so trying to avoid it is never going to be reliable.
> 
> I did mention 'whole SoC crash' which typically means unrecoverable
> state as the SoC would crash (not just the driver). On Qcom SoCs,
> this will also lead the SoC to boot into EDL (Emergency Download)
> mode so that the users can collect dumps on the crash.

IIUC we're talking about an access to a PHY register, and the access
requires Refclk from the host.  I assume the SoC accesses the register
by doing an MMIO load.  If nothing responds, I assume the SoC would
take a machine check or similar because there's no data to complete
the load instruction.  So I assume again that the Linux on the SoC
doesn't know how to recover from such a machine check?  If that's the
scenario, is the machine check unrecoverable in principle, or is it
potentially recoverable but nobody has done the work to do it?  My
guess would be the latter, because the former would mean that it's
impossible to build a robust endpoint around this SoC.  But obviously
this is all complete speculation on my part.

Bjorn


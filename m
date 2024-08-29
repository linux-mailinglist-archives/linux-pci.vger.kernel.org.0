Return-Path: <linux-pci+bounces-12457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46460964C9C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022B0282566
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E651B5ED1;
	Thu, 29 Aug 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcH+wcIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB391B5EC7;
	Thu, 29 Aug 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951187; cv=none; b=Tj3Z3egxfe/nUU9wpNEsouNVnIPCJ1OnQeBZ3RpLdSwOqo+m8gzcpfhW2+JDUrthdBkE4SeHgOR0/BN26KJKqyelb9vHLIxvB9yyraTq9i3aDsOiHnOWbpBmnpGyjbAQjUJ16MbOdRjUudtNLvFsqh9V76KAg92xCWHn/FIURwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951187; c=relaxed/simple;
	bh=lj650uyHo6vu/bGwW3cMb2EVJ2dmy20z4HwiRrmZTpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mzjqipyx4lfYytSlZrWkRF/Ekzm5/wsFJqQyhEhy4L2rlAmSrvdut43P+V/gaTclBeaZQAWUdABuo/iL86tIdDxJY/jvKtY4Lgfr88bKnB4MWh6QvbGZhg/y1khH+xEbqSk+63lN8Mmf7TPKOTrvMWBCRTLujAdzE3N9FYNfotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcH+wcIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A07C4CEC1;
	Thu, 29 Aug 2024 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724951186;
	bh=lj650uyHo6vu/bGwW3cMb2EVJ2dmy20z4HwiRrmZTpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IcH+wcIeM47sQx9CH1WoGqeEMfoUeYPH2+tDfCozYasJXeeKjV0ZvFUkVWju/PCYq
	 xwbNcjjH/MxUmcQWXStqHVQ0WR6wlfJpdbhD96oGch3nmAuwkr9M8Qc6FZTmFcDhn6
	 g4h0EuFSGDmkmZ/v80oUNLbeB4VbP01eiH6S2xDYRkEQLFou5l91hwxXYosVx6DW2V
	 fayPgnlzWaJTBDhnc6lvZ3xALheuLUArB+SiE3n94MhyvVRdmn2xz5oU6ivO19mR5j
	 stElcgd/pu8fCxePcz43OUmWuZg6f+5wZnPWTiInI+/wU1hmKrrYu6C1EJqPpyJKaz
	 /WGFTWP0pBTrw==
Date: Thu, 29 Aug 2024 12:06:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240829170624.GA67120@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829164455.ts2j46dfxwp3pa2f@thinkpad>

On Thu, Aug 29, 2024 at 10:14:55PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 29, 2024 at 07:38:08AM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 29, 2024 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Aug 28, 2024 at 03:59:45PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 28, 2024 at 07:31:08PM +0530, Manivannan Sadhasivam wrote:
> > > > > qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> > > > > enables the controller resources like clocks, regulator, PHY. On one of the
> > > > > new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> > > > > on all of the supported Qcom endpoint SoCs, refclk comes from the host
> > > > > (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> > > > > whole SoC crash on the new SoC.
> > > > > 
> > > > > qcom_pcie_enable_resources() is already called by
> > > > > qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> > > > > available at that time.
> > > > > 
> > > > > Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> > > > > qcom_pcie_ep_probe() to prevent the crash.
> > > > > 
> > > > > Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> > > > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > > 
> > > > > Changes in v2:
> > > > > 
> > > > > - Changed the patch description to mention the crash clearly as suggested by
> > > > >   Bjorn
> > > > 
> > > > Clearly mentioning the crash as rationale for the change is *part* of
> > > > what I was looking for.
> > > > 
> > > > The rest, just as important, is information about what sort of crash
> > > > this is, because I hope and suspect the crash is recoverable, and we
> > > > *should* recover from it because PERST# may occur at arbitrary times,
> > > > so trying to avoid it is never going to be reliable.
> > > 
> > > I did mention 'whole SoC crash' which typically means unrecoverable
> > > state as the SoC would crash (not just the driver). On Qcom SoCs,
> > > this will also lead the SoC to boot into EDL (Emergency Download)
> > > mode so that the users can collect dumps on the crash.
> > 
> > IIUC we're talking about an access to a PHY register, and the access
> > requires Refclk from the host.  I assume the SoC accesses the register
> > by doing an MMIO load.  If nothing responds, I assume the SoC would
> > take a machine check or similar because there's no data to complete
> > the load instruction.  So I assume again that the Linux on the SoC
> > doesn't know how to recover from such a machine check?  If that's the
> > scenario, is the machine check unrecoverable in principle, or is it
> > potentially recoverable but nobody has done the work to do it?  My
> > guess would be the latter, because the former would mean that it's
> > impossible to build a robust endpoint around this SoC.  But obviously
> > this is all complete speculation on my part.
> 
> Atleast on Qcom SoCs, doing a MMIO read without enabling the
> resources would result in a NoC (Network On Chip) error, which then
> end up as an exception to the Trustzone and Trustzone will finally
> convert it to a SoC crash so that the users could take a crash dump
> and do the analysis on why the crash has happened.
> 
> I know that it may sound strange to developers coming from x86 world
> :)

It's only strange if the system design forces a crash for events that
happen in normal operation.  Sounds like part of the problem here is
the non-SRIS mode that depends on Refclk from the host.  That and the
fact that operating in non-SRIS mode has an unavoidable race where
PERST# from the host at the wrong time can crash the endpoint.

I think users of non-SRIS mode need to be aware of this issue, and
this patch to narrow the race window, but not close it completely, is
one good place to mention it.

> But this NoC error is something NVidia has also reported before, so
> I wouldn't assume that this is a Qcom specific issue but rather for
> SoCs depending on refclk from host.

Are there other drivers that need a similar band-aid?

> For building a robust endpoint, SoCs should generate refclk by
> themselves.
> 
> - Mani
> 
> -- மணிவண்ணன் சதாசிவம்


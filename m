Return-Path: <linux-pci+bounces-42469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39344C9B006
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 10:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 186B6347B07
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB330F553;
	Tue,  2 Dec 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYE3zYYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566D30C343;
	Tue,  2 Dec 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669203; cv=none; b=DICZ8jWZRRa/LcwYO8eHTH+/opf6ni+Lt5ddEoyWnJjkQaiALlJDwfGBpNMlEU6oz3y9jAdO1YgWuckJPIDhVH+SzuPljJuElFqQdR3LVk1E+rT8gPB288iFgLQ1esRTzmro1LOZx3ymMAV62PNzxAaDD1Ei4j7l/EyDVmY5Z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669203; c=relaxed/simple;
	bh=/AhUc5pNDMIB+MxG8tAbE5vEZvLdVKtKwk2LjUvq2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVfX99j6ulsPi/ykQ8LUdS3wjSobDRkp7EjXZYCOxlQzKSHtrVMBA//xFgeOxQ2Nkp+rKxRq3D9I8aXTTnrdXm+NoyL3BwG7fEUVY1F4B/P1CqlL6WD9bQK5D11CLieU+pXN5/LZFolWdoxjdNYqpLk8gnW8fr7TVpaCpMo6LvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYE3zYYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95D4C4CEF1;
	Tue,  2 Dec 2025 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764669203;
	bh=/AhUc5pNDMIB+MxG8tAbE5vEZvLdVKtKwk2LjUvq2j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYE3zYYo5Vf0etfLhw7gf+HgO4jDdia94Of7xcMn3TvSPUR5Xn0P9uVqMwBZjY3O+
	 vOcLfblHAfxA4wsR205oEiC/MYd6Tgmoq2FwAFb26Ky1prZedcELZIuV0j6GyZWz3U
	 s4+vlqBGevYEfKCVMhSzYggbwm/bdM2PjJYu9tGjH/6g+lVLMl5iXG8206RkTLeh1L
	 Gv/CZ17AmVfLwFGmpamjbiFBqn+ezSkCLiIByjsovx/zd3m9+/pTGyVDE/ZoGG6/L0
	 PX2mA7ZthsKOu8/grMPOrRA1WMYrrGgeWCFUWRtBQ5cOEoLDSy3srOH0govZhVMNYB
	 h/mETuUTem8eg==
Date: Tue, 2 Dec 2025 15:23:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
Message-ID: <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
References: <20251128162928.36eec2d6@canb.auug.org.au>
 <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
 <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>

On Tue, Dec 02, 2025 at 09:54:24AM +0100, Vincent Guittot wrote:
> On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > + Vincent
> 
> Thanks for looping me in.
> >
> > On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> > >
> > >
> > > On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Changes since 20251127:
> > > >
> > >
> > > on i386 (allmodconfig):
> > >
> > > WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)
> 
> Are there details to reproduce the warning ? I don't have such warning
> when compiling allmodconfig locally
> 
> s32 pcie can only be built in but I may have to use
> builtin_platform_driver_probe() instead of builtin_platform_driver()
> 

The is due to calling a function belonging to the __init section from non-init
function. Ideally, functions prefixed with __init like memblock_start_of_DRAM()
should be called from the module init functions.

One way to fix would be to call memblock_start_of_DRAM() in probe(), and
annotate probe() with __init. Since there is no remove, you could use
builtin_platform_driver_probe().

This also makes me wonder if we really should be using memblock_start_of_DRAM()
in the driver. I know that this was suggested to you during reviews, but I would
prefer to avoid it, especially due to this being the __init function.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


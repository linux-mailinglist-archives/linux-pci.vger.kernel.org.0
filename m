Return-Path: <linux-pci+bounces-42171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B8C8C254
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E39B357492
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EAC2F7AA9;
	Wed, 26 Nov 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YshyvfpK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811212E54BD;
	Wed, 26 Nov 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194683; cv=none; b=eKpHMtzP0OTpnFrToge57gUBONtjlmdpGWu8FRTBKrBWHT5Y5YYH9q44fYLxpvOz38329SiUEvM3TMKNroZvNJhLPSVmQoR1qdx6H5ZgHyrn0bmQV2PJG8SPN6pOo4WSZdzAHdS4t98nlJW1xqX5rZsqrUJxMj+xitwfTGKXV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194683; c=relaxed/simple;
	bh=7MXVz5XbnQiJ9KSKfpDXjWyTcuClQu3/RSwbYgSfr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wic5RlaZ0HsHvUsIF0Z5JBnAd7+5EmlTn03+ooCV40PyFN8FZm8lbvb+4cGXbwni0r+bSi8XiZFdF3EXfvCcnu+VcgeLVM0lz1+fcDBFm5SR6j/RvLGNUG2v13Gjll00AnId+grtWKyowLa2Tfkm02BXyDRlqLGq5uWdCkPSDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YshyvfpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E346FC4CEF7;
	Wed, 26 Nov 2025 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764194683;
	bh=7MXVz5XbnQiJ9KSKfpDXjWyTcuClQu3/RSwbYgSfr2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YshyvfpKSMWr2sZ8GR9EoUjTGOc5cNdU0AmRwfbctAyMDgvRjFT65a9zm0aECjeNj
	 N/ZOOPXmGCQO+LMVUR5uhMspQAWJnJvNlDFQwPj05tttTk8CxdLuUKup7Ihs2srvE/
	 nZi+oScmbNJxwaA6ymd1QkR/T3lJWKGHoM88Fz7ZbGLZ2lE9rKEXRhbYLgn5JajrrO
	 EidPsBzyNhf4FfEDBhWemk0u+sgAUQuCOXzmMll/HSUS59ctKOzjjHavYcV+1uT7JG
	 IerTyE7fOyL8mWO2Cnj39DAa8Nrhx+9YAe52JnpsjwQSt8bZafwxXOPpef7BGkXIEe
	 RzQvxVhda2s3Q==
Date: Wed, 26 Nov 2025 16:04:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Message-ID: <20251126220441.GA2853437@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8170513-e08a-46ff-9fb2-310f3e9c1ba4@oss.nxp.com>

On Wed, Nov 26, 2025 at 03:47:46PM -0600, Ciprian Marian Costea wrote:
> On 11/26/2025 3:41 PM, Bjorn Helgaas wrote:
> > [+cc Ciprian @oss.nxp.com, see email addr question below]
> > 
> > On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
> > > Add a new entry for S32G PCIe driver.
> > > 
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >   MAINTAINERS | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e64b94e6b5a9..bec5d5792a5f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
> > >   F:	drivers/pinctrl/nxp/
> > >   F:	drivers/rtc/rtc-s32g.c
> > > +ARM/NXP S32G PCIE CONTROLLER DRIVER
> > > +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> > 
> > I'd be happy to change to
> > Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > per https://lore.kernel.org/r/f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com
> > 
> > I notice that most nxp.com addresses in MAINTAINERS use "@nxp.com"
> > addresses, not "@oss.nxp.com".
> > 
> > Let me know your preference.
> > 
> > Bjorn
> 
> Hello Bjorn,
> 
> I prefer "@oss.nxp.com".

Done, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=c7533471578e


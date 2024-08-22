Return-Path: <linux-pci+bounces-11983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FD95AF32
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA67287742
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C617E473;
	Thu, 22 Aug 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8diliVK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AC16D4EF;
	Thu, 22 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311229; cv=none; b=JuozqwAludBFVXcSGS+DUHKurxD99gTARDiISuKgF8vRIeV50+UM+R8AGXTWx2TSbwYHhuJr3yOlJqJoq7o9FjING6B8K8HyiYigbTrIAD87hEoTpzSUiW0wxmkdbVP1AC4VltzFEdyduzmRu0cBuEcRuSuOtbjcXaZ0sB/h1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311229; c=relaxed/simple;
	bh=ZOF0WR1Gj3nT85Z5d4gkd1GJQUYFz/eHTeRA23t5mn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frNzFO071WNYeIy6xNCMtOQJOHIh9zyENmSiMaQOjZec/3r6KQ+qQxfIACoJyM0wWmkD5JmQyw1xa2fY5vazUvzrtAncRuiQVOSATNYryltZed686bZgNyngvOlcpvD49p7WNq5RZ44Oo5ltbWdDhldBrjMGavNVyw8VZYlOkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8diliVK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so814725a12.2;
        Thu, 22 Aug 2024 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724311225; x=1724916025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZJLE47NxLo6eiTCM83oiOz2FzGL7nsxAHhhkcrrTiE=;
        b=R8diliVKYAGlgq7fGrrDi+wtUyzL49fh2pxv92fw0acEoDHbCNKloFSmFwVji5UbFD
         V51jfdWVmnn7NKvPgBjYdC+9d57rdinWOMs8RgYXCEruH/yn70HTWXoNB0TEOyVozalu
         WsB3mVyS66NSjZdCcVI+ZE+EJyY05441RvjgyhLPX0C6qRVB8xna+VV5lL9DbV4d04FF
         z4NWRT31A1AU3mnOeWtE6UYIkM43IpjIgtxxawu7DMbfPTTaotP+s4AZ66hNYRLSnySg
         nLoNX5UztFsophbcQcyvvgaVeMhdM4ZZsaFdBpMD8SrC1sehn8cpengrQsh4rIT5/q/r
         cYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311225; x=1724916025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZJLE47NxLo6eiTCM83oiOz2FzGL7nsxAHhhkcrrTiE=;
        b=wSPFXCiAftKZLeruTE9YFZtqsTzAIIbzL2upIaRcshRWzOUweWCWrK3y6HQxyFa75L
         QrfUzFfFLyctBcI0m/kKDXsd3JbWl24hokElAZb3ML4YLPcvr63Cl5wGsxcKWbEkEX5p
         wvtU/ANx16KClw8l/dAqPAwtSkbXJlI9+0H8vS3CnGJcJVeVUeLm40KUaEfKxyA/gvqL
         nYt+dueaWm0qUAQfEGW8UnMZCBvfDLGWm7X5ARKnX/w91j6kqLp5tShoEAeeV9t4LQuq
         6gegWohN2N5C5HcOBH8spxMNcbKX8zyOIBnDjXH3FiaJpTTE1FTFhdrRt9fw0ScX4YC7
         QU+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFn7O58xi+a3RTgHTnmPxcRmAL/d4GI7FWpynsuT+uawab3ccaVG1sn6nRRiq39GlKdNhqnbAsnf14@vger.kernel.org, AJvYcCVQkX4wP0p+xuYA9Bqhnirz7xFYcuXroqHlkd3Js91RtuyS2pMl9xhFkI4nNAuWpGSZ08g54bNfYXPJ06M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTphznkjMBd3s4fsqtyzUFF/tiWIpm1QsmI6BTpFsyJo6LKOkI
	aIYU8YUqO0qmzTmm3nQgNR+Nyj4295W00vftz6OLDkDVxZY+rvVj
X-Google-Smtp-Source: AGHT+IGxy+zKNyZnjMAmFsnzCP6StW+jFRGcpYePiTJJdxdrkAiZFUr29/nyIwkAIZWWVtSNyOXfvg==
X-Received: by 2002:a05:6402:3713:b0:5a0:c6bc:9f5a with SMTP id 4fb4d7f45d1cf-5bf1f284c4bmr2262367a12.38.1724311225164;
        Thu, 22 Aug 2024 00:20:25 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:daa9:644d:3c2:44bb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc0e6sm530789a12.19.2024.08.22.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:20:24 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:20:23 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: imx6: reset link after suspend/resume
Message-ID: <Zsbmt1Q-CpsO4gp9@eichest-laptop>
References: <20240819090428.17349-1-eichest@gmail.com>
 <ZsNXDq/kidZdyhvD@lizhi-Precision-Tower-5810>
 <ZsQ9OWdCS5o96VN2@eichest-laptop>
 <ZsYKjFXHDVr8tz9K@eichest-laptop>
 <ZsYbAMR72/TsnxoA@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYbAMR72/TsnxoA@lizhi-Precision-Tower-5810>

On Wed, Aug 21, 2024 at 12:51:12PM -0400, Frank Li wrote:
> On Wed, Aug 21, 2024 at 05:41:00PM +0200, Stefan Eichenberger wrote:
> > Hi Frank,
> >
> > On Tue, Aug 20, 2024 at 08:52:41AM +0200, Stefan Eichenberger wrote:
> > > On Mon, Aug 19, 2024 at 10:30:38AM -0400, Frank Li wrote:
> > > > On Mon, Aug 19, 2024 at 11:03:16AM +0200, Stefan Eichenberger wrote:
> > > > > On the i.MX6Quad (not QuadPlus), the PCIe link does not work after a
> > > > > suspend/resume cycle. Worse, the PCIe memory mapped I/O isn't accessible
> > > > > at all, so the system freezes when a PCIe driver tries to access its I/O
> > > > > space. The only way to get resume working again is to reset the PCIe
> > > > > link, similar to what is done on devices that support suspend/resume.
> > > > > Through trial and error, we found that something about the PCIe
> > > > > reference clock does not work as expected after a resume. We could not
> > > > > figure out if it is disabled (even though the registers still say it is
> > > > > enabled), or if it is somehow unstable or has some hiccups. With the
> > > > > workaround introduced in this patch series, we were able to fully resume
> > > > > a Compex WLE900VX (ath10k) miniPCIe Wifi module and an Intel AX200 M.2
> > > > > Wifi module. If there is a better way or other ideas on how to fix this
> > > > > problem, please let us know. We are aware that resetting the link should
> > > > > not be necessary, but we could not find a better solution. More
> > > > > interestingly, even the SoCs that support suspend/resume according to
> > > > > the i.MX erratas seem to reset the link on resume in
> > > > > imx6_pcie_host_init, so we hope this might be a valid workaround.
> > > > >
> > > > > Stefan Eichenberger (3):
> > > > >   PCI: imx6: Add a function to deassert the reset gpio
> > > > >   PCI: imx6: move the wait for clock stabilization to enable ref clk
> > > > >   PCI: imx6: reset link on resume
> > > >
> > > > Thanks you for your patch, but it may have conflict with
> > > > https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#t
> > > >
> > >
> > > Thanks a lot for the hint. I will have a look at the series and see if I
> > > can adapt my changes including your suggestions.
> >
> > I did some more tests with your series applied. Everything works as
> > expected on an i.MX8M Plus. However, the i.MX6Quad PCIe link still does
> > not work after a resume. I could trace the issues back to the following
> > functions, besides that we could use the same suspend/resume function as
> > for the other i.MX SoCs.
> 
> Upstream 6q pci don't support suspend/resume.
> 
>  [IMX6Q] = {
>                 .variant = IMX6Q,
>                 .flags = IMX_PCIE_FLAG_IMX_PHY |
>                          IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
> 
> If you add some code, can you post your patch(mark as RFC) then let me to
> check.

Sure, I will wait until your series is merged and then try to come up
with an RFC for suspend/resume on i.MX6Quad. Maybe we could use the same
mechanism as for the downstream kernel where they just toggle the
IMX6Q_GPR1_PCIE_TEST_PD bit?
https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995


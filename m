Return-Path: <linux-pci+bounces-11982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17A95ADF7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331C42848D9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF214B964;
	Thu, 22 Aug 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qb561h/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76A14A600
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309311; cv=none; b=luBfTAGjjqVIgok9bs18VJWfm4HGF8YRAHRAkFZA2vTkWk/s3kIuaJSQDMgTr5Nl2TUhHOFcnTOd5sHXo9QNYh6sOgyfAVcSQK8P7SJAcl+LEYEFqZeRRvTzcX9d3gfhXnaZrXAHC2CdJpDNEA8o7XubuFcELd3vXJ0BodhWZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309311; c=relaxed/simple;
	bh=Q3RaQTthFLGzHxCrgTbtz1ZJXYee5PwCPBPzsgT+2J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ollhPr/ITy5fC7V/r/I+nePcMfRRluXAUFLMhodZOF5H4OnHjj1YWBMkk59mL9TtxxYpz22q2qZFHBNM793Xe/5yY1Vt2AkL3k1dcWTzRMohUar1s/MgQ/gAa64I4Wfj6k8/AlKhP3Xt3C6xtDxA2r7DEEDnzK9JKMk70sXLAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qb561h/t; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so323979a91.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724309309; x=1724914109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cTrGbpd4HSUevNKGqvJ3V68XZ6nrr6FN6bBsJQjjtE=;
        b=qb561h/tL0IrzYyO4WTwgpCS7NykRgEdmN7pZB/8IXba1hKPm0ttWrHUpvXteSxpaB
         NC7GwEOgxz0TbV6figKcNLUvk9LS1hpOSeV0IwMez8ydHeJgiOWeugFDw+yI3wzbp8QE
         91XVfuqh0zeK7EqS87ohofwlDMZuVZyIQNGRuay4dm0v6Dur5omC059AcqM8fAmCfXk7
         B2UV+Bkvo5kiJ2v1v3vwDMwXGccxT1VMsyHmn7uaaiUXoyqCcPntc23ak2kk28QttkWk
         38iEnzRwm04cRSpWtk77HKM08SkutAR7pGsNrCPj2dkdz3RzjWr/Jb5Y5/KvKioFMR8v
         wZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309309; x=1724914109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cTrGbpd4HSUevNKGqvJ3V68XZ6nrr6FN6bBsJQjjtE=;
        b=noqjZ+kBtgDL3OjgIyyAWG2rrEyoutdoYEQmW9vGSLpVcdk2F6UIwYCtvmQ2gGBPty
         J6WBMyomSpxA0GKa8yKCHmLes03BfrqZUSaS5+XU7IXupra4j4tXQ5Rjm61Q7u7PFaSR
         qdJV5QuecxvWMlEUhF+DoI1gZBmEixPgWtmCB0cqmNnY5VdEZf7mVw7FlJ+PCYSBIhSW
         DWQLHSjSb0coN4uUwxmBLBsivkd2XS1NZbRF1/Wu/8lYh16XPCqd1OKU9RAapDVjA7TE
         qfliHUTplIgYywEj679jYuYKiGTPDRK4bsgX+BLnfGk3MIXkUWWcwKqqnN9E9voLqUXp
         4g9g==
X-Forwarded-Encrypted: i=1; AJvYcCUxWQdAEUfcm4aN8sRxbnZLPAdp+oybuvBV6eOxkrEZ06I3sns+APPp6NDSjCY7hOuOXJvIgap4Zt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtT4SQm3Xdu6CECEYYEokbH0zXL6uNY8/KZ2hR/uJLo1kG6lw
	nVgXUjMg4YyuqCosGaIjC7CTApychWj0VMBkXCnBy4qtzOJkaDZ8d2wTqo4jKQ==
X-Google-Smtp-Source: AGHT+IGzpHEk+tReHF5mUVed8OkxXUvu8WNzbGV/GptH5xMS7EQ5B+lFYWNn8tj8JipsQgSzgi461A==
X-Received: by 2002:a17:90b:1b48:b0:2c9:8c34:9754 with SMTP id 98e67ed59e1d1-2d5e9a66838mr4991548a91.21.1724309309452;
        Wed, 21 Aug 2024 23:48:29 -0700 (PDT)
Received: from thinkpad ([117.213.99.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba239f9sm3171237a91.28.2024.08.21.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:48:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:18:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240822064823.x26bjqev6ye32v5j@thinkpad>
References: <20240813202547.GC1922056@rocinante>
 <20240821225618.GA270826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821225618.GA270826@bhelgaas>

On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 14, 2024 at 05:25:47AM +0900, Krzysztof Wilczyński wrote:
> > > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > > for drivers requiring refclk from host"), all the hardware register access
> > > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > > from host.
> > > 
> > > So there is no need to enable the endpoint resources (like clk, regulators,
> > > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > > doing DBI access, which is not done now.
> > > 
> > > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > > EP controller in the case of failure.
> > 
> > Applied to controller/qcom, thank you!
> > 
> > [1/1] PCI: qcom-ep: Do not enable resources during probe()
> >       https://git.kernel.org/pci/pci/c/cd0b3e13ec30
> 
> I think we do need this, but I dropped it for now pending a commit log
> that says "we're fixing a crash" and explains how.
> 
> The current log says "869bc5253406 moved hardware register access like
> DBI to dw_pcie_ep_init_registers()", but 869bc5253406 actually moved a
> bunch of register accesses from dw_pcie_ep_init() to
> dw_pcie_ep_init_complete(), and a subsequent patch renamed
> dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers().  I did
> eventually figure out the rename, but it took a while to make that
> leap.
> 

Ah, sorry about that. I somehow managed to merge those two commits in my mind.

> It also says dw_pcie_ep_init_registers() is called only from
> qcom_pcie_perst_deassert(), but obviously all drivers call it.  I
> think what you meant is that on qcom and tegra194,

Yeah, the context is only applicable to the respective SoCs.

> dw_pcie_ep_init_registers() isn't called from .probe(); it's called
> later because they require refclk to access the registers, so qcom and
> tegra194 call it after PERST# is deasserted, because then refclk is
> available.
> 
> Trying to understand the 869bc5253406 reference: I guess the
> point is that the dw_pcie_ep_init_registers() work depends on
> qcom_pcie_enable_resources(), and before 869bc5253406, that work was
> done by qcom_pcie_ep_probe() calling dw_pcie_ep_init(), so it had to
> call qcom_pcie_enable_resources() first.
> 
> But after 869bc5253406, dw_pcie_ep_init_registers() is done in
> qcom_pcie_perst_deassert(), which already calls
> qcom_pcie_enable_resources().  So qcom_pcie_ep_probe() no longer needs
> to call qcom_pcie_enable_resources().
> 

Right.

> As far as the *crash*, phy_power_on() has been called from
> qcom_pcie_ep_probe() since the very beginning in f55fee56a631 ("PCI:
> qcom-ep: Add Qualcomm PCIe Endpoint controller driver").  But
> apparently on some new platforms phy_power_on() depends on refclk and
> (I assume) it causes a crash when done from qcom_pcie_ep_probe().
> 

Yeah. The actual intention of the patch was to get rid of the
qcom_pcie_enable_resources() from probe() as it is now not needed. But later
Dmitry pointed out that qcom_pcie_enable_resources() is also causing a crash on
his platform because phy_power_on() depends on refclk from host. So he had to
manually boot the host first and then endpoint to avoid the crash (without this
patch).

Then I thought that this is an RC candidate as it fixes a hard crash and asked
to merge the patch ammending the commit message with Dmitry's info.

But now I understood that I should've reworded the commit message to make it
look like an RC material.

> So I would think the commit log should look something like this:
> 
>   PCI: qcom-ep: Postpone PHY power-on until refclk available
> 
>   qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and
>   powers on PHYs.  On new platforms like X, Y, Z, this depends on
>   refclk from the RC, which may not be available at the time of
>   qcom_pcie_ep_probe(), so this causes a crash in the qcom-ep driver.
> 
>   qcom_pcie_enable_resources() is already called by
>   qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
>   available at that time.
> 
>   Remove the unnecessary call from qcom_pcie_ep_probe() to prevent the
>   crash on X, Y, Z.
> 

Looks good to me. I'll post v2 incorporating this.

> Although I do have the question of what happens if the RC deasserts
> PERST# before qcom-ep is loaded.  We probably don't execute
> qcom_pcie_perst_deassert() in that case, so how does the init happen?
> 

PERST# is a level trigger signal. So even if the host has asserted it before EP
booted, the level will stay low and ep will detect it while booting.

If it is an edge trigger signal, then ep wouldn't be able to catch it as you
suspected.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


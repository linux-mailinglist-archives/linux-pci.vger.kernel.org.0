Return-Path: <linux-pci+bounces-12454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA2C964BE8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B40B244E5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25C1B5ED3;
	Thu, 29 Aug 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9Ny6i14"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BE1B583E
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949906; cv=none; b=m7RkrvBQaGXPszn/36SiinbDKW7QrVRQx5mpdrVcguNWpOMQoR9ahoGhb2oowl9Iunk0khkLzrif2F+mxAaZUdlLuLCOId3gD4njmptCNfZLcQ5gfMlm7ouyYsA7nmxgTtfDIHVFydq2nPrzAnQnBWauK7+1rJF1Y+S+SNR/K5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949906; c=relaxed/simple;
	bh=dGeqRNL0k3U8r1FrAdMByEIRpBqjUiADntTeyo3O/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpzRsaahNlARqb1OvbSeeNn0zDR2OYa0cze9+i3XFSF3LsjM/T8IE1ehl0PhKjzprwdfriOfBqxmwg9Xij5IyNN+FdkzwUe/lOp2EsculgMNK8dZl6noK84CmLV4gqOexrsoy9JqK7iOcBSzAnjlWiKa5DM16TEDsi6AQJCXE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9Ny6i14; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71431524f33so684414b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724949904; x=1725554704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgFyhyb1uCXggxvp1V3dzxUi9b48dUBBRni4XLoofMY=;
        b=X9Ny6i14XwJOBiLYDxqUfKgu0lfFEZEUAxILPgPSI64ddQVFe5VCQgHneUc8MNxe7g
         MAxjmTuEAD07zKlkpGcRJMgTJY5PgenG4nSUJOk9h+ZX1jA/wp3b38nt1zrAPMVSLANm
         BwohNZKQaMuTTlY4AtlECp0dMENVwsFyu/Pyv7CNtolu8c3O97DrCMMReDbxKnhCC3RC
         +RDyctSYisJHAvsbFlQzPPN6bELtDQSYzPlP+vTCOJRAVlRD+EaTz7ko6rfqgRG8QWzO
         CBLdpvWLMTuWlTAMKUYonA3r4AlD1d3mn5X1gOT2g95aHadjJMRxFBOsyvRZordFUafp
         j08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724949904; x=1725554704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgFyhyb1uCXggxvp1V3dzxUi9b48dUBBRni4XLoofMY=;
        b=EHqOEJVxu4k4ykP2WSxAk5d2Nw+RW1MQPQfL4pRcqoiFvh/vPdoIGQtcp79iCIOeV8
         X18AXZyGSkg6exca1d9awu+C/RjkWxk8iG6DnLQoUqYkypryEneWCdWfIJUOoIhXlYB9
         N05KMW/ytbEvAzEIEeO0E9He0RieasHo0Y3oSFyV/PAVHYoNHvPqplyokf7cfT+Piy6i
         Bjt3VL6m2Kk2i6Rha0trD8OG0Dk7A4fweLvKVxFw5EZnH1C4ahnX0bFPRPh96zELpaV7
         pQazutzRIqMnA8BN0Nvyq7pdOAquRIOcd9X6MD/vBLPjx5mn4P21YmOJE3IS++BQUCfZ
         1Zmg==
X-Forwarded-Encrypted: i=1; AJvYcCXIvNUDHVxK24ZExTcrArZXi40SFT1LeXGbxQeemYacg2455yR4Yq0zz88ka5aN0VsUtRWu5F16Pmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhresAtdsswUi0CGPQX6MwoALiiIUGL2L/Uf+xXAL3KYz1mOWh
	MTEErNRqYw0nwo+xxDjznTeQ6k18nWq0LQQ5nNIUF/bSCUI+4Tg6j6gATGs/S7G6AsBLDJLWFlY
	=
X-Google-Smtp-Source: AGHT+IF+STfTZn8+OCUAmOtpGVosHxp16FTi1c3m1cVFQLchpyX4nrTzvfScbQwBAr1n+NG6sH0CPA==
X-Received: by 2002:a05:6a00:a01:b0:70d:3420:9309 with SMTP id d2e1a72fcca58-715dfbc885amr4708301b3a.17.1724949904214;
        Thu, 29 Aug 2024 09:45:04 -0700 (PDT)
Received: from thinkpad ([117.213.99.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be18esm1448578a12.73.2024.08.29.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:45:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:14:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom-ep: Enable controller resources like PHY
 only after refclk is available
Message-ID: <20240829164455.ts2j46dfxwp3pa2f@thinkpad>
References: <20240829053720.gmblrai2hkd73el3@thinkpad>
 <20240829123808.GA56247@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829123808.GA56247@bhelgaas>

On Thu, Aug 29, 2024 at 07:38:08AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 29, 2024 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Aug 28, 2024 at 03:59:45PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 28, 2024 at 07:31:08PM +0530, Manivannan Sadhasivam wrote:
> > > > qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and it
> > > > enables the controller resources like clocks, regulator, PHY. On one of the
> > > > new unreleased Qcom SoC, PHY enablement depends on the active refclk. And
> > > > on all of the supported Qcom endpoint SoCs, refclk comes from the host
> > > > (RC). So calling qcom_pcie_enable_resources() without refclk causes the
> > > > whole SoC crash on the new SoC.
> > > > 
> > > > qcom_pcie_enable_resources() is already called by
> > > > qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
> > > > available at that time.
> > > > 
> > > > Hence, remove the unnecessary call to qcom_pcie_enable_resources() from
> > > > qcom_pcie_ep_probe() to prevent the crash.
> > > > 
> > > > Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> > > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > > 
> > > > - Changed the patch description to mention the crash clearly as suggested by
> > > >   Bjorn
> > > 
> > > Clearly mentioning the crash as rationale for the change is *part* of
> > > what I was looking for.
> > > 
> > > The rest, just as important, is information about what sort of crash
> > > this is, because I hope and suspect the crash is recoverable, and we
> > > *should* recover from it because PERST# may occur at arbitrary times,
> > > so trying to avoid it is never going to be reliable.
> > 
> > I did mention 'whole SoC crash' which typically means unrecoverable
> > state as the SoC would crash (not just the driver). On Qcom SoCs,
> > this will also lead the SoC to boot into EDL (Emergency Download)
> > mode so that the users can collect dumps on the crash.
> 
> IIUC we're talking about an access to a PHY register, and the access
> requires Refclk from the host.  I assume the SoC accesses the register
> by doing an MMIO load.  If nothing responds, I assume the SoC would
> take a machine check or similar because there's no data to complete
> the load instruction.  So I assume again that the Linux on the SoC
> doesn't know how to recover from such a machine check?  If that's the
> scenario, is the machine check unrecoverable in principle, or is it
> potentially recoverable but nobody has done the work to do it?  My
> guess would be the latter, because the former would mean that it's
> impossible to build a robust endpoint around this SoC.  But obviously
> this is all complete speculation on my part.
> 

Atleast on Qcom SoCs, doing a MMIO read without enabling the resources would
result in a NoC (Network On Chip) error, which then end up as an exception to
the Trustzone and Trustzone will finally convert it to a SoC crash so that the
users could take a crash dump and do the analysis on why the crash has happened.

I know that it may sound strange to developers coming from x86 world :)

But this NoC error is something NVidia has also reported before, so I wouldn't
assume that this is a Qcom specific issue but rather for SoCs depending on
refclk from host.

For building a robust endpoint, SoCs should generate refclk by themselves.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


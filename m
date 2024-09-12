Return-Path: <linux-pci+bounces-13128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14284976F7B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2281F242CE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDF1BCA18;
	Thu, 12 Sep 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWufL7ea"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1615098A
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161946; cv=none; b=ETgfiqoQicfWZTaUU7UrdXms0ra+BaaLNx79FlFdT5BgeZw4lVJXqS+4aI1reMxgVraKlZiJNITUO+uAaYYnWVZdIbzZO5tMhGpDUI3vs3kvLxY1yuvbiHLPcKKdyMcXOUbpgnN8/emPMLhYBdAEX0I6pDoO3p8INX98TfGpOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161946; c=relaxed/simple;
	bh=KyL6uEhWeHWlYJtYe1QAQefl8kW3wICTzGTQbXr7t2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0x5CZ8B6XZJfAh047vFi/LOyw7Ch6qDw1nxNWmi+do9uMJk0LiQcLceEmzdEAEUcjiMbMD5zKwTVpuMfH0rqBgnEOwZ85UBDm9VT+W7xf6snXi/pLctQ7KCTP5aRCW2rsbLF2/PwJzJ6PBVgu7F4Nj/Nx0494JwKhO1kWtgKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWufL7ea; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055136b612so16989625ad.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726161944; x=1726766744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMgu5NTVWEplLE1M1vZZEcRzdtwTvf4LfXQMbaClz5g=;
        b=iWufL7eaUY22UXsrlljRCTr7T/J7rg+44jovE20yVo9VCdYNqGyAtxkz0VR2zKjH/X
         bTUr+qwZ8DCPq5J/Dx7qp9l8BeZEvrlmr/q/lVp77B45XJI1b7Mn1gznEOfD1R1AiPdp
         xf04Lyw67yE79EzXSxYHcILbULh8gqtfttz5RSMrj0Uyq83rR+FI14ECUW2y3geaKJZz
         f+MZ+YExgJypEbE+ICgRUsG3riqbeJcHXpQk6rA/wIB4Vr2O595QcjyJLaUwMXXohkGo
         KY4ndcdTftGIWeCYhOUEwA5l4F7yX9yTExDHxBLnYjgcoSwwi1MkhQshAmsgO8nCs2r0
         pcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161944; x=1726766744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMgu5NTVWEplLE1M1vZZEcRzdtwTvf4LfXQMbaClz5g=;
        b=fGtkS0dUwaR6MRLHfm4XjjGEquzKFixBR2JssZ/wDrsRzcTCy/Xdte2pqZpl353y6n
         JoDWwfDfXTMDugL98zzbpdyr3owwbW1Ghqne1OpORIp38ymUQ3x9SuiqO5Pq/TjXB/Fr
         PNmHi9vZpRG975GGQcn3jn9B3IWU/6u7usvfphOUvZy7gJ8Vu6lbVdTDL/u1Gu5n3ZfZ
         nRym7yDpwxxE1wjy+A0NiJrUH3LxJeso1oVyhAslM9Ogkj17V+fOplW6SYQAeixqH99O
         uhFa7puIUtCtvxNKo0T13tpj404sJ6pNVh2dspEgzkcafwmSN7SiLFny3M8MffkNsc+r
         +ztg==
X-Forwarded-Encrypted: i=1; AJvYcCXA3OGuBjXFVWqwt8kW3BANob5YSGTtpHdmOD1b06gYyNUm7dkJteHoMDx+iks/bTECjkLBiy2TCaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcz3bAK276p2K/ydNMGFmY0hNYBBghEHUUuh4Dxo8MxEVqjZ8L
	KKPp1Ckwu6+WBOi+uJ0o1YDGUFPIG1q5auKOHJuTuCpyVMViXWhkGnvhYFx+qQASS6aZSR01HiQ
	=
X-Google-Smtp-Source: AGHT+IE2JdkaPzD1winftTN0IL8OS2UItpNf1GtYEJJuTChPcL2iFHWPaY5dGfkt4om8GbPhCT5jJA==
X-Received: by 2002:a17:902:e543:b0:202:3a49:acec with SMTP id d9443c01a7336-2076e30a8f9mr59052535ad.11.1726161944026;
        Thu, 12 Sep 2024 10:25:44 -0700 (PDT)
Received: from thinkpad ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47150sm16676565ad.82.2024.09.12.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:25:43 -0700 (PDT)
Date: Thu, 12 Sep 2024 22:55:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org,
	paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <20240912172534.ma3jc7po3ca2ytlh@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
 <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Sep 12, 2024 at 10:11:25AM -0700, Dan Williams wrote:
> Manivannan Sadhasivam wrote:
> > On Thu, Aug 22, 2024 at 11:30:10AM -0700, Nirmal Patel wrote:
> > > On Thu, 22 Aug 2024 15:18:06 +0530
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > 
> > > > On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:
> > > > > VMD does not support INTx for devices downstream from a VMD
> > > > > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > > > > devices under VMD to ensure other applications don't try to set up
> > > > > an INTx for them.
> > > > > 
> > > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>  
> > > > 
> > > > I shared a diff to put it in pci_assign_irq() and you said that you
> > > > were going to test it [1]. I don't see a reply to that and now you
> > > > came up with another approach.
> > > > 
> > > > What happened inbetween?
> > > 
> > > Apologies, I did perform the tests and the patch worked fine. However, I
> > > was able to see lot of bridge devices had the register set to 0xFF and I
> > > didn't want to alter them.
> > 
> > You should've either replied to my comment or mentioned it in the changelog.
> > 
> > > Also pci_assign_irg would still set the
> > > interrupt line register to 0 with or without VMD. Since I didn't want to
> > > introduce issues for non-VMD setup, I decide to keep the change limited
> > > only to the VMD.
> > > 
> > 
> > Sorry no. SPDK usecase is not specific to VMD and so is the issue. So this
> > should be fixed in the PCI core as I proposed. What if another bridge also wants
> > to do the same?
> 
> Going to say this rather harshly, but there is no conceivable universe I
> can imagine where the Linux PCI core should be bothered with the
> idiosyncracies of VMD. VMD is not a PCI bridge.
> 

I don't think the issue should be constrained to VMD only. Based on my
conversation with Nirmal [1], I understood that it is SPDK that makes wrong
assumption if the device's PCI_INTERRUPT_LINE is non-zero (and I assumed that
other application could do the same). In that case, how it can be classified
as the "idiosyncracy" of VMD? SPDK is not tied to VMD, isn't it?

- Mani

[1] https://lore.kernel.org/linux-pci/20240730052830.GA3122@thinkpad/

> SPDK is fully capable of doing this fixup itself in the presence of VMD.
> Unless and until this problem is apparent in more than just a kernel
> bypass development kit should the kernel worry about it, and even then
> the fixup must be contained to the VMD driver with all its other
> workarounds that to try to get back to standards compliant PCI bridge
> behavior.

-- 
மணிவண்ணன் சதாசிவம்


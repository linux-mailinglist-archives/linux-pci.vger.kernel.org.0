Return-Path: <linux-pci+bounces-28694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12510AC86EE
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 05:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA8E4E03A9
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370AF78F52;
	Fri, 30 May 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxEH+XKz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F931182BC
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748575000; cv=none; b=WBWDKl+GalreAhNyma3/tAWOZ+E54BjQkhCghIRxDOxSlr0BmdpnqxKHOt6MMAuDx2+6fpMlThoDUk79xAQF6sqruLLcI7YbVwmrMtSW+QsOcY+iQ2HH6C3W8LlYuox8hV3drBVunDS32KPp7JpFUQ8h5w1kDwnaUIx4CBYfVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748575000; c=relaxed/simple;
	bh=XVANWFhgXMv40Jkl6FJe26HKPUpKGq1GAb0fbWJTo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Z7rp3Fy5f34h5GQ1dNOtPGDNZQGzqT/MRo/uTQrN7q3LNfhVhsnMBBnZBb+S/2485mx9mNrZ3HsYWofEO1Hf4Rr1u3B1rxECYeRMgmdPADIH+5By4BU6wO2O/X0QxOGgcpTOmlKFBmi5AlCo3p29azwAZyNB7ZXR0vlblj+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxEH+XKz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312150900afso1520777a91.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 20:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748574998; x=1749179798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hG2cMyUqEG6RKX+zXxbm5GFZDNa/fK0gHsKi+Pje0cY=;
        b=sxEH+XKzJEKHZm0P6h5RQS63CoSgTtrMbEm+J+20svx1J+1i6UpiiRIeqf89fBT2kO
         KYiarMEnw+5Sz00oOlCqoy2Z1xgc/8urVNRk1xqlFGbUvwqyHa5OR7TRbRAQjWfclhpC
         WGNdqwEo66R5JiW5hazmQFv1c/MvRjIqBLAAcJ2yopLTCNgWR+WIB+wLEAhIqT54xQUG
         dLt5xYmdmA3U5Tiiqv8E2FejE8KcWqwei9A3yBc2k9o8QKcWlIo+O05SCWoeps0EhvGQ
         6Uq745VVgRxYkcPv+U0BscwoC7WRNC1gBtExEsDNPyMFDKa1V5DpAldcJGw9xz80tin4
         IVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748574998; x=1749179798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG2cMyUqEG6RKX+zXxbm5GFZDNa/fK0gHsKi+Pje0cY=;
        b=ee8z0YlJpspOFjHPUs/KFBb/eP5fj6s1q2b/X6bEKqU7mXAFNeIk8Dmdl/zsZ1XlwE
         2J4xiNhGO4c55mkvKGmU6GsCoCnxt0piodVAbB59h2rNaQsRSIAZdGGXqgDAAaZb/OWz
         vTBVk0pr8+l0yvdA67xKK7lQTcSbd1ecIF5fxOv3AG28qk5ZZ8eFubUHiwUeQ4VSC2Tc
         RdGZyb6SVEl6VeAVaGDcwqA7KtparUq3gfM1Q0EmhEoWFMp1RzZVwegbgtBtknXfClng
         jLfEuddA3mschUnmVY7aMxt0joieCWkf+JBFC2jTfk/WX41Y7yZ5fDxjzuzHgA6Ucl5W
         CpHA==
X-Forwarded-Encrypted: i=1; AJvYcCWrmqM5oFHi11qUN1dC7GBE0jHwTCOFDzsgSr5wY2TuoS2re++GhhHUmxUlhJo3+bzsUFyVXARcvRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwMdLFsmEmiwnILrJ4YujX4oDwH2cQkoEdJx9zCMIJwYSL+GP
	M/QLvpx8YRCl7aasjwHMu+pa1JRAyt73xm9V4ZmlGgnUOuskF7KAiJNDveZpPUSbGA==
X-Gm-Gg: ASbGnct/JcX7pIiyrPfUbhZ1dpbMrSN5jfT3k6mKu882se3s8v7yNguOKxNutbX9yBM
	+hI7NupGDOUrYE/N+cU57p4hDOorr/d0jPR9f5vI1K251luS/NMyaSmWMcGBCB2gmqNNz/JTNqw
	YGFCe+VCPTIaRPN2Qckbzjw4Exo5velxRY/3zCgVagNtZt9zFIc5kC2tf3rxh52KujALvC8lcg2
	DPJSY4jAAt32zULzjDwhyjBOUBcIarXie2UACITOqJYbkffGa0UqJAk+f9cKwJuzLNYkHXvbhv5
	DiwO5H9cdR5/nP+FF2ApGTx04ADt575mJ/BrXm+t64z2iZNtCCtCdJg+8IKCqA==
X-Google-Smtp-Source: AGHT+IEEn8LVklbjuJd3wJMpBvcIz8GKfwJW4nlD2EaqRmi/httRb+A8B1jCr1nfQUSFXjBRRKtNHA==
X-Received: by 2002:a17:90b:3f10:b0:312:639:a064 with SMTP id 98e67ed59e1d1-3124198adefmr2623680a91.28.1748574997839;
        Thu, 29 May 2025 20:16:37 -0700 (PDT)
Received: from thinkpad ([120.60.139.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e1e9103sm267399a91.0.2025.05.29.20.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:16:37 -0700 (PDT)
Date: Fri, 30 May 2025 08:46:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-pci@vger.kernel.org, Cyril Brulebois <kibi@debian.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <otrstq3g55ddtlbelzgyirpt5ahfirgkhrrietyrgbhxbueiwp@hyu4pgj6m4eo>
References: <nt2e4gqhefkqqhce62chepz7atytai2anymrn6ce47vcgubwsq@a6baualpdmty>
 <20250527222522.GA12969@bhelgaas>
 <CA+-6iNwo54tp4pvUGHXYjbV8sT6FWhSrd2k4pDJgtUGQWYhGXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwo54tp4pvUGHXYjbV8sT6FWhSrd2k4pDJgtUGQWYhGXg@mail.gmail.com>

On Thu, May 29, 2025 at 03:23:29PM -0400, Jim Quinlan wrote:
> On Tue, May 27, 2025 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sat, May 24, 2025 at 02:21:04PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
> > > > On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> > > > > What I would prefer is something like the first paragraph in that
> > > > > section: the #ifdef in a header file that declares the function and
> > > > > defines a no-op stub, with the implementation in some pwrctrl file.
> > > >
> > > > pci_pwrctrl_create_device() is static, but it is possible to #ifdef
> > > > the whole function in the .c file and provide the stub in an #else
> > > > branch.  That's easier to follow than #ifdef'ing portions of the
> > > > function.
> > > >
> > >
> > > +1
> >
> > I dropped the ball here and didn't get any fix for this in v6.15.
> 
> :-(
> 
> >
> >
> > Why do we need pci_pwrctrl_create_device() in drivers/pci/probe.c?
> > The obvious thing would have been to put the implementation in
> > drivers/pci/pwrctrl with a stub in drivers/pci/pci.h, so I assume
> > there's some reason we can't do that?
> 
> I was wondering if we could confine PWRCTL/_SLOT to work on a per PCIe
> controller basis.  For example, if we allow the port DT node to have
> boolean "pwrctrl;" property, it would direct the PWRCTL code to
> operate on the regulators within that node.  This would allow
> CONFIG_PWRCTL/_SLOT and the pcie-brcmstb.c way of controlling
> regulators to happily coexist.
> 
> One could argue that "pwrctrl;" does not describe the HW as a DT
> property should, but I think it should be considered nevertheless.
> 

No. There were a lot of attempts previously before the advent of pwrctrl
framework to add a DT property for powering the devices, but DT maintainer
clearly said that there should be no DT property for this purpose. So we came up
with this approach.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


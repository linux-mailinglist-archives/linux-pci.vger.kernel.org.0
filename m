Return-Path: <linux-pci+bounces-12367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DEF962D00
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0021C20C1B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180E1A2573;
	Wed, 28 Aug 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5ieMxB+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870018756D
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860344; cv=none; b=g6ZFTV9I8xwqUN0Ig8BK6vFeOh0fLihyX4zpndRSRpVs1Zsk2lRtMrKyy0NlwUHggoAIRtbr6go8XQLMCWeGW9/5PJZvM1/L2ex7OTRq9ObIpHyQrOEGjwq+cNtY1wTGFtmfa2Puaf0ZNpC5zduXlSIyQyS0JHShmPRXpOi+mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860344; c=relaxed/simple;
	bh=AYwJsPFJTs+BMyQDHjSBUGoJbZSElw/swWIE6XYBz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1L7mZa/w8IwwuUl0xiyIhAsIX12up1RZAred+cq3HNsm7QbcebLVuAwonH6T92xY2IHT7dJgryVLEdo0wrJUV+yw+vjwRQBBvVZ25cC3Uq50ezu5mhi5EkoD47ZhzHdJNRv//p9tUX+UL41kh9uxYQkeY3OJC/qGkryoPtCwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5ieMxB+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so47991855ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724860342; x=1725465142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftzkSWbFvLJ9948dQ8TVsavC0mFp50UvDV94rVgLQ2k=;
        b=D5ieMxB+8jlaaVGNpIWduVsHlNFpIqCSgy736Vrmb5V7d4upg4KJNCwjHJnJoGx1Tz
         Ixx9U82Lf2mZUEr+YV9P/h7SCT43KRcFYN6vEln9Jz34yON15iLtfzOu375s65bUf2c0
         +9ugFN6tBHQZli7WBsitkgiVLotuPcwAp4NwS4pFCVLL0Ku1o/c0KQr1l1/Pi1T+fxvG
         /P0IcK8/QChufejp+qVNFfzExS2uKP+S/u4Dn8lXbIegfljt2z49B8WyLI5HYXuke7SE
         8lJab0D9WR6pKI1G4oY2zr81BbOYJx6btQHaNAZ0a1BcqofzJI741IuIXuFZWj2zm/is
         /3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860342; x=1725465142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftzkSWbFvLJ9948dQ8TVsavC0mFp50UvDV94rVgLQ2k=;
        b=K22ELjrvPX4C69ofEhvupCyaExzRtLoCGmOuLoLYaxiicEq1OU13+biTy2gRgaoVcM
         ilCU5qopyl+cypwT4mgY6J8gUfvl23DYd3F8VSLHNWIIAfBiGBVCLHVKW5tyFvWOjfl8
         XxL3dLqYy5SD09MiUSEG2ghDziw25edsQ/d/uVq+tdtr3vLKTdaAU37dy3wu3JONy7FN
         zofLJOOGRehOXtyjot1e+C/CIVFLBnYDrzEFw05GX5HwO6LgpGza1ky0T53HWTGnqSOf
         FB5CU6U7/GrtHZXkpfdqTVDukZJFJFWTMgPPlBcat0c1hILN1GO9+BNtp6MU7Z23WQBn
         EOAA==
X-Forwarded-Encrypted: i=1; AJvYcCXWVosNn9Otm/HPv8skMh/7h2sy3xxxQBQq51VEO8f1FSFIwaP4jSR3Oxr4wY480K7yLCSZdvrzfbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Vt+YxCTzZ8685b+5IWuaiw7OcSxP7fNU1+6/sUQdvg0pXyMs
	qVbzpv3rr+DnacZbLnO/s1iwcOCgIiNVhfT0CEemxzzCnaVv1teQQ2WoLCaOQQ==
X-Google-Smtp-Source: AGHT+IFgo/cUJQwlwSXIoPmB/Y0s5lv+ozTSguIks56E+QNBK2Z1wW4Eku59mqPReTGV1Hr4ehcyCw==
X-Received: by 2002:a17:903:230b:b0:200:aa31:dc8d with SMTP id d9443c01a7336-2039e52cb0fmr191870685ad.63.1724860342472;
        Wed, 28 Aug 2024 08:52:22 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564b6csm100745445ad.27.2024.08.28.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:52:22 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:22:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240828155217.jccpmcgvizqomj4x@thinkpad>
References: <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
 <20240821014559.GA236134@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821014559.GA236134@bhelgaas>

On Tue, Aug 20, 2024 at 08:45:59PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 02, 2024 at 11:25:02AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Currently, there is no proper distinction between D3Hot and D3Cold while
> > handling the power management for PCI bridges. For instance,
> > pci_bridge_d3_allowed() API decides whether it is allowed to put the
> > bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> > is allowed in a scenario. This often leads to confusion and may be prone
> > to errors.
> > 
> > So let's split the D3Hot and D3Cold handling where possible. The current
> > pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> > and pci_bridge_d3cold_allowed() APIs and used in relevant places.
> 
> s/So let's split/Split/
> 
> > Also, pci_bridge_d3_update() API is now renamed to
> > pci_bridge_d3cold_update() since it was only used to check the possibility
> > of D3Cold.
> > 
> > Note that it is assumed that only D3Hot needs to be checked while
> > transitioning the bridge during runtime PM and D3Cold in other places. In
> > the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> > allowed for the bridge.
> > 
> > Still, there are places where just 'd3' is used opaquely, but those are
> > hard to distinguish, hence left for future cleanups.
> 
> The spec does use "D3Hot/D3Cold" (with Hot/Cold capitalized and
> subscripted), but most Linux doc and comments use "D3hot" and
> "D3cold", so I think we should stick with the Linux convention (it's
> not 100%, but it's a pretty big majority).
> 
> > -	if (pci_dev->bridge_d3_allowed)
> > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> 
> Much of this patch is renames that could be easily reviewed.  But
> there are a few things like this that are not simple renames.  Can you
> split out these non-rename things to their own patch(es) with their
> own explanations?
> 

I can, but I do not want these cleanups/refactoring to delay merging the patch
4. Are you OK if I just send it standalone and work on the refactoring as a
separate series?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


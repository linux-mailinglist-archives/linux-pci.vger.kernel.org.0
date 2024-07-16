Return-Path: <linux-pci+bounces-10380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20015932E68
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85962B21DCB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6319D88F;
	Tue, 16 Jul 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jymqtiOE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44619AA61
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147600; cv=none; b=XAvVZaP5t0vTv9Wbsmp19tKlbOE4A4g7RhSXE7+rfwsY1hzKM+TUnaTSViA34ruM7OK1dHnE3WZQan3WaeBZdtBFAQNUIOobNUeZCuumOpnL6DVbfq3yJ21PeHZR6wLlvOO1mzBsbMys0q0QXqlMTM+Bxwon6EXNjoS6y1BC6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147600; c=relaxed/simple;
	bh=2VQzD6LQQC6mbooMZk/DEbZhp2HOfxiWakWYL4qLRek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/4EuDqag2p+35Vax8GksYXQopSerYqiqyonH3/zxIZG0K2k/fAphxe1NngAynSfG+pW7uHa7KKdokkFNGOh8XM8IIsJHCgVDHT7G4ipDZor7NM57UQ3kpSBXtfueDwZB2DTVBPmTnSU9kUcF1/mcbSWwlz8QQU3h4zZorzSn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jymqtiOE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fbda48631cso40920815ad.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721147598; x=1721752398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oV3r6z+Da2SxB9Y7C50nA0DO7pVs/conpjP2usifdEA=;
        b=jymqtiOEOXvEEJyvcKE6vh3apcziefsx8v8MfteQYN3PBsfx56hbfX5Z9ka0sMyiqm
         rPbaINm0/5IgyU7h4W0sm328eQUaTk9bhefyRFDakSklr4BKE2Ax8NdGhqDYEcRZToLs
         HDMJA/fy2SJefq+aFNTMC790KyezT+CijAcTszITGyc5rvnBrdgwjH/1UFHgDJYaxEi5
         ce4Jid2xrmdDStyj2YJHnMkEZmPkGbkpzM1fv/32qkXbfniQYknFUuEqWJCXz4vOwGvQ
         YNFZPbRrbfRZW/2TX0INx3M1flUxWzvYxEZ5d28yDFcB/Paiqcves5igJ0IghN0zoUYp
         lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721147598; x=1721752398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oV3r6z+Da2SxB9Y7C50nA0DO7pVs/conpjP2usifdEA=;
        b=atN3sbOLRmHKD9/q9qyhnbAYUs484wK5/nP+RIdDhJsgF2Lac70AYyNr8729Swfwah
         wVY2jIvXJ2d2LkRq7xzg+ZCumAKk0o2gCYSK4pmF1Ie9o35nBItmqPf+uftStBDgxuzt
         l5e9ikAOzE598NwepLvt4XPobGAGWLL2JmHgn3V6Kblt1U4UF1E9und+CePSZ0w+LlzS
         BUsTg/00CdvDvIIAc6VKGv/gn+HwcREhNm00Y7CIb60LDZm60cuGcVPUid2kRDfXsA8K
         hOrszwT8OZ25nMRVdm+KIGNoYysJrCNBcHG54CiaNKW63m/DmgTOCfOd7hcTTNtliTPu
         +Waw==
X-Forwarded-Encrypted: i=1; AJvYcCXY5UGcYCiId3GlS52F/44LA+8lm5KUB14wqjThYdwa5vdihkCXwDcRsYBgneJNuClX40DdyF6HlhyWFtBfocN/GVXqX2Q41ipG
X-Gm-Message-State: AOJu0Yyf8fqm3d5UGMx1zQzY3veUt8pRPlBYPl13s02Zn54PCW/08IRv
	p14Vj734fXwf0WTQLcZYUa2u6c1QdpjsQjG6KWcoudXlHOckLymeyj8OACrdzQ==
X-Google-Smtp-Source: AGHT+IGxVPaz3ng+AAV9BSgu9/POkhqVEqJ4hpwNoWQ3lgOhnURmakn82LgWZd89+n9p0pTcFKXG6Q==
X-Received: by 2002:a17:903:32d1:b0:1fb:95c6:842e with SMTP id d9443c01a7336-1fc3e6ef518mr44526395ad.26.1721147598291;
        Tue, 16 Jul 2024 09:33:18 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2a3besm60676115ad.149.2024.07.16.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:33:17 -0700 (PDT)
Date: Tue, 16 Jul 2024 22:03:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
Message-ID: <20240716163312.GN3446@thinkpad>
References: <20240716152318.207178-1-brgl@bgdev.pl>
 <20240716155943.GM3446@thinkpad>
 <CAMRc=McObC-+xPfZADQ2wEHO5c3htLbPZLU0Ng-VmgBPEN-2Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McObC-+xPfZADQ2wEHO5c3htLbPZLU0Ng-VmgBPEN-2Yw@mail.gmail.com>

On Tue, Jul 16, 2024 at 06:29:04PM +0200, Bartosz Golaszewski wrote:
> On Tue, Jul 16, 2024 at 5:59 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:23:18PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Kconfig will ask the user twice about power sequencing: once for the QCom
> > > WCN power sequencing driver and then again for the PCI power control
> > > driver using it.
> > >
> > > Let's remove the public menuconfig entry for PCI pwrctl and instead
> > > default the relevant symbol to 'm' only for the architectures that
> > > actually need it.
> > >
> >
> > Why can't you put it in defconfig instead?
> >
> 
> Only Qualcomm uses it right now. I don't think it's worth building it
> for everyone just yet. Let's cross that bridge when we have more
> platforms selecting it?
> 

This is the same case for rest of the Qcom specific drivers as well, but we
enable it in ARM/ARM64 defconfig. So I think this driver should also follow the
same.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


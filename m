Return-Path: <linux-pci+bounces-18107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9B9EC899
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F80280C5E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171B1FF1B0;
	Wed, 11 Dec 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAG2KN3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64351FECB5
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908481; cv=none; b=uYm8YWf9qUOIIS2YfHwX6uOWSh1Uc4mJES6oAgG07rQsDoFHPbBs+pdT/CDAAbA0w7o5EKXtSTB3ZKM8yAKUQ6JEQJZ1G+7g/FKpvY445vIeeBPSPbnvzhmKzbTjO2eMf/UzFnjQBRwhXgupUDOvnjC9aq6YaFxyw+LYa+Oivcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908481; c=relaxed/simple;
	bh=Ox+dvyXza+TX7ZDpJ8HAcztROBmWclSerpmh0X86Alk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcxlLy4xaVYTCT8ox/pg/AhkQjOWmMjygh+4AfpQ3RzO6NoR7Ga7N3LXIQCaMaXrqsIasqjaSwxIqrp4nGMn2Bm4fbpWMou4v42lgB2jg3jtFtXv4Ig8mr7bmSGnH729l6MblNiWCJ/BXN6VySdcioSK9gpyq2awL9s2nFmUJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAG2KN3n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21675fd60feso19982305ad.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 01:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908478; x=1734513278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUFybBHAtKBg9XAbRfnlqLJtUAS0jaNbKaZp0A764TQ=;
        b=dAG2KN3nE4vO8Wbzja222Y0MPHoVAEgTLJHUKvG7m+ikMGr334rMGU2cf4OpRmZuDe
         xwzNcRgN7NNhOgkhz2Rt1WhX+NUhiv2ezU8RUw0eT9oIKmzU5vokUyCeEYGiuYRGUIEY
         aFo0Vgags/f/+mgxCsD3lpjNiJ6aj6RbqDJ2mFkjPYvfuuReCN4S5BX7IZCNPuZgOPsl
         rEL9fkHDoOHpE5B73TVeS+p9zUOHoVeG3HzOBevdLUrUzfYErYy2i5grYTlBhBoGj2ET
         N37JXnGPAIA7fROGRq/FaJq4a74Xza7X+rvHftrmIoG77yZBu82l5VeL7F9IX4byK1jR
         grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908478; x=1734513278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUFybBHAtKBg9XAbRfnlqLJtUAS0jaNbKaZp0A764TQ=;
        b=OUbN0jhdYfqwS2vkXUfOvUU3ti5Fq5pd/5djVLJhnn+/M4eaXqepEu1ebKD5zGF4GL
         awR34+Wpypkd7a1YskcmkQUWpJVgrQP9H8vpWkveddD8WbCfL5ixn7ZmcBIWUxBffBwl
         2Z8lgW7ZNoRrKfPtVPMUWxBTrC+arTVoBPQUz6HCIx6JQGbwaZJlZKx5BUbgRaVfNJSC
         rUrDoC0Nqm6YALX/b28GkmG3LCU5+gZog5rYjM9rZRnlsfEbbmO7AsyxldlSbYuWaeg7
         RKtELfsaczlGQTSaJ3p8GUpDwFPnaDHN300wt4QMzRiAEVwfd38cSC5QCR65C7kCR27B
         Fj8A==
X-Forwarded-Encrypted: i=1; AJvYcCW7QVkvBmqvyRl8t+PKjzrhoQ6wY5+XprnqHNqX9tgxWrGFNv2m6Xho94rw+c6W2mroIiFCPYDiTWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPmje7KIoY304cVg46hA4l7TChGz2swQXHq8cUX6MHQADzJ40
	ctJqTsY7xr08MwiHyqqyLq6wCA8uiHa4MDVT1VOoW/W7NVLO9ZsGSSwwc8Y92g==
X-Gm-Gg: ASbGncv4pjpJIfmvWk05TjirbIPWCddwclNxR+ofvs000O9QFCPi3GYmBN9p61Eb2hN
	XSPd5qqxlWtLV3iBEb4cfr6QDeR4EXAu1z2hn1enrkj2RykL4BMlQajq1McPFy3EhitRnU3gsiL
	RqKStmrx+Hbx8G5xHdaZr0zye4cvr+TFkUoDr2rIsYqFMAIScjQKP0UxKnTB7QyV9rOSnHDY8Ea
	FxIUlL6eprhaFvx+4tGs7f+Ks0F/qNeJYJkvbhY0ZB3xN+bFDa276/WIuRUi6s=
X-Google-Smtp-Source: AGHT+IE7knwn48LdhJslFzK1Zi2TZQ4t5PfbLv5V67ShOU5zUeOc6EVVuqUeQ7tRigEaD2ORk66xQw==
X-Received: by 2002:a17:903:1d2:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21778696456mr33767495ad.47.1733908477842;
        Wed, 11 Dec 2024 01:14:37 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164252350dsm54976385ad.43.2024.12.11.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:14:37 -0800 (PST)
Date: Wed, 11 Dec 2024 14:44:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, vigneshr@ti.com, s-vadapalli@ti.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, theo.lebrun@bootlin.com,
	thomas.petazzoni@bootlin.com, kwilczynski@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
Message-ID: <20241211091421.4empou7mbm35ynxq@thinkpad>
References: <20241210154256.GA3242512@bhelgaas>
 <6c7cb07c-af9e-4f69-84df-2b59a57e4182@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c7cb07c-af9e-4f69-84df-2b59a57e4182@bootlin.com>

On Wed, Dec 11, 2024 at 09:59:30AM +0100, Thomas Richard wrote:
> On 12/10/24 16:42, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
> >> The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
> >> not NULL before to use it.
> > 
> > If you have occasion to post a v2, update subject to:
> > 
> >   PCI: j721e: Check reset_gpio for NULL before using it
> > 
> > s/before to use it/before using it/
> > 
> > Did you trip over a NULL pointer dereference here?  Or maybe found via
> > inspection?
> 
> By inspection
> 
> > 
> > It looks like gpiod_set_value_cansleep(desc) *should* be a no-op if
> > desc is NULL, based on this comment [1]:
> > 
> >  * This descriptor validation needs to be inserted verbatim into each
> >  * function taking a descriptor, so we need to use a preprocessor
> >  * macro to avoid endless duplication. If the desc is NULL it is an
> >  * optional GPIO and calls should just bail out.
> > 
> > and the fact that the VALIDATE_DESC_VOID() macro looks like it would
> > return early in that case.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?id=v6.12#n2316
> 
> Oh yes you're right.
> In fact, the if statement in probe() and resume_noirq() is for msleep(),
> not really for gpiod_set_value_cansleep().
> 
> So this patch is useless.
> 

Yes. Almost all of the GPIO APIs accepting desc (except few) use VALIDATE_DESC()
to check for NULL descriptor. So explicit check is not needed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


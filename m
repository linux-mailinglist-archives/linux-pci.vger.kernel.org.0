Return-Path: <linux-pci+bounces-17119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7389D40BB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2484F282B8D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9115853A;
	Wed, 20 Nov 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2in1Zcb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792F153BF7
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122166; cv=none; b=f7HnnDPAw9fiY4wPk5AR7j81ufeMryRnfMMjvqw61e+apYNszC6YOxuEr3gLvD0F7DW7WzMiaigJAvOH/bHrEb874F7i8Fx101fCrFiuSloQmWPyv+IyMCmecvUzkP/7rLNurQmf2A8/atef8TyQLqJi8/THmWpRgv2cBDdZMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122166; c=relaxed/simple;
	bh=/f8uYPuQX/ROszRbmQFmcbDG3zmYAvpDx4QiLFxHXMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEwtc/SXKyuclyngA2VfFpGzMtwmmRyj5GgW4UOVsfJvUHgx4ye7OnxJ0GC6qM1hys1WbxGnvH+4eS8Lta2YGEtxvIdkHwg5MfUiKjvnvxCx5jAB2J7/JMNTjaYperDUFiLKijqaHa+zaAQdV9ZaxCdolHuUY0S6NbojpwJwHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2in1Zcb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72061bfec2dso4483b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732122164; x=1732726964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctM3iStXVQXWRldjhr5j1F7CLkwdxNQDSi2rfTsbrIo=;
        b=j2in1ZcbinVKOVt+IiwmC86MkvxdqvVtuGtNUIRRM3tSHPOcmOms9XxBVU8CnJIGGi
         zjWEUyHqwz9HOSz1h6ZWoQaWgGqhXC3DDMaZ22ol1ykG5eByR/ENzbQt7M5bW8IL8Nxo
         RKUe4pua4lV0qu0D4CvjHuH+Pcg7F2iGnRanQSg6E/ARGcGP5HpXTxpslRVcjrZXa3qD
         DoKXV94ierumvr+dLTEQ5soFmFNLm72QGwRnavVMUil2EgKeY2J7B9mDUcohekMq2wME
         +Z1R4MI5Pd2S58sof045t0ysRevRgu1T8AofdyqDtuukHJQkUqe8Xw1r4ljPrqHEM4Of
         reIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122164; x=1732726964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctM3iStXVQXWRldjhr5j1F7CLkwdxNQDSi2rfTsbrIo=;
        b=M1ZdYz8XC1xDDoA2Gyvk4KJzC6uzCDROkDcg2p1TDCRdKUZRVXPeL1oNwwVOVNAjxG
         PVnlzdlniKRoe5T9nKMDsUBfpR8u8RoMrLkdN6Lk4k3QDO2j/6merhHF9tNZRzUwksvI
         poSlcQOokGLWlfEWNoIRY/KVfkqc40UTbK45mLpqr9R8eH2VP1/jaUUL31VLJoVjnWJW
         K5eb3p+m5s/LjGLcbxOYxnnmOkpNplPBstNhHlGh2k7S0P2Pr0ZY7Dq03ED6I0sj7Jnb
         ONEaHoBrDTLTljwqlHdFUaFl9QmIb4fNH13tU7pkw9jfaF7AknoroTsLORUtbJ7+7Mv3
         2vqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuhm/9SyKLI9Y+dTgnMAOu9tG6PM3IacBdWqNK8S9a66scCmr5OcAeOwRJ0gjvH1GCkznaW2TSxtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7YpgsT6OB+T2E1PQ6TNCvSx72GJfCoZ4QzHJGsGu6nu+ggBI
	BeVEkl8sGVSbyFJLr3sXRfdNCLWx9WQc2kQYq7jH44h/0RII/mMPkWdHDj/twg==
X-Google-Smtp-Source: AGHT+IHIik/zRYPgkopkspcV4s4tfBgXsrtFiGJpzprYeAmSSfSz+DgK3mZhO54pdUyDOXUVB0Ac3g==
X-Received: by 2002:a17:903:2348:b0:20b:861a:25c7 with SMTP id d9443c01a7336-21270463234mr27106695ad.54.1732122164353;
        Wed, 20 Nov 2024 09:02:44 -0800 (PST)
Received: from thinkpad ([120.60.72.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2124aed0fbbsm36204065ad.18.2024.11.20.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:02:43 -0800 (PST)
Date: Wed, 20 Nov 2024 22:32:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Message-ID: <20241120170232.flllyqcycsrsk6cj@thinkpad>
References: <20241025-pci-pwrctl-rework-v2-3-568756156cbe@linaro.org>
 <20241120161047.GA2325953@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120161047.GA2325953@bhelgaas>

On Wed, Nov 20, 2024 at 10:10:47AM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 25, 2024 at 01:24:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > As per the kernel device driver model, pwrctl device is the supplier for
> > the PCI device. But the device link that enforces the supplier-consumer
> > relationship is created inside the pwrctl driver currently. Due to this,
> > the driver model doesn't prevent probing of the PCI client drivers before
> > probing the corresponding pwrctl drivers. This may lead to a race condition
> > if the PCI device was already powered on by the bootloader (before the
> > pwrctl driver).
> 
> > +	 * Create a device link between the PCI device and pwrctl device (if
> > +	 * exists). This ensures that the pwrctl drivers are probed before the
> > +	 * PCI client drivers.
> > +	 */
> > +	pdev = of_find_device_by_node(dn);
> > +	if (pdev) {
> > +		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> > +			pci_err(dev, "failed to add device link between %s and %s\n",
> > +				dev_name(&dev->dev), pdev->name);
> 
> This prints the name for "dev" twice (once by pci_err(dev) and again
> from dev_name(&dev->dev)).  Is it helpful to see it twice here?

Hmm, not very much. It could be reworded as below:

	pci_err(dev, "failed to link: %s\n", pdev->name);

- Mani

-- 
மணிவண்ணன் சதாசிவம்


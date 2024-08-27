Return-Path: <linux-pci+bounces-12288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7B960D36
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDB1C22693
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5D1C4EF0;
	Tue, 27 Aug 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2ZywhW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626E1C461B
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767791; cv=none; b=Re8TmPSLaSJkT7E+WOvNh7fqK4krAd/QSp1W05RbW3kOHNngY7GGgg8B4vYmwOw9tFbrlz1QprgHAdjnalVQSnhSRbO92P/gCZkrKr+fIr1ZgGuCmntl5xI3jtdDFTcMzrlX6KC80m6V3ZJbbWdeAE1OHs+iqF3WsP8h9BrlSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767791; c=relaxed/simple;
	bh=GdIpFTgbfxU+NKY2XBXIblMsCTYmmc2hBkBCO3HgeWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReUWSJwH/ZArc0z1JGC8QUa9Vsv5GLPfBvh7bRFG34HHKXxjA1S9vpe8vCPHq6g8zXgjgaq7VcHsZ7SE8ItBiIAfYjYFqJtfVVjxLXAmxqCPnOxeig39iPw1Z+7zOS1VqvVFbIGjhO6akCMdPvBkxbFQHKxzleKzpPN4puNGHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2ZywhW1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cda0453766so1781850a12.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724767789; x=1725372589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouRj4TAgkRTz5GRtzqlt4tI1PtOjY+RsVnMcjc3Hl+w=;
        b=F2ZywhW1dAr+iWC23VdFx8sxBR3V8wxKgY4AGHc4B4G7yD16su+xtPgLqDB4jKTVAh
         ET51ab1OrS1HbklT2VHSUBS8x8GxZSkWbuEhbxOgbBSOw5fASxPFquy87rif0UEIBg7t
         5jJ97b5n2wUbgGxsOXwv2nfJS87S11KRGB0zQodNkB4CcERbYvi00cLH5XlhobrL8G+E
         nI+JWkQjoXPSJ5yibkoLRdu7E6QvvbVICD/AiKBR5gxq2xhP0FW4F9cRK8VESuTWQLyi
         hBAzszhMSPr76L0J9XoBcI4935aSL2b5K4hW6rATYsc0kNWK7jKhMfP+ng58d6LBvDug
         GmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767789; x=1725372589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouRj4TAgkRTz5GRtzqlt4tI1PtOjY+RsVnMcjc3Hl+w=;
        b=m0yukfsYdPuHLHomab07+tHBgOiaC1YrRFl6eCQJMX+RoA6bXyzwZoyOa+TWLn4UT1
         LY0M5ws/sDaVmwMReldWwdWoQAQ0YlvrYOf48/Vsk/AZz80F3d1GNHNWoErxREZiO1Z9
         lse4jZT5PNp4CI9gZkpi2PJ4eVFMBxOQXu+a4HhQ73Nrer3k0eV2FeNWTS+nFIHgL2SF
         ANHuPXB4oXdkPj+KbsJiKhyF5d9iqXWaskBSOCM6Vm1A4+YyvtHnQyIwR5wZLUNptfwN
         5fSuDauFcjnzWQPE7dmdXIN+7c9ILbQT3k7DUJ3Sz767aB81vX892nIxhW78jDnmjk0E
         knbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXijUPWdxtkOOx0SnOzf5vGzF3vZPhP1ruU0kb5M6xc3mbRvAvzn1B1Z3x8yoM5569C5M0nb+5XJJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCICl9RZfUta78NlhIiNzhV+5Wrmres5a+JqY4r1nsfdhlKCW
	21IMMNWxNK+6hTMe8a139sCHuVkJdPCAFBiuSwafBipUuZDlauTGz0nDC3TPBg==
X-Google-Smtp-Source: AGHT+IEKzEYg3GopwFR1fgAkJ8tHS6Cu7uSDx5Vu1REqSojLlIdiqFl36KFNz6Mpex8Rv8qz5VOGzA==
X-Received: by 2002:a17:90b:356:b0:2c9:61f9:a141 with SMTP id 98e67ed59e1d1-2d646bf605amr15398464a91.16.1724767788735;
        Tue, 27 Aug 2024 07:09:48 -0700 (PDT)
Received: from thinkpad ([117.213.96.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61392a1efsm12323555a91.21.2024.08.27.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:09:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:39:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
Message-ID: <20240827140942.mujjwea34iscqzmx@thinkpad>
References: <20240823093323.33450-1-brgl@bgdev.pl>
 <20240823093323.33450-2-brgl@bgdev.pl>
 <20240827084012.rjbfk4dhumunhaaa@thinkpad>
 <CAMRc=Mfd08i0NFsuf=igJRJszDNfLyHf+bf6ExjNYxX41CMdWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfd08i0NFsuf=igJRJszDNfLyHf+bf6ExjNYxX41CMdWA@mail.gmail.com>

On Tue, Aug 27, 2024 at 02:25:58PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 27, 2024 at 10:40 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > + Rob
> >
> > On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > of_platform_depopulate() doesn't play nice with reused OF nodes - it
> > > ignores the ones that are not marked explicitly as populated and it may
> > > happen that the PCI device goes away before the platform device in which
> > > case the PCI core clears the OF_POPULATED bit. We need to
> > > unconditionally unregister the platform devices for child nodes when
> > > stopping the PCI device.
> > >
> >
> > It sounds like the fix is in of_platform_depopulate() itself and this patch
> > works around the API issue in PCI driver.
> >
> > Rob, is that correct?
> >
> > - Mani
> 
> of_platform_depopulate() has more issues than just that. For one: it's
> asymmetric to of_platform_populate() as it takes a struct device as
> argument and not a device node. This causes issues for users like TI
> aemif that call of_platform_populate() on nodes without the compatible
> property that are never consumed by any device. AFAIK there's
> currently no way to depopulate them.
> 

Oouch!

> In this particular case I think that the OF_POPULATED bit should not
> be set when the PCI device is created but only when the platform
> device is.
> 
> However I'm afraid to change the semantics of of_platform_depopulate()
> et al for all users so I'm more inclined to have this fix in v6.11 to
> avoid releasing non functional code (pwrctl devices not being removed)
> and then possibly introduce a new variant of of_platform_depopulate()
> that would work slightly differently.
> 

Ok, sounds like a plan. Since Rob is also in favor of this patch, it is good to
get this series merged for 6.11.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


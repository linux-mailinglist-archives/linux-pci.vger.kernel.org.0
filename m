Return-Path: <linux-pci+bounces-16988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09419D0087
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 19:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A7FB22499
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20361188735;
	Sat, 16 Nov 2024 18:41:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E018E35D;
	Sat, 16 Nov 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782468; cv=none; b=jgZgExylpuhnECw//x1NZmcdn8uJPLOi/tS9ajymwrmx+i/Krhl7ytxaj6R+HzMl9Veu+BKFOl1ZaRLMAkCVf0XZZzRrc+iLHI/17bN9yLnX/nW7Sp8Uy+odmWbCn8FendTCaLQ1zrG5pFaU4tp5xu+Wbymlcvb3LThl49G/OpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782468; c=relaxed/simple;
	bh=IRz7sUjYrGHPvsSE0pzBCsINEQiVvdX8CXirsCR5/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWkdCsmfzae7yGrIhC7Vw/fshSKlOQjeudUWdok2XrKro1x7yIkSSdCPFvuHpYti5/wp3IIR7aTK4og0MsivjXUvCT744Cl0tW5bcqKwCkE+402qsWB/26cpeNmLoFWKH78vN1UwGildbuL/MvUN9KSR4cQFV9xk+NdUZxqOFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso29601215ad.2;
        Sat, 16 Nov 2024 10:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782466; x=1732387266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6zrqPiWQC7rDWZoE/g4GnXAN9sjElaRR3twDuAtjOo=;
        b=u5FZDY3vNKv9Vb2nxY9KTf2eYi0xTVCUpz2hdfjIv/93vJ0bEt115OOq7ECLAc7M/P
         NLU9jhDSeVthdRwlAJDFDoXUAi3SH8z9XNUWfVA2KnL4Z1o5D2nq6hd8xsrGhkWh2CCT
         lwCkzXwAgnpQE2yMFAa22kbwb39vzixMicxAsddw1Jro62tgqPXbHQW60pE2WXZZGCZd
         GUyuRa7Tx2qZ31SXxgHN0/fauFPagsEh1DmlbxFB4ZESGkd1W/CgjfaWYfB0FJ11n3PE
         6wEtu9aiFwkEiZsxHnye9jeQ6OYMx69MSH1Df61z625lNB+b/9MHEYDAlv5ZLolpNyPA
         Crfw==
X-Forwarded-Encrypted: i=1; AJvYcCV2POhgZ58E/GWCHEslqOdgz8MGZFqDfmIbPp2Hj2TsXo9uGo/wVnv60ltMN4qX6J3uZpsenznWWhm+@vger.kernel.org, AJvYcCWIp5OugHzoh0N/73Lz/Fm5thEBTOtcPxU+8bQGk5osZxWop7fOc9fnMJ9ppVQj+RLUnU+EngUsOe7oY18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpZXYCMXzOJ474uEUJ+vn3dtXjRqsOpkWLsU1bu0oBXltcAfv
	XV60yZ3sji7Mt15hiw7zJ1sbRC/ihKVj/2xy/YDk5l5FeARQKO0u
X-Google-Smtp-Source: AGHT+IGklcX91lB3aw+DDj0CMsZ/9DbTURDoBMutuQQkQS6lg5ZoMyrEgDcYr82v0d6dAwEYAmdy0A==
X-Received: by 2002:a17:902:ec92:b0:20e:57c8:6aae with SMTP id d9443c01a7336-211d0d62503mr101325775ad.3.1731782465801;
        Sat, 16 Nov 2024 10:41:05 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f5555esm30390095ad.259.2024.11.16.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:41:05 -0800 (PST)
Date: Sun, 17 Nov 2024 03:41:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at
 least one power supply is present
Message-ID: <20241116184103.GD890334@rocinante>
References: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org>
 <20241106212826.GA1540916@bhelgaas>
 <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>
 <20241107111538.2koeeb2gcch5zq3t@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111538.2koeeb2gcch5zq3t@thinkpad>

Hello,

[...]
> > > > +bool of_pci_is_supply_present(struct device_node *np)
> > > > +{
> > > > +     struct property *prop;
> > > > +     char *supply;
> > > > +
> > > > +     if (!np)
> > > > +             return false;
> > >
> > > Why do we need to test !np here?  It should always be non-NULL.
> > >
> > 
> > Right, I think this can be dropped. We check for the OF node in the
> > function above.
> > 
> 
> I think it was a leftover that I didn't cleanup. But I do plan to move this API
> to drivers/of once 6.13-rc1 is out. So even if it didn't get dropped now, I will
> do it later.

I removed the NULL check directly on the branch.  Thank you!

	Krzysztof


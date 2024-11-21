Return-Path: <linux-pci+bounces-17171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9919D506F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E40FB2841D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD519F462;
	Thu, 21 Nov 2024 16:03:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE119F12A;
	Thu, 21 Nov 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205016; cv=none; b=rd4RrRTOirXoOMVeNoQxN7BtCCGgTcDlYw8piRWKMFHrqB+7KldsKONcuPWaMHTUwyvhDAJc5ljesw8DMKSK5hYrIZSu1sBtZRj1OyAg/8SxRcSef65SVyZdbIimNtm/Or/69a/zKdA9pq2sODTXn+2shTGglzwg9T/Kl511XhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205016; c=relaxed/simple;
	bh=6hBxZGNSaRRk/xb2CQzSEeUt3G9r3WBcA6t0UELd2Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8x7DuZgC4sT6pJdbHe2f12GW9dtpr7rpvvT4cp4M4Vp9f9Q3mpG7DyFN08GXiouATmzbzxc69INEvDqeNxHMivaFEkBRC44p0wqYbF7wCuQ3BwkEw9dDxbDM6QrLsT1Z11L1GE4OqYjdhSHj5BzATeTXQ7H3Dtis8NN8Epb/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7240fa50694so993971b3a.1;
        Thu, 21 Nov 2024 08:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732205014; x=1732809814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwJLzHBRW/tF4s1zzWI1Pa1QXiwfnJOVwrmhp2jROEk=;
        b=ZqqvxRCf1KA0tqAVZjYRqnDAu3ujCE9YOVWBkmPMB4yHsORjhEjIJxSvILQF3wzsAy
         g/oF8U+JCwbuixiYuH/MByGQ6P5ciZNEbEHa9X6d4q6hBqNg5yeuIvvSe34rrPd/coWi
         q2VYp42SpsZDADntkHmFCTGbsc8jDtjRp4HbFvJEuXNhv+T3B/4mQyXKnFQTxow5p3Fh
         5aphUP4UlFnIyg23A8N+wIC+xQSVKmuYy4IqBtWCU7tJPwMScEZzAPWEyVerqyLi7rUZ
         TrnSKW/C/D6A1E03XdRwepOSFVHS/E1kOhs86j2HuG2tbLAI23mAbu4aU+vVjhEzkgaM
         rCRg==
X-Forwarded-Encrypted: i=1; AJvYcCU1QqZaWo+SuoVnmMlS8UDtnyxecgwyV98qftVhncaCOP2ZdYIVwE2rsw5NV9Hz4LbLy9fRIBS6mDQO@vger.kernel.org, AJvYcCWPj5gOoU1AGoLKeSrr83ny41a/zuwaDi6LF1hNN9Z7b7v2v5+/+AB6hlFTYkn8HtTArb+f7EDCfobcdfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSvy9rmHNxMyjkf36p/ylyNdqWuuY0W35dNox0SFHx9aZlcoW
	XDY56FaOdv2WdbL3pgWeals+MTAU6oYo2Cao6owiRzU8Q5m3gjYD
X-Gm-Gg: ASbGncsUasydkuxViC/dDJfg9yiV/lbX4H7xyE43wg3VoWIinnuGZcR9UpxITnz5dZo
	y4wLni1sKygO2BXk96BoLGc2kZ2yKIk+kcca5hW1svNiDwRJPeGsmOegnzBYkC8x0+TkdZX/oiY
	ejpcOGCeMlL8fQ0SnwYnQL3fgcX+F5pX0OdBJlp2fYa+viwoatrJ0qfSdfqKLm0mDH8GEwjXqKh
	gbZcviSg7OSTmrgx6GUZKf7q9SXYj0QZ+3J7gNzq00EbIDrAxSX76X6iTjq1K+DDib0xw3/4hnQ
	nTnOYFED
X-Google-Smtp-Source: AGHT+IHITVlJdUuy9vXzR5CSv2Nmr3a/BW89tAkmDUvIfw/40J6yxYHpNVFPxhbmFrSFNKZ3dgKJNA==
X-Received: by 2002:a05:6a00:b85:b0:71e:77e7:d60 with SMTP id d2e1a72fcca58-724bed7c51fmr10863603b3a.23.1732205013496;
        Thu, 21 Nov 2024 08:03:33 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef11785sm3815016b3a.83.2024.11.21.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:03:32 -0800 (PST)
Date: Fri, 22 Nov 2024 01:03:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20241121160330.GA3239115@rocinante>
References: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org>
 <20241106212826.GA1540916@bhelgaas>
 <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>
 <20241107111538.2koeeb2gcch5zq3t@thinkpad>
 <20241116184103.GD890334@rocinante>
 <a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com>

Hello,

> > > > > > +bool of_pci_is_supply_present(struct device_node *np)
> > > > > > +{
> > > > > > +     struct property *prop;
> > > > > > +     char *supply;
> > > > > > +
> > > > > > +     if (!np)
> > > > > > +             return false;
> > > > > 
> > > > > Why do we need to test !np here?  It should always be non-NULL.
> > > > > 
> 
> This doesn't appear to be the case, at least on my x86 machine and on x86
> QEMU with CONFIG_OF enabled.

Thank you for testing!  Much appreciated.

We've also received other signal about this, too, per:

  - https://lore.kernel.org/r/673f39b0.050a0220.363a1b.0126.GAE@google.com
  - https://lore.kernel.org/r/CA+G9fYurbY3B6ahZ+k+Syp5bZ3a+YQdeX8DRb6Twi4BDEFbUsw@mail.gmail.com

> > > > Right, I think this can be dropped. We check for the OF node in the
> > > > function above.
> > > > 
> > > 
> > > I think it was a leftover that I didn't cleanup. But I do plan to move this API
> > > to drivers/of once 6.13-rc1 is out. So even if it didn't get dropped now, I will
> > > do it later.
> > 
> > I removed the NULL check directly on the branch.  Thank you!

I added the NULL check back.

	Krzysztof


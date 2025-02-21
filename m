Return-Path: <linux-pci+bounces-22018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB50A3FDA3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9151888C10
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26B2512C5;
	Fri, 21 Feb 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BV3ibK08"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD093250C0D
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159657; cv=none; b=tFi53/1YPMsdvTLC/4Pu5OybCB1JD6PKZFw3CUbNPr95FcWWT4H4gJjz/vjiJMQEe6WLmAulkeVkMRDugs7+8PJ4Z1nQrJ66uzGblaGChvR/DFOzzp9swCf7E+qvksWiTVlGlE4oWOpbPvk/x5jb+w7Y1+UnUHlZ9UUhl1VfutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159657; c=relaxed/simple;
	bh=1TOSqunaGscWN4l00qLq9s+/LjcCxdSYRcrFPYcw9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uudHcrEY+GFCqFT17RdfVGxMDW2IePWnSllHRTvDQYy5oPD/y/X11cCcCRYy2CdmRwgJNdbG3QAKafTiei7XBgtXPVsjQI2CVSgm3HTWVexDtZkkluTdhq0C9KJNJos/xDi/XqxgeZDmssCZZFvQnZPFtlJbqwPG92/HNRoMKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BV3ibK08; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f44353649aso3724983a91.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740159655; x=1740764455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q2oAkFXciPkZq9YMdViJHNElYAn9PdezEzpFc03PeNI=;
        b=BV3ibK08tOS4zCFfw5yR2J0OAOt6yZ9C39qBQkBy5mLDSQwUqWFTYb7q9GIU4cK7+d
         DZNh8Uv9ZKnXETwTcq9zTUrgc30W0pP7JsLqusgp3hA4yl5a0W8B8Fc/fLEV9fyQLXzK
         VBDdf/d528aPpA2xgFYhEQR+o29n4S/oJ9cwa+mRziYxd7mkT6LWp3iNTummd5ownBMX
         nh3yGBc5C3Edu9Gt48oYSb91EuE6uaFiEdNjY/4spafb6RqwuWmDdr4qoSMMdyajyalO
         LmKry3nnmkm4MI3OALEkU3nPoJcdrnEwIVtSPz6qwmr5qfJ1M5HqvyL/DoFI5aU/gKTN
         klXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159655; x=1740764455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2oAkFXciPkZq9YMdViJHNElYAn9PdezEzpFc03PeNI=;
        b=qnLoGOnwmi2pgbPi95RYA8Xx2L6ZMwJPvJTi8mF50oJ40C2Wc7dsT97BnJzefkVNVT
         LSGM4eiClc7McYI3Ip2SpFh7ty8v43K9uFMbGIQfeSDIBL77nsElI3TgS5baqyV9pFLQ
         2ULuoJ39yRKFhXPjvVr69H+vhCoGQ3AvLW1hctoeroTQqJKzqIHvAyr4Kn2BqbCBiJgB
         d9vJlFyBw2UAtBNg1corp5rRqQr7wC6Jh8+a7dQbR1tynrliNkgB2fQz2V80nkPnA9+Y
         SY6QQifozO9BCyDC3GEXWopgSUDBBzEeduEKW8o/dReyRWugnIaD6NV28p6yFZs3TcpJ
         EUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAO1K02AMj3c8ormXKw2wPsXZPpUzBq/ql0JQc6WECSWUMgFj8OMvPmoz+giO4Q+XeRxyijeDc1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgyDk7SFj47zGJAPQ/vMUuCdZxnfFr5XuJr9moxNn8h1oUZHUW
	4vm7PJMkd3IJvWmcWAqZlHpx6Oe4BWxxtideSpe0TLew7/SOnfqXUbsIXxVQFQ==
X-Gm-Gg: ASbGnct/q5EhNZ2gIFdkuZ0LlhWYVa8uUQIaoH7tBECvOye8RZ9osnzeYGGh3cxmy4O
	sYzeVAKcppXtQUoWx0tB41Kp7v6N1lAfsNEOjFzQcoFbKe9X2e4hw+3HEHHhozr7HR2Tg89FyAM
	v0hv2jgu7xPeZdtGNqdproY5KneVQN6yUwHtSzowfCEUbicplGA96zt5+XDgHIHFfG2EqQueBTo
	mEpFtJf5mPSA+eElGjy2n8r+OX3kOoUCUr93k0NK9K8lQvgNakTI1PaQGPwlhMGlUxE+zDOK3n/
	Q3eEkDnGzIKIiuEbL/IkpDTXzAWqKVEakac=
X-Google-Smtp-Source: AGHT+IEUM0IWL8eNAN8UJ1dXT8ryrx7MU+nn31plTm9kxpVbUvaF0T1r8uHMvFtjWR63sU0O0ebkqA==
X-Received: by 2002:a17:90b:5201:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fce76a1eb6mr6181982a91.5.1740159655296;
        Fri, 21 Feb 2025 09:40:55 -0800 (PST)
Received: from thinkpad ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae32c24sm1662150a91.0.2025.02.21.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:40:54 -0800 (PST)
Date: Fri, 21 Feb 2025 23:10:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Message-ID: <20250221174050.olbntmyzqew6ygfu@thinkpad>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250220233520.GA319453@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220233520.GA319453@bhelgaas>

On Thu, Feb 20, 2025 at 05:35:20PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 07:39:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > The pwrctrl core will rescan the bus once the device is powered on. So
> > there is no need to continue scanning for the device further.
> 
> > -/*
> > - * Create pwrctrl device (if required) for the PCI device to handle the power
> > - * state.
> > - */
> > -static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> > +static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> 
> > +	 * Create pwrctrl device (if required) for the PCI device to handle the
> > +	 * power state. If the pwrctrl device is created, then skip scanning
> > +	 * further as the pwrctrl core will rescan the bus after powering on
> > +	 * the device.
> 
> I know you only moved the first sentence, but I think "power state" is
> likely to be confused with the D0, D1, D2, D3hot, D3cold power
> management states.  Maybe we could reword this to talk about power
> control, power sequencing, power supplies, power regulators or
> something?
> 

Sure. It could be changed to "power control." I hope Krzysztof can ammend it in
the branch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


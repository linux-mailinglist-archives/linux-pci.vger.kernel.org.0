Return-Path: <linux-pci+bounces-28364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE4AC2E4F
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 10:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529997B877E
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9573595E;
	Sat, 24 May 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psQz3INo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372F4C6E
	for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748076673; cv=none; b=PlZys2dpz6Vr9U5HontDjclB7DSqSkZpsLEwc0ko5QJ2/0MPOPEePzqgp7zVAZ+nA8sfD61QLephaCHzUUAP9knJrSU4pSByexlCSFI2wk1L7WLFZiYwLXGymzsSz/T0vvNaxH9Xr9EQddbXeqsgL+UC7A6UAcW0Eb9QVyDKuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748076673; c=relaxed/simple;
	bh=hJI2cVKiGaBvtXQjm08xYf5Z4PHVl6rT8CHYdOSGTmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHgKD8Gpc8JtxkrVwSKwVgGMhfzuC3zkw3F0gqSNh1vURWKkL6uimJ7jUfy6ymAsYDAlhwmYcufPhzp9AdAPSAA2Aic/PXgxgpsCgdTXdw5hrBeDopf08lVzmt7xe3S1KmplE3FyvnsErpoikbARyKo1pBfDbVtUCZK0n0+IoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psQz3INo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so617346b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748076671; x=1748681471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NgUtYvO5WBVFcjG1wvfO5HBM3gch3DBKN3wNQ2sbbso=;
        b=psQz3INo+2xPlXZGyTnsZbjgP7vsqZTAf6TsxYOzaRiXJ82n0tOZCPqz40MjwPbtgL
         NRYpkpIIUOiewTR573aQeWskE7BPNXMZ7BU6/LQUiiAhIR0lwtcC/zcL9XTswHprYZAg
         JBQDkJcGOmNiDNz9uOkLS6VJola8litSmRPA3K2zEUqeKCOcHP1yRUgGmRnsJEn72gCk
         zZmaO8F3K2mnwwoYjEdfuhacbqBJfXMnehnNiWeh7UaA2589xUoNPDVK+XuLfLG7rmT8
         vSwuflFAluibjeLJYdB7UOIUkKjzJf0CuZDcdEhjYlogF4IlnArDPP7VtHWrmK0CXcM1
         4l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748076671; x=1748681471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgUtYvO5WBVFcjG1wvfO5HBM3gch3DBKN3wNQ2sbbso=;
        b=EZ+zmdl+sVveEougauTM4x+U6NVRcX+Oh1AEhtox5Ik9Zb5ga7/ueNfQubWTb4SThc
         gco/jNK3EqVjU1NF+/SU7GxnDRqeX83PRfc5Lk8C4VezmJ24H5JLjHADfi6z18VebZtE
         FNBXDE6JCdqvPrIKb2Y9myS3J+PLwaBVryWIfqQSI1sRO8q/rbZa+D/NajNScGmecLPy
         MlVUoxt7moqF0mx7+OV57OVtZfFAQR+ABedgzLB62G7yHreobDdNzpRhpdayZKAioVBR
         +bVblw0tDQSd+0mQAFaqAzHLnTzvJN0DAFu7CDjMimyCPRVb9vldGKQ4zSQGd2uKH5/g
         WYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0KwGWt8u0EPjIBdpV927O/URNZdIzoVsPOEPwWIEXy2MnKV59Bfl0ioTfWfyObvD90rICHjckWLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ho9J18VuI58vDWryLPP1Qbc4CKzBF0SrtMB3/+PolVXKAgLu
	pv9jCGPCO/WJ9T7U47QZIuu9zBwUwcNCPbsfnqAkb1d80bs0M1xsznXZN8saNgCWZA==
X-Gm-Gg: ASbGncuGtYjp5s8hxsS/CCuke2rBk7qnpKVtO4vn7ACfbIp8tx1FmYKqM0xB29f1+xq
	R6S8xO5DgIznYF14qH9+LqwkaPXqEumJ/wu6U7UYxuSMYeVl2iHE7R7Zhdkc3JvdfJpGKJBcmbu
	B3O63xAO7ULiLuqKhg8kbn0BJnrcATpcS2FHLyp0AkF1KkAfmeHwl2YBfyIJ3KBgAWiriAZiNjF
	kwOaNwrk7itqouRdhvgSUaaeufovockvLny70sIlev4z4bHrD1Aan/EKGgzkpdBAIyP4IMKWW+0
	pkp2WmwiEhThmZ7EAXi5SY/16Fq54CYBjgkz2Wmj6o0sqcGw4lScxUe+Y+LZd0a1fQ==
X-Google-Smtp-Source: AGHT+IGFbuTyCv6tgMm8E3JAfJ6kyMrUujqWjJTP9pTwNm1nU1e8K63D+WmdZes8QFKEikCi/Dy1sQ==
X-Received: by 2002:a05:6a21:9017:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-2188c2673f0mr3510555637.14.1748076671262;
        Sat, 24 May 2025 01:51:11 -0700 (PDT)
Received: from thinkpad ([2409:40f4:3001:8408:6765:3c6c:c7cc:8f5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5a441sm13882488a12.8.2025.05.24.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 01:51:10 -0700 (PDT)
Date: Sat, 24 May 2025 14:21:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Cyril Brulebois <kibi@debian.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof Wilczy??ski <kwilczynski@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jim Quinlan <james.quinlan@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <nt2e4gqhefkqqhce62chepz7atytai2anymrn6ce47vcgubwsq@a6baualpdmty>
References: <aDDn94q9gS8SfK9_@wunner.de>
 <20250524024207.GA1598583@bhelgaas>
 <aDFnWhFa9ZGqr67T@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDFnWhFa9ZGqr67T@wunner.de>

On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
> On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> > What I would prefer is something like the first paragraph in that
> > section: the #ifdef in a header file that declares the function and
> > defines a no-op stub, with the implementation in some pwrctrl file.
> 
> pci_pwrctrl_create_device() is static, but it is possible to #ifdef
> the whole function in the .c file and provide the stub in an #else
> branch.  That's easier to follow than #ifdef'ing portions of the
> function.
> 

+1

- Mani

-- 
மணிவண்ணன் சதாசிவம்


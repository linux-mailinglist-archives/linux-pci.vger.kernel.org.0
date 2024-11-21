Return-Path: <linux-pci+bounces-17176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A969D5280
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78493284089
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3914BF87;
	Thu, 21 Nov 2024 18:28:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1B19FA93;
	Thu, 21 Nov 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213710; cv=none; b=ZGiWZk316K0aIjTc9HSCzCw2a2Meh4Yk/DxSARo7miXyhQ753GIHkbaUEmFfOKBqLfRqnpkDcNDkYDsKyWqot+wMVhCDPX/zPh34uG32SrAOq8/ldntGIaLmVQOLbK+J160ozORtq/CL3+Z8IX0SiD5VNZxN16NLUwNnqlXBvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213710; c=relaxed/simple;
	bh=wzMBpikQ2npNr9/0hK5Jk2TmtPJk1ucHRZR7PwBRKrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnYpXWylaK60BiaGyuLgXA/cl2FfAHSgLSd1KPPIm2axhy4XncWYrIwC3k/B+6JsMgjTNjyZtNUoEm21KGC7Ao8kUxDrlhq1z/Gegdpa1jW+zs69g0W8tSV5gIP3Pt50CLRNz2j/MvrO6ZZLwRwyALR8uV7Uk0qrWQtCs+QFZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so1033942a12.1;
        Thu, 21 Nov 2024 10:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732213708; x=1732818508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc3puHzPXmkH4hov69LjVs0wyGCY6QS1VrIR+xpLSpE=;
        b=V49Ebu8f30AzuMSyi1kqd7tCcQqHlWuBmf3FWtS+1UccAKpYqWEygmqpgHYnbhuXw0
         2B+WyKUkjFZNkE+nRldLvGtb/rdnFrY7jj3ibwv8KbQTZVL6QJnW0CLbVGhJryxKV1WX
         b2PKqRIe/89c+6qG9yU2RBZeLCbqLlELfsAv7zfExI4aH89J8Om7rGeiyp1UG1OA55Zx
         M8TVSXWoUZzZMjY8v8r3AdYAkCPdZeyq0YNhcPdvjg+hLBicEOjizJfvJiaTnAM8ACz6
         B6vykBOvrVRgQgirebOqZlWy6X/Wpsh7sF3mrj8afszpSgnLNQRYPMJualysvPit0kwP
         C6sg==
X-Forwarded-Encrypted: i=1; AJvYcCWhEUzHXwYmiYtHMoFvYqALr/PL+6vkxHLRYBeQoZSxA+CmrK3HUwxroTo255fq5tCNOXt05E5Ljf+j9XI=@vger.kernel.org, AJvYcCWt/CcDBH+HaSXoVn/UQnB1vesrzrZwlpF/gDE1mlk71dDXz0c1fRlYdonH3tZLWm7fvj/hh3Vxh1lA@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7gcNw0UrLQPG8fLHMeAL2k67ZIiSYXlaSYJHa0LGy8Zik459
	2qXx4tPQ/di6yHNYzDJee5lxbdroenJuDVGnRgiv3i2+4v7kWeUX
X-Gm-Gg: ASbGncvx+zJWtMsToRC18F5oxHeq2yv1WKZqiws1B+7GOUKvknrAwcw+P3gtRD7pvwO
	1ObjtS1u+Im6FpD8LSdTMHJ98RkVPaVIWk7zP5jaLRv5EstbcIKfRmohuOAYNFtJohbk7ewyu1p
	LJZGsm8Vk1g1FMh2TmDGVwBfk7QDffo5snsH3tXAkYnTEA6ZiEA6fIKtM6YoXR7Z4KuQXMp72rr
	D1/bb8kmci4f4vWRGK9As1DqjS+ubafo39RXlUJHNap4lu8DjNcJb/eZFZIpsS2tAgpo8wbP/7Z
	l5TxhPs7
X-Google-Smtp-Source: AGHT+IG4+g8fynFdOpAy//6pxtRCSM6qPyzx+6ZR7M7ejU5HZbYGyTtUqGKuRNecnqhLTbOVHAhvkg==
X-Received: by 2002:a05:6a21:4d8b:b0:1db:dc67:1827 with SMTP id adf61e73a8af0-1ddaebd8dd5mr11513731637.25.1732213707724;
        Thu, 21 Nov 2024 10:28:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de478f71sm71919b3a.58.2024.11.21.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:28:26 -0800 (PST)
Date: Fri, 22 Nov 2024 03:28:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20241121182824.GA69684@rocinante>
References: <20241120170232.flllyqcycsrsk6cj@thinkpad>
 <20241120201839.GA2338274@bhelgaas>
 <20241121120010.zjmo7sun2j7w2f5r@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121120010.zjmo7sun2j7w2f5r@thinkpad>

Hello,

[...]
> > -			pci_err(dev, "failed to add device link between %s and %s\n",
> > -				dev_name(&dev->dev), pdev->name);
> > +			pci_err(dev, "failed to add device link to power control device %s\n",
> 
> Maybe use 'pwrctrl' instead of 'power control'?

Changed, thank you!  This makes the verbiage consistent with other
messages, code comments, etc.

	Krzysztof


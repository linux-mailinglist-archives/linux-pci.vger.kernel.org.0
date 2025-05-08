Return-Path: <linux-pci+bounces-27441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8891AAFB29
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0FE1BC6E24
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D27F477;
	Thu,  8 May 2025 13:21:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EE450FE;
	Thu,  8 May 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710463; cv=none; b=IaSSZdJRF0USCksErNd8ibJhAeDUtUu8Sv+KDpuRZPIXY069Ze+28iTADgvr1vs5rer9JH6eEiKacrgcd1OqR4so8c7k/XbDqHS19NacTYKQ86vYjjyxvgDT65Z0cItNHoKrjV/v7pffeHOyanJxVDqSVqIfpynvCLH+qzXAJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710463; c=relaxed/simple;
	bh=b5U0jdehZzjyw4oH4Xog0i0xxIDE6KzH2wpCe0BbjOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS5/KYcWlrzTtJT11fliMKWTDAu9OqNOvVu1rH3riC5516xfdn4VZDm2AhFy1RlcxIAMhRRGxYLG8AZbA8/lWBiuXWS/fGDch89kxWSohkjPmYJdHRjVZq4fMJ5OW1g01CRegrrM9M3oAkQs5dEBRDF/KoIpNpLUrZwBm1bOuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c3e7b390so922277b3a.2;
        Thu, 08 May 2025 06:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710460; x=1747315260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHunf5/QTJWew5e3tkDgi4bNl0uijCDmlABB1Q9DUy0=;
        b=JPGGLua567RA0T4clJ4ZT6KtMaKTwyxv3uHa76xf4dHlY5OGNvVDTjgCpa54AsYnYT
         R0WtHe84/Fm3mLfS/MUJYw39Rh4o4AbTnYW64U1Ds4GkOt4Xr7bBO1Jk4I7pezeGOQy8
         KP7WcsJ5QS5go/G/5r5hGFqEk+pbnUMf0Nee6KztzZzIRaLddVbY4DuAv4+T/GnYY2Mo
         430HFWCcmLsjh62trV4sALNLV3g/nn1p0dYPAfXZiO08dqLVM5BfoSAbV0s4jynLe5O5
         yaoTmtA/Fw7QL4QxqcOLT1Kzkd0yRwlHuQFk+Q2FF6g4s2a0yhCbQm+x/fB905D36iIy
         s7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW+388DMYyfrKZmj1nC3mTPoPOd9fH6ib4qKjdKGOvVcWRTtoacpenagYOz2v/PD2ycWWWjwKxDOTGM@vger.kernel.org, AJvYcCWNkiWwqmjvUnHROF7quGjEQXnat8MLZRO8d4u78TCVQrBxM5lfZCqOxhytQx37+h3IGCxZuFUeg82KJE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeV/FmNbaxy2XyMaMjRcoiBzVbmn+E7/01a6wqmNx8GuIvAlfr
	l79NvicM2J4YEom5IX2J9SkOyHmXup19SgRucbQs0wKk+HCHyKSZ
X-Gm-Gg: ASbGncvueVns4jUdMl8Ak9y5HSna4mgK46gBRskTLV3SwN4o960t+9jUJB+yYAmChfU
	FMAPSBdAuEA/UTjmesDPh+DrcV7hbjaQz5VjT6skzfRmVUhuIeGfz4ZlvL2tuOPu/h47lUtn0NB
	Rji1RG4IBJcK/1m34xFGvixlhj+Bzo80ZuSo7f3Ch+2eH0/sHQ49H5rPmC3TvddorJ3lPe5xk8Q
	f2SQR4ZTD+RNvUDLXVEAvi1xEb48+4ezEBgv1tMQfRfIxIYew3eW5wYrjR3NdHf/6l7jlqal6/N
	2+KXNcS/QAsLeBY7qiClfDSpBVmOOoxCV/+n4kL5oaprnQaVwv1z8qDhEVYWpSfQflApQfQhj4U
	=
X-Google-Smtp-Source: AGHT+IHA1WtuQA1TLHx4EzuVY0FM9Azk2vtubiVKpuEkCb5BJpliP3/GJfhlO4nOkeFq6hHgVxVrow==
X-Received: by 2002:a05:6a00:4acb:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-740a99aa622mr5064364b3a.8.1746710460570;
        Thu, 08 May 2025 06:21:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058dbbe25sm13685875b3a.59.2025.05.08.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:21:00 -0700 (PDT)
Date: Thu, 8 May 2025 22:20:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <20250508132058.GA2764898@rocinante>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508051922.4134041-1-vidyas@nvidia.com>

Hello,

> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check for the Tegra194 PCIe controller, allowing it to be built on
> Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> by requiring ARM64 or COMPILE_TEST.

Looks good!  With that,

Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof


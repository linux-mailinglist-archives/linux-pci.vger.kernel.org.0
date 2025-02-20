Return-Path: <linux-pci+bounces-21902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A6A3DCAA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322EC163629
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31B1C174A;
	Thu, 20 Feb 2025 14:24:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F51EF0AD;
	Thu, 20 Feb 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061471; cv=none; b=ACtSCnYXsgN8UscZS1Nxivu8Inx5ygH74j5h6xlKw1+qGRmwnw9TV6cTIZyYOZ/kHU/YKvA/4+QPD0HtUWYGZXTU6QpfwEDFL8bFeszE1v4e2VQ/mwfMLAsdoJ99qMZ5lal87pHp675hHy7Lul2cGgH2ofy/Mu4BSo+rg/AS9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061471; c=relaxed/simple;
	bh=5FmzeOvXEn61KTC+2HWup0o8sdMfDH6J8cL2SvlWnI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+6vu7l4dWWa49LiyuDQ8P2Blf6bbYHpMr4LdBZXEpgl91I48VkZnwGBTTlJTC/IQ6z9Nv8Qw85EAp+xCy45B8GOLxHRmGg7hatI+tr+aw2mwGQdkdKPcnB+yfOsEjfxOl9A5SJopYS+eU/POa7XlCycwMojftttNHQp/Na6VkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22104c4de96so16078705ad.3;
        Thu, 20 Feb 2025 06:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061469; x=1740666269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZIppiUhdCegkGeLQ0/SgLq0DHbP/ljnvKte6a5KKPk=;
        b=iSk5k5ztmloswa5+axH3Mq2LJHtpwiFdFJ5xJLMXL7OZDorz+tBGipwlOI/B1KmqD9
         KeiqKYvL0ebEOxX0BryWI7e+9Bzah7NwHvAiHtuMYupFXzBAHiVCR14yOzHb6MR+TnOV
         uUiEBsLIs6Xzt2YxLFTqCCbfkwtuWuseNo/9I1dw3XFuPQfo3U+hYFhPtF9q57d27Oj2
         m3OMmEB5J6TJNfOX5fivSXqsqG4cCYUdUU3qaONVrgzCg5RlTOoHR12xUny9mGJQKdLS
         0LPdLfUd5eGLaIiaCACO8VtibCT9hRncjfZ4SRqLkPNM+kSIo+ZdhYIb1144SQrnfOea
         wgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQCDVGj1BDIW4Ceiq0nmPhLmHZZD+QvghFPDqAGqePlNZ5jfmz14dzpe+nCflk5tu+HphXgjzhvbO7@vger.kernel.org, AJvYcCWHO+M36lBWrX3m6HTXZ7oJYoX/65ltOH5rQHItdtrxse1bpwm1Cg1P52TguV76gAkuO76QEqEWaslmhStt@vger.kernel.org, AJvYcCWq+zlL/VQuyMNXXSIs2Y6wkNBIxPqcbou8ZnZD4uA+XMga8AU4DTqfrcn7gZQqTi/rVjr/v019892a@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYrx6RKz/MRsHPaUPrvZgQhv8fMdVKCXkkFjD2FJH4QIi2aGX
	Esbpxsk6GXZDmrhgLKddKb7ZOsmC5B/EGmbBdYIqdCvnvKomcaaS
X-Gm-Gg: ASbGncsEudut7mjvFWO0zMyuHU3WGe5J1TL7rLWeuK9i7FWPBzxDFqJupcD8Cg2XFDD
	fa/KVzt3L34OSvQ/stdcRNIzrVuA5IEys+1hcECnidy4MJF6+w1RKxWoPcgxJJrmJITxOT/WJ90
	EIpsCVz76tJ80Lrxz793oLxb944ZUX7Cc00pC7tiR4Krwb//t+0GY4NG1zMJhTsRz/wGgOXnvdb
	8t5dXZ3bDSyGkbLmm6ot9LeGFrp0y3FGINE4F6uHovdKPCBC6a5jTbaIknhh6N7FcCt6Zpd4z9t
	ZzcFiCfoRhBi1mx6ELWincjZo95k1UiZB4yVKuSffPNkysudvw==
X-Google-Smtp-Source: AGHT+IEqHWvFyD2pATrLa8n7cKBoH6VgewNPY03fmxnWu+gC1tc8IFEe4lnDQmi3qJeiAbRkUmwmgg==
X-Received: by 2002:a05:6a21:9999:b0:1ee:eeaa:919c with SMTP id adf61e73a8af0-1eeeeaa92c3mr1886839637.8.1740061469230;
        Thu, 20 Feb 2025 06:24:29 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568146sm13851313b3a.47.2025.02.20.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:24:28 -0800 (PST)
Date: Thu, 20 Feb 2025 23:24:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 0/5] PCI/pwrctrl: Rework pwrctrl driver integration
 and add driver for PCI slot
Message-ID: <20250220142426.GA1777078@rocinante>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>

Hello,

> This series reworks the PCI pwrctrl integration (again) by moving the creation
> and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev() APIs.
> This is based on the suggestion provided by Lukas Wunner [1][2]. With this
> change, it is now possible to create pwrctrl devices for PCI bridges as well.
> This is required to control the power state of the PCI slots in a system. Since
> the PCI slots are not explicitly defined in devicetree, the agreement is to
> define the supplies for PCI slots in PCI bridge nodes itself [3].

Applied to pwrctrl, thank you!

	Krzysztof


Return-Path: <linux-pci+bounces-9868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE492904F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8CA1F221E5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BCDDC5;
	Sat,  6 Jul 2024 03:24:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AF17E9;
	Sat,  6 Jul 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236275; cv=none; b=c4Z20DuGV+U55zLyHSHaHf+2xrcKMdpitwD7Yblu3N/o2dKHJwscxDeBNrd9e20e+pTTW3vcYATKOuT9N/UY5IB2sozxM97tzypOCU7nzAYZWYa/4Yfja0r223pKPvtzj4hOFinnSQg79XReq9LW0POp+1t3uFv8OwmAiIJEQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236275; c=relaxed/simple;
	bh=Hb5PgMHh9aLvQi1yuVN4GWqNjsdDKqaYmaMQZ/b+tiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtL7SxBXQrEKlXAGrsxofzGCTaURQ7tV4aS4ULdZN3RqY/whhoEXbgaQvBDeXhWGuBPPaGtTQenENUjydfPRPiP2LdhVTDTThL4DT7zHw6u9kYmjyAlMf2E1BggDxj1pIiv83hKAQphTYi269lVqjpTH09QXjEOtUQ2wfyZUiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b04cb28baso1610412b3a.1;
        Fri, 05 Jul 2024 20:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236274; x=1720841074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Pb7EbDUVGH98ibgR3s40PMLBJFydYTcIKO50p0umcU=;
        b=ViQQA0zXMfFeV+kehrvNxYuL5r6w7+rYSNo72nfxaoGMgLFdHIRaQA8V/hnl5UO8zo
         swRjMlpsm6dGN1Wjh3+IHgicFWDj5O4mRcZL3x1xqBu28cYKGRUHRZYBh09v+LvCz/Ie
         LsGdbEsZuJMfANiG104uv7gCOpzlUBYDt77D06RkhGivOiYNjFmG7wfemquqMrLeuQEg
         Np+dkYOs4lcy07OeEfrBagV3KlnJ8AoaosCgk1Enw3oD8zGZTRLWapSknBNStVYfJP6C
         1NepLgwsDqDFBQjQIelAU+vJpdWJA46hQ1vRt0Oy3bH1zNiLmrfOUPoxy6OMcPXCKdy/
         e/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo+xiviyzpPf63Eqtu3A3RF2Ebtl2ZPPvL2MoeXssPcBNumwGnBhqAUeg8ePxhYutLl8QUzXECAGialteCLjgAnFC4/1wm0NkA86eeif1fp1F1vXitb+yDZjq34TGuAWxmWjMBuA==
X-Gm-Message-State: AOJu0YyKMsrfhidP3twH2YwBW13KL4lMKsDkSG+iqxo1C6GfN0u3OnBG
	XWJftwOv1D6NhTJt2a9jzs1OmNC8vFRDQmzAKk8RKOhR+GHXd3uq
X-Google-Smtp-Source: AGHT+IFURMNMv3i2QDNgjzV+meNyec/XNEWMDIioYfNtMKTQgCJfyraBJJkOdc75XnBjTu8O+vWrCQ==
X-Received: by 2002:a05:6a00:170d:b0:704:24fb:11c6 with SMTP id d2e1a72fcca58-70b0094a6c0mr6154295b3a.12.1720236273403;
        Fri, 05 Jul 2024 20:24:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70afeb4186esm3967297b3a.41.2024.07.05.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:24:33 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:24:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: generic: Add ats-supported
 property
Message-ID: <20240706032431.GH1195499@rocinante>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
 <20240607105415.2501934-3-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607105415.2501934-3-jean-philippe@linaro.org>

Hello,

> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex. An endpoint with ATS enabled may send Translation Requests
> and Translated Memory Requests, which look just like Normal Memory
> Requests with a non-zero AT field. So a root controller that ignores the
> AT field may simply forward the request to the IOMMU as a Normal Memory
> Request, which could end badly. In any case, the endpoint will be
> unusable.
> 
> The ats-supported property allows the OS to only enable ATS in endpoints
> if the root controller can handle ATS requests. Only add the property to
> pcie-host-ecam-generic for the moment. For non-generic root controllers,
> availability of ATS can be inferred from the compatible string.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: generic: Add ats-supported property
      https://git.kernel.org/pci/pci/c/631b2e7318d45

	Krzysztof


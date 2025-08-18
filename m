Return-Path: <linux-pci+bounces-34187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB7B29D5F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5961886DB6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B430DECB;
	Mon, 18 Aug 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9W1K+cT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19463277CB1
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508420; cv=none; b=iGNYqugW7MTHmHmR+AEHgemqtsxjVNkXcUBlZ9x4hzxvPzqzfB4XfaiXa1Ls7j5rvgVt3ZNh+EYx+C8AMutTJF/5YbH75gTdr45HqScpJYTpOfxLwrIbckMj1jCjBjTWDzLFh/OZ0IMh0xT2xuVzDhNYF0u1Oh0QLfdx4J2B0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508420; c=relaxed/simple;
	bh=xelw41k3pm5cV8Se8ISfXTeVZHnkMuKVO9e05eqy3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4/eTWQApFaefWmLLbcARakieb577zUvg57glW5FeqKRJMp7+ycRgkQ87iqStu4+jx7YwfqsdJcs7zOBExouwH5C+dZAKgXMuP1dpHP33rSEt+QcCswFBlxMawqnWG/b2d1WY/+9G5tO0AsWTOQTwWIkDwqj/Ck04nJz10QNpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9W1K+cT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445826fd9dso43212135ad.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755508416; x=1756113216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=C9W1K+cT5ps42o3H9HzYBnM4SPO26FQcXEVBikx9EfxJIgbUgTjQh/A1vVVVo0ipZw
         jTt85Q9ciyP1y5VGy7QLDV7ft41Qzb4FfkkXL3slsxH1+rlgiDc7Xd++nU6RtiIoBPKI
         L6/Rzr2zHDjL3GN5WoEfYPn1SYFGiMQULulV2qc+3FERwucLibJTdVxqu9RQyaQyeyf7
         wbHN/lijD+5af2eb/dNiOcq+WDmqkixx3thL2CRhLntiTtBcNkdvGms9GTQMmAYWsuCR
         xfu1AfjnzJsrrzFuL8m3f/Sggy3ty+PKgb3TTH8tmbLWYYOWRQHDH3z5+ysD1MHb8l+3
         8ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508416; x=1756113216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByAqf7ew0qsvJFSkObrVJcMa/hiCKQ4k7aVcvlUbpt4=;
        b=CquLegW9/o2oYnm5/vx7/Z1zkuUUEpiPy28ViF/DITX/fAq1D+n3mA1a0GC9RkG+2U
         G27JR2xu7HlsOXDpJ/1skZhUUZmlYqfWgeEvWMKiK1JTxe5Gua0T2pFO6N/rDgbKjcH0
         3p+NFckB8UvXC+IgKmZblPH8mJPTg2uoUWxsnCu2GzSHPGm0pg1JpNdKSvlEfvFZoVZ6
         CD+48l5ZMLn2boj3K/I796y9zW4BIlwhiar0rKUCZqzzahThBcPC+ClEpfwqcwoPFrkB
         Xm4AKCe0KkunZOE0mOOvPxJ7Jr3DGFlsNmLijFW5vxioGGrwWSsLNSn3ca8bNWuNLRBX
         kcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS+V4oFAaiJsaxpIn5mDElddL5H2eaR69qMMUkbgaQSeGlwsR750aj8goWT7EX766kedemLWoOi64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45bINOAF0ZVe11PFhG4v48dJE8TNHzMCB4ZmHuNPZEZQ4gIdD
	rMNuPP0+8buT3c4wgKS9FOEHUE3/1eCfkRN5JzDuXiGkNuop29W/p3JDfXjKxUAi7Sw=
X-Gm-Gg: ASbGncvsxrNDCL68xM6VAI93Lidfd9EreDjdkiMzEdaN0JMNHWChDZd1PFwIhF80TuR
	VGUkpzP0jF1mCQmdmZ2wfIY9o9x3s3QG5fYEarixrrLksAewQOtNml2pWmtjVju4hrhCL5xlaQm
	YSBtTyJfODdQlhrQhogDWUfWSUMY24K41fNyuhfKiU1vCHDFGKrUHVjt7Yto9LDiGYBRjLf1ALd
	33z07IOZr0LUGU+bk+WA2SudiRsylqPXJdA/zjWXxTmfM4IJ+tJd2acZGqiqnbQdnNtr4oWNVWC
	OhzazCSxSEZfXLh8lr9CXLS4KLxoKTuLRkbv4trpGUsy0BnE7MfWTJkN6Zf6n4jpoif+cVkwo/Z
	mzWzxkjpxVHUC6HvaN6LVHhup
X-Google-Smtp-Source: AGHT+IH4KDM7M4CRQXVnB3k6j8efu5yywyMexkJLQg2z4smAorz+ZWupNwv9P9EteJCL5oCvCbiASQ==
X-Received: by 2002:a17:903:1b04:b0:240:150e:57ba with SMTP id d9443c01a7336-2446d6d33d2mr159454275ad.3.1755508416372;
        Mon, 18 Aug 2025 02:13:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c4d680sm7505714a91.21.2025.08.18.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:13:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:43:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818091333.qlbipfkg2hasdzwi@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
 <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
 <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>

On 18-08-25, 14:37, Krishna Chaitanya Chundru wrote:
> I tried to add the level as prefix as that will indicate the PCIe date
> rate also instead of 1, 2 to make more aligned with the PCIe
> representations. I will update this in the commit text in my next
> series.

Okay, I will let the DT maintainers confirm if that is okay or not.

-- 
viresh


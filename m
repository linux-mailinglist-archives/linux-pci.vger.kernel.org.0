Return-Path: <linux-pci+bounces-19878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60656A12296
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F981886F0C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB420967A;
	Wed, 15 Jan 2025 11:34:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D971EEA5E;
	Wed, 15 Jan 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940843; cv=none; b=jl2HHnElhRBFqlm5kXs2wOIUgQZS+GHS8JHeSuhU6kHaZ+QcTTFkxDoqfPahbgE7RwmlWlhvi23EehC319oW14CDMv2qrTobh/yx/Cx3mgwWx59RsjoCFJoyvclUvuhVxxoh+2kjchK+RmEvdWinIvso2qMZpf6YoBG8h6uhbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940843; c=relaxed/simple;
	bh=lAiEBNayTGDW4da0WgLzFvA6vCvneaRqJoVHV9L2uSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ02iTQwIzVLhzFk63NfUT8TZ1DNYUowa3k3hPEsRYBoG06qQNEqUaxEo9XGuwvlV+3n8n1cVifhLr/1ZBhBQuMa766NvpQjGePH3PlXFwqAo6JySIDirJ2i7ZOyBvCv8ajGMdVDPB8fmHizxcBRFgGU5K/XY7VSXOSUz1Y+Dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso112253295ad.3;
        Wed, 15 Jan 2025 03:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940841; x=1737545641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT/v7v/ZhP1Oe1gXNKmpWEOBnV3Q/4yYH1W0mn6Z4Ew=;
        b=njv46tluzrxj8qNU1llo5F9cIGz42VCjzJabvWYZxkCZw/di+S5tp4sp3Cnbdcutfa
         OoOa7IiAw/lAADoOYyH3mMM8HYFu5McIDgD5Uy/oMYdMU+znqkn+JQRxSXbIS/csd/Fh
         u8Xsw6RRZvZBK7b0xseYlzJFTHoYuGitpjvf39Xb747QTAnw+xhtNfDaTH4Ed2/4hW+N
         qxaVxWogTT64upMA5DnLuH1E+55+7DzpsfmiiHuGvSjXyV+2m7PGc39w+NGYotUva4pP
         NjwPK+oo5YNCjTjiEpn0h1ZqRk/L1RwuAOkMt9ItcZIHIx/tR5zFYfS6/NtdzTZgOkXX
         6t9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB4TigPS+pTeJ4zFlzKj+9IdM356MprbZqmgytQOyNI/tD9da3qHHoEvWlzyjYEj7xs2ZMIqEzBURa@vger.kernel.org, AJvYcCUX9zOQJrVBHNORbz5r0h6GSqLf9o90WmaN17CPTuBNQdiwXDMYfS+sqGxjIagAFfj4Hz+ngAnVwvFmXeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9U/4Ku2A73a/UEDAahXl6HjopAiSWGZUj4WP2vm0nrIEF5LAQ
	XdG6yhb7xjj2mndSXAzzlG6uhYt2B0BUiwDKWtbw8ilB1YBZNjof
X-Gm-Gg: ASbGncsnaxi3iJAjw+zkY39I4a33Ot6FSGmvOU9QOC3qnMp34anH78kLLVgE56BA2ui
	CoZepjwDLu6H/9RJCFXXtZAdBYx2yYWmoQWq/trBaRmTYFiIKiw28FOPnOgcy9pkMSt6DI8Y7TY
	E/pEHvOUjhJiNpGqPlR36ifhoMhEHQ7LYpfloBhz+rXafk691i3225go9lZVMHbuAGjqwnzbBRl
	DjQOBrY5KuGXELMznlYtOaPJ4DO7J2JFwuVAl2FxbzdRnmdiRRM7qh1+Wd2HK3z2iGJkIURrgtY
	wZtazJoqz4Duqyo=
X-Google-Smtp-Source: AGHT+IF3ncfyJJ4wHbo8dW61YM7Q6SfSbohDD2GtZKlbQZPatS+OS4uMy9se+AnwGY6nzxZyX7BPPg==
X-Received: by 2002:a17:90a:fc48:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2f548ee4bb4mr41256309a91.20.1736940841043;
        Wed, 15 Jan 2025 03:34:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c20cfe5sm1160921a91.39.2025.01.15.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:34:00 -0800 (PST)
Date: Wed, 15 Jan 2025 20:33:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: dlemoal@kernel.org, jingoohan1@gmail.com, bhelgaas@google.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, frank.li@nxp.com, quic_krichai@quicinc.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Bug fixes when dwc generic suspend/resume
 callbacks are used
Message-ID: <20250115113359.GL4176564@rocinante>
References: <20241210081557.163555-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210081557.163555-1-hongxing.zhu@nxp.com>

Hello,

> Some bug fixes when DWC generic suspend/resume callbacks are used.
> Drop the first patch of v3 patch-set, since the use case of this patch had been
> covered by #3 commit "PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()".
> To be simple, re-format the codes, drop the first patch of v3 patch-set, and
> only keep last two patches of v3 in v4 or later
> 
> Here is the discussion [1] and final solution [2] of the codes clean up commit.
> [1] https://patchwork.kernel.org/project/linux-pci/patch/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com/
> [2] https://patchwork.kernel.org/project/linux-pci/patch/20241126073909.4058733-1-hongxing.zhu@nxp.com/
> 
> v4 changes:
> Drop the first patch("PCI: dwc: Fix resume failure if no EP is connected on some platforms")
> in v3, since it's use-case had been covered by #3 patch of v3.
> Add one Fixes tag into "PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()".
> Refer to Damien's comments, let ret test go inside the "else" and remove the
> initialization of ret to 0 declaration. Thanks.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof


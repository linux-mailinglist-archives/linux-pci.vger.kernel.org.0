Return-Path: <linux-pci+bounces-27627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF041AB500E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C53A6226
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E2230264;
	Tue, 13 May 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdQ0v7E0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F621CA0F
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129223; cv=none; b=XJVlRxMp3tUrfWJlCMtMaM8NUcQETNSdywpOwDK0rvtXKaIFONK/lQOZ9B5XlcqRj0wAI2SryRyJXXpXL54jJpGlYzkOR+e7Ke8Dn8gStU1hBh0A/8DTG7hmgGHawynyKOXvydEXl1GgqpQ7Qcy94NTcxt65Oc46DDjscksnqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129223; c=relaxed/simple;
	bh=y95+dDV6mcOwRPJJ2X0+bkbLdz55ei6Ti3x5ncLzUjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV3drGZlqgDUtjGbCTIum4SozMYc206gYK49DAnC6xenkIxJcVgpjkha4aFblFOQ6TLXXDPUHCCaXLSkZ7GChb4bA3d3xAsNZntJTzP7Ia+1WS9FkOJUgQfX3Cs8jhjZgqvW22mwm8QyNsDinTnr4E6GLAohHHPQg80G54qohPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdQ0v7E0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ede096d73so37609095e9.2
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747129219; x=1747734019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcH3NoUa9zYUGHE3e6RZVql7e10Z0H4w1SBFkELAfU4=;
        b=KdQ0v7E06t5F27WJvbxj1MXkA7ou3wUrhUXimfpLUCFJGSfXG+YCgXikTIimhiq65F
         m5nFetFlMyM+osZMWLjJ2URGxFXXaSYhM9E7n2hHhxeVPdQMNQE8vxa2EjtdSq0DPBBX
         NbakRh8OsVibDgnrIFsb3Q+CQyJmdKPNeXExpmTwWRgYNer7hFMbaJRAJ/SEpaQIZick
         FJu7CXK2B2m9R8KzFHUjlDs//7W7yX6E1APnfD4JTxRb+KLtdEmkUM94U/Vyo3qb2vhT
         rkumT1Cpes2/gMCh+3S+DcBfJVbm1AwhkM+MfWy1en9FPuPPnCJWGVgtDO33dFSVLYY6
         pL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747129219; x=1747734019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcH3NoUa9zYUGHE3e6RZVql7e10Z0H4w1SBFkELAfU4=;
        b=tz5ovq326RIZl898ir69dwmp7f2pXrctfhQBdeNIWY+EIlEVf7hf/YVCVnLX7SvkM7
         yPjKjAlx2Nug3KJWWcvx5dDsr+eb5XoYxGQ6CWiviW1QgvaJ5ObFSe43HGYdeGPShePu
         xnLJmMsCsnXfpIsfi7nxGugHOLZwU05AjErXhQz7mLdkS1tj2PjUTJCGK7QFvDiVY79L
         +LpOi8VPfIopdXk2ngnJ82+8bz3UEqrpyYZ3DSBKBVv2LpLXyPJnxkUPccHMKHr5LWrS
         QhfXwhHSoYGyl4a0a4ze68I7mQGLdBsw/HS14u7VJYOgayW+qPA4vybBV/CAmIfKm6GW
         4Rzg==
X-Forwarded-Encrypted: i=1; AJvYcCVUNqS/VBSE/qd3Vr+ceLB5bZ8ePgZ3CK7CjP0yS4WVM1dtBeOd5ephq/EwFIJ+NBOxYADL+fRxG9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzazLkfuW5mmD71L214iKfsrQM6Uq48kQ+k5vBnlGEkxJi56iQc
	ncEac+FCi3tBGDtEui+wgUEu+aKsLAzEWpRPkEm5uzTKGu4fgZ6ikP713vl2Yg==
X-Gm-Gg: ASbGncsRfd3hivPLJMtwH/AOD7ojZac0xcLo2fRJM0YwcZA9tvtNafUpFIHqg4DS59A
	U+p2fsVwPF4vLBguYH4eh9op4bMYUhA/7SZ5Bs8pXMpawnD1LVqf4RMsJ5M9wmVD8nYz1KNHWql
	kBcD7yNmBQ1/HgV4RUv1YUgRjfE/mBqJhnYGnB6qa06Qm7Z4Yjty/mIMhIpuWfTS6lGa313Exem
	UfGshajRSL6aiM7oAhT87+KDSugSSOvpbmhEs/jYSd8hwMWRKtceilFDge8xgdYmNFpnQkcTjV8
	stoLmKDvrTEBFCzAfSgx6XmMziLzHfQJvnzjI4LM+DzZqim2ExAq0bYXYkDYrcNNI8Ia+dUgJJT
	Kl+WvTw4GJ4ngEQ==
X-Google-Smtp-Source: AGHT+IEnFcdOdVeGZ05hT5lYfCJGIEriQAJ/H62kZzWpWG7SrRPdhYj+LEeG7joQas8peUF0EQqhBQ==
X-Received: by 2002:a05:600c:5118:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-442d6dc557cmr110195405e9.25.1747129219435;
        Tue, 13 May 2025 02:40:19 -0700 (PDT)
Received: from thinkpad (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c35sm160428035e9.5.2025.05.13.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:40:18 -0700 (PDT)
Date: Tue, 13 May 2025 10:40:17 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, cassel@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <k2ralcw6ynqfejsyk6z7vdodhbn5gu37gqkt4x6yzs7t2y4h5s@6ag7omevjfl2>
References: <20250510160710.392122-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250510160710.392122-1-18255117159@163.com>

On Sun, May 11, 2025 at 12:07:07AM +0800, Hans Zhang wrote:
> 1. PCI: dwc: Standardize link status check to return bool.
> 2. PCI: mobiveil: Refactor link status check.
> 3. PCI: cadence: Simplify j721e link status check.

Please do not paste the patch subjects in cover letter. Cover letter should
elaborate the issue this series is fixing, its purpose, any dependency etc...

- Mani

> 
> ---
> Changes for RESEND:
> - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Changes for v2:
> - Remove the return of some functions (!!) .
> - Patches 2/3 and 3/3 have not been modified.
> 
> Based on the following branch:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
> ---
> 
> Hans Zhang (3):
>   PCI: dwc: Standardize link status check to return bool
>   PCI: mobiveil: Refactor link status check
>   PCI: cadence: Simplify j721e link status check
> 
>  drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
>  drivers/pci/controller/dwc/pci-dra7xx.c                | 4 ++--
>  drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
>  drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
>  drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
>  drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
>  drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
>  drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
>  drivers/pci/controller/dwc/pcie-qcom-ep.c              | 2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
>  drivers/pci/controller/dwc/pcie-tegra194.c             | 4 ++--
>  drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
>  drivers/pci/controller/dwc/pcie-visconti.c             | 4 ++--
>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
>  21 files changed, 37 insertions(+), 56 deletions(-)
> 
> 
> base-commit: 286ed198b899739862456f451eda884558526a9d
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-20670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA5A260AC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD24A163381
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74520B7E6;
	Mon,  3 Feb 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtRP0gvy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EF194AEC
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601981; cv=none; b=ul9X/4WdMT0bXC8+U1hnoNZe5+ZQaJnkSGaNb55t0nbDprgruA8C9iYqb+3Og1ssNp0TgTzvR9HbBE3DYTqyjtvztWvkzLvcerahkwQEIlUDhWbBKYl1jYIwWfmZzgKsb+Rkb+OpJNuds83lLS1gu5IWAvCRaKY2lYK3O77SZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601981; c=relaxed/simple;
	bh=jLGNywigFGZZFI+a00xhq8nTW0MVgJVmbi8nC6Ol0N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbl518+kGMmu+IMYlOBZ3P2eWLUt+bbL0f6BiRzwci9/gGRR1tLHNXshZqBzpNKEs9acuxLUOSxd+hEtsg97RQPPvbEGh7MPw4J/2XADfywy80KWKLVh+fJWSa5OOzLUSjcEcs4A+nA8fT0gZ7U4OGlg/WVzbSxGZNobwVgbU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HtRP0gvy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so99095565ad.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601979; x=1739206779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zrpvrygZLQjrM3HtWYch8S/JxCN7cSqyUAsI5EVA/A=;
        b=HtRP0gvyOvxPkm73VDUpRwLIdMOMpkd1+VQWm26TW6zQuzm+kcxKQMi1lpUkcA4oKW
         2hxIIAPyKQvpS7UlJB7QKo5F5TVL5IGvJdUl4DIsxTh8xEvEmxuVRYliWpXHQc6tdswH
         kKEuN/UmNF8L+fHvIYDJaQI7yrJBHt/HW8J5jCUgGIcg/zQ0LOfskpp0jXeTlo5hZIo1
         wGAs0rcDtUG/vY/k02GK22BzBVYDnaJKfTcYXi26SLGrmI4/BR0ZAANN8MivBs/KAmA7
         1r2lSrAuloaum9TA/C8R0/JuLL8+PjLfB11r0EC0ktcJ/+c0QnJnEAuzVsTcVdstRZ8W
         fm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601979; x=1739206779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zrpvrygZLQjrM3HtWYch8S/JxCN7cSqyUAsI5EVA/A=;
        b=eN4CIrf2q9Dn3MBrYvS7GvLvL4YfUs21p0RC11LDXVGsVQVnxou5STm2cWH7e/NUVh
         MOMEADHuq9rN+GwUtw7qv+bMV2OYHM6RFoW5G/rEeyG/EPfzXytjQ2UH0jVnxW84fiXA
         L2FEicFukIyzsI7n74ZgYJvNmMs5ujK2XvN+Q+ebMVFgeVcJ4RPa59+Ymi3UTTrb/jn0
         y+QzfWiAUGgnGOtFRonBH5scar3Ut4WxXbBsX0j2tXcRFNahqSRNOKWLt8otiaZyoesl
         pwSc3H7AiKqD8yk1PlAer9hBGGWMUmD8/zJ8B8+HpTPlLfMzDIHL+4skK3Ks5dw6xAwB
         ZtQg==
X-Forwarded-Encrypted: i=1; AJvYcCUNh1oJEidKogb3bjF8dySL7/xIhloYdFKjPmLURPoMlnWAl2T/nMNMyBCXUto7jhMYuKVIjtoV+HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXd008AdYWe1O2lxrlmFnoirhAETj4MItUcanvJCt8x63buF2v
	jFjd4PvJC/Vv7giJspPf+Rdt0j1/kw8Bh21gQeWxtyKtmd0tMJofLFSx00BwVA==
X-Gm-Gg: ASbGnctwCcByYUqi1LirQIpBmvBQWAfQ1Wa+MBnNB8StPib5VrIU+lNoeFjUDK5NiUx
	JwYXCg60NIOqH2R/21P+4D/q6uR4JsaWO366qBg4BEKJjDC5mxP2TldkoAI8o4mN9a2MloL3Pvq
	6pw+L2nUF2GhSRTPlME7aOlIncktrqLfO+Zg7U/j1xg7AdgJqC+Ohzkbfs6sDJDjb6pZw1O4RMD
	23fhKe+fn7CK03jLGKqMuFii6aT+qUzM3EzZwDQ2fi9Ixkrg9CuJ8ZQTLtxgm/vg5bWocFIpCwE
	jCwfNkfzRKnX9Ec9huzqESklvQ==
X-Google-Smtp-Source: AGHT+IESJb6dkF+TVNR/mG5DUGCPCXithT7+mpqAigDM+8DjF/8wG9pZcbrD/g8CmSauk865rcWZrQ==
X-Received: by 2002:a05:6a21:78c:b0:1e1:ad90:dda6 with SMTP id adf61e73a8af0-1ed873bed0bmr31925457637.20.1738601978734;
        Mon, 03 Feb 2025 08:59:38 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631c021sm8603327b3a.6.2025.02.03.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:59:38 -0800 (PST)
Date: Mon, 3 Feb 2025 22:29:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <20250203165932.72kezmi3dtqpytvg@thinkpad>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5jH0G3V7fPXk0BG@ryzen>

On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> Hello Vidya,
> 
> On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > Add PCIe RC & EP support for Tegra234 Platforms.
> 
> The commit log does leave quite a few questions unanswered.
> 
> Since you are just updating the Kconfig and nothing else:
> Does the DT binding already have support for the Tegra234 SoC?
> Does the driver already have support for the Tegra234 SoC?
> 
> Looking at the DT binding and driver, the answer to both questions
> is yes. (This should have been in the commit message IMO.)
> 
> 
> But that leads me to the question, since there is support for Tegra234
> SoC in the driver, does this means that this fixes a regression, e.g.
> the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> this driver was added. In this case, you should have a Fixes: tag that
> points to the commit that added ARCH_TEGRA_234_SOC.
> 
> Or has the the driver support for Tegra234 been "dead-code" since it
> was originally added? (Because without this patch, no one can have
> tested it, at least not without COMPILE_TEST.)
> In this case, you should add:
> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> 

TBH, I don't like muddling with Kconfig like this. Ideally, the driver should
just depend on ARCH_TEGRA || COMPILE_TEST and the driver should be selected by
the relevant defconfig.

And this is what all other rest of the platforms are doing. Why should Nvidia be
different? It makes me feel that this Kconfig dependency is used as a workaround
for defconfig updates.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-21101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C3A2F5D6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4163A8842
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5625B67E;
	Mon, 10 Feb 2025 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrXg5RzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FD25B666
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209786; cv=none; b=IaOq5Dox/sgysr5C8cs22yEBbTmCMgwahBPb4iOO4h23IOk2K2pyfnxiGfdNhjyYJekSiow2EPJ87FFRqpxL0LQ186zxYNNxx5Gf/X25o3Swe1d10jiJuYjXX0lo59rSzgmfJqt4VdQtJ3QxDcZxpqP/tdOeFEJJAFpqPswOX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209786; c=relaxed/simple;
	bh=j22m0TYSniLq2PbQWxTqfTlU43yWiOom13s0BrWEMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghL00oyH6jOBv4D6DXaFyVxF9Yty2Wz08GcqeO5LQ83qlY+3DtZ7z3Dng3aK8Kby+lc8pouE45NTHX9DLgcDJ64Ya0U2TgH4fX9YSo9C1UHXLNgUlHES+G1NgH/IjyGG006HSeJePCeqiV1ksrLkhJ8iC8nl+LyUYOaW5L9myw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrXg5RzU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f2339dcfdso74284575ad.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739209783; x=1739814583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3JvQMZsdHQaLpprslknSiWrQZhlcqffgdK8WGQxtqo=;
        b=rrXg5RzUEBcTxYi9sDu7Wy+moCkM5sscNiy9JeAHp41f4g3TaMIqfNkrgHba7thrHg
         lcjCnFJl0f8SHmZT7b/58o5LJ8CYZ9YHdyVPFQKQCPeVGi3bx4Wszdl9pl8Pr3tXpiz2
         GBIYFlhPOGebmSeHrmZCM47Lw7roRLfUOSSChQTNbM8xOEZ4sMfQd45O1qAP4X+S4YYF
         vF43OH1sBpUazGT/SDoZ/uw7k9V+tNTV+Ox6yngleF3ZNN2HfC5YM9sGbVjBSuOhtEnw
         AEoIv8EQCnMz+TlK3cjHRRtiLpPyaIb2/KasswLXA6vkAVmtBYrQawDtgrrDzoIwjlHA
         EACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209783; x=1739814583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3JvQMZsdHQaLpprslknSiWrQZhlcqffgdK8WGQxtqo=;
        b=p2bwPJA/JpW7BQDR3ceXA1glfshJiTHFmvtoKWTB1OR4cp1vROZLJvKlMef5phDEuj
         TkkhoouGr/2nkcgy1Bd3674X8OsEzL0Wfe/GROsqrMlChQA4anGTKO0eWzDfLMSHxN8N
         hwsjCJXU3vuFJYxB0Q/u+EyMFA9xEADWx1zXCZfA46wUzP4e6kvaHV+LBxe++IibaHRV
         VKmmV5Jm9r289qbyEsZa7iRh22qYsZ0YVjzwOR+l13K6OqcdrMxIZfOHLapYkYlBY3wI
         KAs0B2x1GL697LDU80SmWnBXqUX0ksVTH/1FOgq/LcVDVtGNYzyeo87sCa/8TryCgkPC
         crTg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIHSOoOj7/g+dBuUlKbJRUg+uY8zAzvPHiaLgP5vP0E4AKJVdyZT/AZhEZ3NZNlqiQhbWmApEp0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRK369LohpXQk4a6In5IQwCdsD8oPlu3DH79xAzSnh4p2tsGov
	i04icMXDstuEnQ8UkVm+8iQGe1RKp/dklOCf6PrBQBy+/Wpv0CoyhAhdlouCtA==
X-Gm-Gg: ASbGncuc9eEjqylkNyaxUvdXEaaGgTnoUpAiX1zAUQHiUTZXKIOmOrTlIByrh0W+mjA
	XaBKeFTfOgk3g9YaIZmE2jLv/4CLPzycwoq4HIC+1nVyGf5omuMqDYGVbSwOQtqd0E3pLSgDAyC
	5LuMgOblAppC7y3+yE9pYVySChReHcSpQ+YYwOEPuodytuMiWOL+qBvYlDYDR9GEu1QisoN6Yp/
	u6PHKGjqtcMUHsA9H6SVhnx40kr0U5NeheKSczKa87hJnwg1VGXCXwo4scTiBu0XcaNOC8F647V
	JjTUcom0ctDlAXr2OnVpz106TP6v
X-Google-Smtp-Source: AGHT+IGH2lPdRHK7Sv9IJsFAd/uOnmQa4ZfsqMz8gQKbymR/tJagN7b4+LE/qagYkGFj6uow/BIB+g==
X-Received: by 2002:a17:902:ce89:b0:216:271d:e06c with SMTP id d9443c01a7336-21fb6c026camr2943755ad.4.1739209783453;
        Mon, 10 Feb 2025 09:49:43 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653cbbasm81884435ad.79.2025.02.10.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:49:43 -0800 (PST)
Date: Mon, 10 Feb 2025 23:19:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thierry Reding <treding@nvidia.com>
Cc: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <20250210174936.oq6mn3czodmqss6m@thinkpad>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
 <20250203165932.72kezmi3dtqpytvg@thinkpad>
 <zaj4vcbduaoceaueqq5hvbw5rvoksk5oz6via3jhfp7lyzlxnh@2umxfxphupgd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zaj4vcbduaoceaueqq5hvbw5rvoksk5oz6via3jhfp7lyzlxnh@2umxfxphupgd>

On Tue, Feb 04, 2025 at 06:19:51PM +0100, Thierry Reding wrote:
> On Mon, Feb 03, 2025 at 10:29:32PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> > > Hello Vidya,
> > > 
> > > On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > > > Add PCIe RC & EP support for Tegra234 Platforms.
> > > 
> > > The commit log does leave quite a few questions unanswered.
> > > 
> > > Since you are just updating the Kconfig and nothing else:
> > > Does the DT binding already have support for the Tegra234 SoC?
> > > Does the driver already have support for the Tegra234 SoC?
> > > 
> > > Looking at the DT binding and driver, the answer to both questions
> > > is yes. (This should have been in the commit message IMO.)
> > > 
> > > 
> > > But that leads me to the question, since there is support for Tegra234
> > > SoC in the driver, does this means that this fixes a regression, e.g.
> > > the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> > > this driver was added. In this case, you should have a Fixes: tag that
> > > points to the commit that added ARCH_TEGRA_234_SOC.
> > > 
> > > Or has the the driver support for Tegra234 been "dead-code" since it
> > > was originally added? (Because without this patch, no one can have
> > > tested it, at least not without COMPILE_TEST.)
> > > In this case, you should add:
> > > Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> > > 
> > 
> > TBH, I don't like muddling with Kconfig like this. Ideally, the driver should
> > just depend on ARCH_TEGRA || COMPILE_TEST and the driver should be selected by
> > the relevant defconfig.
> 
> ARCH_TEGRA is a symbol that exists both on 32-bit and 64-bit ARM. This
> driver is completely useless on 32-bit ARM and only used on a very small
> subset of 64-bit ARM devices. It doesn't make sense to be able to enable
> this if you want to build a kernel for say Tegra210.
> 

As Niklas pointed out, why can't you have (ARCH_TEGRA && ARM) in Kconfig?

> The relevant defconfig in this case would be the arm64 defconfig, which
> isn't very authoritative.
> 
> > And this is what all other rest of the platforms are doing. Why should Nvidia be
> > different? It makes me feel that this Kconfig dependency is used as a workaround
> > for defconfig updates.
> 
> Well, it's certainly not used as a workaround for defconfig updates
> because the change itself doesn't enable this symbol. You'd still need a
> defconfig change to do that.
> 
> Also, we do this primarily because we've always done things this way on
> Tegra. As I said, for a lot of drivers it doesn't make sense to include
> them in a 32-bit build or 64-bit build because the hardware simply
> doesn't exist. Having per-SoC generation Kconfig symbols allows this to
> be modelled more accurately and if desired to build compact images.
> 

Well, certainly other SoC architectures are not following what Tegra does and I
don't see why Tegra should be different than others.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-11646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20657950B09
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0BC1C24D7F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E319EEAB;
	Tue, 13 Aug 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cix59MF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899C14D42C
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568586; cv=none; b=s3H63+nDRrM4jYfkGWNdP5lMnxaSunynoxjAYBL1LW1juQo2esFP4DyPXaIoZv2oe3xLyJU08K1U62ob1sKIhONqkhu5vb0miOxhFY/+AJBPvZeKK+nZXR0SfNkuIjH7BO2kcNXYF9KIL7M5KB3OUN4IH3Dk/5jeMnzERjYGhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568586; c=relaxed/simple;
	bh=+88RSkxN/H6afefxdGHCqq377VWT9vaJAn1EHtYr1rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+bDr24WuSDT7fObFkN87xH/7405rpFUTK+Clci41QvVivphEGoCmjF80p7QeGU+nNgRQxdzWDfTfZPLO6gwWqjYbJajBR6aGzXwof00W72RVBLP5Ae24nfCj6xEjaFU3c/q9utYQbUEBmy5wlJRodO4YC0vDGExaXd04Y8Pmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cix59MF2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so30733011cf.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723568583; x=1724173383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+N8UBYC8SKNdClQHm8KFeXbKwY6AotyQfa8NkNjLDpo=;
        b=cix59MF2KztqjLdVn/9d5dNvarncaW7dgQB9chc88q7HXhAVeq2OVgBQ3uaHjIDjf+
         8cIgXkVGWmx5WUxKpeklbUoxJ3zzgQrBru1ZsAdgqGmV7RUx3VTmWiCqyosEkSQD0/Rx
         SADU5UTYo7UBPRM+0aZW8qgBL6aPg2FLx5ivP+HTULtrIrJKfNgRrlOmmSFbQQT0WqhK
         XUb3Fzo5FRb+P/28i4ODTLBflfs5MI5lrEN52u3tY5SszGBprB3lIW5W2jzvcV40ELEs
         Nf1luP244Xr5LiDBNKL0WD0BsFCeHkkOvDXyK+JVxLKSc6V6OLXyiJPqSm2e8jwFulph
         jx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568583; x=1724173383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N8UBYC8SKNdClQHm8KFeXbKwY6AotyQfa8NkNjLDpo=;
        b=ZH2CUl5Ko0rucskfi6mhhpbx0cS3hb29wtNCV13qqOKcSnp1jh1Wl0F90cj8+kf9Xj
         w6MaR07UZK8jnVdPDCWu4QXzs5+yco4DSoZCG0lyWDBqdYNhssSCpdrSzyGe911SnW5D
         7rwe3ELrTidjO3SGPrb5VxEhs4Rshu59Pw3Lyuv4+8kvalOyC35EFsDKL5XyR5ljMZwU
         Q99UFWWRbf9oxhQGAihURCmVrZHDJf5iV1dZGkYO62Y9wQ3B5zqVePw44O7jGjNuT+rl
         P7gqjhwmFnL7m8LmYJ4VoBKmRsCw+b78nVKVCLBaOFCziv7oVjLjjDAULxAmCxdBT+Ot
         Ngmg==
X-Forwarded-Encrypted: i=1; AJvYcCV890qkrdST0Dp7yqcWZNw04X4KSu9btTqy4kIEDTC71izYTvgMJN2hQxqgBLxxjTDSLFDBU48qwrczvhpSMlgEl1yf7n9Ne73M
X-Gm-Message-State: AOJu0YwQsD2Mids8y/V3HBFVEWAgyA8yOxMJJTIQ2Ah8Qbha8utAqVrM
	fX+92qpXjB5/7teuG4BCzUTog9ozY7v/M1yadecGfut7n7uySIYadw4sEqGAJrDHgeXJSgcM8x8
	=
X-Google-Smtp-Source: AGHT+IEthgbcgoAs4AuQD1OxGgSkqwR6WBXoTTpYwsR/9bZNZTl31mk8MOD1vQ8KTchWQT15dBdhBQ==
X-Received: by 2002:a17:90a:680d:b0:2cd:2992:e8e5 with SMTP id 98e67ed59e1d1-2d3aab422a5mr123893a91.33.1723568572275;
        Tue, 13 Aug 2024 10:02:52 -0700 (PDT)
Received: from thinkpad ([220.158.156.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6c4dsm10810545a91.33.2024.08.13.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:02:51 -0700 (PDT)
Date: Tue, 13 Aug 2024 22:32:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240813170247.GA26796@thinkpad>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
 <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>

On Sat, Jul 27, 2024 at 01:32:40PM +0300, Dmitry Baryshkov wrote:
> On Sat, Jul 27, 2024 at 02:36:04PM GMT, Manivannan Sadhasivam wrote:
> > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > for drivers requiring refclk from host"), all the hardware register access
> > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > from host.
> > 
> > So there is no need to enable the endpoint resources (like clk, regulators,
> > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > doing DBI access, which is not done now.
> 
> ... moreover his makes PCIe EP fail on some of the platforms as powering
> on PHY requires refclk from the RC side, which is not enabled at the
> probe time.
> 

Yeah. I hope Bjorn/Krzysztof could add this to the commit message while
applying.

> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Thanks!

- Mani

> > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > EP controller in the case of failure.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்


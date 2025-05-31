Return-Path: <linux-pci+bounces-28761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89832AC99AF
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 08:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F0A16EF3C
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1911D63F0;
	Sat, 31 May 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBrMvwJt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039E2111
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674073; cv=none; b=U3Lo0RCEBYPa8mu2DAtMOx97wdxq8GPbYbzKH2urZHF1DWl5uD0BXlJgglsfZ85StHiPivl7w9temojr6vSpuf317t+7kH4xIy8HVp3BvWwU1Fd26FpPsAMpYjN+dsoWX3DTPg/9sYYwD5CrZ2yBhF0E+UPT51PQKJeDtOskJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674073; c=relaxed/simple;
	bh=AP+8l/VrWj5dM2p5TLYSBWT/LoH7peXQg3wUcRM7Zoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a45D7taudZm+TCI+G2vTHTfmJABIn2/hMqk8mVisrtaKEDL2dnnHPj0cqHsnDwYx2RK+s642tsbMc9JJE55QA5+F4k+u2XxUClrszXIwG+WeHBDuXQETJTbPGAqDd+UDA+IHo8No9h+eMm/ioOYpqPk3pRw4Y/fvYsb4PWN0sFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBrMvwJt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399838db7fso2557233b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748674071; x=1749278871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a5ZWLH4632Zz40l3FU4iRpheZh29+AsfRRhpH0NFHZY=;
        b=YBrMvwJtnk7LmESqfGrsJYckYjJ3nbbhzEljU3yxZKw3Jm8lnLcUE2ZSpm8dr3fu0U
         t1ucBnKVMSHn6Ai4OMrYVhQ8usiePEcYN2/pxhsHCsvfckUhG4qucFhVuHvopt/Unxq/
         CadnNMKPY88zkOLFfIVadApMDP5xpyf57y8O5beegLMxZ/ijukJa03MlNJKqGHE5Lgk7
         e17MvEfCpco7iDh8g8YMw8rco86EyBkIid3Sx1f/uvJd2DBdqkmT/L/H9pJm5lxZtyUL
         BZiESwE5OGG+dp2kDbvpeLC7R7JtKLDR2wYqeOkNbVLK0+4wVVNCYrHaRAseA6RNF7Hn
         lj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674071; x=1749278871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ZWLH4632Zz40l3FU4iRpheZh29+AsfRRhpH0NFHZY=;
        b=hHvSR2EwBZBFBHf123B6N3x+nyDTO2wrnKaBqw+Zzb6xcPV9yuAFFmUOcjnO+4Ck9K
         Fs08hLYqVyGcnFlZvFQHpyjoEhSF2vMz7T0vd7B1wnBYaeZPJRnJ//GjQ5BI0QDTLuPD
         YVA6nBebmR6oNfSecBexhNjDout8QEo0tt+iSNRdGmG/Cxbah4k+0ru+74am/RI7Cn4a
         rQIRb7R/quu+j2Yx6OgLQljd38nM2Y79ZzLh2lNW84mhGG4K9tPZTnpYhvKDXjXQP1MK
         9+yaFfHuppIaFmur0ipYytgZeXA9fIhl+2B05XdpghqbCyPCD5tEEwTCPEFQ/PlV+URb
         41iw==
X-Forwarded-Encrypted: i=1; AJvYcCUAhTkmnFSVAhAIsK3cGMrbOLZOR+PCq+zsX1UicNuIYxPbv4CkcfaaGWeLXcu4ctcYHsVQWZLl/ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMHjdYIXY3HDB/L6Ymqz7t/Yv48vH5ctGlEQ9mKHNyqtJjc07
	V3fNmfuKdxDBf8dfYYtDKE68Az0XZF88q03nY6pDXx1U6npbfhzAU5qWXgi9SQrrYA==
X-Gm-Gg: ASbGncuVXrmY/8aW+FKZDk2UQaVmjd1InJV2bf8Dm6a5wXmdIo8DHzaDYU1avsQmX+R
	uBtf5TYTzMxKSWkBa3sjaB8Zow1BjK0frh6kEUMi0K/jGoxy1jybtjffVXSWcPGPSSUYE4UWngP
	mVn2/9kEag6w3uj5os7uYaniiZZrCpBU/to7F9T+PRmsomDJefkfdmb2BOwHHdaba3sEv3BLQFO
	NnsyHXVdDu6MN2lRQENfn8q3GCwF3hxovHhJiG2ML47smcxP0o5mVBCcGLOEuzUGx8E3LuRORxO
	Xr+sp9jjvr97ngl+YQK4zisParhPg2PBq+rBO0fVtP2c6XTINJMHXJrXS20yuA==
X-Google-Smtp-Source: AGHT+IEKL4fPM3xoNxSzuxpYqv6nyVtXsn84i+gad0ylQKNT3LCGJ0g2SDcStXdW+/7FoA7i3aHggA==
X-Received: by 2002:a05:6a00:179b:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-747bdd85a07mr9014475b3a.8.1748674071613;
        Fri, 30 May 2025 23:47:51 -0700 (PDT)
Received: from thinkpad ([120.56.204.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe966easm4032172b3a.4.2025.05.30.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:47:51 -0700 (PDT)
Date: Sat, 31 May 2025 12:17:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <domwxd2beelpnuuzgbxuizqnfo24aekhtxsahodsbfkpc3n6fd@rahjejxklr47>
References: <76F22449-6A2D-4F64-BF23-DF733E6B9165@kernel.org>
 <20250530194347.GA217284@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530194347.GA217284@bhelgaas>

On Fri, May 30, 2025 at 02:43:47PM -0500, Bjorn Helgaas wrote:
> On Fri, May 30, 2025 at 07:24:53PM +0200, Niklas Cassel wrote:
> > On 30 May 2025 19:19:37 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > >I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
> > >from Conventional Reset (if port only supports <= 5.0 GT/s) or after
> > >link training completes (if port supports > 5.0 GT/s).
> > >
> > >> So I don't think this is a device specific issue but rather
> > >> controller specific.  And this makes the Qcom patch that I dropped a
> > >> valid one (ofc with change in description).
> > >
> > >URL?
> > 
> > PATCH 4/4 of this series.
> 
> If you mean
> https://lore.kernel.org/r/20250506073934.433176-10-cassel@kernel.org,
> that patch merely replaces "100" with PCIE_T_PVPERL_MS, which doesn't
> fix anything and is valid regardless of this Plextor-related patch
> ("PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
> ready").

It is patch 2/4:
https://lore.kernel.org/all/20250506073934.433176-8-cassel@kernel.org

- Mani

-- 
மணிவண்ணன் சதாசிவம்


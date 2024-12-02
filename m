Return-Path: <linux-pci+bounces-17541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA469E0A61
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67486B426BE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B702204F63;
	Mon,  2 Dec 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGB5UOal"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498C205ADA
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151580; cv=none; b=Wocg3oHD3I8qcCcVFdGHOARTQZWR7sq+8zIc++xy/GVGg5+ZluJwDgZFU20o86bvoGE3eq195LlS1IiMALtYPVqiBdggnaKTP5E93vUTR9oUfO4Q1yASxuNKmeLeWFiDN55K/nniRC6WwDEfelrSkrMP2bsf4ryXnPdeRKDCTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151580; c=relaxed/simple;
	bh=eoMDpvdSrW/IuE6tWQhPLD0TMa2/13xTFFot0aFscv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpuSuABwy+pTtS3O7MhsaEXBtLVfNDT2wd/Veg4JpSWz9p8SLsjDjO5wA85JF3lLNr0gAc6wzwOd2/KRSZhevSPIvfnvoN9sDVyMJt5WNuCbmXWDM0m1MKfoc9H47Rmj12E7hnULK9HfE6EutMJkJTMSbYJ4cw60gwW2gOvczhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGB5UOal; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f0f6300aso4856271b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733151578; x=1733756378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgF/4kcAR5ywQOr3IwzI+nF+D01WGBejA8XPwY6tGHM=;
        b=xGB5UOal9nC2ZhiOGMrftpxnrPBm+sPjxzq6bYAN2PYQQd7TMDFLEkflE76b3yHb+8
         O1u6GdECptjr91TyqpLUe2Umqm0W/7NK65PApnDGVuv4fA0zfuNCsMMi6dBKUSZhvK62
         UuC3L1rC/UJsAMEOE+CUamJJTzTTVuuCaS7ASnLq2PxjImEoXj/lm8SZQSVEL35KLfZw
         Cow6093zM5ccfbH0xVU1q8Ls3+W6F2BweL1K858FtEmwbvazuEA9Yz//g+rIrt69Yt8+
         Q3Vp/eXlvygMIWvbIjdf8IpW7yLsaYwPido432SaQ/eNUpSelWSZbW/239/ovG/V3IBW
         FIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151578; x=1733756378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgF/4kcAR5ywQOr3IwzI+nF+D01WGBejA8XPwY6tGHM=;
        b=hOjl5dDDmIFsX75MfUgmmHuFHyUx4pPBTX7ZpE0dszVR7n32DMd+MwoH47OfTeJurc
         SBA1Lgk9HS4iuykg1FGysKF4Z9aWYH0wC28rIqaQHpWyYN58oOViU+crgj7+Mc8O1+PP
         dPCk2CbSNdAUC50d/lHf7vhbV8k0wbgjtWIiJE0Uoray+DHvXoZq+x9G7IP9i7PKz0DJ
         plspbV+U/ZqzK1ytSoEygPAD/IXwMRIAORsa8juMmvYY1hAt03GCdCV5srH+Ab0m8HS+
         JVGlc2ozUDOBawrZ43PfYB1DkOsQWfJE0M3WjVkeauGw6rNJTgWc9JVuaI2qNELhJu3T
         KTlg==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ+IhV2ZuKVOQzNeLe9YmkYLJtnO2qrazx07Hk1L50TnG8M9RG3pfGa+FnrAUO+wh4G65TVzYyKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTu7zMcyIlqC1RXF3PH/+mY4UQFwwanFZryb8wjcw1i/LRbl+d
	NuZ2VelPt8QZmAHO8BXc2GAQLO+YA9GfHvz2oI1enpU+BmYbqMQNVtKkddeIgA==
X-Gm-Gg: ASbGncumoEP0+qHY0Gjs4PN4FRl5xF0yrIkKVYG2OaWovQKzal1ZHidL5Mnevjgswfn
	D43/QDMb7oAMcGK0le3Nho0QZN+W89lhcvWWfWFTy40xJsuPG/VdlrWvqeXYqIE/HPss/8FT/Jt
	16QLgWY/V9iHeBd34DGyeWJ04CaApeRQD7EUw2xJnmdNGE/B4I7fNTGMSUyoLSFMe5J8K3OMOdn
	o3Zq8fJ9D0HSSJhXjbqlPuxTWOF0svKUtsxIXrNQ7SOlzkOZACfmvOrAdhBJw==
X-Google-Smtp-Source: AGHT+IHgG+f2vTl6EqIIXMvz6jhpHEi3UtNHtTewd/BkPPiHdBuHK6on+aYbHzhIO2Aft6WgAvaZ/w==
X-Received: by 2002:a05:6a00:181b:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-7252fe113f6mr29871251b3a.0.1733151578094;
        Mon, 02 Dec 2024 06:59:38 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254f689085sm6557728b3a.131.2024.12.02.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:59:37 -0800 (PST)
Date: Mon, 2 Dec 2024 20:29:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: DWC PCIe endpoint iATU vs BAR MASK ordering
Message-ID: <20241202145932.5gj72erze57jh66r@thinkpad>
References: <ZzxeBrjYRvYgMFdv@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzxeBrjYRvYgMFdv@ryzen>

On Tue, Nov 19, 2024 at 10:44:38AM +0100, Niklas Cassel wrote:
> Hello DWC PCIe endpoint developers,
> 
> 
> As I wrote in patch [1] (please review):
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> While patch [1] is a nice fail-safe that we definitely want to have...
> I can see that the DWC PCIe EP driver is currently broken (and has been
> since the beginning).
> 
> We are programming the iATU _before_ configuring the BAR:
> https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L232-L247
> 
> The problem is of course that the iATU registers depend on the BAR mask
> (the number of read-only bits depends on the currently set BAR mask),
> so the iATU registers should be done _after_ configuring the BAR.
> 
> Doing it in this was makes a lot of sense.
> First you configure the BAR, then you configure the address translation
> for that BAR. (Since the iATU in BAR match mode obviously depends on how
> the BAR is configured.)
> 
> 
> Now, I would like to send a patch to change this order, so that we actually
> write things in the only order that makes sense, my problem is this line:
> https://github.com/torvalds/linux/blob/v6.12/drivers/pci/controller/dwc/pcie-designware-ep.c#L236-L237
> 
> This code makes no sense to me whatsoever.
> 
> If I look at the commit that introduced this early return:
> 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> 
> It is not signed off by any of the regular PCI maintainers, neither does it
> have any Acked-by by any of the regular PCI maintainers, so I kind of wonder
> why this patch is there is the first place...
> (Taking something via a different tree is fine, but that would still require
> an Acked-by by one of the maintainers for the tree which owns that file.)
> 

It was one such occurence where the PCI EP maintainer didn't respond promptly
(not me) and the NTB maintainer merged the patch. I did complain about it:
https://lore.kernel.org/linux-pci/20220818060230.GA12008@thinkpad

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-21082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE340A2EC61
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F21889F81
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15229243374;
	Mon, 10 Feb 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMg8nCzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BC222591
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189769; cv=none; b=pcYdUnZfj3U95GiBaHN2AwcS0x4/1/7Az59W7hFJNjYfbQXut7+o+MGiVdUma2aJyeu0aCYABzNTFU+xoJ4QVwC4g5wViVttyLJF2AJ86TCjnsOJ6aploK9MXfm0N0i4FaLhPN/8XKK8De2pEsSnP5qrDPiNs2u23X46DxCwUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189769; c=relaxed/simple;
	bh=a6vfTjxnm0yZvIJRR86IUBku4zV/0mC5t2GB+2m2jxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxk+kKY3UqxmwesfsUKBIzHb3Q9YBNUM/yuFar40+n8fcOYNAzJU/yjZfHiuKJYI1mSGbtS4OshNhLbKipzAiIPsWiZVgufiO9m9+qpvskzcZK9B+vAS6tOep4eb9bUJ6xYPZGfKd+4yZvker5gt14OVExc8A94Eh74bRojbTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMg8nCzV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f40deb941so86452355ad.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739189766; x=1739794566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXftzj24CJqkMOObB5GaPCcmmHzxPWIlba1HI5I0fVk=;
        b=hMg8nCzVj9HuoXMYPqxBEALsh3D4NFq7wOwuPWwlqhb7soqcHlwLZu2Aj965c5BkNt
         6kaBu74lQ3D+vB9AG6uS8B2NilkGVvHe5AShxB9JF6hhDQg5qA6bCHxBkCa+zcy8TgJC
         Uvf53jxxCtR9i1GX2FFS/cYXt0qd4Ko63yEZBbP8ocVCo4K3zkMP4eRJbLXTWf7rvoL/
         ri48ldzKDcKZVkDUtmVc/PTMypQbGSwUak0OjiiTbHeqGgVj1jRKwlprfgnr6Qz5Fifm
         GRVtqjGMOkmbRCtnuk2Z5RFFihZPgCexy4HhVE8Ykl4w6wYklz0K3l/KsVeOwz407CqZ
         u5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739189766; x=1739794566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXftzj24CJqkMOObB5GaPCcmmHzxPWIlba1HI5I0fVk=;
        b=KqBQ65ekJ2ME2nJKvk6AJDrevVcyJAerlRmTlM9OA2dtLxAGc62UIDtNUpHQatc10K
         rQcz/yiOeUpWbMb4mRpDxZ/rMXOMI42mxTZybVvEB5jw9Ud6HAHvBCB/oPFFNQA1fpM1
         9dmFT9F+BmlWMYaIKWVsWe/aa995R+SEaiUWwWalFjhBmsUUx55nNWbz0hifyjHpcGLV
         mAfT+eoxAp8NiJRO47YWoowWF2f0G4zXKWhtagwlaE7WB15E8m8A7qQuVi7BhYDvwYa1
         /VWZ0b/C6Y83Tku6DGe3XCXzhj0g7p8Q8k2YN4FIMQSD5apFR75a2SMvxEKb54T/rVVe
         s/tA==
X-Forwarded-Encrypted: i=1; AJvYcCUUapdWO/xsu4vVQWTbLRO23gRutEJceMSI8saiuHloOblT1YbJQNwGfgPIT5HcTouIJQ1PgJn7va0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgzQI3QrwSqED3+34MioP4oQBb7z0omoOilufH6xlbLKvDwpk
	n0ei9feiRZRVQGuJF56CWm/YESIYwmApvz2SUm9mJO1erEFHnk5Z//M4jI4zf+TutS7IvQ9CkxU
	=
X-Gm-Gg: ASbGncvuBNoJwKV5hmvZxc/2tg6T56KgMsO21C66YKw+HC52K92tOSc7gidTzphiEpv
	TiZPJlvbTbm9EuSEDgGEQ1vATCXLQXB4OdaX7pxNe7hyrXSGgS4lwHKNtEjsYFPpHdea3nvpxp6
	JIgUSoK/bK6holqBxzg4Qs7aybD3X3sJVEYAltasWd7DtSB9e+flXx/3JtNEHbnnusmtxzg2M6H
	92D4qwS3vnCOfJjgzKTO4i4GJguhuZ1YNmRUKScazUOGV1A7c6Z2jYwRav67XxvCUreNiX1uB5X
	RnTdCoxqBmO7iKdJqD46Z8zxnU2K
X-Google-Smtp-Source: AGHT+IFnNVaBnfMyWeyh9NI1GANa4XxEOnaHFfmOg8hnw2swIIGDMaWDJobQW9Ts9U6co0933Grchw==
X-Received: by 2002:a17:903:2f8d:b0:21f:71b4:d2aa with SMTP id d9443c01a7336-21f71b4d4b8mr141545095ad.5.1739189765676;
        Mon, 10 Feb 2025 04:16:05 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650f91asm76808785ad.18.2025.02.10.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:16:05 -0800 (PST)
Date: Mon, 10 Feb 2025 17:46:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Handle endianness
 properly
Message-ID: <20250210121601.gpjjwkmf7ew2q5tp@thinkpad>
References: <20250127161242.104651-2-cassel@kernel.org>
 <Z6nU4ndEhN4R1-Z-@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6nU4ndEhN4R1-Z-@ryzen>

On Mon, Feb 10, 2025 at 11:28:50AM +0100, Niklas Cassel wrote:
> On Mon, Jan 27, 2025 at 05:12:42PM +0100, Niklas Cassel wrote:
> > The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
> > BAR (usually BAR0), which the host uses to send commands (etc.), and which
> > pci-epf-test uses to send back status codes.
> > 
> > pci-epf-test currently reads and writes this data without any endianness
> > conversion functions, which means that pci-epf-test is completely broken
> > on big-endian endpoint systems.
> > 
> > PCI devices are inherently little-endian, and the data stored in the PCI
> > BARs should be in little-endian.
> > 
> > Use endianness conversion functions when reading and writing data to
> > struct pci_epf_test_reg so that pci-epf-test will behave correctly on
> > big-endian endpoint systems.
> > 
> > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> 
> Hello PCI maintainers,
> 
> Could this patch please be picked up ASAP?
> 
> The reason is that all other patches for this driver will conflict with
> this change, e.g. Frank's series.
> 
> So in order to be nice to other people, so that they do not need to rebase
> their series more than necessary, it would be nice to merge this ASAP.
> 

I waited for Krzysztof, but ended up applying myself.

Applied to pci/endpoint!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-16035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016B9BC8EE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EE6B20F63
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F11CCB2D;
	Tue,  5 Nov 2024 09:19:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC918A931;
	Tue,  5 Nov 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798346; cv=none; b=VGUeshAMdh1kP8sdi8hSNW1T3SC5T9ZBo4QG/8v4Wxr575aTSOqEGwlcNTddYUTZH7lDwomayadZMWF4B8u862ziyzqQvX7Flqf7uS0Vgo9FcIHAG2qV1ARhTfVnw9UNULDks6Ck4f3F9iP198BPbouCF35wSA3Tb39jPAugrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798346; c=relaxed/simple;
	bh=Fe+eC7hqSYnAaMX20TTDfFXiCTF5VQLoRkObh+lKXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRVDpLQAA3WGDdLrnRfzkGPTZHypBIkRdRO/B+KU59wmMVF8SwGRBQY1aLjNoBaArr19toFSkwhq57taZ78yJpLSVxcxIcQiTVNi1ZFc7mdWhUaftZuJKF0zBS+kGELav2knBkh+54+Kb5Qjn77z+UfgAj6oHoOuLJkSItTlDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso3988420a91.0;
        Tue, 05 Nov 2024 01:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798344; x=1731403144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rbsOU9SwqzbBGUQW/LpQgJfCbCyISPbLseLiVIiq30=;
        b=EqOGSmmJhFudD7izDuvhcZ09cgzb2cYTmxDr5eymwBQ6m3oWIiT25+N3wB46QH5+lc
         kTyeHgPn3ls1UmI5F/GDETNuvx+fwp6aApnW8j7znzfKHuJo0HjpYZ72ZGqqpLLxBH2r
         fy9CXkkjD2k2mhi/i2bUtHDXuL8cllOZmIpW08kdRxgBArYn6LAbUABOdS7LswC0UpZZ
         KNC+Md9X9boCkxnwnvmSVv2+VKVpU2uA1RIvzMbsh0U+mEnAhrtRj0TDiSBM9eQ1FzuD
         lewrPVFtOAlZScfn1IG5+gS2cmkc4/9QC6pHSdyLgcyhsoWEvPP+CdX67yuZfcGWZ4Na
         WICA==
X-Forwarded-Encrypted: i=1; AJvYcCULLs2PnKyvmY5jQGvXpp8y9ALVFJQjYOBZC35i7lkl0Wxx+2TlQ8eKf5cTvT0KVU4hnvuqfz/iISuuwzI=@vger.kernel.org, AJvYcCW+vwyN9ftWnISDc4/dlZiJNRX2i9bOwsXdjtLEyLEv2/Eln84rzq7o0JtVOQ0lcOmirNtYh/mT0mlH@vger.kernel.org
X-Gm-Message-State: AOJu0YzztheM8w2Hd2JbX+FzMd5rA++Y7nSeXBjDSnHCpgUc68VhDk/I
	yoBxEvvN2Rl8e8dgUG3cqOR5M8tlE0+2a5K9K0m82AAMAvFgjHr+
X-Google-Smtp-Source: AGHT+IEgcps5a51bIOEKMbVlNKwOIQItISM8uUMU6iM944TS4pMAPI5zU5S41jRofRL4bgeAdGbFEw==
X-Received: by 2002:a17:90b:3003:b0:2e2:c6a6:84da with SMTP id 98e67ed59e1d1-2e8f11dcd91mr37247526a91.34.1730798344061;
        Tue, 05 Nov 2024 01:19:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da98474sm9180589a91.3.2024.11.05.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:19:03 -0800 (PST)
Date: Tue, 5 Nov 2024 18:19:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: 2564278112@qq.com
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Remove surplus return statement from
 pci_epf_test_clean_dma_chan()
Message-ID: <20241105091902.GB2202146@rocinante>
References: <=20241105004311.GB1614659@rocinante>
 <tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com>

Hello,

> Remove a surplus return statement from the void function that has been
> added in the commit commit 8353813c88ef ("PCI: endpoint: Enable DMA
> tests for endpoints with DMA capabilities").
> 
> Especially, as an empty return statements at the end of a void functions
> serve little purpose.
> 
> Otherwise, a warning will be issued when building the kernel with W=1:
> 
>   296: FILE: ./drivers/pci/endpoint/functions/pci-epf-test.c:296:
>   return;

Applied to endpoint, thank you!

[01/01] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
        https://git.kernel.org/pci/pci/c/06f893055382

        Krzysztof


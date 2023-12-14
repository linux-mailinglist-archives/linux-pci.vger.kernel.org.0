Return-Path: <linux-pci+bounces-992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23382812DD8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5765DB21316
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2693D98B;
	Thu, 14 Dec 2023 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eV2lu8zH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F7BD4B
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:55:14 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ba10647a19so3190355b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551314; x=1703156114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IfG/ysGevH7N1+fittwEeggjkDoQ9clr+IHO2E1aJ/Y=;
        b=eV2lu8zHrNORcFeXmgxQb2QFeyr/GSPmcwMPHWAMh2GUyiaTAYXpdF/5b2Faq2n2v0
         4GIpUAh5Iq7AZOugR75bFsvikFYpgn0SVQYLA+lOtU62Do8tNKQXyHbdf/elMLa/dQld
         ZfIuMFltbSIf5xoaWZxUTL8U5a3lpW/YNS1BSuEs09fJ+0dFXojQVOVNnbMASCzhCGuD
         GxTe3+4KECYO1NAGSJ40S4qMVNsR5mPB3IA6P3uSyHvDC694ebQZMfjdKYf6EJksqE+N
         28ZCWJLGKvdbbtoBGB34DLq0UU0wRF9S2FvKXVWjvikLFkEUYOGV5uCh8iMNm0zZCVE7
         fwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551314; x=1703156114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfG/ysGevH7N1+fittwEeggjkDoQ9clr+IHO2E1aJ/Y=;
        b=FTLRKC+hKrZtiNXhjp/8+8PMWhuNZ7Nk+cbdydJZqGaQgMKLxzIRPIVuhX3HmA7GnR
         xKSb3bG19Kd0gCezrCNjdkRWB/vcjcdTtWkLvHNSkIJuuhqAgsb5jLRuuG1bnVR3WKAL
         Zqrw11++se8RVSBbAdUsFsJ+zffgjYyE0V7fYA7YmNmv7AVlpCWi66/LPd3kAhAsIsnx
         e0nXGLNleQGhiAKrLD30Jts13yLsyr0lFhhoWPr6Zo194xqXQjFFnKoUAzPKbimdVL5q
         5OYKx8z51jngf+8ucek5342iWPgG6IrfIFGKhitk9wej7STQJqbShZC1ldUa5K2xLTsQ
         cmOA==
X-Gm-Message-State: AOJu0YxwxXFkO7HLGSGi1ng/29OH+Gay+x6Y6cASTgKQkjsE6kEaeX2k
	cu0+qGutw5UDG0w7o5gtpO1u
X-Google-Smtp-Source: AGHT+IH9dKZ7weDdopz65PuRKkbO/Mp6K8kuMEeI2h6VFnM6F5xt5c41hlBPLlHFALw9Ax8DidTESA==
X-Received: by 2002:a05:6808:1690:b0:3ba:3234:a068 with SMTP id bb16-20020a056808169000b003ba3234a068mr970504oib.110.1702551313755;
        Thu, 14 Dec 2023 02:55:13 -0800 (PST)
Received: from thinkpad ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id g25-20020aa78759000000b006d0951e74cbsm6780784pfo.178.2023.12.14.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:55:13 -0800 (PST)
Date: Thu, 14 Dec 2023 16:25:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org, kw@linux.com
Cc: kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] bus: mhi: ep: Add async read/write support
Message-ID: <20231214105506.GA48078@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>

On Mon, Nov 27, 2023 at 06:15:20PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series add async read/write support for the MHI endpoint stack by
> modifying the MHI ep stack and the MHI EPF (controller) driver.
> 
> Currently, only sync read/write operations are supported by the stack,
> this resulting in poor data throughput as the transfer is halted until
> receiving the DMA completion. So this series adds async support such
> that the MHI transfers can continue without waiting for the transfer
> completion. And once the completion happens, host is notified by sending
> the transfer completion event.
> 
> This series brings iperf throughput of ~4Gbps on SM8450 based dev platform,
> where previously 1.6Gbps was achieved with sync operation.
> 

Applied to mhi-next with reviews from Bjorn and Krzysztof for PCI EPF patches.

- Mani

> - Mani
> 
> Manivannan Sadhasivam (9):
>   bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
>   bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
>   bus: mhi: ep: Introduce async read/write callbacks
>   PCI: epf-mhi: Simulate async read/write using iATU
>   PCI: epf-mhi: Add support for DMA async read/write operation
>   PCI: epf-mhi: Enable MHI async read/write support
>   bus: mhi: ep: Add support for async DMA write operation
>   bus: mhi: ep: Add support for async DMA read operation
>   bus: mhi: ep: Add checks for read/write callbacks while registering
>     controllers
> 
>  drivers/bus/mhi/ep/internal.h                |   1 +
>  drivers/bus/mhi/ep/main.c                    | 256 +++++++++------
>  drivers/bus/mhi/ep/ring.c                    |  41 +--
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 314 ++++++++++++++++---
>  include/linux/mhi_ep.h                       |  33 +-
>  5 files changed, 485 insertions(+), 160 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


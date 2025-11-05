Return-Path: <linux-pci+bounces-40377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C78C3735B
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82CF44ECE2E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E7335082;
	Wed,  5 Nov 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p+qg5rB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B93328FF
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365071; cv=none; b=jNGq0is3c+bbSxJ2dXpIETb650TCIVPHyNdPApCJm68/q1xa8sbgcGPmEDvvAVUQ6nsWGAKJg3+vrlTNn3PylUf7gn9escct3zDRqnYOx0miDILdPKaY3K6IOI03t6V5R1jKa29OIJ5vlV+mTOO5ycBInpYpLQSVO3YbKZdjUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365071; c=relaxed/simple;
	bh=tIgDGOVX99OdQ7xUMrv9gmtn1EgXPokG3WTHA51WYa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEJmXl+8rc8a0nEspkiORZPTcPGBZnpKfkWDdGkuTDARtWZ1RZqgesQRoVpf7YEmb2PZ40ZkZSRxLKOA1sLDgwzq1htaBFlFy4rtrKl9Oonn5SaLKjFpDTLwUR/1r3B8bECbhQPBju+R80dRxSCNrYGUBi0stug5THOSImqLHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p+qg5rB9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-795be3a3644so1112326d6.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762365067; x=1762969867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDrtj0a1qY5KhyImx5VYDzDX8bVcvGFBBUFmZLDCfSw=;
        b=p+qg5rB9I7ZEesolYhegQvv+t3d5zVArOc803nNlc6FndePPV+FkJZcu3/Aes5Pp/Q
         X0ah9qDlM1DIWuF4f1p5bsaIT1tLGT7UWcyDVGoAPiVHbUnMXSxfIVCEjj0oRLJk379w
         p/rzpZ4fDcYZKEkw33V0VPCNUQ4/pi2eogoRNG1ZH6WHP2NhnV2h05wlrc1CZSLqOwkc
         DXK41s6HRPF3u2PWmqfiE6LZnSq5yNNsAhqvv9WT160BVNEGav2pR25CWDNdNHenpEnI
         7zkXHCUotnxhOIqCqWl2rBZ6EUjpdKjIuVCY7eyxPWpdyS6CBPdvA0fGAriHMuFQbp/K
         JsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365067; x=1762969867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDrtj0a1qY5KhyImx5VYDzDX8bVcvGFBBUFmZLDCfSw=;
        b=XH2ZMFsqSGzgODM6qsRR7WVGZZXjjnNlho0nCNflOtzn5z2PqNXHK1Ybv8ZrVK+8Gf
         aYuzUtAYMnHY1H3eV/TpELlEbMH+SF9d9w4wieNxiUqhPNr90lcGmkV29Di2EgLd5yyZ
         UFDVrR0XVUkeKSYpsFmKyxw//0HSvuL7Hb+5y7gBoTT2Iu/cF3AlpImeOs6DcW1vhN5B
         OJaf1i9XmbHeVw9llvd8pCS0U350flUWLq1O6jweSVooAx/MBbqJtNJ8x/QE2KluTNvq
         ToXLhhobeZg5/Cf9kI1Zg1ll8uyPGGZIS3VVtS/163k7GDhSqxDuwdIkmavo0zgHK2PS
         oglQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsEVOIwDnyYbCxmOwLAFjU5+08rr4Uz0YBjVqw1SM3Fstb0ZF9RgXKC2t1wVdWAdFCtK0q/a6K+Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPhf8tGa+fQNxym6a6YSiBqtQdDP3csCTguSIFxQksIKH4nR0
	zjPtXd1BkPH1y/ToF1jxxRKuUxRtzXYV2Vydm2/7h1aSDFd32QYwitCWAqN+e799+Iw=
X-Gm-Gg: ASbGncuuTCxw3sLRthtA3nltkyqpdJGeS7fuMg3t2ZgS7Fbhxk09LY5ukt/usRpUFng
	C1ksuwDX2VEPUwtjKXQOIB1wdi6ca+gr8Fg00uXdVjpi9w4dky+I6Nk95I4BpbjZ+UskoeExePf
	kjYf740NGhEXPAbebJddLGpFhlVdZ41QaiUO4TJodYSiQj994k2Tf+AvrpgZ42N2/ACwSWYaCzL
	RyQIyfBmDkbZkVfjQdRv5SVx8OLjLSvnV0MwlI+72jeUgK+6wtGvmGjTmZXwLcwnj3oKaJqQrqE
	MHNtrFsPS1beEhhE7Xsy/kZyUuS05bu4ftyENi+02GPNcOHjrB0ImPE3+RXeGgzeMeC/eQHhzdu
	wX1IP/n0DTAuVQ41bd5F3QgjSUhb9wRBn0dGY0rD/A8U0WkTyDproMBIISh3qyH8d074+NmFnFF
	ky/f+w5ckO/KrBKQEJET88yLmVVe8UVGNsYQNVlO/mg/yKIKGmUgQfusZi9xg=
X-Google-Smtp-Source: AGHT+IFbubKK7RHluWy72s0vGay11LKV+jA/RxKZTdEkayr9i/UfiWmuCSryIaOc1e9CcrXX+Lj9EA==
X-Received: by 2002:a05:6214:2686:b0:87d:e456:4786 with SMTP id 6a1803df08f44-8807119644emr57736286d6.45.1762365066850;
        Wed, 05 Nov 2025 09:51:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8808290d03asm1375476d6.26.2025.11.05.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:51:06 -0800 (PST)
Date: Wed, 5 Nov 2025 12:51:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-18-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> eliminates the circular dependency so cxl_core can safely perform
> bound-driver checks and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> ---

This commit causes my QEMU basic expander setup and a real device setup
to fail to probe the cxl_core driver.

[    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
[    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22

Probe order issue when CXL drivers are built-in maybe?

~Gregory


Return-Path: <linux-pci+bounces-39531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62AFC14DB9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFA5E5AF3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128823321A7;
	Tue, 28 Oct 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K95auNhv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F8330D51
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658140; cv=none; b=USsLEkWGz8L8lUUg1VO2VROKA/WhTjxdZSsOAnfGEKad835bQzTbEXN/sGn5JPwSY2EVvPmv6ijLf0hFoYRYEIjW5fnZjithlE85TfSYN7IA6cwYJiY2LogcfAfLBY6zPFZX/+6Io7bnCRQw3rFwgGu2VI61xXS69sBXvnW8zAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658140; c=relaxed/simple;
	bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ehZdP+RKCK2a5RVcJO+Uv7p6Gw2D/7IuVnplJV+hfxuoXJCUUqxoINnh2PcF6pAyJVz8L5Bxgkdt0m5DkvEWO27h6NZyvS4a5JkO5wAZsDw8NrwvpXH8uVS3PNABFIttW3gyj8fPwYilbRj0/i2/VcYZukfbv6Aw/2I+XQcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K95auNhv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89e7a7e0256so470347785a.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761658137; x=1762262937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=K95auNhvrSFR6PPDg2ibB+mdTp2motrPFwy4va//VFphBGbf/4LZapakAXGoOkez92
         +AhFNhjlkgSbj2HMewM0Dat39X0k7WeXiUlhUIX+BSs49FIoqxxs1QjxEt2dQLPv6SCQ
         bLvy0Rbo8HeAM+TxfWfHlBGlE8Xhouu3jsMCc6LWd8NVW8c00G/buUgePHr4ZjTt4WGE
         B8vDDf7tawyGnwMDnI9CpypUocmYloFMI3NlNOA4sQnCmqD+G094F+7MFS9BHtgWdh0T
         9FscgUMGPE9hiPXfDsLqc85DmN3rfWgzEcOekZ3IQne1k/cWy4aDNSWFfIGosHxZ2gOD
         RAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658137; x=1762262937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=wvKXEaZpVG/81H8iEIAwWI0B6233MEJ5isfc6YbdUQTwe9vk9YbT5TLxMOBVdp4T3V
         FMdkRKzsyvhyURsVs8MCxAfBHv+gGO8jZX0myU2RymUsB6O7ZdLQ9jFjAkqQoNA+qF10
         L1lvCdV73YLzPWjcWsN4wHWApuQaeDBZnC0TQ3pgLOwHPut2xPOtVWRdGB8PH1LGDD5j
         DHEg/RV+IyrKU6Tv2S3xe1wuCDm+CWGcHoZeJLhNxi0Tont6EGDIEz1fr3ZP3jplS8Vf
         HxVTduUJ/QkoxGqEm44FYMYLhE6OmVR8V31BX2+1lcBafgzzo8yFpXhecfDUOzqG2MqL
         azXw==
X-Forwarded-Encrypted: i=1; AJvYcCVRczbH8k99KHq/pVlDQ9wdAmJhXucv4y4OWulh5AKyvL0z4LzVsM7GnpDX357GRmM1TzkKF/nYyTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+xl7ZcgSXfY8u/5yX1DOwrC+wGexx+yFKQuM0UDKSQ1COl6y
	YZeR/Yb4l4ncI1vWZI8zQHYkjbKy4lFgoIkXTnjnYPkY7vj4bbETwPeIfee0EQoBYA8=
X-Gm-Gg: ASbGncsOL4x/ZfLZ4fxyFezKLYamsjZuQiJl9hbHD0i66O7x70vJ8hDazPI/k5/gUHF
	8Y9+MHmyhcVFEQbYLo/tSJKzh+HLhUn19Ui2MKNPxjC6H3u5byx7dM0FBpGyxzwh6Ltz36Y56l5
	ELlS4Kwav8UJqNC0NyzfEime0KXbTB6N0vgCM7LmzcbrRh217DPwKQvsJLdVUCgpkrG4buSuEUJ
	fZkOz762078XUEnEcTKJ5bJfbSQR0qf3yEFr3nTDrrFDSlE4MouQrwN/8NS2dbz73fogHxlSSwv
	rPpMTETUmiGf5GALIUpNFJvgGL0ePz1hnm28uC+MgTRLGkRM8x7rJEPNcRB7G6eOSvZZQlY9wcI
	tzhltPC9hW8B6fxBCyHipuIto8SgKI2cIyIL4POoEG10lYcIBgl/s5CfPMF45IdiXLX/WSUYGUO
	uxymhDtKSkd4/tYxaZ+TwyNCFVpL+nahcXl0koyn1FtDsB4bWNQ7FTovF7
X-Google-Smtp-Source: AGHT+IGShJMC1iBLkVMVTtmAgFjNgDYF2kS2KrAPaxSmW4rJSZvLRhN0tZlnppqE/frY25q7IEUPHg==
X-Received: by 2002:a05:620a:462a:b0:8a5:6ca3:d56 with SMTP id af79cd13be357-8a6f63c48a7mr436299885a.39.1761658137149;
        Tue, 28 Oct 2025 06:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5617sm829595185a.19.2025.10.28.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDjkt-00000004PA5-0Sy6;
	Tue, 28 Oct 2025 10:28:55 -0300
Date: Tue, 28 Oct 2025 10:28:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251028132855.GJ760669@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On Mon, Oct 27, 2025 at 01:44:30PM -0700, Jacob Pan wrote:
> I have a separate question regarding noiommu devices. I’m currently
> working on adding noiommu mode support for VFIO cdev under iommufd.

Oh how is that going? I was just thinking about that again..

After writing the generic pt self test it occured to me we now have
enough infrastructure for iommufd to internally create its own
iommu_domain with a AMDv1 page table for the noiommu devices. It would
then be so easy to feed that through the existing machinery and have
all the pinning/etc work.

Then only an ioctl to read back the physical addresses from this
special domain would be needed

It actually sort of feels pretty easy..

Jason


Return-Path: <linux-pci+bounces-32946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A30B121CF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C675817F0FB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79012EF66C;
	Fri, 25 Jul 2025 16:16:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE882EE97B;
	Fri, 25 Jul 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460195; cv=none; b=gBg+M6XfbjdqQMHph0mWke88LSHqk4/z6Yh1izCo0S8X9rEjz84Kja2lgU0cghDvcZT2wf8FNAUoJq17CNYCqVNY7ac/VG7HVEAISMdDWAtHH0OZvZX8dPMBjsWditpn2JpNJD6tF2sEfRhRRZnox2ZFBRE3RJNRQqo05//6vMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460195; c=relaxed/simple;
	bh=VQ1Sb6bzClPJLyUB37odBN7nVHwdCTVLgyDv6w/LViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itoKFUj/HWC1Hh2fmrwyvSyHHrB/puYLn3E6tOQcijqY+WdTfGIDIfbWwqFzI3/O1GlEuvRg4o4eWh9nhF7JcD7QwEjIsaUrC6Ssg3eH1XL6PfZg/Xza8C/dAsZ87ReaYgF/1CukxQF+nM5+XLWGYoPpcNf7dpW2NcIrHnYw4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3b336e936so448581666b.3;
        Fri, 25 Jul 2025 09:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460192; x=1754064992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9lVzColSUbzoyzWK1v2ytYya9LR+3IJRUPOrRIrYkE=;
        b=OKHxCC7KLs+dVooVtYQLip1Un20W5CzcAXXA3e3KXELSGxmo7ppXjbQAB7mYuMiZav
         mZPqXH5o7poo53+Q3PE11Qa4sc1wNk0sAH/TjdpfxY4+g4a721bVKl1DKcmWDoTbNRiV
         kr/w8mDevqZp/wFz548LpNwZPZ/rXrh+V0zluRFyAj46nU1D8AcliyXlSlfya9geqrn4
         RKnEnyJvzKSExaHHonQhiqbxWeaEe2LVRzrxzi7k8zbfO0MnH49tDJSvlsbUKbWVNsDf
         L/XEg17kEbtv/9MPkbASoAByq0CKbWjWatpeWdjpbMsmmaabU4kU/r4Z75cy/LMaYuUV
         lczg==
X-Forwarded-Encrypted: i=1; AJvYcCVj6fu/WQF4vCUzFkxOM40zdLxJCc1eK87l2HxWYio235Vnl0/umXBPtF8Hig19sXwWJSMRucDnld8l@vger.kernel.org, AJvYcCW2mYG22Getv4JmGy2HtA7GSP34/EKqAeqFn82WsxB5iZ4ThdbVglYzeObQHj4ZpfFkfGHnJC9Q0lNK@vger.kernel.org, AJvYcCWNLs9WRHi3nkkPUmbnP5L7yd+iJxfN77ZMaBWrC1m9AZ0v3zqEWisnIP1QrCsSBxJMPQEY7sKvYcGLWg==@vger.kernel.org, AJvYcCXriWbD2Ms2y0srHeq8dQdvteWvVF8Hf40zi9WYJvIndeLEbgZU7tdLnIr36vo4Qn8Dd9j7cgsT8e53IBUR@vger.kernel.org
X-Gm-Message-State: AOJu0YwONUHGKThdU5Vc7MHh48J9VIP7PLVyKfYuyOAY280/3u+O2yGa
	DfxzUUhJcr48UaJJFRYEXZc+7h7sg2bdKgsodRuY/O+MZ9HYEHepuMsX
X-Gm-Gg: ASbGncvUnFEGXRYGj/cJ9VMWbpimMlDLB3t/GV5uFSEp5jistPeW3OuuMfF/O65nihQ
	IOhZlHVZ8BVq3nw9UNQbhZCT76bKnzcJq3oq5uJLzpyvW9oQwP1EhPF8YrhTKvZGFNxusNYp/23
	lxylxYyiWDKydvV87AZAdt11hfjy3IJlr+CUr5Lpj8WAXaiIjaSgFNpqqpublgP5hIVotn4Fxmt
	BD5MeUHbLUDwf0Bilm3NpJjQMCuc9KVmBlC6tl6L6+3LbfLU5l8r3vZIbH42yB1rfboSyIJpmqN
	tBQoxjEkUH5VCiDpetARBu+vsBGVlhejYTcorAnbCNySHplPoUFz9UnB9IMqUzyqAGPxq5MFv55
	urcrOsjcTf721BA==
X-Google-Smtp-Source: AGHT+IHbjaJ8cbbWsPvmFdchaHgB59gZMNGBegBtlGVNhjnCNqWbZSGSDTI+qaKic8T0W3LbKoDy/Q==
X-Received: by 2002:a17:907:7ea9:b0:ae0:9fdf:25e8 with SMTP id a640c23a62f3a-af61e6368d8mr274930166b.47.1753460191687;
        Fri, 25 Jul 2025 09:16:31 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635af9967sm11514466b.131.2025.07.25.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:16:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:16:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>

Hello Shuai,

On Fri, Jul 25, 2025 at 03:40:58PM +0800, Shuai Xue wrote:
> > > APEI does not define an error type named GHES. GHES is just a kernel
> > > driver name. Many hardware error types can be handled in GHES (see
> > > ghes_do_proc), for example, AER is routed by GHES when firmware-first
> > > mode is used. As far as I know, firmware-first mode is commonly used in
> > > production. Should GHES errors be categorized into AER, memory, and CXL
> > > memory instead?
> > 
> > I also considered slicing the data differently initially, but then
> > realized it would add more complexity than necessary for my needs.
> > 
> > If you believe we should further subdivide the data, I’m happy to do so.
> > 
> > You’re suggesting a structure like this, which would then map to the
> > corresponding CPER_SEC_ sections:
> > 
> > 	enum hwerr_error_type {
> > 	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
> > 	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE
> 
> CPER_SEC_PCIE is typo?

Correct, HWERR_RECOV_MCE would map to the regular MCE and not errors
coming from GHES.

> > 	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
> > 	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
> > 	}
> > 
> > Additionally, what about events related to CPU, Firmware, or DMA
> > errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
> > include those in the classification as well?
> 
> I would like to split a error from ghes to its own type,
> it sounds more reasonable. I can not tell what happened from HWERR_RECOV_AERat all :(

Makes sense. Regarding your answer, I suppose we might want to have
something like the following:

	enum hwerr_error_type {
		HWERR_RECOV_MCE,     // maps to errors in do_machine_check()
		HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_
		HWERR_RECOV_PCI,     // maps to AER (pci_dev_aer_stats_incr()) and CPER_SEC_PCIE and CPER_SEC_PCI
		HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM_
		HWERR_RECOV_CPU,     // maps to CPER_SEC_PROC_
		HWERR_RECOV_DMA,     // maps to CPER_SEC_DMAR_
		HWERR_RECOV_OTHERS,  // maps to CPER_SEC_FW_, CPER_SEC_DMAR_, 
	}

Is this what you think we should track?

Thanks
--breno


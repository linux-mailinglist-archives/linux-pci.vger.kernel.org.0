Return-Path: <linux-pci+bounces-36473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D2EB89672
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B0B171152
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582330F942;
	Fri, 19 Sep 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DHvklvcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2124DCE6
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284225; cv=none; b=mQOEB3DfPqoDZBHtzEHiqPD6CYCtdn1qKqYAYWgd7ByiOC0CBrc410NgUTRKvJoCQuFlxKlPvhbUg+Gi7nqGYmi76PbwCkyh9aJ6Y3OsPMAVQbXSIGZV9gnCXIQuXLrxE9ihR1DDHqjUS6KJLCbR80JzeHYtKIfk7cW3k0/Vr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284225; c=relaxed/simple;
	bh=9hOdlGjuaO2HgHLNkmD06YTLKgftelYAE87iNaJOHB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Lr7s2htA1lReBCPTUjlt+G3MeuxeTbJEWG+LM79ughhFsvxerKRPn/7698FHnv9QhN5FiGq4J2Nh1bZmTa/af3dB7Rb400LoxWQymOXsnPhAGJkEF07exrfmdP1oiwfck7Pwx4IrY7TeBZijK4Hcsr6AWl/m7TR96o1mV4F0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DHvklvcg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746d7c469a8so1650046a34.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758284222; x=1758889022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8z1PAUhuZhJ0qIsnRvrF+kox36Ion6GUIrhsugfkSaw=;
        b=DHvklvcgDIjQXu3Pnv+jb+IdI9pDPZ9BFFsYDvfTB5xKKQA95W7DN8aSHdtCrARdor
         +BxCoiiAcSxOPjcv9la9wNys9A9pr+7VSo6E8E9l8DmxLj35msN7BDJf6V5BDYJd9YUV
         80QhecaooJdjH/G+Wr71dI2HDLgtQcM6OYmQNavjERL2FYEuwm/7Ar1PiDuF4UHCIbA3
         c4pmxVBxB45Eti/1cugxpZDRtUr+cmRdzCO+MhEowMLl6j0tlNC2PyTM74QRImV5OXBY
         3nJQ+ODoxq/UDD5mpEyWiCnFyOeKnp84ZxAy2zYSPgvlz+RS0AJMdzDmWyp6sAnONXKH
         xlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284222; x=1758889022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z1PAUhuZhJ0qIsnRvrF+kox36Ion6GUIrhsugfkSaw=;
        b=eEhckGcqQOkt+vizjjFWy9dPXHiBCIxWTosi303U5JNqK2dKjDt1qthdxncq8Z61Ox
         lZEb7V0aObRfJ1aDMNDDOeDZkztXzoUQu0s2AuU+JOHRlvS+fbFt4LROIOwLaYT5Qo7F
         dKfjiOH85oadpdpkaopVwKeY6L11sMFwdMEW4iimocJuIUDhq4w2zXNJeubvqqawBU9w
         TJL4VCLiARF3hHNmTpqlWAZ6fkA5r/RZrl4dQ0UU9In+JUybvqFlmjChV2E4mOa24mrw
         fQs1avYUiMM/3c050F13Rz71iQQP36EPvHm9jKjMjJ2xTJVnA5GWrmR3ijnovkaaWLvE
         w1mg==
X-Forwarded-Encrypted: i=1; AJvYcCUBTm9Y/ePqfhfCs0VQ7n9JUxeY//vn0KSqYZ0RI/IOA4pSUfB/5xqFOKCbnSJEz5S/tCEqz5Rtj1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0ALZ7iN8YCw83iJYybyiZLf80taGSIvdOR3IrWTj83g6is/T
	gKRBVuhy0EzTMOvhKjIOvJIwYzxOZGbQLd73LRTtziS4K7kQSMKEr6kS3h9QGz+UBdCZoMeBzJP
	OJzta
X-Gm-Gg: ASbGncuozI0Mt20RtJBIAq8guOGi/PzDSIvS8jJsAgczL6Cvp8EUykda2OfYEEzzjZM
	4de2saSuXBA+k65jYYCzSuVZv9Wc+QCke41AeD5oJlvPWD70bNTtdZ9CwqZ8CLjwJJBdAszvbzB
	wwvtmBhU00lS4/vDUi1d1Tst/ZPRURWj1/lSUDMtkJII2GioLFj5nxUBIxzN5C3j1o3rSyuJM4v
	g3v1CvuOplxeocYWROvcMUFs6xcg7VRNLH25egpO6mQxOtdsHy39qFzjzXuc7vTJBx7ZmFEXQjU
	8nXz3zIsBTEIZvV0yoV7li6xmrIIaTJvH/+sIi+t+qv0hY5Mo/FviEc74oucgLSghLAaCdFc
X-Google-Smtp-Source: AGHT+IFrXXchLffhfMy1C7fmW24InJQmRXLk2dWjCrL6t07KpNbKa1uhJepPBwWb7oulkXbJlwg8YQ==
X-Received: by 2002:a05:6830:2b0e:b0:745:9272:4a34 with SMTP id 46e09a7af769-76f72bbc69fmr1610183a34.16.1758284221993;
        Fri, 19 Sep 2025 05:17:01 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692af2f9desm2303860a34.31.2025.09.19.05.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:17:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uza2u-0000000988l-35TG;
	Fri, 19 Sep 2025 09:17:00 -0300
Date: Fri, 19 Sep 2025 09:17:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, gregkh@linuxfoundation.org,
	bhelgaas@google.com, lukas@wunner.de,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH resend v6 00/10] PCI/TSM: Core infrastructure for PCI
 device security (TDISP)
Message-ID: <20250919121700.GW1326709@ziepe.ca>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <yq5azfau7fpq.fsf@kernel.org>
 <6e8a11ac-21ac-4260-b8ec-54bdb058fbe4@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8a11ac-21ac-4260-b8ec-54bdb058fbe4@amd.com>

On Fri, Sep 19, 2025 at 02:17:23PM +1000, Alexey Kardashevskiy wrote:
> > The corresponding Arm CCA changes based on this version of the TSM core
> > infrastructure can be found at:
> > 
> >   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/tdisp-upstream-post-v1.2
> >   https://git.gitlab.arm.com/linux-arm/kvmtool-cca.git cca/tdisp-upstream-post-v1.2
> > 
> > These changes are still based on the ALP12 specification. I am not
> > reposting the series yet, as I plan to rebase the v2 patchset against
> > the ALP16 version of the spec. Those changes are not ready at this point.
> 
> Here are my trees:
> https://github.com/AMDESE/linux-kvm/tree/tsm
> https://github.com/AMDESE/qemu/tree/tsm
> 
> I'll repost after I adopt "x86/ioremap, resource: Introduce
> IORES_DESC_ENCRYPTED for encrypted PCI MMIO" (hopefully soon).

Guys these all need to be broken up. We need to see arch code to
implement only the ops and features in this series so Dan can bundle
it all together for merging.

Think small steps not giant trees with a giant mess of
everything.

Please cut them down and post something mergable.

Jason


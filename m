Return-Path: <linux-pci+bounces-6997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19C8B9829
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E47B24999
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47FE5647E;
	Thu,  2 May 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WD6C0WeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592C56444
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643718; cv=none; b=DT/muCkUh8eyb2H9Toyfla2gT8Gv2N3MedkGSuB2UzQ5VAF84w+R4O7tKJ7xFznQIis+jz5CcEWmrTmoPt15GhuG8gIWRvYb/cg3zV4cg+tGmPg5UeoI+eLeslkYdS2FwooYa7Jy3MsSoPYsL/gTT6z0MY+p0vGAyGgvZPdaVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643718; c=relaxed/simple;
	bh=qRdP1MaAcqny7WVri5XKFV3uC/ES+lwc76NtRhAJ63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7GJynq6P0yiMjsgonXK+Hyxn7cdPEjgOXQBkszqH+t/jmYZ8aEPn5kP4FKUQ+EGSC62UCR4GJu12ZpqKWVWBq0uUQ3Q4ZX8eqxpaLXv/O5UUteWX6f+g/C6DhosHNdT5U3q9JMs5XVK0aCaBUzhJHjfwqN09iOcd448LBhWhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WD6C0WeX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e50a04c317so42647355ad.1
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2024 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643717; x=1715248517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NL6wf55BXPa+yyuBuN45neIFKGEebMs0pSULB1fzRIU=;
        b=WD6C0WeXH6sRZovf9W46qUF4W2Ncg5Vw+flKXSqE3F/7A+DxQ8ICk7VFG7pscqYqc0
         qmZ9tg3TwJCwg+IaKxASoOyqdwZG4r17JzQ2o5ezDZ6MqavkBPV8FdMr6S8/DmKggJO/
         pPv2eup29iAieYBWyd28ZP5HsXwqYtUzVkfSmjOI/3wyBJNGu/StALD/K2hr55OrZIRV
         j/4wmo3AVJ7G29eO0ixgQadmF439ZZ1i0q5muCUQCJ0T2O1c/Nqubi57pIpLiFeNM+MH
         ztDuzJUwSnA6vreLH3rkphKejTs0PlOrWv8lIwlM7UFsKVPcm6P5/vmbEyaryO3Quuu8
         4lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643717; x=1715248517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL6wf55BXPa+yyuBuN45neIFKGEebMs0pSULB1fzRIU=;
        b=FpjVxhbGhYoHceTXAMwvhzdKFcLJl0j01mCN5apuR1B8Ygtxx5/CkN5FWZvYYr7UFR
         oZDpQC/Y7fhbzELW5DOrdu85oeesDiOeZ7ImFoodBh/BvCt7DJsl8/3nM2+75Lc6cOEI
         rCpoaycD98mxU77MkQFbL4JDSGa2Db7GLRGLUmRaag1/kpnEjpV7KqRFhhew575+OaTl
         f3vF5KgIiyjt6otY5HNCwIb+2tGTf06LoYJwgmn7cPWRg4TyjMHVjUBMHR0maeVG/2bl
         nuOMIubh1vmw/L6Fm3VHubhEgWKzkT2qrrUm1o1DF2BwRBn9OwGNRyoZw241uAAXoQnC
         DarA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/l3S1hIdadCZomyRDRqfUYIef+gJw2/nfOMSdZIL4cIbvpoyQJngag5ZjmQJ3EK3uNhYW6a6hzIRdyEc8wk0UGub2LZ8DR+4
X-Gm-Message-State: AOJu0YywSndrOLq4nwJf8IKsnpfnswax6xARoP8sIMBM8D+nLeN8Ub5m
	0tYQJcyhGtEqu/vYx2pQxiKg9VFATL+ihFf09X+qSQ0w4n15WpBgsMcYp+Kwxj4=
X-Google-Smtp-Source: AGHT+IFpK3bIq8mezuHv2XyP6jnQjh19B8eyQtbmKS7Jf/SgRv411rIyzxq+sdALFrGRrZq6EWk8mA==
X-Received: by 2002:a17:902:e80b:b0:1dd:c288:899f with SMTP id u11-20020a170902e80b00b001ddc288899fmr5793344plg.18.1714643716808;
        Thu, 02 May 2024 02:55:16 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e0e977f655sm867362plb.159.2024.05.02.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:55:16 -0700 (PDT)
Date: Thu, 2 May 2024 15:25:05 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 04/17] ACPI: scan: Refactor dependency creation
Message-ID: <ZjNi+QaVZUX0Ntiv@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-5-sunilvl@ventanamicro.com>
 <ZjNaxvh2ZSfDcTa8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNaxvh2ZSfDcTa8@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:20:06PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:29PM +0530, Sunil V L wrote:
> > Some architectures like RISC-V will use implicit dependencies like GSI
> > map to create dependencies between interrupt controller and devices. To
> > support doing that, the function which creates the dependency, is
> > refactored bit and made public so that dependency can be added from
> > outside of scan.c as well.
> 
> Side note: If you haven't used --histogram diff algo when preparing
> the patches, do it from now on.
> 
No, I didn't use. Thank you very much for letting me know. I will use in
next version.

Thanks!
Sunil


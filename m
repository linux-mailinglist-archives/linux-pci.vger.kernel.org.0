Return-Path: <linux-pci+bounces-33199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DAB16561
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B91AA375E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E102DEA94;
	Wed, 30 Jul 2025 17:23:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AB1D7E41;
	Wed, 30 Jul 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896182; cv=none; b=bs6OoNW7amOlMYNLqtiJ9yk9/5JyCCIAcWpBaGRH3yFyHb0WEWbY3vU3poaAHZ610ZK+17wk+jfzQ4MRNKGrq8Qy/y8l0OZha8WCiPKBhsI0s5N/CL7gd4YYQ2qstVMiwYskXVoCLkByz68UwljSVKYf16xvwzpw86LvjnIY2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896182; c=relaxed/simple;
	bh=2inB9lrYIxnh5dD0KnQ79CfqCqa2mBwK28Hu1ed57RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyKxbBM5g8AXkrBswQjUE05h2GNiRvsipyYufFSMLFy2nyuqhx7P7MdBAMBd9hYpn4g53KsNouK9TFvO2lgb0c3TC7qeFG3q5FGkYP/1ecf5onJ6DsHvOHtWwqBzsOEzuZwO1KyzYomU7OhCJeAZkxsY+Mq0NQdq/5Iy3/IY9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so2845466b.2;
        Wed, 30 Jul 2025 10:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896179; x=1754500979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVG5g2ageWB6fvYTmlrchc1VftQuavVCJU6Q16hxq1Q=;
        b=TWsJFbVmcJ+2unhu6eVN9mU6koxU7zwsliO+KRn0dym5wi8MJNeN5kn6PfMbSkh/10
         r7KmwZsbOl4EZY8cAS98q0E2zOALhq5Y3Sa55AKmszu8o4bCfdGQk7//4lc9nTL4xt6n
         uwe7L8Zjld6YrSVnLFnzS+xwpNLaxgumy55ddvrz36qbzkOdiJM2IAORBFOPLNzTd/uT
         GXr6d0ayttRFdcjc0d+XHYW1d71GrVd+PCcaLzBDO4ZclHCIWZaRZeUaQGd6vIBO+wC0
         SmVuvOyTItC+sdPJs1Ww97noa+v/auv70LNbZugXNiGiRM8l/HLLhP68HFg56y9oDPXV
         dQjw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RbvdzOPiEHreN593rrstqTuHqvrFPf8HzsOi0gJBwej/FLXl28lW3ngwKuWTHIgBE15Gq4skuU0T@vger.kernel.org, AJvYcCUpKqLRNX2kHuJtZR/zn1WpMPUGExNrpJ+bh4RbXJpqRB1hgn7OrYcvy1N5foI78mmTZi0jNphEeWf4@vger.kernel.org, AJvYcCX0geZbygbugmleA+KoSBCNE6m3N4R6ZEUAethNPh9W6UbQW/fqihhUOHNLMXIGyX76UX01/piq4qyCgdnb@vger.kernel.org, AJvYcCXWfkAIZqsAzqMhkJWh/fOWXA5IzZFRdxKeV8MJv3nZr2jB5o5bD/7/AKjRIZymsNShWy9Yy9atpueWcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEftKqWYmY3O8h/J9jbwaaxkLsXng1moLqxPSmUVa8GfNGp5Iw
	TLN8O01RAH8Sum6B6UN76HrI9DQbX5CGuykq98fQJMu1kSvOOm+wb/VN
X-Gm-Gg: ASbGncuAm5mxYRjzc4kDrk19ESn8YXjGf61k9GypwnK637vevGeWWauKacXS5WWrCuz
	H72Aup6388uWGg3jv67VbcX7zE587VHqYkCjMQQRwLwHtzq1CH0dEXhTZD/kq2gzy0kvwxSRuUM
	9ELTZllvRIah7KgKIC1GJXY0HVszHZm/jhxtbdtRPb/dtWvyeRAUYoBMMkUZ7YsM8U0+RM/rrTS
	GJ9WVC/4K/mSrtm2I/1zDxl7qOGYeWFvp3oGWzA50HaGFiEkyvQSK7eMLZi5i8nbA6l3UiKuDpX
	yiFL12vqIYgtffy3juA9RJBpXmNnCBg0LNnxy6i/J7OKyG+D/pSy3Lul+j6CWH7QIuTQskB9rKA
	WBDVvYXsiTbrz
X-Google-Smtp-Source: AGHT+IEUbbT7MGZ9RPV14AyB319B+ILu1Zn4HTqqRjqhmc6jefo1B6r2lcAh4WufQuwJ5cKV1ZycMA==
X-Received: by 2002:a17:907:3d0f:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-af8fd71454bmr552748166b.15.1753896178789;
        Wed, 30 Jul 2025 10:22:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63a5bsm781297566b.93.2025.07.30.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:22:58 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:22:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
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
Message-ID: <4w7adjalaisxhdx4l2zzl6ghanky4geijl523q2ezz7b5kj4kq@fr44nlwsw6qa>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
 <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
 <2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
 <a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>
 <zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
 <20250730182137.18605ea1@foz.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730182137.18605ea1@foz.lan>

Hello Mauro,

On Wed, Jul 30, 2025 at 06:21:37PM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 30 Jul 2025 06:11:52 -0700
> Breno Leitao <leitao@debian.org> escreveu:
> > On Wed, Jul 30, 2025 at 10:13:13AM +0800, Shuai Xue wrote:
> > > In ghes_log_hwerr(), you're counting both CPER_SEV_CORRECTED and
> > > CPER_SEV_RECOVERABLE errors:  
> > 
> > Thanks. I was reading this code a bit more, and I want to make sure my
> > understanding is correct, giving I was confused about CORRECTED and
> > RECOVERABLE errors.
> > 
> > CPER_SEV_CORRECTED means it is corrected in the background, and the OS
> > was not even notified about it. That includes 1-bit ECC error.
> > THose are not the errors we are interested in, since they are irrelavant
> > to the OS.
> 
> Hardware-corrected errors aren't irrelevant. The rasdaemon utils capture
> such errors, as they may be a symptom of a hardware defect. In a matter
> of fact, at rasdamon, thresholds can be set to trigger an action, like
> for instance, disable memory blocks that contain defective memories.

Sorry, I meant that Hardware-corrected errors aren't relevant in the
context of this patch, where we are errors that the OS has some
influence and decision.

> This is specially relevant on HPC and supercomputer workloads, where
> it is a lot cheaper to disable a block of bad memory than to lose
> an entire job because that could take several weeks of run time on
> a supercomputer, just because a defective memory ended causing a
> failure at the application.

Agree. These errors are used in several ways, including to detect
hardware aging and hardware replacement at maintenance windows.

In this patchset, I am more focused on what information to add to
crashdump, so, it makes it easy to correlate crashes to hardware events,
and RECOVERABLE are the main ones.


Return-Path: <linux-pci+bounces-32883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FAB10BA3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4505A7A8F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4E2D5A18;
	Thu, 24 Jul 2025 13:34:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51613BC0C;
	Thu, 24 Jul 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364078; cv=none; b=GddP4x7VQayeZO/VshKBsOB9Fj+Ogf9kXLgY8BBrz/bWcecENqK4KB1xlsskQIoW3Je0/KpEzraMeU1MuXohxhSBUTfJauI3+UTk9OhFVdLBhCC66xL7o4WvZRcAMq3wmakkdgpTgoBdiMaj5zPy+4b3xmIxYCTaD0dFY7bhedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364078; c=relaxed/simple;
	bh=MVJ3E/91h69I0bmDMezkRZP4rkHbijJOQ6KILSOiZCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5TyZl0Q/3dEAIVMrh+F5EwN6S8zkpA3m/nPOtrkN1yhMDK4zPqNQ2CJ3LaPpijwzi8y1wZPKKv1W/sUNXcbQ95y3JxmQeGjVTKVsluR+pT7WJ+Lkxt3SZs7X8jpFEshXmmiSTE5BBTu7RoEjAqY5dmjkqMaFUHrMlBiG9T2Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af2a2a54a95so162762066b.0;
        Thu, 24 Jul 2025 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364075; x=1753968875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fx+2jC1brmgVu9hs4XiOEifPBnLGokabrEM+R2kq2s=;
        b=pAH/Z8xdK0+QpGizQ6NuqWHfiFMAaYNv2Tov10c2YcezJaCxR8WlODx/ugavmVPyYR
         tqd5Vo0UvtLUm6eLDc4Luxbib+gfOx9C7/CktiAxXWZ+wHa6KyJlGvr2GvVaghkxfyDo
         Pqh0UIAP5Yw8nt5Zuy7vH59gMNumCN6DIj32OhTt+4YGhVrWc9AlSzEDR2qTscH/kYBR
         KExYk4vlp7rhsjqEB57TkSEgsybWgW+c0Lrd+x9VN9UO7oBARgzYDiH+p8Ch7RR1Kycc
         RadCJQ1UXAtnUmYIZNdiTtwO2t23EBinzyK4EhwBpCByd9w7VNogEEanIi+Fn/MX4+en
         IkKw==
X-Forwarded-Encrypted: i=1; AJvYcCW6cFmtOT5l0dGa5Mlo8J0r2MgHainsQ1B2CKc4GzsqIUTsyEEas8Iv2KIz3fDH7lBbOGtNEyg2MidNcg==@vger.kernel.org, AJvYcCWAG1MdyVBLDOi9Jx5nEvpF0tHcfsSdxV40ssk5M2hHpqqHn6GCr3kLtdT1Y6WveE1gIfXdmP3+i3rL@vger.kernel.org, AJvYcCWco3+clfJrs7fd0vyNbzmXEovTeIOkE70+NXEFtm2eagGvpPBcFvupu1PkRuYpjcmHz57u7z6rSp5A@vger.kernel.org, AJvYcCXtSym/WcXizoM0yWfgrKDp6DJBNRWmWW9HQZ8Nqctp0s2M2e7HWuvY9BHwdqoAhE6XfmUNbyKxCxyo/4TE@vger.kernel.org
X-Gm-Message-State: AOJu0YyefYRXlDMZXDTr4JRXMpR5b52SOMsZu3uTBl3rjV07HlLCiESl
	GekYevEwhtVnLYf4cd8lvItm+p/hb3AVLPpX3D+rIN48VVNTGj/5sbUv
X-Gm-Gg: ASbGnctVAr+M8C9xMzOwxb76ahgBTFuyAlW7lPUnJwcc+27lZoy6RNxQ984C/rfVEjg
	+csaBqeN0aBY/25B/pKnJxLZHRknFXg0UAeJtFpzTojuzA7RjfgPCzWsJTs10ZyFU/F4UWqm5TT
	szRmMZ2NCQPzgpVV063ALJKPHrx45Ps2LkrV2msHuMTMxagB4LkLvkbm2FSpsKsfW70YVKtm9gt
	OLY2zyTEkcOwO7LShWCn9qu3fVfcZzutwrp7TmLq80odssPA4YYoPt2QJ74v0TNAZZKilk8AQDr
	I/Rx8kN63uyBwXK3i7pYpH1/Vo9PudSfKhmFGcODqaorrbXGLSf8l+7j+pV9Iua95cvCVjGMtKg
	BbWI8AMxRZg==
X-Google-Smtp-Source: AGHT+IErTV5E5SvHgukSA8OS+U/Vctcx7DT/kAXhifsJMwbjohYquNlfTpV+af0AGvLRHpjhkGn6qQ==
X-Received: by 2002:a17:907:e8e:b0:aec:76c6:6ef6 with SMTP id a640c23a62f3a-af2f8d4fc6amr617861566b.50.1753364074854;
        Thu, 24 Jul 2025 06:34:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f861d7bsm111509066b.119.2025.07.24.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:34:34 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:34:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>

Hello Shuai,

On Thu, Jul 24, 2025 at 04:00:09PM +0800, Shuai Xue wrote:
> 在 2025/7/23 00:56, Breno Leitao 写道:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that did not cause a panic) and record them for vmcore
> > consumption. This aids post-mortem crash analysis tools by preserving
> > a count and timestamp for the last occurrence of such errors.
> > 
> > Add centralized logging for three common sources of recoverable hardware
> > errors:
> 
> The term "recoverable" is highly ambiguous. Even within the x86
> architecture, different vendors define errors differently. I'm not
> trying to be pedantic about classification. As far as I know, for 2-bit
> memory errors detected by scrub, AMD defines them as deferred errors
> (DE) and handles them with log_error_deferred, while Intel uses
> machine_check_poll. For 2-bit memory errors consumed by processes,
> both Intel and AMD use MCE handling via do_machine_check(). Does your
> HWERR_RECOV_MCE only focus on synchronous UE errors handled in
> do_machine_check? What makes it special?

I understand that deferred errors (DE) detected by memory scrubbing are
typically silent and may not significantly impact system stability. In
other words, I’m not convinced that including DE metrics in crash dumps
would be helpful for correlating crashes with hardware issues—it might
just add noise.

Do you think it would be valuable to also log these events within
log_error_deferred()?

> > -	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
> > +	sev = ghes_severity(estatus->error_severity);
> > +	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
> > +		hwerr_log_error_type(HWERR_RECOV_GHES);
> 
> APEI does not define an error type named GHES. GHES is just a kernel
> driver name. Many hardware error types can be handled in GHES (see
> ghes_do_proc), for example, AER is routed by GHES when firmware-first
> mode is used. As far as I know, firmware-first mode is commonly used in
> production. Should GHES errors be categorized into AER, memory, and CXL
> memory instead?

I also considered slicing the data differently initially, but then
realized it would add more complexity than necessary for my needs.

If you believe we should further subdivide the data, I’m happy to do so.

You’re suggesting a structure like this, which would then map to the
corresponding CPER_SEC_ sections:

	enum hwerr_error_type {
	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE
	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
	}

Additionally, what about events related to CPU, Firmware, or DMA
errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
include those in the classification as well?


Thanks for your review and for the ongoing discussion!
--breno


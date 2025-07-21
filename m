Return-Path: <linux-pci+bounces-32666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B9B0C7DA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3A3AD47E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03662DECD8;
	Mon, 21 Jul 2025 15:43:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09195170A2B;
	Mon, 21 Jul 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112611; cv=none; b=b3D/13gVM0i8Fd8dPN3eX9EVF3DyCDS7sTzn6dSRa24d8sMR4w+A1oD0K1EA+5ahOWJuYmJtztFdp9MVa0WN7SdBRTFeQ5gRtwXDk13VxIglo9KMVZbi8buW2irgMRrmmblRl+JvXcYjAanigQpqjLySIj15ImHH0obQpWRGfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112611; c=relaxed/simple;
	bh=FmHzynu9CSyBjY7snrkDKw/+CacF/IzAQo3vvCbvS+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByCd8QCoNqYkMEjhXbrUcpDxZFAKqh1S0fs6quqbVTDD4k+WYcPAKFuxRQ62GzcUFOI7KRAQ4HgsQYp8vZf82eEt7qmKKE3HN/Ow1OBGwkCOZF2CUzbojJv1cxjzSjlxGbHrjQMxt0T1NbAVvO/Y2BL2b/UX/H2iKht4WFEPlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo6978369a12.3;
        Mon, 21 Jul 2025 08:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112608; x=1753717408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8EMch7mkTjcU9bPeMD8J/i/5F0EvPo6dc4/iWe3Dl8=;
        b=cvlXpL555Dil8P857eWH+XR0hmotVtqiwaClLhIbwQM8fFgRMCg71pc5WimBpg3n3R
         HgnoUVeoEPskXSBEQJXGPg0sYfF3/8Womdc4A3/mpSn2P6HwQwE3f2hNWNyjViQxLfBB
         kLbEW19BLVfyawk93hWq71WxPxiCB64MM6s8TsQ35Z9cR5W/sm59TIiR26Cm+r7k9Bgh
         ObjAR+VQ1PiYNOFlB0vZAtjAsDPKuAoc3ruHb5VZ1G9ofb5ByNSOCKdE0BGjXaPFNxCw
         h917UFBmAnMKnNqQilXZOibIcgYOMitWHinTiqt51K22exqn25spTOEH6Z7la4dz6HWt
         PvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGXAmtW2G+HXtWvXhIOhCgPKMp+YT8G5GbftnOjlfPEvsl/hRF8Xnf/k9bc2wfH2wjMMkjSfaWbclGxa4r@vger.kernel.org, AJvYcCVlKN65A7hfV/Xq8iWUMWMfy2RNIBcpKTULF5lzJvjioWteE+ALpDeD7rf+sG5m7UMCgQSDFS72hTZo@vger.kernel.org, AJvYcCX+pbJClUaJz6cJAaQ0+XcB9a66mTImlkKTci4fcCAFOhPta6Tqt7AuH1ikD4DKBtXaEpXVG1eKfsMG@vger.kernel.org, AJvYcCX0/7jIwcIW/+uZhXY+GE0MiqueWKrKymmN3F8E22CgC+dRAEr7pKtF8bk2gwdEeA6f4ER4IvVl2w1e5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqRVK8GFOfzKtOeItjxOkO1b7C0z31vfSZbesXOQtubg23Yaz
	1eZB7W4F4uQoQwWOiKGaJzJ7ngSUujAUFDWiYjf8CDbp4Gh7eV194j49B/lt1g==
X-Gm-Gg: ASbGnctRkWi6JFs/Q/ch7+GmjJoHeBktZISeWuU7UYqBIcAPP5u6dw3GeBkAj8bYuhi
	UK4xW6S1pLTviFoHqYu4goyLGS5C9jUiPhpEciVCs1EN7Xp9HvW3WbofK8MvBqJWkKkL4AS2KL1
	luSeG3xcHwNe8SiKr3yYZaNTG+dKg89ms1l1NO6xJxmIdrRrP5hRYge50VVVLjER1g0mN8SezGY
	WH4mT8KL18HXsPfaLdGjQQDu/DWdFUO7Py2vXz7wh8Z2cWFgf9ZqkclasA7hviuX0kbvtB81hvV
	r3RPx/A4+oy81ar+JQJgU9EE/5wjtn7NlwAsYMnJhDJVh/gY/umZf0cJ0XEvndDhncHzuiclcYa
	vEAl2tnLRiPhbeVD9P4TRASM=
X-Google-Smtp-Source: AGHT+IHiVZajLNzCqasc/a84TFi9Eq0YagQ04C+1iS6aqNPgOjIXzg/tFI2BWhK3viZOkIp11MJmpg==
X-Received: by 2002:a05:6402:13c8:b0:612:b573:f4bb with SMTP id 4fb4d7f45d1cf-612b57401cfmr14728022a12.0.1753112608001;
        Mon, 21 Jul 2025 08:43:28 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f0a0e2sm5675860a12.4.2025.07.21.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:43:27 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:43:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <crxrexye2nmqebct6eisgkvpc7btrg6ckh5qr7tmhpkdnqys2h@6dpf2j6yhlxq>
References: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>
 <20250721135718.GAaH5HPinaKvXjM-1g@renoirsky.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721135718.GAaH5HPinaKvXjM-1g@renoirsky.local>

Hello Borislav,

On Mon, Jul 21, 2025 at 03:57:18PM +0200, Borislav Petkov wrote:
> On Mon, Jul 21, 2025 at 03:13:40AM -0700, Breno Leitao wrote:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that did not cause a panic) and record them for vmcore
> > consumption. This aids post-mortem crash analysis tools by preserving
> > a count and timestamp for the last occurrence of such errors.
> > 
> > This patch adds centralized logging for three common sources of
> 
> "Add centralized... "

Ack!

> > recoverable hardware errors:
> > 
> >   - PCIe AER Correctable errors
> >   - x86 Machine Check Exceptions (MCE)
> >   - APEI/CPER GHES corrected or recoverable errors
> > 
> > hwerror_tracking is write-only at kernel runtime, and it is meant to be
> > read from vmcore using tools like crash/drgn. For example, this is how
> > it looks like when opening the crashdump from drgn.
> > 
> > 	>>> prog['hwerror_tracking']
> > 	(struct hwerror_tracking_info [3]){
> > 		{
> > 			.count = (int)844,
> > 			.timestamp = (time64_t)1752852018,
> > 		},
> > 		...
> > 
> 
> I'm still missing the justification why rasdaemon can't be used here.
> You did explain it already in past emails.

Sorry, I will update it.

> > +enum hwerror_tracking_source {
> > +	HWE_RECOV_AER,
> > +	HWE_RECOV_MCE,
> > +	HWE_RECOV_GHES,
> > +	HWE_RECOV_MAX,
> > +};
> 
> Are we confident this separation will serve all cloud dudes?

I am not, but, I've added them to CC list of this patch, so, they are
more than free to chime in.

> > +void hwerror_tracking_log(enum hwerror_tracking_source src)
> 
> A function should have a verb in its name explaining what it does:
> 
> hwerr_log_error_type()
> 
> or so.

Ack!

I will wait a bit more and send an updated version.

Thanks for the review
--breno


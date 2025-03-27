Return-Path: <linux-pci+bounces-24828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DFA72E54
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C519E3BD288
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D4211460;
	Thu, 27 Mar 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vxn96Ruy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D7210F4A
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073227; cv=none; b=G7z63BK9IbjnKDa/UIV3lngIPC92OT3gMMKOKi8tcxa2K8r3SY6H/E+YnJgFjtRIGTQqxedL87JuDxamFp9z1N/QCTrtBIweCzp09dqmSjgXXaE+jSlX3rhGFu6hrCHKZz6i9+/gdqGrimR18Xwn+1GwcD6A4LiIFXcD7vrLOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073227; c=relaxed/simple;
	bh=PYINQnKycbXh8ZEgV82L19kwunYBNxMMAcYZj3hrdYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2WriZKN8T5HRj0dDH+2DG6esU2wcnwSMZxk5CSgZGjR4U072AOEKyeyYXiuOQx5hn+Lsx+4mqBZCNiMoxxkhGq7dQ1VpqQF1o4YTYrY0yrJek4zxi6VanwbYyRTpWdJ9AO7ZFppOTay2IJNv3uieo+MywGCWmpx8Gd+ub9XvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Vxn96Ruy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc45dso23027815ad.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743073225; x=1743678025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+3oYLEdjTqzY7ue0pi7WI8oniaxoWaW2vaMHk//k+o=;
        b=Vxn96Ruy1IXYHQbfans8tmw+NGXbXMFOMQK01lK+cPN9xW4CkU+3eElOy8XHia1JIZ
         +GA2h5B6P8gTHrJr1A+ropBRKsbN1YJMdvBcqCtfBBQpfOvB7+eu7itHwIphEpGzJLdE
         9jaNQQh7YMHGX65uTY23wC5kWs07Cbx0cmA6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073225; x=1743678025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+3oYLEdjTqzY7ue0pi7WI8oniaxoWaW2vaMHk//k+o=;
        b=DxrFI9cgUmZJpgt5xiYsS61n1eNkIXrIpSdOEZgriZqdRd2S+TmUGt8MSM1V1lYXIo
         JBsHoNuqQHU8HFuaPau6TO/O6RYeAAvTs+JoCt89U91jSQAUu0/Qbvpg9Ap0DOj83nTV
         /XaKcvhehEzSzmJTxWViWiO0j4o8ek3qQNq320AumPYIhASOLX5LMx9gcCzwUUAFPhjd
         hNil+us+SV4vHYjV5Lew54hJ3ghEzbXXi+8RWJcNOeE79xvgDhmCWzkZ5K11XmjilG7q
         L4TBdy846uI48mQ//QpRPcIwL/hDGtR/sbqq7svtlR6jjgKz0/85raaoNYykpLAjix9w
         GkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCrDRsk5W4ZEqBMdUNLLcQ1v8BWNJb/ovImb4yaupoucYsVzaThF1SUAL79oUQWrWACRHmFsCL94k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygCxQm8QkEdep9JgAfIRTN0ATSh/6GJEOec8RtCOmGGAzbr7jt
	aHqdews9w/xvU+CbjhMNlUZValvNEkNq9MiE+f0d2w8mab/+ME5gSc4bF30aZmE=
X-Gm-Gg: ASbGnctY9Oy5qzEcduPZStso9kqTVLx41PKyIVcKSoqha/TEdTE+zpQCpiEGGbvvVZG
	3rxv2x9m8W1yt6rNJxgO+mCKNZXFbor2NO8qFc/JEXqSJ06cQYkoY44Rzn4bE6HI5U4+n6foYqj
	7pgWJmCX+skDHZQIxN5BZzxLex5fhNyTZKAsRHWDpffsiSwhMWePZBGs3ByaIMTxpjCy2L7qUfv
	YubvbJAoqNMFyvoLYdWIqZRDWUivaY5dfj/b+Vrvgpze08L+kQ0qYqf+04ju1q18SMoqLY14N4i
	UDsUkk0nOeI3exLcW3vQTmBMBhBqeW/DX5o456imvp3DGADPWA==
X-Google-Smtp-Source: AGHT+IH1gxZZic6MFjUwMzJgoZ8YGYTQsOie+7V5EQMxQWaNdI6WA0iGm3+Xf9x6MiyTN7yeoRlPiQ==
X-Received: by 2002:a05:6a00:1743:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73960e468b0mr3936030b3a.14.1743073225242;
        Thu, 27 Mar 2025 04:00:25 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390600a5f6sm13932175b3a.82.2025.03.27.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:00:24 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:00:20 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	PCI <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	shivamurthy.shastri@linutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference
 __pci_enable_msi_range
Message-ID: <Z-UvxG4EIeO5zOgU@macbook.local>
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
 <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>
 <Z-LDdPeTsnBi8gAU@macbook.local>
 <CA+G9fYumyaftJ9FaK+74g5iw-v9RV4qDT-SLg1XGk8G7ub2EXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYumyaftJ9FaK+74g5iw-v9RV4qDT-SLg1XGk8G7ub2EXA@mail.gmail.com>

On Thu, Mar 27, 2025 at 02:10:21PM +0530, Naresh Kamboju wrote:
> On Tue, 25 Mar 2025 at 20:23, Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Tue, Mar 25, 2025 at 04:56:33PM +0300, Dan Carpenter wrote:
> > > If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
> > > ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
> > > suspect d->host_data can be NULL.  I could be wrong, but let's add Roger
> > > to the CC list just in case.
> >
> > Indeed, sorry.  There's a patch from Thomas to switch to using
> > pci_msi_domain_supports() for fetching the flag, as there's no
> > guarantee all call contexts will have an associated msi_domain_info:
> 
> Thanks Roger for the clarification.
> LKFT started noticing this issue on the Linus Torvalds master branch from
> March 26, 2025 at git describe: v6.14-1979-g61af143fbea4
> 
> Anders bisected and confirmed that,
>   # first bad commit:
>      [c3164d2e0d181027da8fc94f8179d8607c3d440f]
>      PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
> 

Hello,

The fix has already been committed to Linux master, commit hash
3ece3e8e5976c49c3f887e5923f998eabd54ff40.

Regards, Roger.


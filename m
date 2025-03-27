Return-Path: <linux-pci+bounces-24825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451CFA72BA6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790D61898DDB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B8207E1A;
	Thu, 27 Mar 2025 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbhOZPYz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2F2080CE
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064835; cv=none; b=Tmva/A/dDygYC3haY46AubaSvXRZOrQVOa+67UPR5bU+Tb/MEyvvQ3bJG4jfWH9W2sdMhH1BKKSH7TDp1S5sAD1YzN7l2g158700g+K/56FWS8CYbxGbJ19rcEflLK8sgAd0IPfageRf3g84MTei24AkuNUGioe3Nhm/PVHnH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064835; c=relaxed/simple;
	bh=tX45f4SgJzV0BzxhEgpd0/lEHTr9TcXiXqeGEs6DGTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cm/PiF2H0o891LXBvQZNBd+NQqrRjjnl9Qo1ogbK4awlkuHENbqzo2j5mfvK4+nREG0x84/0VD9weXcoEmBZu4g6xGJVZRPNvDguy/27kfymvK1cke0oXAscDChv75JGH5GpIjxRGc7203gWtK+aomo4IbbgiUWnoBp/otR6/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbhOZPYz; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso767789e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743064833; x=1743669633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drLMpc31hHP8DJqxvldHizaDERYv7LoBBB4sM1BPDHc=;
        b=WbhOZPYzJBZFpHvI7EN/ARNKhvi87i32PHvu/BTzI4E1jKzQHtDKyGPVEu75Y50B2C
         p7v0sHsEnlcA/6wHireBajjjtkfaUGR7a4/0Ofv7/N1u/h3P6wJ0PqdJugLSBSgGJwo7
         SerLB0E2m9Hd+K88wwhRYsOqsAFhZ2AZH5R/vygL2x0F+cw+QfERQ/g29TIFZPaoTpG5
         hRr1kVEPXiz8SysEjLnsZhgzWZSDsXsYCmqlcg+VH4JZU+wdib/h/QE14oa9BuqaxNET
         GuO3Uu4CADgnFje1B0Ec3qq2VBTFdYfRlyRpOcQt5v692UzQdYRbitRpaBQKwAULMSRS
         XN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743064833; x=1743669633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drLMpc31hHP8DJqxvldHizaDERYv7LoBBB4sM1BPDHc=;
        b=Kj8LFd5WGcx2TsnzQgaM8tfCznA64GvGSBciJxFWpFN55FPD8TKfR+6tKIAut35VTd
         aKARoGKqV2MoIEptY6oM6k6SW07aNCghxGxaipjzYTaE2y0cl4kvVhlbpkPBY5vi+6jt
         MOX4//bQPhD0WDrUbXzQ4/nosf6MFj9s+pA3kMpv7E1RONbXUghGmVjSAuok38uLAtvG
         nnKM3Iy0F5e9lBPO15OxsxHVpMuidx+fA5XtaWhG+KPkI5p/b/iKTtFvE0Q2iwOGmNNh
         hd2a/k/ES/MYz1/vBnSlluaj6XdE9xV6MQIwwCLvmLAW8xwy6Icqxki5Jbs1TNp/YHwm
         wWtw==
X-Forwarded-Encrypted: i=1; AJvYcCXlcIfhAgOKP96g3VW2PzQd8pQDk7S7EjewEURNFdX89hNIrK5h4HepNIkhL77081g6eE3MKdfXW+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4iGDbemaZmmipk6PSKuOsLR9HZRCrXDkJT7GYHk3IJ0fxCLW
	iVNK81p/dv0wkxQ1xr/eOObFo4JAcnXltNctWUbthZIvRn5dTkhxoRaz13sYeqoJPOTAAPcmP7v
	xSMUxjq91byHzfLY31GjsxvfyCf9Smfh2HPEa3g==
X-Gm-Gg: ASbGncvR2nJhcydmlZK32U5uAd0oAUs9OuQkT+zkP4MC99FAuvTZJXUZyCHSYVj+oVx
	bzdFbEPS9Qb+24kPfmjc3E/hjVtsrvvuZDlXgY1wB4wr7dPmqoM53no+WlT5Ootn4x8aahy02/e
	/hwTpq67vReUgP8Bod5ryW2i5Y2xVWK9HGROiwQ2XuWwpQgfQZYcGue588tCI=
X-Google-Smtp-Source: AGHT+IGOGcjqwfMP9mXiNbxB6MtctF0dET/SKTnUAdsnVBHT+F80EMzrMsZihZOJ8DAzX0n8EDiMCpkMZMySY3I6Ims=
X-Received: by 2002:a05:6122:8c02:b0:520:9688:d1bb with SMTP id
 71dfb90a1353d-526008d082fmr2054719e0c.2.1743064832775; Thu, 27 Mar 2025
 01:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
 <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain> <Z-LDdPeTsnBi8gAU@macbook.local>
In-Reply-To: <Z-LDdPeTsnBi8gAU@macbook.local>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Mar 2025 14:10:21 +0530
X-Gm-Features: AQ5f1JpOCRetHukvs6jfAS61Q6C2j3250sLzDARLwQB5DraQTDosJm5QyiXZRkA
Message-ID: <CA+G9fYumyaftJ9FaK+74g5iw-v9RV4qDT-SLg1XGk8G7ub2EXA@mail.gmail.com>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference __pci_enable_msi_range
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, PCI <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	shivamurthy.shastri@linutronix.de, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 at 20:23, Roger Pau Monn=C3=A9 <roger.pau@citrix.com> w=
rote:
>
> On Tue, Mar 25, 2025 at 04:56:33PM +0300, Dan Carpenter wrote:
> > If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
> > ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
> > suspect d->host_data can be NULL.  I could be wrong, but let's add Roge=
r
> > to the CC list just in case.
>
> Indeed, sorry.  There's a patch from Thomas to switch to using
> pci_msi_domain_supports() for fetching the flag, as there's no
> guarantee all call contexts will have an associated msi_domain_info:

Thanks Roger for the clarification.
LKFT started noticing this issue on the Linus Torvalds master branch from
March 26, 2025 at git describe: v6.14-1979-g61af143fbea4

Anders bisected and confirmed that,
  # first bad commit:
     [c3164d2e0d181027da8fc94f8179d8607c3d440f]
     PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag

>
> https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Lore report link,
 - https://lore.kernel.org/all/CA+G9fYs4-4y=3DedxddERXQ_fMsW_nUJU+V0bSMHFDL=
3St7NiLxQ@mail.gmail.com/

>
> Regards, Roger.


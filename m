Return-Path: <linux-pci+bounces-36640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A53B8FB4E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E0516C664
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4152857CF;
	Mon, 22 Sep 2025 09:14:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38621D596
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532491; cv=none; b=qwIe2qeVn5aUw114uUeI0npLNBkpELhEZtf6tSIRjnlygARgqDNcUZQJlGr/4RJxQeVE78U8Fenp/9zS4b0ONc+OWB2EZxIYkNxlyPSPtg5zbq1XfB06mG5+zEky4445C6gOosISS/XxlCmZyti8ZvIJ8beb49m57fnmAsCYiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532491; c=relaxed/simple;
	bh=6KHJcEnIVlCxmXhX0OhfMBaFaMVz1ecRFiMG3CflXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUuWt7OClCBCTFMmBnatKitDGJd/pPqcUHlczIp2QVagn+lyjZH0IL+bp6mMu49HkvsgG9Wsv56Bhp6+3o99HfRwp7S1qQJZbsHbqLgLUVsidKkG7FkaNz7SwEHqG0VGgXc5qHfLUJJ9nlDMpJaM7SVLVR74TPTyakkqqz5wpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89018ec3597so2660021241.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 02:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532488; x=1759137288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLwAIW/7uzQCGM18tYiubcKSm7XfD2QdDVkO6Wb+rco=;
        b=tNv0pnbWvbtjgnwrFFOnMV9NJuF0auGUSm41TcTx6zg5womiBAsBEyBZ+iuiBBf7pF
         S4nueSiYSvMdReQCyE+EokEo0NRI5eK9MW5wiCOABFdDSyKS3IkuTKo6D24rvE8esMB0
         H8k+C28iJAwzIiE6FpXvT3I2O4fgBBdQHxMZ+ji//5ybztXiGoCjvGmC+pu/BcElEBfD
         kcHCyMOQ+cqlkOCSfqAoF13AQRs8B4wPmGFkmV636vcuADhLkMCh5VxY1CIh79FFjdAe
         D0RFQxFUOl+PYiHGTX6UdIU6D+CugS1r28cF4hkEyEqdXkp7e+DTxeqvvalasIG4LI7B
         jccg==
X-Gm-Message-State: AOJu0Yy2yWY5BV6wiZtXeSc4jnC8rwxHbakuSSPZrK4ZBwHHqJ2rTidQ
	ZFqoGabQ1DfU22GfflpG8HZaqpbkFBaF6GadPAqu03MpPzSlE22EYzm2W9aPWwE4
X-Gm-Gg: ASbGncuC+h0b0SFGEvicRaJJcNJ1sFI55VDFqbNpJNGiZPsNPAnWdZGGG2mKa9iaKHh
	VQ7jynskaFdvpZ0NvU2Dm6uyGDVILT+DOz/4cF78SVyJzN5OWdgiqGDfG5cliPUGwDXHj1KXusj
	MhIUnHwwHbmetGTp1gQRj+gyU8QZqWTMmWm6M0AefDVC8NMnhEUViXlHGCooks9J5S+XUO2IUvA
	2jwXtiAU8mRmjh4Sua/RQWfeQU8bkJUeBAU1dD1NoIzPcTp6OX1pU6upMXh81Q7alhd4WQJL/qY
	FnD4KhZa9A7Jfkjpgb5K8X/NhwZFy0kL97P1/BQ0BGITa+xguj0I0/39m0p6DLkWsyhBPmoKbyB
	+5RjN0f1QqQXhB1o2zoItzD9/t4hlvAzT1B7vETXqYIuXnDn2SXFEBNDnQ+bu
X-Google-Smtp-Source: AGHT+IFwUrFHNR7/EglN2qnOjR40BHxgUOhj4DKiT/as5yjRPdf47a8SlLAgY3jztkyllJeFKtOy1Q==
X-Received: by 2002:a05:6102:3f8f:b0:51c:77b:2999 with SMTP id ada2fe7eead31-588d9c545b3mr3955430137.2.1758532488230;
        Mon, 22 Sep 2025 02:14:48 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-579ed35f674sm3139050137.7.2025.09.22.02.14.47
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:14:47 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f8bf5c518so3166565137.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 02:14:47 -0700 (PDT)
X-Received: by 2002:a05:6102:3053:b0:5a4:420c:6f94 with SMTP id
 ada2fe7eead31-5a4420c955emr87759137.4.1758532486911; Mon, 22 Sep 2025
 02:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 11:14:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
X-Gm-Features: AS18NWCy28oVP6aNkng2frgdJoNjIFwDpm5d2hI--F1SYyy5KYW3QCIN2mFvGL4
Message-ID: <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

CC tglx

On Tue, 9 Sept 2025 at 18:27, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The pmsr_lock spinlock used to be necessary to synchronize access to the
> PMSR register, because that access could have been triggered from either
> config space access in rcar_pcie_config_access() or an exception handler
> rcar_pcie_aarch32_abort_handler().
>
> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
> which triggered an exception"), which performs more accurate, controlled
> invocation of the exception, and a fixup.
>
> This leaves rcar_pcie_config_access() as the only call site from which
> rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
> called from the controller struct pci_ops .read and .write callbacks,
> and those are serialized in drivers/pci/access.c using raw spinlock
> 'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.
>
> Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
> raw spinlock, this constellation triggers 'BUG: Invalid wait context'
> with CONFIG_PROVE_RAW_LOCK_NESTING=y .
>
> Remove the pmsr_lock to fix the locking.
>
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

Your reasoning above LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
one day, breaking your assumptions.  IMHO, the mechanism behind this
config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
Kconfig option for lockless config space accessors") looks very fragile
to me: it is intended to be selected by an architecture, if "all" low
level PCI configuration space accessors use their own serialization or
can operate completely lockless.  Usually we use the safer, inverted
approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
do not adhere to the assumption.
But perhaps I am missing something, and this does not depend on
individual PCIe host drivers?

Regardless, improving that is clearly out-of-scope for this patch...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


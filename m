Return-Path: <linux-pci+bounces-42730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27599CAACDC
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C99C130069A7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542729E0F7;
	Sat,  6 Dec 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fJ7XDcod"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FC1EFFB4
	for <linux-pci@vger.kernel.org>; Sat,  6 Dec 2025 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048899; cv=none; b=STD8ofZCRs+1sNXuCnnnzFMUJ/Jptk2e3yuJIjd8nTBMn28v1iitlWx+SBFplTepszE9QgMBoFVZhtTONie3TlQayYjVUObBJtRTG/fyCHO9fUgqsPWLy0T6yPt+mCtbkaPoyog1o7hT8ACm9yDGPGqOBQJJgdyKOBE1A6kUJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048899; c=relaxed/simple;
	bh=hgNUVmtl4mfYg9LW3etbEEze6yO6cETokzqvLHjQeAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkRV/39dqCWza2wlHRTLmYrjH/La/HciXUU9BLS5oEqZtgJHG0yXOr7DegKI5Cq865FE9u4BnIxfShLfLccHh46aQeweJXnHjRvC4/PGvGjkC3C4PqeouHbvNxHL36UqlrN6PKSKgC3PkSc5c4KfQ6FnHaBRiFHFq20yzDGS1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fJ7XDcod; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7697e8b01aso331352166b.2
        for <linux-pci@vger.kernel.org>; Sat, 06 Dec 2025 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765048895; x=1765653695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlnfGUYYvUGsH9rhKskM2mNvUgt3d/8KYaqEF2qulEo=;
        b=fJ7XDcodgqXytOEVhQzZsADYPKnau+0OmN8BFX0uTQDpQ2Xhp01SXCTURijSCtDgWz
         tSUGwvy9VW9fhaM2WuyAktE568InuhIig9WehIJx/GiyHQtJlDahflPPKAg8SFJddzOC
         gppxZRH4XB6+dlomGGZ44uGZZzW1vXE+YMNnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765048895; x=1765653695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlnfGUYYvUGsH9rhKskM2mNvUgt3d/8KYaqEF2qulEo=;
        b=p5z2/e0CVep9oRG1P1BdjEhVpKqJw2H2A5eFa+4Hfb53yd860wWotl5wmDDMe/dEQh
         pWW0d4vs7Py5qRjfYh89q620Z6v3C1mmWQalnqgLjU9CEvq0rXMhRzMDYUspXD13CKR0
         4B+grNGH+L2Q1OrStdm1Qt9/vymc3jaYZfoGPnKMXdONBnyeRYJ1puZz6AaizmoVrb6j
         UFUbeucHop8LndAg+lTT960VaxI8A0OBj4cmakEAEIHuwG3WdTOgoDZA1ZN0AnP94wDE
         EzNtdWFxaI1Igo652mztjo+Dl8ZqdqIVm2rFjnkucH/IGztg+BpIQnADTFD+8xNNEhSM
         Hk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUi6nomtT/akhoABwFgOaf4kiZn+Mn4hpxuDbFDenjFuLkx37idLdom81x5DVQ5u6xaOcuYhm2minE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyN759Rss3yV83QPHSEjdDImIRrE7BY2KmgyFhg1TZ40qerahK
	h7NnmBg+kPSuoYJQCV7dEJ5chV9Rfv1b9RS3wCtwIbgtetrRtf4JLHURhtjJRP4aIOxPW3HLnVB
	C27wwJw8=
X-Gm-Gg: ASbGncttPHvueyv9ySGglexQCc7B2+Ks/2vEL82Pg/cZCwsus9X/xaxG/NL+0fs4HtC
	KVlBvGEkXaHC1EzQ0Ibpp7ykoA1hRQjnJvH6U7Ibg+2mkt1yeoHCLDqKq2ChrnCvrn/N/odEXUy
	2BNyVPIXRPehEWa2c9TRyxPLT/bziShYRYrQVsY6CDKOL7e/6VXsSS9UECEV/bi31NHL5La+iLX
	4rg+K+cR6yNEDkia95oFeXQPCiYwofMRti7k5RL6NC/MV5eqKcHxikiyIqpz/eH+7DUHPGZZdu3
	vUFkUEQUSHPJNXFfc125isKeLfaSTekmDujOHYeTuiWoaJhIQIxWnkAP5vW3z+yGXFJEjXFdEgp
	ToXgmPdb9D8/OzGM7PHXpv3ianOZRz5oGSuQFLtCM1huUL4gHXuR6bpw/6O+1cvW2LOirKuKHuw
	Oz5WwXpByz1LzAq6Zjw0kLMS92YN4VB852ddOjNu/sR70IYA5Tqjb0BLiVAEJ32/iCF/q4B2E=
X-Google-Smtp-Source: AGHT+IFaH+2gCS6EueKEx2sFRd4MlZ0oUDhwUtO31cirMlQ56ROegmszPS0I4C4uU0/QlmWZguqULA==
X-Received: by 2002:a17:907:608c:b0:b73:74d6:d360 with SMTP id a640c23a62f3a-b7a24753c46mr350143766b.40.1765048894691;
        Sat, 06 Dec 2025 11:21:34 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec2d8csm7028017a12.5.2025.12.06.11.21.32
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 11:21:33 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-647a44f6dcaso4357965a12.3
        for <linux-pci@vger.kernel.org>; Sat, 06 Dec 2025 11:21:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjbO49V43pSA6issnZicEwgW0P2jQogiE0viDC5642R/NMq7Xf6Mc7k4+Dc2PkELbgEw7P4s8pAHA=@vger.kernel.org
X-Received: by 2002:a05:6402:3512:b0:641:5bb9:fdfb with SMTP id
 4fb4d7f45d1cf-6491adee818mr2590328a12.33.1765048891924; Sat, 06 Dec 2025
 11:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
In-Reply-To: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Dec 2025 11:21:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
X-Gm-Features: AQt7F2psuKzNOwy7lHUf032auHjsHnauIDDjO0WVF0-O2w7bGqwfN-hMc0aXYO8
Message-ID: <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCIe Link Encryption and Device Authentication
To: dan.j.williams@intel.com, Alexey Kardashevskiy <aik@amd.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@linux.intel.com>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 19:08, <dan.j.williams@intel.com> wrote:
>
> Alexey Kardashevskiy (4):
>       iommu/amd: Report SEV-TIO support

Bah, I've merged this and pushed things out, because my allmodconfig
build was fine.

But more testing shows that this is broken.

The amd_iommu_sev_tio_supported() function is only defined for
CONFIG_KVM_AMD_SEV, but the <linux/amd-iommu.h> header put it inside
the CONFIG_AMD_IOMMU config option block.

So if you have AMD_IOMMU enabled without KVM_AMD_SEV you end up with a
broken build:

   ERROR: modpost: "amd_iommu_sev_tio_supported"
[drivers/crypto/ccp/ccp.ko] undefined!
   make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

I've pushed out a minimal fix that seems to work for me.

Please check - and be more careful. This is _not_ some kind of odd config.

              Linus


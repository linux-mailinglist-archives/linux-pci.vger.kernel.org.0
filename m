Return-Path: <linux-pci+bounces-31103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BAAEE6C7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E41BC15F1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE428C2C7;
	Mon, 30 Jun 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIn8dNDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911672613;
	Mon, 30 Jun 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308322; cv=none; b=KM4x5qvEAUC5eFWMn3irez6Vld0DKgo5ueINEeb6t5oM992q9fVeRGOKTvK1foVfc41XLJ2d6vGvhIKm4TkfrS0tYRSwMm719NVbr10utWsCZwj7q0Z0jQt8nboRZCI6iW8RsF7vKgs9COcE2eiplWI1tTmu5bi6YzY4iGST0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308322; c=relaxed/simple;
	bh=cg5QB42byw5/eyDVnJ7rJQrWcmUM7VDs7F+Ui6B2qiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxrFq9cUNgKQhj0aEx2RvZylPiloOhkVLtCvl9VyeLQ8r/80F8wG1dsSe8DhLuPtOtfuGRrTrNxs89biomMDi8xAZC0JwEhZTQOvtrirooA5mmZb4aTWyXz91wS8hRICfuAx98kCizM6qGadLlJGVdO1RCKwPftQFyYvUyE7QfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIn8dNDW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso48333691fa.3;
        Mon, 30 Jun 2025 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308319; x=1751913119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai6tAv34puQfBTGh9QvYgWi5UihLDDoPAxs87G2TzgY=;
        b=PIn8dNDW/d9jv1JQmH4PZS552mEzVRW3DTjOzAexv6QWmOuE/U+DBr3S4ZAtxAweqz
         dSGIgap+ioS56T2JTfC7urH2DP0mh0JTf5d+2g25NbdS1XXcluCRYND3FXfwpQeRTAUC
         hXb8s8LWr954l9UJc/R7aGD13oMmvLMFUNyMV1nBMmgofSmn0cvbDUCOsTzPpgAyrFpS
         qU+M4HPAIPLIM24dwXPP1rzSHXRSo2DXwx/JJBA/stlnt+rC4CLpoI4YxOr7o+AweAfk
         u0HZTqXt8oY3HMFpYwOHezRgoZXvxRrbX+zv2GKZqfA7vTRM+NRamIQF9zVP5r/yGGbL
         BMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308319; x=1751913119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai6tAv34puQfBTGh9QvYgWi5UihLDDoPAxs87G2TzgY=;
        b=YJCsEXJgXUbLuwGAW7LtBDzdwCVrcDIXR8dLv6+H3NhYBmbiyiu3n5B3NEnoqEYT5w
         rdTwUQFCxDIJpd/G3UmpXW/sEvk8RMtTdEYNkIITlX/Kq7rLFnc+RCs6xHxYoyW7CoWu
         uPdEdQ9Germ4dH5556HGsV2urab8njVsD2idm4XpM90sjQaPPMOaJ5abJftEb8WERIb8
         IgoKSK12ZCpRSkPK+UOk1i+ndynRlJi9V2Av7hIyOS1VtKRPwuj1geM7g0+HK2V4RJhY
         2d4p0WHeaeUwcQu/TPRY3A1orPcVg19axfsU8s+izKtbwMmPCAptO9EEDUTkob1Cent0
         FQFA==
X-Forwarded-Encrypted: i=1; AJvYcCU4qxkKUTiWszud5upcoO6BoHz7oIUDWTPGVcnDjK26iuiABA6O8foFD6ILTqyi/w7pp1n0xsPOCHNB@vger.kernel.org, AJvYcCUCpZflwYH2qm49UlF26yeWizucelDvfy/cSNX/yeN8YxEKKdymGX42AAttk8ydUOC3L1gIuLkTuvGI/PM=@vger.kernel.org, AJvYcCV0KZXAFkww8yhOy9kFeGnDV+GoadYqOcJkFvzkxnym1/r8CnxHd6mzCXmTXTplr/0o0XXHWoi7Akc=@vger.kernel.org, AJvYcCWgrO0v89lfLOyHYp3LrRJx+4Pk/LnmB3HrnF6s5vGvdoCAPm4PWMxyPWZQTvz5m7TiqqlGSYiANN0DQRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPjMKAhOmG2+m2z/touqSDn90gCZv+hqbJHEKh3cMjJKm9QiU
	LKWJE2HkQgpvnS49BhR7iGjQh/RzxjH4l55mWCY10skO4qOGCmkYnbq+qi0VqNkSLbdKs+QL0yM
	jeqjKhBL/wa4Ctv0D3A4wyJ2Qd03tvzwO+5l6xWE=
X-Gm-Gg: ASbGncsuPhilzNOfF43XQqQt3kk8U4hY39HK0OgHag5t18PvMcGtwAfFgxmWSW/l+6b
	Lv5uuXsglx5dM++wi7ET453oaaE/NBRGHMt9o+y+BDzT2Qfq96vkr9Uc2yZXMYJ0tqZ2bQbsea+
	REUdL0JCzBAv5sAF0Tx4kfVlU2p9MpyYm8JnUZ+SoEyNk=
X-Google-Smtp-Source: AGHT+IFFlmIm+enc9TVfwVEzI5i5UrpTUkxdFArCLPINzmek/bvv2i80hFOIl+yU0HrPhUHbgUTt5az/k7cjhYRZ5tg=
X-Received: by 2002:a2e:8e74:0:b0:32a:7826:4d42 with SMTP id
 38308e7fff4ca-32cdc50d72amr34297321fa.31.1751308318788; Mon, 30 Jun 2025
 11:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com> <nz76wk5yqytag255jijxlyuodzpo3fm6d5coxutqrd7tgomzxm@pwzvpv4frjxu>
In-Reply-To: <nz76wk5yqytag255jijxlyuodzpo3fm6d5coxutqrd7tgomzxm@pwzvpv4frjxu>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 30 Jun 2025 13:31:46 -0500
X-Gm-Features: Ac12FXy1RvVgqtIu_YbU3P5gESjgnNVHKx_yI5vyivJxu6NSFHgJgYSIdjaX3dw
Message-ID: <CALHNRZ9WYJef8+QyCfpkxLhUj_KRY=kZisEwq=arrTxXXfCknA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:17=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, May 07, 2025 at 10:25:51PM -0500, Aaron Kling via B4 Relay wrote:
>
> You should always add the context of the series in the cover letter.
>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v6:
> > - Remove unused debugfs cleanup function, as caught by kernel ci
> > - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-0-=
827aaac998ba@gmail.com
> >
> > Changes in v5:
> > - Copy commit message exactly word for word on patch 1, as required by =
reviewer
> > - Delete remove callback in patch 3, per request
> > - Don't clean up debugfs, per request, which drops patch 4 entirely
> > - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-0-=
088b552c4b1a@gmail.com
> >
> > Changes in v4:
> > - Updated commit messages for patches 1 and 2, per review
> > - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-0-=
556a49732d70@gmail.com
> >
> > Changes in v3:
> > - Add patch to drop remove callback, per request
> > - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-0-=
c11a4b912446@gmail.com
> >
> > Changes in v2:
> > - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
> >   building pci-tegra as a module for arm
> > - Drop module exit to prevent module unloading, as requested
> > - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-0-=
c0a1f831354a@gmail.com
> >
> > ---
> > Aaron Kling (3):
> >       irqdomain: Export irq_domain_free_irqs
> >       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
>
> I need an ACK from the cpuidle maintainers to take these 3 patches throug=
h PCI
> tree.

Reminder about this series. I'm normally interacting with the tegra
maintainers, but I don't particularly care which tree it goes through
as long as something that works gets merged. So, can one of the
cpuidle maintainers take a quick look through this, please?

Aaron


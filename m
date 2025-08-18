Return-Path: <linux-pci+bounces-34221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FFEB2B09E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDE3B9F33
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE1266EE7;
	Mon, 18 Aug 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQVOqmPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04904263F43;
	Mon, 18 Aug 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542404; cv=none; b=n1Nmr58nH5pyZEFEc0u2FxTUs4MxvOr1L+WyGNvGQpzr0GLB0uSZ20W+3cCcEuXVqrpzjzL1UGtMhVosaQ6U+Yn6bGUTwSTvIMj6NevSoO1XmKQIb78dWyuQV7m7DRaNTYKn47kTwMwnNKo43J67wTrML+rjtfg7WnHRi36+eLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542404; c=relaxed/simple;
	bh=dD5udPYcdw+R2VGmCouPujWySrsi6OZs03UQR0ljOZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ2/MK5pGypUx3GN+5LGPJyxC5crLe6VcaYOxBU2bvcRZtj97ylR2RFE2+/kQW+IShzRFf1Ex7EEQlDW8BOW9FVOUofJsf11vSvy+udNqw6XvpxlY9pQkJDiilL5/iTfdUd9DpHlYUIBo+yIZcRcgxGVjFZ+PeZSIWBDTQEZ8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQVOqmPP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce5287a47so4068580e87.3;
        Mon, 18 Aug 2025 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755542401; x=1756147201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmM7ItIjaraXAGSyLnrAC2qMTcYYNxGTgbCl2d6rdYM=;
        b=mQVOqmPPcGN24UCnYHWGzvB+/5riYf+n4hoIQM94VZ0FpxjtXjCF15ct/WkkU27OlW
         UDH7siQZwTB/i9wLpwqOlaUi2vnr4QjEzHjHIca44xBxbnaGMp5xv5DwgZV/WiGk78sA
         sdo3BzER039vDGy8sCI1bwaAMqRNLWIyPpmumwyRt0RKeD+M5DMbMzp7yschbNL8o1Tr
         BS565p0FXJr8RZ3ZFPG7mpldyDbrwwTyoGZ/IrDO6MLJtRSiWbS0To1Y1KFY1Iym5jFb
         lx8ypF/WvhpCTVyduxytUH5x+NyUwLVcz2dSFHiJ8AJ/YWTz3dUT7Ls1IDHHjhbP3vM+
         vjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755542401; x=1756147201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmM7ItIjaraXAGSyLnrAC2qMTcYYNxGTgbCl2d6rdYM=;
        b=J95gKfIZrldek0XJuKn4ltgxo4xkIxFjolWcneCNjxXkLtmFDLYW1Edk5X2zCS4+RF
         suF/Br0dZgIMhdiK4pCuekZjO4cParF3Ip5cBbZfgZy1NUpI7n/wC4YL17yE6Gph3hgT
         2jeAcRGLqT1OTbzusBglOEZDPynLZkShpW/9u8MxqrIH6/nKf/2vFGnSDQ2YptMsk1AX
         RYfcWVH+d9jjq+oM5275bQ1gjrmV3qhf+2iUCsVVoO1wwqaZWKTp2O4MTTAZ+4qrgOUI
         +47TovLSbiuHQmb7Otxz6w2bC8DxXAZB5PUXgkKQOT8lMT3PD8ODlU2GRmplQ8nurcTK
         atUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6a87qakJ1JNySwpzBgjGzzcbqRMpx2vHB2mLLz4sCFR32pFFrdAwqupDYwLk+Vv3YT3p0oIRXjgM=@vger.kernel.org, AJvYcCVacGIm8sL/gB9Tbzy0DPxCIiiW/w31EjH+ACykyUNJjd/jJWE8xHQPnZt1ouXohf48Z4ijNinWHc/TrRM=@vger.kernel.org, AJvYcCXXN5xyeBlIAA1BOAmT4x3YiyKOdajDA28gtfIvoJP3+W1jeqGI/lpMeYDdlkXteUIeUOS9PsUjBGSp4oQ=@vger.kernel.org, AJvYcCXhX8tZTBz09t/xNdh8xG8dXBJFFYcugyE7Vp3Z/DNx6VSsfNArteECWWRGMHtsVhRSyJtv2jQNiVmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzChb3Y+mgWkhpxiV8JBf7rPlMBuMKN5stnuu5G1j0BY1xTEEfW
	jsxDzxmQ8whBvgq1XkD9X6UB38vZHNxilq3LQAoQ3dWeLPkBLrGtlVVHThL6Ly2MT273PRm5Z5y
	SDTKo0Y+zMsN7kj1G4jPG5r2p3GCyELQ=
X-Gm-Gg: ASbGncvEYaDxloBcvQRqK+gr+dMDiDRMglUK1R6Hs7UrwceON8c+Homak26u6oPAiQb
	FU+FNwoxPYGnZpPvsgqyMP3T6ZhBvgutKsZm6n4mFNyvJh3ErRg+9CrHKPpmq6gxqAJ9//lkF7i
	IIela6bPitoF7kjiwzaIaKZ2adXDg3I6tnbW7uBhlF5vUfWH658WEsNpDVSofFSVeXBrce7Lz45
	z4MsUqMxHmhmfc6yA==
X-Google-Smtp-Source: AGHT+IFg0y+xEYU/HgP9HL4d5sN72FK5jZ52E7S9n06a5baoH9Fv+JwoDsRpAOqS2jtsH3a0D5vcAWadwlMcLhp9uK8=
X-Received: by 2002:a05:6512:6418:b0:55c:df64:3780 with SMTP id
 2adb3069b0e04-55e00148f8amr46834e87.50.1755542400596; Mon, 18 Aug 2025
 11:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
 <CALHNRZ9tOJccZ5sQjvkoPe4-+VUtWRxAzAOUainGUCs4+_RBCw@mail.gmail.com> <omchhpbmsydfcsm6mzmbdiupsrxmxxvkxqf33fgi563akn76vf@vkc7k2zhlvee>
In-Reply-To: <omchhpbmsydfcsm6mzmbdiupsrxmxxvkxqf33fgi563akn76vf@vkc7k2zhlvee>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 18 Aug 2025 13:39:48 -0500
X-Gm-Features: Ac12FXyL-zgUyoJv4HtF59wJM8pPidfHQghJAOvbeDQ3uqVg48agQEUJcLS4nZE
Message-ID: <CALHNRZ8PZzseaTSCvhM6o7jMVYtVdHTczurXh1q+DY5MG62+DA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:01=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Thu, Jul 31, 2025 at 05:01:55PM GMT, Aaron Kling wrote:
> > On Thu, Jul 31, 2025 at 4:59=E2=80=AFPM Aaron Kling via B4 Relay
> > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > > Changes in v7:
> > > - Rebased on 6.16
> > > - Updated mailing address list
> > > - Link to v6: https://lore.kernel.org/r/20250507-pci-tegra-module-v6-=
0-5fe363eaa302@gmail.com
> > >
> > > Changes in v6:
> > > - Remove unused debugfs cleanup function, as caught by kernel ci
> > > - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-=
0-827aaac998ba@gmail.com
> > >
> > > Changes in v5:
> > > - Copy commit message exactly word for word on patch 1, as required b=
y reviewer
> > > - Delete remove callback in patch 3, per request
> > > - Don't clean up debugfs, per request, which drops patch 4 entirely
> > > - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-=
0-088b552c4b1a@gmail.com
> > >
> > > Changes in v4:
> > > - Updated commit messages for patches 1 and 2, per review
> > > - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-=
0-556a49732d70@gmail.com
> > >
> > > Changes in v3:
> > > - Add patch to drop remove callback, per request
> > > - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-=
0-c11a4b912446@gmail.com
> > >
> > > Changes in v2:
> > > - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
> > >   building pci-tegra as a module for arm
> > > - Drop module exit to prevent module unloading, as requested
> > > - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-=
0-c0a1f831354a@gmail.com
> > >
> > > ---
> > > Aaron Kling (3):
> > >       irqdomain: Export irq_domain_free_irqs
> > >       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
> > >       PCI: tegra: Allow building as a module
> > >
> > >  drivers/cpuidle/cpuidle-tegra.c    |  1 +
> > >  drivers/pci/controller/Kconfig     |  2 +-
> > >  drivers/pci/controller/pci-tegra.c | 35 ++++------------------------=
-------
> > >  kernel/irq/irqdomain.c             |  1 +
> > >  4 files changed, 7 insertions(+), 32 deletions(-)
> > > ---
> > > base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > > change-id: 20250313-pci-tegra-module-7cbd1c5e70af
> > >
> > > Best regards,
> > > --
> > > Aaron Kling <webgeek1234@gmail.com>
> > >
> > >
> >
> > Continuing the conversation from the last revision [0]. Is there any
> > path forward for this series?
> >
>
> Daniel, could you please look into the cpufreq patch?

Another two weeks with no response to a review request. And over two
months total since the cpuidle maintainers were initially asked to
look. Is there a policy for dealing with lack of responses?

Aaron


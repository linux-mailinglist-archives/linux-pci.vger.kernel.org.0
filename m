Return-Path: <linux-pci+bounces-26340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10DA954A4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB63B71E2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5F1E7C23;
	Mon, 21 Apr 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ4y+2Bs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC1E7C1C;
	Mon, 21 Apr 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253502; cv=none; b=riv3HYDN6pzdgHuU5ov5h8N++56jmqmlj2eKHMPM7sK8deZ5lXurBrkC+gk0d2ubiCNxZgSp1WBMcfCvixjpq3rgtX8LygVrShvIdq2AWSfXulxtFD+iSQK6IxPTX9MecTgFmiDQZOae+6EnIFzimQQR9G+e8ZgatLaosRsZ5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253502; c=relaxed/simple;
	bh=QSSauynPj3+ZMlIMaDaeEq61cdFGlRUaZ4ahX2nPlgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epAuUuWegnLIAlrYcMI4yYabuGFIy7zdr3yzFi6lmFh7AL507Mnxf7G/0OotZoKrCOrWqVMLPcuR8HaRU+xSQDEMhgfkY9KgSpNClE2s/u5/f73t7irBwE2lBCO0IRYQ/HmqLiZwMVy10JHs0qsOzBRWxOXBdStYJZrrkP2dzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ4y+2Bs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54b10594812so4270404e87.1;
        Mon, 21 Apr 2025 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253498; x=1745858298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/jjbSVheygxc30YiXxMObt9cZgzpXUj7ujOQEzEW6w=;
        b=DZ4y+2BsFXDqTD45/7y5FsRiizSKzr4zZKLsDoP53KUw83DqntBF/Cogh4g2/urg+s
         +mTHxknQcf2HT0kvBFDsHQ2EeQUFDs5HJiX1k+FPQQ3Hn1+i/rQarPj1KWnTLpyl4s2x
         IFz/dBn0E6a54pizPfMFQsidCNpAlLpkvdKOjF4dU2m1NGLOhT3B0f/kV/izYHhBEtLW
         joYeNbEmFsQ6fc810HPCsba4+SVlirdfoe5JRR3q7BxH38H1nQVR9YSQhvK8pfJQceCu
         GMcbcxGhera9LualJM7n75BDrl8fMvm0fmCb4M8GVE+keJkz/feQf5FjWjld8sXVd1m6
         aOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253498; x=1745858298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/jjbSVheygxc30YiXxMObt9cZgzpXUj7ujOQEzEW6w=;
        b=wncjGzQN11zX+thZ2DnTbjeIGDVH61WXK3bVd/lRy+3FusZhU4P/osc6ij8I5/eA1A
         KZMJJWy37GhsWIguewOXs5SeFbb5iJzMxn2LiEYwmaq0Lk7riWD5BkxWYa0HuxRmGJ0q
         PyoL3IctqOgVBfT7bndus1IkY/+pX7AoNdoUVD9nAjvnM060/ZH+qwFddDvHtxTeMVCz
         e3KW7jNv4+P2Caa5VoeN5uczh55k/EHw6zRBCXD/ZwbWpCiUeH3Ecb8nErhAWF9Wm8kd
         oO+ejUaEiryEk75+JNIuho9JvJa0ju2KsZ7CIsWzxG1yrjzUWFEUaEIUhBEgBMXGIp/M
         Nn9g==
X-Forwarded-Encrypted: i=1; AJvYcCVhKyzEDnMk4jjbFFflJZlqWyAvQa5aIZ6eXqg9T56mfBQb7gHtX1aelKZQV+SfoiDRORnLdUqc3CPRmz4=@vger.kernel.org, AJvYcCVr41eV9QPo5n9bZCzP+pQsLZzf+UGcFNL6Rk1+/JB/IzT4hlaM0XrEHw0I6cnvDOaN9eVbSuGchS9KivY=@vger.kernel.org, AJvYcCXuybPtxKN/a0Uwz53+kolPkket2YQDWSURtzqIre3vgOSWFYzUKb5YR+DwysMjAIe+tJ3S6jykm6ej@vger.kernel.org
X-Gm-Message-State: AOJu0YxURU3vxWIj5QAaOidqZONv4Sf+ZFcQjSlWeSidQiPrAzj1Fiyu
	ws7J9gUDTn1gwd6lVY1olnML4JPQhoti8wdZjVY8mPWSkcmqZdaeKl0VPbH/x36lDuqCnR1SGLW
	Fqa1sULXSI7R+feXi8XkIcA3o/aU=
X-Gm-Gg: ASbGnctsPl3ulCoONVuZFN6yNra55ujOgNd9WwnvdEuqWqzrR/Ap5k1WBI6WhmoGDgW
	YmrkaACdhnBfss9No7BR9MrBoTj7GNA4d54NNnZ7kkqErgSYYmp8/AVEg+ktn7IyCKMY2UCVgka
	+LChYfSRJSWscXZEmIBmZhOg==
X-Google-Smtp-Source: AGHT+IFsE/MpLAU/FhdThE5Ap6NktdUHstoWs3t1J3TCmWnou4xJ0yEG/pcKZivO7Tiz6i1DPlLHXG6orOywOwcbWvw=
X-Received: by 2002:a05:6512:2212:b0:545:2f0c:a29c with SMTP id
 2adb3069b0e04-54d6e661b64mr3887476e87.36.1745253498293; Mon, 21 Apr 2025
 09:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com> <CABr+WT=4r46L4x-Hez_uqxw1aXmG6Wda0HxCJf_m+0Jj5B8JRQ@mail.gmail.com>
In-Reply-To: <CABr+WT=4r46L4x-Hez_uqxw1aXmG6Wda0HxCJf_m+0Jj5B8JRQ@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 11:38:06 -0500
X-Gm-Features: ATxdqUHbAxTMOSUoFv59N0iRWMf-8cgyD8lVczDDZB15qUEyKKZEnJU7ypgHgXo
Message-ID: <CALHNRZ9M3LYJ1Wi44ZArTt4FQCMwY-VmE8+=qJKbqMezmNGPfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 9:20=E2=80=AFAM Nicolas Chauvet <kwizart@gmail.com>=
 wrote:
>
> Le lun. 21 avr. 2025 =C3=A0 04:59, Aaron Kling via B4 Relay <devnull+webg=
eek1234.gmail.com@kernel.org> a =C3=A9crit :
> >
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The driver works fine as a module, so allow building as such.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/pci/controller/Kconfig     | 2 +-
> >  drivers/pci/controller/pci-tegra.c | 3 +++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 9800b768105402d6dd1ba4b134c2ec23da6e4201..a9164dd2eccaead5ae9348c=
24a5ad75fcb40f507 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -224,7 +224,7 @@ config PCI_HYPERV_INTERFACE
> >           driver.
> >
> >  config PCI_TEGRA
> > -       bool "NVIDIA Tegra PCIe controller"
> > +       tristate "NVIDIA Tegra PCIe controller"
> >         depends on ARCH_TEGRA || COMPILE_TEST
> >         depends on PCI_MSI
> >         help
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
> > index b3cdbc5927de3742161310610dc5dcb836f5dd69..c260842695f2e983ae48fd5=
2b43f62dbb9fb5dd3 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2803,3 +2803,6 @@ static struct platform_driver tegra_pcie_driver =
=3D {
> >         .remove =3D tegra_pcie_remove,
> >  };
> >  module_platform_driver(tegra_pcie_driver);
> > +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> > +MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
> > +MODULE_LICENSE("GPL");
>
> Thanks for looking into this.
>
> Last time I checked, building PCI as a module didn't work on Trimslice (T=
egra20) at runtime. PCI ethernet failed to bring-up.
> It might be because of the tegra_cpuidle_pcie_irqs_in_use in drivers/cpui=
dle/cpuidle-tegra.c, see the comments...
> At least this function would need EXPORT_SYMBOL_GPL IIRC.

Ah, I've only been building and testing on arm64, tegra210 and
tegra186. So I missed the arm issues. Not sure I can easily get my
tegra114 or tegra124 setups booting again right now either. Don't have
anything older. But I can at least make sure it builds. Will fix for
v2.

Sincerely,
Aaron


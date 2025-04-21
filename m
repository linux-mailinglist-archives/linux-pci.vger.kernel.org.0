Return-Path: <linux-pci+bounces-26328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15CA94DAE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3547A7A139C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1A20C005;
	Mon, 21 Apr 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPWG3LlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040F1FDA;
	Mon, 21 Apr 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222997; cv=none; b=Do25Xf1hkPYO0qfKUMVoxzzm4VXjArTOvSd/LNN7swA1mEiWqJhIxwWMfXUUH2wG72iTla8EltSaAIXT85j11BQCzAn5Pqr/BJCIKuDiag2Z+02bt1Gl/CA9KXgjMqdYfdmn/wBEpVW9zWShSvm5fmzMh7LzsBSIM9KYN4zmpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222997; c=relaxed/simple;
	bh=XpSVWIoRM/bSSzF4R1F4P4Y2Mzyol/7p7Paa0a0lh8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJac2A6bUQrrz2s+lBot7dW8R9LBKd/c7y+te6KMTNzbm30wS/AGe+jgjX7onqECs/Lq7LkmfetiUBhL+0S9pu+hPujjNO4a3PH4psPW97+Lkp7XA0CNvYmQfuCUkNN7PzVFcfDBbp+hoIObRX0ixeUB7YaUwuSbqGlc90KoVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPWG3LlA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so5275075e87.2;
        Mon, 21 Apr 2025 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745222994; x=1745827794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2mjSQTce/ct1xp5p+D1e5MxdFlEqzn1xpx6QH6j78I=;
        b=YPWG3LlAXARs1MeR4Jv9GU7FwFKOdtu+VAV1mNTeeu7THD+8KxMTea4lcj3KO2rzRq
         fEHvnxi1JJB1mai6WyI2MJA1IbLQCYG2Db/3+VmYyWwLoX8cFhK3a/oalWlwCf9lfnqs
         MYskGtKd52YUhHpaY6mtwzd9K17TvXA+Y99XwAHdRp5RlHeFpW6rmxQemLYpvemStUPS
         sZGWv5pduUusMr+8lqfOU8PkDutL8W4kDDvyDIi7ppq1dP9JFpKm1MXsnwFKUbi3IdaO
         HpscKPevMZOPxOfLjOjeTMpCuucvuJwzbQmuW//uOS0YxGJUGzR3ftueLdL98AYUYPlQ
         mxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745222994; x=1745827794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2mjSQTce/ct1xp5p+D1e5MxdFlEqzn1xpx6QH6j78I=;
        b=gKqmPbrty7V9a9tK6tUUgptAF4jSvB6ck+SGkJkFeVDqOf8Mwg3Luk7sPCiKNaFvVq
         QXVViL8mZxntxN02NJBzmOSfxqcz1w39lM2couAE01p9h9PtiJjJYpgDh/oEN77MQ8oy
         kTXezM1+2C5UZHRx75IZS3VLb1O5ocmm7TEocrRPGf9tLs3EtSCTckJoLdmNhxK1ICRf
         84x7V5oPIn7JX+gwOKHPqZDvm6UzElVhtHn5tE4Vi9B7EEuHNxtK/qgeqyzRfEmh8nKb
         t/sI70iV1VZrEi1pR8Tchjj77n1ny8glrwU5ON3sshvFsXJvnbYhd9hCRLgdLIgX+xEk
         WHZw==
X-Forwarded-Encrypted: i=1; AJvYcCW08s3Rh8sgSANNnXW25+9VLLPG9HiMztD87uyU0qlFVkx2MazfmdzOhepe6+rSKxhdm2b+wsVptsUg@vger.kernel.org, AJvYcCWHv11ZLJhAEa2Q/lJEcNu2Jq7NBVsXJe120qxb8jgfXaKR/+iHrC+k4ZQuw/muJhqvsNdnm3dbBZgXNR4=@vger.kernel.org, AJvYcCXzDnR2wGJiDn1zy+wB4kXXQ9sYJug2Ajias2Jfhxka/rRdsUmbL3kTb+4k6NWXGHL/QLmJFLfUEKMawo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNC+8+3Uvj+E4XE76oq6BBnzYZN9HImuy3lMxqnPq67efUYUx
	6PP7fVS948Z2NNfiPyJ9yU9U+Sj0PIOh1QvQUKl1MBBm9AmW1jGSLLQR9M5RoFPwpGCecbJw9Gv
	nlMOPP+EyBw9iWFjNjcaMseCXS1VkFi9F/J8=
X-Gm-Gg: ASbGnct5CuOgaVL4I++XJvrj/7yCNO4QPxkPRl97J9YBtKiqiJK7nqc2RBXJkISWiGu
	CpkOaYb1po9GJ7t10yeMo+0x6wKinSMNnolHfplZuAsUxI4Eb6cntJMidMMD9QjfORop0DHhRDs
	CgVDjOLzCMpe5Ui7pVNEtD0r85p0veDR0U
X-Google-Smtp-Source: AGHT+IGGnwYms/bwQR4bfKLFxhGYy6bjC9kpgReShLXDrZx0BD5MBp6fWCsOgOl04IWSsloNeftYWOCMqI0GGiljTE8=
X-Received: by 2002:a2e:a808:0:b0:30b:9813:b002 with SMTP id
 38308e7fff4ca-3109054a531mr36843501fa.30.1745222994000; Mon, 21 Apr 2025
 01:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com> <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
In-Reply-To: <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 03:09:42 -0500
X-Gm-Features: ATxdqUGjmCjoWgRy9CFGvBYM3AO3yhleNveM0vXHl0xHTlWPrWFnQUy71zJlHaA
Message-ID: <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:52=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The driver works fine as a module, so allow building as such.
> >
>
> In the past, the former irqchip maintainer raised concerns for allowing t=
he
> irqchip drivers to be removed from the kernel. The concern was mostly (af=
aik)
> due to not disposing all IRQs before removing the irq_domain.
>
> So Marek submitted a series [1] that added a new API for that. But that s=
eries
> didn't progress further. So if you want to make this driver a module, you=
 need
> to do 2 things:
>
> 1. Make sure the cited series gets merged and this driver uses the new AP=
I.
> 2. Get an Ack from Thomas (who is the only irqchip maintainer now).

Should this be a hard blocker for building this one driver as a
module? I did a quick grep of drivers/pci/controller for irq_domain,
then compared several of the hits to the Kconfig. And every single one
is tristate. Tegra is by far not a unique offender here.

Sincerely,
Aaron

>
> - Mani
>
> [1] https://lore.kernel.org/linux-pci/20240715114854.4792-1-kabel@kernel.=
org
>
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
> >         driver.
> >
> >  config PCI_TEGRA
> > -     bool "NVIDIA Tegra PCIe controller"
> > +     tristate "NVIDIA Tegra PCIe controller"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> >       depends on PCI_MSI
> >       help
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
> > index b3cdbc5927de3742161310610dc5dcb836f5dd69..c260842695f2e983ae48fd5=
2b43f62dbb9fb5dd3 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2803,3 +2803,6 @@ static struct platform_driver tegra_pcie_driver =
=3D {
> >       .remove =3D tegra_pcie_remove,
> >  };
> >  module_platform_driver(tegra_pcie_driver);
> > +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> > +MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.48.1
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D


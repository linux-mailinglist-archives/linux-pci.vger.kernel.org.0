Return-Path: <linux-pci+bounces-25945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D7A8A67C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E797A1F11
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8480222595;
	Tue, 15 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9ugFKHX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9966FC3;
	Tue, 15 Apr 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740773; cv=none; b=b3famGh0QgOUldtwSjEgB71GWU6iLCygqTzpg6wAz2GwkixcHLtYGQp3+hXJQ2lYz4o0Rj2X8ax6PwvFpYLuPrT7lAU3sn/fmDPZSZipudrw+8DVK8R6a82YenZo313++KDn8pia9De2DbVG1QbgGwkG2qkRw2AtALZ6jSLajms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740773; c=relaxed/simple;
	bh=bUOQgFHuyjKG1SyfN7Z6jiI6B/+I6piuKyvzmtnGlAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7WsFovT0tlm1bVKQTCeLOdOEC7PLAwwEzv7lyHg3KQ3VEMjB4BFVY1KLz5O4E4EOdZeqRCQDOU+V+kZvGpkG6y6wH8QGM6DqVONyCOsdtwJziG5iVTZaRp16R0sne6GrG6PJR/4cDjGZ6J2fHRqu7DptqInJnGnZ/c8dHn7TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9ugFKHX; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523dc190f95so2715724e0c.1;
        Tue, 15 Apr 2025 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740771; x=1745345571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXHoQ0b0p1xIEqJcM3XXblLBuGoMo96T52RGq1EmA+k=;
        b=Q9ugFKHXcEZd9ZMjjSvgTFMkQhnlQD6Myv37981rDal9VBBpudIhvzopalfoKff66W
         T+oKuDHhlPwsNRHhsN0UlA9fTuaYtCgqr7pmBVCbfA+Wh6q9ozc7ZiKCvsmtLI6xbYKt
         fZPn9VoKbOs/jdlc2yfBglCksrFWCqPZfzpYkr9HqseSkq1Zk0mrXnswsnh7w12C3Hzw
         n0dzHevJTmPeYPHs4BQfVwnh37v26U5vRlE1ZTISFVwvKs55yN9yO2XqVzkE8Sp1up6x
         FWZUytbTXI7j5mNrLoggATxdZHbgTVRGRHWgFt9ins85Y6FFdPfzS6d6rh2m5CLCpKJm
         W2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740771; x=1745345571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXHoQ0b0p1xIEqJcM3XXblLBuGoMo96T52RGq1EmA+k=;
        b=hK5hpnYFuZeByVzJOApuVyoM97o0vqjGbfSKTXB3ZzY4oGsYwPK9Ae0f9A8UueJi0E
         IFxb0lpVxVElH07f3RwfgTsJwcV+DnZ3bBGmYggvEq9NB/OVHJ/Zkr297aG4LAuYNdo5
         OZJb7IWxCSQ4CoQOakIB470ddVwji0h4Flnwdk4ctyUZDlXR/ZNB1zPeICDu9jY5N6mA
         kqbZ6HzDbpG3Z0ufG1dsh3zC4JR9O6cfTQKciR5l70jtE7IU17KxypUr/Mp4eYc24kdS
         MQ6uoST24V3jNUCHMXHXRq3HWH9DFpUkNKC/hfceVSQiw+Uzoxdl1wxY1yMTkPZ5etkh
         7XvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJf4ecAlCcS5krBeWfonPKkleTbVJ31CeyXubbJh3kNvdT/II5TKF62seA0YkW4aHaW72GaWV3bMocOkp/@vger.kernel.org, AJvYcCV0zwtxNjTwpTPK9Vs9EptVla3HIYg6rrsUn5ZFMjM+C6zJ+vTgmg3YnQ0rBv36mhXp7T8Ofmr0X2GTdCih@vger.kernel.org, AJvYcCWhgqsUAZbjVnp0LRGZukRb9fU6kKtA6fnt8xkJuTG8mxLq/g2hQjt1Mv8/Hg9Z0yXA5k+g8nFDHY0T@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnf2yzsB1KfPM0roRflpVj3XMXZsn2q2xG0JlQSEClYYVFH47
	bayxhdvfpgDYu5qDTOLCwSN+qxcqvm5lcN9zG34Vken/jHOwNYt6OCx9ttuWVLKsF4UOq/2goeM
	8WZHzEDkr9f4IGdljrg81B85dQ/U=
X-Gm-Gg: ASbGnculZ2x9UFmEP8zHHU7qVKx5gmcKFt80g0SAVvQJMCXEYs9h2pD3DD+bZIvYahI
	bOIMqg1RD/OoXM3El/9uLdciZuHENHSeKSKWdRZjCls56hcTSXktRL1Tle0XGmZUtrLzF8E1fEY
	TFObFCoCvb2g0jtDJg1Y4Nbt8=
X-Google-Smtp-Source: AGHT+IEtx3L5wIPk0UJSZyOZ3ORE3QPcvdOQAPtc4cEC67xDHAxjv9Aaxz6xeeQJS2XChtUGNkP3GC0I4v62Q1F2fbw=
X-Received: by 2002:a05:6122:c8e:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-52909121fc1mr190737e0c.2.1744740770936; Tue, 15 Apr 2025
 11:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_WAKDjIeOjlghVs@google.com> <Z_WUgPMNzFAftLeE@google.com> <uivlbxghkynwpmzenyr2b3xk4uxeuqf6dow6ao4mptcnzygrw7@ylfqavr3ry44>
In-Reply-To: <uivlbxghkynwpmzenyr2b3xk4uxeuqf6dow6ao4mptcnzygrw7@ylfqavr3ry44>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Tue, 15 Apr 2025 14:12:39 -0400
X-Gm-Features: ATxdqUFsyls6TWnL5p0KqZKPjeYgifEjqc43humsP5h203YLR_rXmu4VRkWrX5Y
Message-ID: <CANCKTBuEyOmojZ0yw30VKF2b5xOYkirx2gWEhkQ1a=-YHud5Cw@mail.gmail.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	Tsai Sung-Fu <danielsftsai@google.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 7:07=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Apr 08, 2025 at 02:26:24PM -0700, Brian Norris wrote:
> > + adding pcie-brcmstb.c folks
> >
> > On Tue, Apr 08, 2025 at 12:59:39PM -0700, Brian Norris wrote:
> > > TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> > > often run before pwrctrl gets involved. I'm exploring options to reso=
lve
> > > this.
> >
> > Apologies if a quick self-reply is considered nosiy or rude, but I
> > nearly forgot that I previously was looking at "pwrctrl"-like
> > functionality and noticed that drivers/pci/controller/pcie-brcmstb.c ha=
s
> > had a portion of the same "pwrctrl" functionality for some time (commit
> > 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
> > regulators")).
> >
>
> Yes, the goal of the pwrctrl driver is to get rid of this clutter from th=
e
> controller drivers.
>
> > Notably, it performs its power sequencing before starting its link, for
> > (I believe) exactly the same reasons as I mention below. While I'm sure
> > it could theoretically be nice for them to be able to use
> > drivers/pci/pwrctrl/, I expect they cannot today, for the same reasons.
> >
>
> If you look into brcm_pcie_add_bus(), they are ignoring the return value =
of
> brcm_pcie_start_link() precisely for the reason I explained in the previo=
us
> thread. However, they do check for it in brcm_pcie_resume_noirq() which l=
ooks
> like a bug as the controller will fail to resume from system suspend if n=
o
> devices are connected.

The reason our brcm_pcie_add_bus() does not check/return an error is
that the caller will invoke a WARN() on our error, or at least that
was the case when the commit was submitted.   We want to be good
citizens.  Also, for our driver, if the pcie-link-up fails, the
probe() fails.  There is no subsequent suspend/resume possible.  We do
not support PCIe hotplug in HW or SW.

Regards,
Jim Quinlan
Broadcom STB

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D


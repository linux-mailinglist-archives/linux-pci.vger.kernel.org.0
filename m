Return-Path: <linux-pci+bounces-42099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81270C88676
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 08:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C123A9DF4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A02957C2;
	Wed, 26 Nov 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EU87JyEd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924A25CC6C
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141752; cv=none; b=CRxD5KWQ6Y7y4RQ3BunsJ8SCD2r4sZ2d1lf4HUGbrYIGAF55jYumh3wuqrM8SszBGNmCfDk0KeLZfb+V4XdAKjrvK5LslHJljmzsJfv5fBRXb4QYnP9IxfvEj+z8wd6HW1lydoW9JaeKlmgUaVvy+MCNNT/uaq3a8bY7q1PcRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141752; c=relaxed/simple;
	bh=HAjRhP9wtDJZJIqyxRpme2sTURNRzMB+f8a7CBTtfrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5mK4c7t50rKWdnTaVn3sIvVsQ708nMxpncDQzsRUgdiAWWpLXlNFGwPy9sIfbcFeLKDmo15QLxqLq5jcEjl9kNAm0ehExngPaPdd/Sfet8OJt/GnfL20Tt8C6wuLvhP2KETDWOwWhBlRyJMFFBSJhlHjrw+kLKzTrSYLeM+4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EU87JyEd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a33f49018so21001771fa.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764141748; x=1764746548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxNG74JUJk+lK7SFMjIhhhwrVaUC7P24hMEewqUp0eY=;
        b=EU87JyEd7t1vj6WPrbyOarP/85Sq/nPBsxF2AspE1QJU6cla+iemfg1OsXQwQtWdYQ
         7Do1k/L5n9sD0L4ApczbXNIwMPcvKpnJgHG33ra8lGF9emmZmtyYYkf4C1GWLIM20nmj
         tY+rim7qaCgxfteWNT3I33wtELxSuJj+v/Vq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764141748; x=1764746548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxNG74JUJk+lK7SFMjIhhhwrVaUC7P24hMEewqUp0eY=;
        b=IBB5Di7R6U/P5Z8tH8Ip/EVcpCUO8HPLs6opdRwH4AE2U+tBY5kMGS0qlEgzavrtpt
         Icfmii+cfv6gc2A+iK6dYwUKsjtfei28uxlx56O/77c1Je3nqtnrSeMIAYgdenBm8VUe
         YP0KVFd1KKZ5242cxmMXlP/jNH1qpYK+Xl7QueU8VVfiVDSMKDMVBrCNRAhyiAiMedh4
         WrZVYSSvdHHcwi4CP5OnobX8H0nzXpHYei6KxHNfcVMVi4ugIBJnbGCmmOm6y/42B/iz
         nPhi547Enn+Xss4ALrgUS+28Yy+Ggk3z3b1GoUt/D42O61p881o53RjK7pW1uEMMx9+O
         Zcvg==
X-Forwarded-Encrypted: i=1; AJvYcCWm+ghwtt0VL8WIdMnHeV6zaJx6ich3ukt6eiVFAD89BfTPlaTBPLNBmkXL7+gDALts3l0m9PBkJ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeocoH3moeXKYGxPWQiCyFBIwpuD/4vA/XTpZr05rYWjp/6Hm
	fvkADt12iYVGh/nJqW8QnBt395LO7CpIicO4mSNwifmdasxbcgLZUncwUfLjhkYZjb8dxA4+lBa
	6DUt7VX2MlXVkmzN33cI6kFrbSIeyOehPzfKL/Ccv
X-Gm-Gg: ASbGnct+J4QTQlncYaMaZEmKtTBxzPY4AvjGak+LSlApetFKw17cHY+BiERDUCVTMaN
	DZhLDeveEUDOs3tgX0WIC7792LFQW1kRXI3RpSywC5Mwi9tNjNOpkjidtBhlJg/k5bo7JLIpTk/
	6luXusXrj+DTOpSrFTiLLFvOkVx5EU8GoDF4U0cQjkUhtWjPV3XJN1NJyPN6If1ZYernGuvsddC
	swn5vViskhbFr06KR2KJqP+w3u7seM2aQPuwQjZVPjzAqHLRVy6Hf5nG1S09TPU2kyo8hX7JyRM
	96ZTpNIzdF2frGtd4WYIKb4VHvTtatKyTl8W
X-Google-Smtp-Source: AGHT+IELttdSAYYhDDT+Ci+Ox38/nz7RKJ+v8Tyb7B7TrkHsaUAi6rnTmUi+qUjbylofJYaH2MAEHwFsqYlLSj3b6kc=
X-Received: by 2002:a05:6512:b9d:b0:594:493a:a27f with SMTP id
 2adb3069b0e04-596a3eddab2mr7291270e87.36.1764141747623; Tue, 25 Nov 2025
 23:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 26 Nov 2025 15:22:16 +0800
X-Gm-Features: AWmQ_bmsWAkF-LlHoz-BQzJMUBBtQQK8vTK3HVxXtKG5iMcZspRSUn6rFoT05ME
Message-ID: <CAGXv+5HRaYVMjwiqeVVm2-abnyga_-hzWM_tXw9hrqo74x47hA@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:13=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Hi,
>
> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI contr=
oller
> drivers.
>
> Problem Statement
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently, the pwrctrl framework faces two major issues:
>
> 1. Missing PERST# integration
> 2. Inability to properly handle bus extenders such as PCIe switch devices
>
> First issue arises from the disconnect between the PCI controller drivers=
 and
> pwrctrl framework. At present, the pwrctrl framework just operates on its=
 own
> with the help of the PCI core. The pwrctrl devices are created by the PCI=
 core
> during initial bus scan and the pwrctrl drivers once bind, just power on =
the
> PCI devices during their probe(). This design conflicts with the PCI Expr=
ess
> Card Electromechanical Specification requirements for PERST# timing. The =
reason
> is, PERST# signals are mostly handled by the controller drivers and often
> deasserted even before the pwrctrl drivers probe. According to the spec, =
PERST#
> should be deasserted only after power and reference clock to the device a=
re
> stable, within predefined timing parameters.
>
> The second issue stems from the PCI bus scan completing before pwrctrl dr=
ivers
> probe. This poses a significant problem for PCI bus extenders like switch=
es
> because the PCI core allocates upstream bridge resources during the initi=
al
> scan. If the upstream bridge is not hotplug capable, resources are alloca=
ted
> only for the number of downstream buses detected at scan time, which migh=
t be
> just one if the switch was not powered and enumerated at that time. Later=
, when
> the pwrctrl driver powers on and enumerates the switch, enumeration fails=
 due to
> insufficient upstream bridge resources.
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This series addresses both issues by introducing new individual APIs for =
pwrctrl
> device creation, destruction, power on, and power off operations. Control=
ler
> drivers are expected to invoke these APIs during their probe(), remove(),
> suspend(), and resume() operations. This integration allows better coordi=
nation
> between controller drivers and the pwrctrl framework, enabling enhanced f=
eatures
> such as D3Cold support.
>
> The original design aimed to avoid modifying controller drivers for pwrct=
rl
> integration. However, this approach lacked scalability because different
> controllers have varying requirements for when devices should be powered =
on. For
> example, controller drivers require devices to be powered on early for
> successful PHY initialization.
>
> By using these explicit APIs, controller drivers gain fine grained contro=
l over
> their associated pwrctrl devices.
>
> This series modified the pcie-qcom driver (only consumer of pwrctrl frame=
work)
> to adopt to these APIs and also removed the old pwrctrl code from PCI cor=
e. This
> could be used as a reference to add pwrctrl support for other controller =
drivers
> also.
>
> For example, to control the 3.3v supply to the PCI slot where the NVMe de=
vice is
> connected, below modifications are required:
>
> Devicetree
> ----------
>
>         // In SoC dtsi:
>
>         pci@1bf8000 { // controller node
>                 ...
>                 pcie1_port0: pcie@0 { // PCI Root Port node
>                         compatible =3D "pciclass,0604"; // required for p=
wrctrl
>                                                          driver bind
>                         ...
>                 };
>         };
>
>         // In board dts:
>
>         &pcie1_port0 {
>                 reset-gpios =3D <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
>                 vpcie3v3-supply =3D <&vreg_nvme>; // NVMe power supply
>         };
>
> Controller driver
> -----------------
>
>         // Select PCI_PWRCTRL_SLOT in controller Kconfig
>
>         probe() {
>                 ...
>                 // Initialize controller resources
>                 pci_pwrctrl_create_devices(&pdev->dev);
>                 pci_pwrctrl_power_on_devices(&pdev->dev);
>                 // Deassert PERST# (optional)
>                 ...
>                 pci_host_probe(); // Allocate host bridge and start bus s=
can
>         }
>
>         suspend {
>                 // PME_Turn_Off broadcast
>                 // Assert PERST# (optional)
>                 pci_pwrctrl_power_off_devices(&pdev->dev);
>                 ...
>         }
>
>         resume {
>                 ...
>                 pci_pwrctrl_power_on_devices(&pdev->dev);
>                 // Deassert PERST# (optional)
>         }
>
> I will add a documentation for the pwrctrl framework in the coming days t=
o make
> it easier to use.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1=
E
> chipset and RB3Gen2 development board with TC9563 switch based on Qcom QC=
S6490
> chipset.
>
> **NOTE**: With this series, the controller driver may undergo multiple pr=
obe
> deferral if the pwrctrl driver was not available during the controller dr=
iver
> probe. This is pretty much required to avoid the resource allocation issu=
e.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
> Krishna Chaitanya Chundru (1):
>       PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctr=
l devices
>
> Manivannan Sadhasivam (4):
>       PCI: qcom: Parse PERST# from all PCIe bridge nodes

I see this is still handled in the driver. Reading the cover letter,
it seems the plan is to move this into pwrctrl, perhaps as a separate
function?

>       PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
>       PCI/pwrctrl: Add APIs to power on/off the pwrctrl devices
>       PCI/pwrctrl: Switch to the new pwrctrl APIs

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on an MT8188-based Chromebook which has on-board PCIe-based WiFi.
The pcie-mediatek-gen3.c driver was reworked to integrate the new API.


>  drivers/pci/controller/dwc/pcie-qcom.c   | 124 +++++++++++++---
>  drivers/pci/probe.c                      |  59 --------
>  drivers/pci/pwrctrl/core.c               | 248 +++++++++++++++++++++++++=
++++--
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  30 +++-
>  drivers/pci/pwrctrl/slot.c               |  46 ++++--
>  drivers/pci/remove.c                     |  20 ---
>  include/linux/pci-pwrctrl.h              |  16 +-
>  7 files changed, 407 insertions(+), 136 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251124-pci-pwrctrl-rework-c91a6e16c2f6
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>


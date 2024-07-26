Return-Path: <linux-pci+bounces-10863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D893DB17
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 01:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94257B20D78
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBD14A0AE;
	Fri, 26 Jul 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efjEE0GD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA02BAE2
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035193; cv=none; b=PY16Mk1ps+ITV8Ah/sg4AfJ3VDGLiBxT31U4wuflpEI5Ob0Ih2PMFV3aajY+N5tKK4Tp3Tcwbi3Uoztgi1mHuyDBjBy4mHWGepdHk5rILv7A6SoK//5qYL6eATiAy8+F8604cXqOPcBlbF3i6e1Zt3jdkz+UTBlH+tyaJvlkbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035193; c=relaxed/simple;
	bh=ld6KeuB4sATn7KhNW/BfMGlPLHxeZpj4+EBu8ioiPck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqbWCdLbZ0dEa2a01qdbtyezEAIKUOqIfDystloIryEarhXsQ1XM3MDCME3WgF1BPwUdCDSJVKxWUIgePxAWpHlXVPKJ8fyKg1f/qM4erTe8tK+3yUvWZv0VOdKcT1r2ja5JREG6i1H6QAsdgGnlkeGIokU4B+6oxQL7/TCVszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efjEE0GD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so3053081a12.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722035189; x=1722639989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=efjEE0GDcJshef/O3pan4Itzex0dz7GegnSqGqNicJe4lcOk2OaqTIt83I95NUZsIB
         uefa+LcmsZE0sMI7I5ZaYKw9s6xq/Y0tr/XHfxcWYduOC4yZzF198bs2DzsuIl1h82//
         c5IOVPfPvq991KIBSMISSDQnGc2xQrrkwggNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035189; x=1722639989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=FyNPOefDCWWeBHeFUR2OVJaxGaabsxnlT+Hy2cxjl3vBGYzI8+LiIxebtw4KNFM+on
         JFwgTXY/6/DGm9DgPvW6qP5w49wEpc0Ml38caF9hSaPbm6G1/v1lOLwwHnwpzXT3Wpr9
         bLZsrPyz8u2SHQiUmRSMkxQc7NzAYF80tBce7nW4e8ISig0jaSL5kZ4Yp1Il2FFxCJm7
         S2xk2VHgSgzwMgEqAzNSpvU0Hy+LJZUO1bawW77IjmsRJZ3xKdzn/yUl9mueQ8QuqTSP
         jTmFG/1tP4dV9swUy120HIoa+jW3vkrC3h8FZxvcX/XlsVt/ZqhPqCH38zoHXOFsFAqg
         XFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFOYcCNGWXvMXQVSTL/kXx4Nb+Mjqp4WiDTQdJJsnqL0NNBDHBc9mlOcV7imiieNdpzEKnlf8aRh5At2W46i0oJI6GVouJXks0
X-Gm-Message-State: AOJu0Yy8cbEZ5lUJg21ZDjs/iwYpi4CJGwI3d2u2uf193c1yR1OQadG3
	/w2tK2HWsEAfi/H0vLBCJGZ07c8wHzd8YeOERrq8zvlpqh71CQEV7rJxljJFRc+FStrtXBx3Y/p
	lFGuVVNT/V+ZGxKvdemrUD3msqgOCNOpbUe3q
X-Google-Smtp-Source: AGHT+IGEQmOdGLNP3Mq5rTpzM4kyWZztDxXbtgm6nR21X2SELvdhrhBNz1AWPZR1GYT402EWXUxVjo+vAtNCDjCBUiw=
X-Received: by 2002:a05:6402:3487:b0:5a3:b45:3979 with SMTP id
 4fb4d7f45d1cf-5b020ba8a06mr486269a12.17.1722035189399; Fri, 26 Jul 2024
 16:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org> <20240511071532.GC6672@thinkpad>
In-Reply-To: <20240511071532.GC6672@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 26 Jul 2024 16:06:03 -0700
Message-ID: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> >
> > This series allows D3Hot for PCI bridges in Devicetree based platforms.
> > Even though most of the bridges in Devicetree platforms support D3Hot, =
PCI
> > core will allow D3Hot only when one of the following conditions are met=
:
> >
> > 1. Platform is ACPI based
> > 2. Thunderbolt controller is used
> > 3. pcie_port_pm=3Dforce passed in cmdline
> >
> > While options 1 and 2 do not apply to most of the DT based platforms,
> > option 3 will make the life harder for distro maintainers.
> >
> > Initially, I tried to fix this issue by using a Devicetree property [1]=
, but
> > that was rejected by Bjorn and it was concluded that D3Hot should be al=
lowed by
> > default for all the Devicetree based platforms.
> >
> > During the review of v3 series, Bjorn noted several shortcomings of the
> > pci_bridge_d3_possible() API [2] and I tried to address them in this se=
ries as
> > well.
> >
> > But please note that the patches 2 and 3 needs closer review from ACPI =
and x86
> > folks since I've splitted the D3Hot and D3Cold handling based on my lit=
tle
> > understanding of the code.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > This series is tested on SM8450 based development board on top of [3].
> >
>
> Bjorn, a gently ping on this series.
>

Hi, I was also working on a similar patch to add bridge_d3 to arm
platforms until I found this series, which is what we need. Also
kindly ping on this series.

Thanks!

> - Mani
>
> > - Mani
> >
> > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a=
713bbc1fd7@linaro.org/
> > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
> > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts=
-v2-0-1eb790c53e43@linaro.org/
> >
> > Changes in v4:
> > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > - Got rid of the DT property and allowed D3Hot by default on all DT pla=
tforms
> >
> > Changes in v3:
> > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-=
9dd6dbb1b817@linaro.org
> >
> > Changes in v2:
> > - Switched to DT based approach as suggested by Lukas.
> > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-=
46d7789836c0@linaro.org
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > Manivannan Sadhasivam (4):
> >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 p=
ossibility
> >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> >       PCI: Decouple D3Hot and D3Cold handling for bridges
> >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based pla=
tforms
> >
> >  drivers/pci/bus.c          |  2 +-
> >  drivers/pci/pci-acpi.c     |  9 ++---
> >  drivers/pci/pci-sysfs.c    |  2 +-
> >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++------=
--------
> >  drivers/pci/pci.h          | 12 ++++---
> >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> >  drivers/pci/remove.c       |  2 +-
> >  include/linux/pci.h        |  3 +-
> >  8 files changed, 89 insertions(+), 47 deletions(-)
> > ---
> > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > change-id: 20240320-pci-bridge-d3-092e2beac438
> >
> > Best regards,
> > --
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D


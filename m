Return-Path: <linux-pci+bounces-42021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DCC83F27
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 09:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAEB0343ABD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92032C026E;
	Tue, 25 Nov 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j2WQ7PVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9727D77D
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058744; cv=none; b=PrRpVV3oG294OO/Gd4MGBRX0SNWA3pv+BvWQ2yF/lWEEqz78gWF5MGAf26UcS3KUIf9TUqOjHoRJDuPTcWWB7yri9uXjXWq/U8kx27XrEOjdwO0oxxn9mw+a6SiaB97xw06tZ0aCAXmVcLbMaYuwu0vITbVMirxodYxMIWXg2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058744; c=relaxed/simple;
	bh=zor+RSumMm7bO9S/VD6/XBUvwQWnH42SDPcawz1z5X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FErdhSm5pgQES+q1O0f0Keiz48w+SkQttT+HMLqYIioxZoBf20+xyOfgFhqL5ziR5UdcZsgM4/p4tyy5kDlcpv8raf97CddTvK9DFyoflKRwB8kVxWeWCD1ZE5heLvhjX/TyUkNdsjckDUnqLc2uVXWPWclFPbgARa8rTXdYFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j2WQ7PVd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59583505988so7037768e87.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 00:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764058741; x=1764663541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV1wd0RBNRffIVLLzUybH3O3hc5b+Hoh+1Ef3J9avQU=;
        b=j2WQ7PVdyNX4vHVb1HX12lLF5ZnUYUjV6EcPyUXHduiSghhJwIV+ZyRe49mPoDpWcT
         X9adhvVaf7QzA84H0/gefPrHmHGyD56XvwDmqjPObHw7MwocEcKj6kkL0RGJatNSoG2/
         KxuWBIP2tqRQMaaqpkU6fi0uyN8p+Ra6WNNlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764058741; x=1764663541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV1wd0RBNRffIVLLzUybH3O3hc5b+Hoh+1Ef3J9avQU=;
        b=GPwYIgJoutELMcJ6ie/rsxUj6bHPKIavpNFW/OLFaA9f2o3Jplez6RqvOSn2YvCXbA
         CU3RKgSPB1Ze08sPiJAJtiBqqgOIkAWg0fXMmBls4Oz09KDoSMy4YSx3/NWxdhDDaH4N
         nNBQjFzmJUcOQ4+EO2nWwtESRohidGZKee/HVUkeuZXahxzZOn2pS7+WInr9aMwJMckV
         XUQa4Nz5/etFUHge5awuXAzftwBcfuYrmKLJr2jt5Oh3Edmumfu/ge/lrTforzJL4WUb
         pPh1U9eLFtQhqcoJHtrn5TDk/IqlGCJ0C7b0+7SD6iX7OBt29YXegDPEcSdR+geH8J/c
         EvwA==
X-Forwarded-Encrypted: i=1; AJvYcCWMD2GsPhGHY/BqrwBqKzlRJ3oXDaVBJ5TX6EmiN3uLwQtXSwN3/tp+S0ZHfYEwR8c4mNavs+lvi/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqHv5q+to7LWPJbIt72lBso7BBk9ECgBZe8hPICxpxczv1203
	OrZKPj56LSEtuyR49yYBELUUbzF1IM5I/fX5mq1/mrYVFMvvcPLMDm/NRSrjT88/VwfkSWJ69kN
	MzInCzQYbSdaTW6IYl9HUZKaq/zHu1Mj0GwhgNcxy
X-Gm-Gg: ASbGncvlAmpu48g1DXjX09bqxD1Yv/AvAUrxgf6WuF71ItNWUJ1eFwvAwlZ7lSymvPn
	zgK0f6pLa8/YWGk0lTvCjIk8+8DwY0VZIqIuYqtF4kgn9xWWWUGA1zkbaoW+nyWGTXtrMmOR4Vv
	JS3zjv/tkPNnJ+rc5JMKRFcoFXjlYGA9WDMT+rFjaieuu8jucqMIm7mZtQefV654G9XOZL1gB2h
	qmJV/e4NrZAUrjpuae5By+VxzuegwacdoFoiGbrKu3H63aPZPfdyT9rbfI9qvqpv0MtDvyDwTAa
	JKAXOqxUxBRr5a0c1HejaQbzjg==
X-Google-Smtp-Source: AGHT+IHi2gdMuYFmg+AgrADHC4yrWhD9HWFMVG6P7ZsI1BLiNn/Orpx+b8it5IAqqf95qPLHI1Al/MkkSWIXbNGJKhc=
X-Received: by 2002:a05:6512:3d9e:b0:595:997e:19ad with SMTP id
 2adb3069b0e04-5969ea31e39mr6650085e87.21.1764058740770; Tue, 25 Nov 2025
 00:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com> <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Nov 2025 16:18:49 +0800
X-Gm-Features: AWmQ_bnl_TKiY4NjKvFlKoM2py7fy89Gm9jFvwJltzOJo-37UQGh1Ss64Akup3k
Message-ID: <CAGXv+5EyOOwZjUARfLzLvhX_vGdYHRz+0M=GbXaBMcaJ=0w+aA@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
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
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> Previously, the PCI core created pwrctrl devices during pci_scan_device()
> on its own and then skipped enumeration of those devices, hoping the
> pwrctrl driver would power them on and trigger a bus rescan.
>
> This approach works for endpoint devices directly connected to Root Ports=
,
> but it fails for PCIe switches acting as bus extenders. When the switch
> requires pwrctrl support, and the pwrctrl driver is not available during
> the pwrctrl device creation, it's enumeration will be skipped during the
> initial PCI bus scan.
>
> This premature scan leads the PCI core to allocate resources (bridge
> windows, bus numbers) for the upstream bridge based on available downstre=
am
> buses at scan time. For non-hotplug capable bridges, PCI core typically
> allocates resources based on the number of buses available during the
> initial bus scan, which happens to be just one if the switch is not power=
ed
> on and enumerated at that time. When the switch gets enumerated later on,
> it will fail due to the lack of upstream resources.
>
> As a result, a PCIe switch powered on by the pwrctrl driver cannot be
> reliably enumerated currently. Either the switch has to be enabled in the
> bootloader or the switch pwrctrl driver has to be loaded during the pwrct=
rl
> device creation time to workaround these issues.
>
> This commit introduces new APIs to explicitly create and destroy pwrctrl
> devices from controller drivers by recursively scanning the PCI child nod=
es
> of the controller. These APIs allow creating pwrctrl devices based on the
> original criteria and are intended to be called during controller probe a=
nd
> removal.
>
> These APIs, together with the upcoming APIs for power on/off will allow t=
he
> controller drivers to power on all the devices before starting the initia=
l
> bus scan, thereby solving the resource allocation issue.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> [mani: splitted the patch, cleaned up the code, and rewrote description]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/pwrctrl/core.c  | 112 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/pci-pwrctrl.h |   8 +++-
>  2 files changed, 119 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6..6eca54e0d540 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -3,14 +3,21 @@
>   * Copyright (C) 2024 Linaro Ltd.
>   */
>
> +#define dev_fmt(fmt) "Pwrctrl: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> +#include "../pci.h"
> +
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long a=
ction,
>                               void *data)
>  {
> @@ -145,6 +152,111 @@ int devm_pci_pwrctrl_device_set_ready(struct device=
 *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
>
> +static int pci_pwrctrl_create_device(struct device_node *np, struct devi=
ce *parent)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       for_each_available_child_of_node_scoped(np, child) {
> +               ret =3D pci_pwrctrl_create_device(child, parent);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Bail out if the platform device is already available for the n=
ode */
> +       pdev =3D of_find_device_by_node(np);
> +       if (pdev) {
> +               put_device(&pdev->dev);
> +               return 0;
> +       }
> +
> +       /*
> +        * Sanity check to make sure that the node has the compatible pro=
perty
> +        * to allow driver binding.
> +        */
> +       if (!of_property_present(np, "compatible"))
> +               return 0;
> +
> +       /*
> +        * Check whether the pwrctrl device really needs to be created or=
 not.
> +        * This is decided based on at least one of the power supplies be=
ing
> +        * defined in the devicetree node of the device.
> +        */
> +       if (!of_pci_supply_present(np)) {

This symbol is not exported for modules to use, and will cause the build
to fail if PCI_PWRCTRL* is m.

[...]


ChenYu


Return-Path: <linux-pci+bounces-34927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE98DB387C8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E3B1732B4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC302296BD5;
	Wed, 27 Aug 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gg6p/4E5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0E2741A6
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312365; cv=none; b=epM9yH0XmNaX7QUXoVbi2yKIAwjxWwYSJQkBj3iZFQzLkKgiFe1Qswuf0Pm1zx6juZ8vfbW3kEC3lcqN7NKG+1hW7R6zfqb0Ug+KyOsHjGteJc6R+RHm/AGJ5YQLu8iuz0g564eyxw6Scrc/ZvxAzXqNlwVEk2/xSyJjyWw9/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312365; c=relaxed/simple;
	bh=sokmmttEF6WQPkFswGePVZ5nkysqROOmFeWowMPSpUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebGLiZe4f2H7xKEMt5fOZVlOjbzbOspP4cHylCxNEmxKC5gMkE2Ftz1G7tGA0J85Z+UwZ+Jxeeu6noosfa4l6c9MHZ3UDWnqmTIKM8Eod3H0oCYDNM6ciy+4s29qowWYUjGeyJ5zC9DjD/nin+wP5C/kVvTHQqAeCqkJ9BNLr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gg6p/4E5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f53ed18f4so54561e87.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756312362; x=1756917162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA1HrGWTiFMd6/17t962MubCXtdKe85dul62wLkDnTc=;
        b=gg6p/4E5aHVjH2uXxUZQmHFeMlCI6dMmMHKdqeWL05IuMASeI8AzbS0b5vbm14JQSc
         Vl1hta3TK28UU5Cmfixr0mIj1j4u+27ey6lTR3ItGQYtGlFPslHa3dePuw+oszlpum54
         pkE8qYAIp2Xdniv9uBYfZZMUYLIBFoGBEHqb1uDoEsXa4UyC2IBbdLzjnQ5WgY6FwoWA
         RigQ/8/HWXRfJ5M4w9iFlYznxoMEcmvYZjOXaegue2qEEil2Jpt3KRQD4fam6q5T/CQu
         w+hZqa/tQuFAny2PpcJg3w577VtVqDtfaaU9RnxtxAyVk2cqFtbldLGsEuGbSWh10b5k
         KMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312362; x=1756917162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA1HrGWTiFMd6/17t962MubCXtdKe85dul62wLkDnTc=;
        b=TC+1FrHWgCsAye0nUypTrLyV4ryDib+BomqCeSNUU13mS285S+4rxJoL7yXUCSeLXK
         LkNeI7SizstPBzdWxYY56079alOGQ6vDkBAxYBaYqfF2Fo1dra6kongZfXEDb4Rx+2eE
         GnjY1P0da4pMeHcbIGb/bcQ2bv/3ZbrYoNfe4Rhxf6rqev7OMaekmd5wKO/mTX43ifA9
         CLIYcHOudmXLUpIi0IIlwgv9sCNqNqMZN9JE34LUVmgeWnoCq8RbiW09gjN+4gYmt3zS
         DL3Vy3/DU3YvzAQVXrJrWUilvv1s4J0XzdgXcq6evCIy9Tw3o95dc1FToMqTj2pcr/vh
         dJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfl0qs1Gw8vGgoEb1E5O+LOJLYpWCFopq5xsGExSmksdrf40aus3MGDAdmZ4lGOrzj45qeRxWcbq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOu766H2r9mrO2nTm6+QN+rT6/UzIJM+85KPCcrDnV2a4VqH2
	GQ60H5uvfdCsJTcXGLcEEPGFmOG4cwqE4MispCfXr/1neHijWnJe8NscV80IVp0/hf0L0Al30wC
	+KMO20pCNwJZQUIWmSQyBR4/QYOD8TJVmq5+MG8tN6Q==
X-Gm-Gg: ASbGnctqIjCBMUUoK16tbtYvla6sE+jHzYxEXhQPL1/B3ZBrHlUqbBWnVbH4/uHVkmw
	4+EQW/+wJ1InIEaTSOGWDZmJ7Lcdq/xMJKaLir81/lsJDSytYPdN6qhmHR8YFa7mMjyMOvNwKiS
	WDQB6dbKDZYOqk7B5BP+nUtwuRsaUMV+FMRxcswiUNrhTtv869PyotX0zx0zCs/+gjkIQ/bBZgU
	VT13yEpz7Z/WOBZlX4DxrNnMm7uZ5eNSMI2lTqNKFnuwFaqPA==
X-Google-Smtp-Source: AGHT+IGmaVgA4GxBThOJulhfd/FOmckKPWhf4GB/qcPY+ghPacNlqJYq74uWQJwg/9d4AeS4NhA5YVY0Wv+MelGFJfg=
X-Received: by 2002:a05:6512:2903:b0:55f:4760:ffc4 with SMTP id
 2adb3069b0e04-55f47610278mr2391780e87.29.1756312361741; Wed, 27 Aug 2025
 09:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com> <20250819-pci-pwrctrl-perst-v1-3-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-3-4b74978d2007@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 18:32:30 +0200
X-Gm-Features: Ac12FXz1RS70--AFk1fE2akY5GEXMKvlLbcKfDDlrSH8dzP6VB_vbFzt6mioyQE
Message-ID: <CAMRc=Me2P9r9w-UPtjMAEvuQ_oNtibzPBg6tE7s1wdKkLmQgcQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI/pwrctrl: Add support for toggling PERST#
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:15=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided =
by
> the system to a component as a Fundamental Reset. This signal if availabl=
e,
> should conform to the rules defined by the electromechanical form factor
> specifications like PCIe CEM spec r4.0, sec 2.2.
>
> Since pwrctrl driver is meant to control the power supplies, it should al=
so
> control the PERST# signal if available. But traditionally, the host bridg=
e
> (controller) drivers are the ones parsing and controlling the PERST#
> signal. They also sometimes need to assert PERST# during their own hardwa=
re
> initialization. So it is not possible to move the PERST# control away fro=
m
> the controller drivers and it must be shared logically.
>
> Hence, add a new callback 'pci_host_bridge::toggle_perst', that allows th=
e
> pwrctrl core to toggle PERST# with the help of the controller drivers. Bu=
t
> care must be taken care by the controller drivers to not deassert the
> PERST# signal if this callback is populated.
>
> This callback if available, will be called by the pwrctrl core during the
> device power up and power down scenarios. Controller drivers should
> identify the device using the 'struct device_node' passed during the
> callback and toggle PERST# accordingly.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/pwrctrl/core.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h        |  1 +
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..8a26f432436d064acb7ebbbc9=
ce8fc339909fbe9 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
>  #include <linux/property.h>
> @@ -61,6 +62,28 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, str=
uct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
>
> +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> +{
> +       struct pci_host_bridge *host_bridge =3D to_pci_host_bridge(pwrctr=
l->dev->parent);
> +       struct device_node *np =3D dev_of_node(pwrctrl->dev);
> +
> +       if (!host_bridge->toggle_perst)
> +               return;
> +
> +       host_bridge->toggle_perst(host_bridge, np, false);
> +}
> +
> +static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
> +{
> +       struct pci_host_bridge *host_bridge =3D to_pci_host_bridge(pwrctr=
l->dev->parent);
> +       struct device_node *np =3D dev_of_node(pwrctrl->dev);
> +
> +       if (!host_bridge->toggle_perst)
> +               return;
> +
> +       host_bridge->toggle_perst(host_bridge, np, true);
> +}
> +
>  /**
>   * pci_pwrctrl_device_set_ready() - Notify the pwrctrl subsystem that th=
e PCI
>   * device is powered-up and ready to be detected.
> @@ -82,6 +105,8 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *p=
wrctrl)
>         if (!pwrctrl->dev)
>                 return -ENODEV;
>
> +       pci_pwrctrl_perst_deassert(pwrctrl);
> +
>         pwrctrl->nb.notifier_call =3D pci_pwrctrl_notify;
>         ret =3D bus_register_notifier(&pci_bus_type, &pwrctrl->nb);
>         if (ret)
> @@ -103,6 +128,8 @@ void pci_pwrctrl_device_unset_ready(struct pci_pwrctr=
l *pwrctrl)
>  {
>         cancel_work_sync(&pwrctrl->work);
>
> +       pci_pwrctrl_perst_assert(pwrctrl);
> +
>         /*
>          * We don't have to delete the link here. Typically, this functio=
n
>          * is only called when the power control device is being detached=
. If
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860dbe50ee6c207cd57e54f51a11079..9eeee84d550bb9f15a90b5db9=
da03fccef8097ee 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -605,6 +605,7 @@ struct pci_host_bridge {
>         void (*release_fn)(struct pci_host_bridge *);
>         int (*enable_device)(struct pci_host_bridge *bridge, struct pci_d=
ev *dev);
>         void (*disable_device)(struct pci_host_bridge *bridge, struct pci=
_dev *dev);
> +       void (*toggle_perst)(struct pci_host_bridge *bridge, struct devic=
e_node *np, bool assert);

Shouldn't this be wrapped in an #if IS_ENABLED(PCI_PWRCTL)?

Bart

>         void            *release_data;
>         unsigned int    ignore_reset_delay:1;   /* For entire hierarchy *=
/
>         unsigned int    no_ext_tags:1;          /* No Extended Tags */
>
> --
> 2.45.2
>
>


Return-Path: <linux-pci+bounces-27576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A7AB366D
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87EF1882659
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB934293442;
	Mon, 12 May 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKf7XXKy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D35265629;
	Mon, 12 May 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050981; cv=none; b=PYcaOrKu34lgg9sif7zOXJxLmkC+AudhYxcz21yoicCDmQSljdRpVTcz5RB1qRRAmyFn1iyVF7LEl/LxWtFxKljM7Xc+hohlv7xAXztZigrufoa6jQICm87Zrfga+6Qz+jvxEIAOTTyxq9DiJanHFDpi05iX3Mum1/a3O8sPhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050981; c=relaxed/simple;
	bh=OP26wRID7imVo7J12rxlgz9zyMjobt/1rWh6Hpm9uqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz+EwjFVZ2xlCvULzynUy1BhU9nSuKyF9Ee6a6foMdAtkkpfl2V0oQ7F1Z1TzBm226olTJ8QWG5dJ39bHP3PLIYYFRfjyHPYo3GmWKwLWHaYvNe6q1nOLXpE4c+6Vcx3RWU4L04wzZ3+9JNaZqCjCqvquAC/GuqsZInDfujiKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKf7XXKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB1C4CEF1;
	Mon, 12 May 2025 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747050980;
	bh=OP26wRID7imVo7J12rxlgz9zyMjobt/1rWh6Hpm9uqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VKf7XXKyJpJhLM038WIdAnO5wVREGY6OMuI4H9Wc1zYvJWzR1kt97dSLt8pjVsC6j
	 11fjkTFmSfEhvYE0SdfKHJcTyTshHpwfSOZqYQQZaiF1YaVikub8w99sQ3Qweor7Wd
	 1h+0blQFDMCRynpbU6DNaF4+K7IB+H4nzAjIjubNvwZL+d75VdNRLFwdkvMlpt/C6X
	 BYNQzbZjhLAniX2A3LHi7ahxyw/gY5aX1me4SNiHwYdieV5+V+rL11beZ3DPMR5tPg
	 gfMcH5SfqZhHxFBwcFEppQCHi8ksLAoQiDhHLasfUFKZN4rEVRxb3OZTBCMoRY6sxM
	 z8MUiOne/YR+Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1297007fac.3;
        Mon, 12 May 2025 04:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXpy7tvEuZgk5B7KEXnCybuvB5FMq4qoVc15tbvqEUilKYus5galBAtHRAepL9EgwGUQK1PIPiX2Lf@vger.kernel.org, AJvYcCXzciVnI4OgGpiJaisPK34d7fU+2jH1iUJdYh6cqeLpVCBoCwBwV3d4GSwEdKH5ueiDfo4SiXFnGhVD7vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpA2zZ1bVU0q1LNtwQcGWC9YgnWcoCQJqHyPNqbPadaZDHQRuP
	y3PfxCo1oVFztllJT7rIhuAuyIXz9SPuymAbZrRzj2kNUE2Ri3Ha2WWqHJCnCp/Z+ij8GmhENMe
	lpIgSAnyIRyMMI2ZDSOqF4FG9qPs=
X-Google-Smtp-Source: AGHT+IEgc1cpclFVS0xFmPfpfxKO7eNwHf/74FzkXLvjtGWVCoI5mCd4F1Qf6diExoLwb0LzDJCm0ssPJhXK3COGOVU=
X-Received: by 2002:a05:6870:2424:b0:29e:671b:6003 with SMTP id
 586e51a60fabf-2dba4539eeemr7885724fac.32.1747050980096; Mon, 12 May 2025
 04:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504090444.3347952-1-raag.jadav@intel.com>
In-Reply-To: <20250504090444.3347952-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 May 2025 13:56:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgpq0VmO_rDnEjDQniUiLJP3yo3-Rpy1NNxA_k8VAS2A@mail.gmail.com>
X-Gm-Features: AX0GCFtPUWD14OGMLgzCm3qM3Ty93hEQvIBQ5Hqi1UOaQYnHDabs5y8Ippsyig4
Message-ID: <CAJZ5v0hgpq0VmO_rDnEjDQniUiLJP3yo3-Rpy1NNxA_k8VAS2A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 11:06=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> If error flags are set on an AER capable device, most likely either the
> device recovery is in progress or has already failed. Neither of the
> cases are well suited for power state transition of the device, since
> this can lead to unpredictable consequences like resume failure, or in
> worst case the device is lost because of it. Leave the device in its
> existing power state to avoid such issues.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>
> v2: Synchronize AER handling with PCI PM (Rafael)
> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>     Elaborate "why" (Bjorn)

I think this is reasonable, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

(and you might as well CC it to linux-pm@vger.kernel.org>).

Thanks!

>
> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=3D9eRPuW08t-6PwzdyMXsC=
6FZRKYJtY03Q@mail.gmail.com/
>
>  drivers/pci/pci.c      | 12 ++++++++++++
>  drivers/pci/pcie/aer.c | 11 +++++++++++
>  include/linux/aer.h    |  2 ++
>  3 files changed, 25 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..25b2df34336c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev =
*dev, pci_power_t state, bool
>            || (state =3D=3D PCI_D2 && !dev->d2_support))
>                 return -EIO;
>
> +       /*
> +        * If error flags are set on an AER capable device, most likely e=
ither
> +        * the device recovery is in progress or has already failed. Neit=
her of
> +        * the cases are well suited for power state transition of the de=
vice,
> +        * since this can lead to unpredictable consequences like resume
> +        * failure, or in worst case the device is lost because of it. Le=
ave the
> +        * device in its existing power state to avoid such issues.
> +        */
> +       if (pci_aer_in_progress(dev))
> +               return -EIO;
> +
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         if (PCI_POSSIBLE_ERROR(pmcsr)) {
>                 pci_err(dev, "Unable to change power state from %s to %s,=
 device inaccessible\n",
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..4040770df4f0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>
> +bool pci_aer_in_progress(struct pci_dev *dev)
> +{
> +       u16 reg16;
> +
> +       if (!pcie_aer_is_native(dev))
> +               return false;
> +
> +       pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +       return !!(reg16 & PCI_EXP_AER_FLAGS);
> +}
> +
>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
>         int rc;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..e6a380bb2e68 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +bool pci_aer_in_progress(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return fal=
se; }
>  #endif
>
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> --
> 2.34.1
>


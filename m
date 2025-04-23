Return-Path: <linux-pci+bounces-26531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77FA989FE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030CF188D318
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB031267F6B;
	Wed, 23 Apr 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrp72AKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AC20C028;
	Wed, 23 Apr 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412124; cv=none; b=SwPT9wfLZbfixGvcOQnvDZQYHfEa7IVjuV7YWdIQK0SLkIfaTIFnsqv/pjsh1xSOxkK/7uxe2YKwEXXTbNpXAatwUeoOV7rFlLvkESF7CfNvrwNEcDXRBaoRfHfCzA9lGmIZLErf5uRUeeQU4K9oTkr5xUPKsTvWDs03EsNnS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412124; c=relaxed/simple;
	bh=6JXUw9KDlKhlNf9LvTyb80wcPFCs/dCF06cs55twRs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuV9LKL7UN6RknduTon6CKYV+vFvjDYQD7or0knQOt6Fnl6V1KJ3rwOvn07XO7XoMkSx83fyUnkeM+IeMIC0OxBvne8OkvzozxvJfxUm9MujaUXvQp3xepw8vZnme9+5sir2UHjG4xFFny2UtZqCY4r7jglYAWR1TFPgrwSlJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrp72AKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A937C4CEE2;
	Wed, 23 Apr 2025 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745412124;
	bh=6JXUw9KDlKhlNf9LvTyb80wcPFCs/dCF06cs55twRs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rrp72AKIAv1LoaxnsmE0Z4ev+0kI6cg8tlYQFaOO8+oQQ0adL7P7AfLy+NFrIcotj
	 Lg55HqxaKGY0Pa65azbJ0IrPFL70bVh0cfHk2Kt9dv+ZzXlM2T437sbVHPFssirXDg
	 IlE9S2XyqGk5Bim4Dl5KvVfoWu2X5HJoRIWSey+3fw6RKpIxdonnMxnmS8OCMuwPPm
	 xjeKWCaqL2iYOyDvPy/1jnSkjccWFUevvjL30U8Z/j8yKkE97LNfpLs4wrRILJnnGI
	 LzgELYgaM2e0Tq4H+KZaROBpuXixmgZGwlU0RrY7QqMl8l9NhOrEWefAidAfhJTRYO
	 FtfygJSbijCkg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b8e2606a58so3472355fac.0;
        Wed, 23 Apr 2025 05:42:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW240JpmGz+DX6XU9T3r6GQDBl3jRenmy+VS/apkiCrsHg6H8ejjOVxGKCG9eF+Lu9a1vMkP7iNiacB@vger.kernel.org, AJvYcCXutO0K0iZBDKpX36/IWp4ltWlb4NCL4zN+vBQlL+oYZm1YM8p8+579/r7gsD+f4pGMRh0LB/+5Dz2kvZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNPJzyvvi7Q+yqTyMfXAJz2SPygVJdKH2bBuez+dL+wAETvMf
	9Rvn1JkrE2WX8FHsB9WCoGjclIpYYL6J6YhQQa6d/ILtI5AHWr3bLOYNr1oGVMSjh8EyMrXmeA2
	cXuN5EjsbpU+ysUxP8tB6yXLAhus=
X-Google-Smtp-Source: AGHT+IG/Mn2Gdw6BufcDTpp8opMgvyFLfa1jgjgwIIwbfktnPgvUyN1Iv0Aj9WOBxD1DHjHqO+fC2n5X8dOk12DvydQ=
X-Received: by 2002:a05:6870:2112:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2d526e25275mr12308732fac.35.1745412123964; Wed, 23 Apr 2025
 05:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422135341.2780925-1-raag.jadav@intel.com>
In-Reply-To: <20250422135341.2780925-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 14:41:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com>
X-Gm-Features: ATxdqUHc2_qjWYGhUFZxApzUYB_8rBJHdL6YdtW9OV8O8advii08NxH7vfc9A0A
Message-ID: <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:55=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> If an error is triggered before or during system suspend, any bus level
> power state transition will result in unpredictable behaviour by the
> device with failed recovery. Avoid suspending such a device and leave
> it in its existing power state.
>
> This only covers the devices that rely on PCI core PM for their power
> state transition.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>
> v2: Synchronize AER handling with PCI PM (Rafael)
>
> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=3D9eRPuW08t-6PwzdyMXsC=
6FZRKYJtY03Q@mail.gmail.com/
>
>  drivers/pci/pci-driver.c |  3 ++-
>  drivers/pci/pcie/aer.c   | 11 +++++++++++
>  include/linux/aer.h      |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f57ea36d125d..289a1fa7cb2d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 }
>         }
>
> -       if (!pci_dev->state_saved) {
> +       /* Avoid suspending the device with errors */
> +       if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {

Apart from the potential raciness mentioned by Bjorn, doing it just
here is questionable because this is not the only place where the PCI
device power state can change.

It would be better to catch this in pci_set_low_power_state() IMO.


>                 pci_save_state(pci_dev);
>
>                 /*
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..b70f5011d4f5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -233,6 +233,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
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
> index 947b63091902..68ae5378256e 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -48,12 +48,14 @@ struct aer_capability_regs {
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


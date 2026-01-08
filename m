Return-Path: <linux-pci+bounces-44281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06394D04400
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64522304EBCE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8874ECFD4;
	Thu,  8 Jan 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urm0cF0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686E4ECFCE
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881071; cv=none; b=lQY6MrxpxPPsjdAbowmRzNdZGxYF0ZEvEepaYVUNFN9TRBJu/ushCwxzDmkkdLszS0sAb8a3Pb0aiP3a/QBOAPjA6R6GiJ1kJdzJPcFAeFPZ1fCAMgoZkYMDpb9/v4pjLDU+ZOL8dueHFDjNjV3rKiJGaOEQs5Vk+POnf2K09eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881071; c=relaxed/simple;
	bh=MyGpvQo9fFdosijPmJBtZZIVi4n0wD1urmO8q8xX9w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlQS3+QPS+AHdaGRoVL73JHNcbVazvMoMl9io0zOGucuEViMC/NSlw/HiiAhq4fwxFI5bsglVzrW4jm/Ut0tiflwpjIpy6zDAgD9M1eatlEoLixT9NaKtCdgGXkWYx9DiUwQdQYExx3fyRpWIuC8JLJ4vwB6a57iCEe9ej7EziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urm0cF0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64002C2BCB3
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767881071;
	bh=MyGpvQo9fFdosijPmJBtZZIVi4n0wD1urmO8q8xX9w4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=urm0cF0AwirqTesDirCKfbYPR0ddR8IlmYemYm1MmQtuAA3l1LBRul3qt7jO2CPJn
	 40t864xKWnFzuJpZ/2s9fLLGzMSAPhPA6/l/fA7cw2/1luth3Y5ghiw2bPT9/M89Ri
	 v5T3eLe7WYSB5YQD5XyG5bX+jWIFS3w1xuF8Bg6/aOnkcJxG1jICDYLBOvnqKvS3RN
	 Ibv06GQ/PWev23Rw88tiMRU2RBMe7jJErwJI7O55Ltcg5j5Tr5zNbjcsjSpf9PMsWk
	 MHIRDJ+ooLH3lmMA/5NBZM1OgHzadXdTGG8if/jaupFn6rQbvhWqkfDX9aor/kT3cf
	 Sip5USg9lbvBQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso2373821fac.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 06:04:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjlQyUm28IFTWiVbcDi932K2dxydl1FbKvadGSoLWB3alCP2v7lb+Em60IFRWAHbM3ABUlzvFBm+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6IuSZVvmYHO2KYwhSVD885VTPcCuiCI7ZHWIe+WT/yBvXMIs
	j6ku9/9yMGuq3VFlTA5U30KJ2WqnFNJUJdOsaOSz34mBicZOaLO976ouClsPqC6USL2z/3Pr+At
	wmVYEMTM7pEBnG4rrY+6ULUfXoeLNgt0=
X-Google-Smtp-Source: AGHT+IEWmSNDkm7cd1N9j1jItnPBAEYpQLsT2JoqKt6RYJxFlAcINFiVdcun40m36PUjL/ippFjH+VlBrMu3vJaVTlI=
X-Received: by 2002:a05:6820:16a8:b0:659:9a49:8f2d with SMTP id
 006d021491bc7-65f550a373emr2609013eaf.62.1767881070426; Thu, 08 Jan 2026
 06:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203140716.3065-1-huyuye812@163.com>
In-Reply-To: <20251203140716.3065-1-huyuye812@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 15:04:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iv8q_Yq9sttsNm2GHTemYVqmnxaQ3xy-cw9wwJFOAeVA@mail.gmail.com>
X-Gm-Features: AQt7F2rxYUivRcLsquM_9m6oqb-2ltv6AOagF_iyo2_Ts3pWNuRXzoUaGVppb-s
Message-ID: <CAJZ5v0iv8q_Yq9sttsNm2GHTemYVqmnxaQ3xy-cw9wwJFOAeVA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
To: huyuye <huyuye812@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn, 
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn, 
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn, 
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn, li.kunpeng@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:07=E2=80=AFPM huyuye <huyuye812@163.com> wrote:
>
> On RISC-V platforms with multiple PCI root bridges, the enumeration
> order varies randomly across reboots due to APLIC driver initialization
> occurring after ACPI device scanning. This defers PCI probing to a
> unbound workqueue, resulting in non-deterministic device discovery
> sequences.
>
> Such random enumeration leads to changes in device naming across each
> boot, which disrupts storage configurations, network settings, and
> severely impacts the stability of server maintenance.
>
> By adding the acpi_dev_clear_dependencies() call in acpi_pci_root_add(),
> this patch enables the firmware to actively control the enumeration order
> of multiple PCI root bridges through the ACPI _DEP method, providing the
> firmware with the opportunity to initialize devices in the intended order=
,
> thereby ensuring consistent enumeration results across multiple boots.
>
> Signed-off-by: huyuye <huyuye812@163.com>
> ---
>  drivers/acpi/pci_root.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 74ade4160314..f5b5aa7d5f93 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -760,6 +760,20 @@ static int acpi_pci_root_add(struct acpi_device *dev=
ice,
>         pci_lock_rescan_remove();
>         pci_bus_add_devices(root->bus);
>         pci_unlock_rescan_remove();
> +#ifdef CONFIG_RISCV
> +    /*
> +     * Clear dependencies to allow dependent devices to be enumerated.
> +     * This is particularly important for RISC-V platforms where multipl=
e
> +     * PCIe host bridges may have initialization order dependencies defi=
ned
> +     * via ACPI _DEP method in DSDT. If a host bridge B depends on host
> +     * bridge A (via _DEP), this call allows bridge B to proceed with
> +     * enumeration after bridge A is fully initialized.
> +     */
> +#ifdef CONFIG_ACPI
> +       if (!acpi_disabled)
> +               acpi_dev_clear_dependencies(device);
> +#endif

All of this code depends on CONFIG_ACPI, so why is the #ifdef needed?
Also, is it actually reachable when acpi_disabled is set?

Moreover, could this be done in RISC-V specific code rather than here?

> +#endif
>         return 1;
>
>  remove_dmar:
> --


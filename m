Return-Path: <linux-pci+bounces-18043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF09EB942
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30BA1889CF0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC02046AC;
	Tue, 10 Dec 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogrout7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A21B1422;
	Tue, 10 Dec 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855046; cv=none; b=JSUJBSZEzb3GpyeaYabsB9YAeQCX6sYVZHYRxw5EpQX2hl+LcddmMMKzo4JQgAQ/MIq/xDeyrg5TREmr23RX2s6VC0cp/SGVgDOg0+YQbmF4Qr6pG24cl96+4UsX6GWQOn9Ucepm0c8J6MHLYTkkcFFi1CaFdYiNz2mcO0qkNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855046; c=relaxed/simple;
	bh=/fyiDo7t3bwOFUjqyiEviTcAYM+EqiEbi3UktkKEp3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iD6vaZAtsAQY0BFhG+PPo5dkKajp/GCLBbslFZtOQxafDqEfbNkE+A/r6jVhR2Ha2puX6+QJ+jdFHwbjStXmyj4Dg8tOV6Wy7ByIfZEwWjOG6torB5eCiCeCYMQCpUzh6kanlgnBrVxBvErq8VGQk37543273E3X5Qs1CL9BEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogrout7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0DBC4CEE1;
	Tue, 10 Dec 2024 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855045;
	bh=/fyiDo7t3bwOFUjqyiEviTcAYM+EqiEbi3UktkKEp3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ogrout7MHwnM7F18t0n7uw+pQZL2ymnVhMl1eO/JP1Ds8FX9WrK28LT2aK/7jZzIX
	 WY71XnrGhnCRPIIJdIMwKZDEfUo8OUe8hcHnFLt1xk/JRfPrrBbbCSqLkLy5dHbmRg
	 UMy9AqKJGuJdn5brzdCDNAYVDjp7qPJTUfg6NZpiOt3nGTh24ZFmuWAsObWZVvIMUz
	 oKSxVkwEIWywvMTarqKz8lSF+Hd+J4vx4Mz5TIvf1yC9j0Ii5CWa+gr4zRrOtr1zWF
	 q+UFauPqIGe6i71/Kjukb2QIZukQ0PBUS9SF6fD+Hcx3vI2b8BKdC1C3kZYUsG9FRv
	 rYsk3k54BxOrQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29e998c70f9so3317108fac.2;
        Tue, 10 Dec 2024 10:24:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOfP4uCdeiuh1ks74MVuQdEv3Um4TnLxd6l4zRfq5JGlcoMjdMv1KDs6RYScMv3FRNXE1rA2WhKrwy1E2f@vger.kernel.org, AJvYcCW9Qucfma5Txv2OkFd+Vs7PTFUOtCJUA9hK4jrQFZwjwAoj19KgO3szVQU09De4ZKT5dURCKEY40RBT@vger.kernel.org, AJvYcCWBF4HDnqAcjF/68XYMehZVQauG3QvDxmeim6DxXpGWYb12/FVwKbFUbmXfusTnOB8+deGTPqojvEel@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65oTSAA14rIBIuOAJwQ7A68JnDuPp5Rsv/ZfvFauQdmA1XKS1
	+s1IfwPr2D6rEsfq1rW65ycIuFNHXmz4BKDMePLWNiwP0LUSVbe5oBOGKNVxNu2c5sDTTRQU5I8
	5qjKo7m1RcoC6TBvAEPCZT7yuVFs=
X-Google-Smtp-Source: AGHT+IFu8OYVyYTKwdDPzTvaFe9ROtPzqdq6WzuKHAXFFij4IpP0p5z0FzryDr3QH/SZNq5GL/qyp6Z2WfvfgDxBYFA=
X-Received: by 2002:a05:6870:c08e:b0:29e:4d0e:a2b6 with SMTP id
 586e51a60fabf-2a012da5ad7mr73511fac.10.1733855044892; Tue, 10 Dec 2024
 10:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
 <20241202-sysfs-const-bin_attr-pci-v1-4-c32360f495a7@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-4-c32360f495a7@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:23:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQT7R2bMBy2JgXO0DJnoMNJ5JotZWyvvBV0w98fBae4A@mail.gmail.com>
Message-ID: <CAJZ5v0hQT7R2bMBy2JgXO0DJnoMNJ5JotZWyvvBV0w98fBae4A@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI/ACPI: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:03=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpi=
php_ibm.c
> index 8f3a0a33f362bc60ba012419b865b8821c075531..b3aa34e3a4a29417bd6942737=
79dc356be284f1d 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -84,7 +84,7 @@ static int ibm_get_attention_status(struct hotplug_slot=
 *slot, u8 *status);
>  static void ibm_handle_events(acpi_handle handle, u32 event, void *conte=
xt);
>  static int ibm_get_table_from_acpi(char **bufp);
>  static ssize_t ibm_read_apci_table(struct file *filp, struct kobject *ko=
bj,
> -                                  struct bin_attribute *bin_attr,
> +                                  const struct bin_attribute *bin_attr,
>                                    char *buffer, loff_t pos, size_t size)=
;
>  static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
>                 u32 lvl, void *context, void **rv);
> @@ -98,7 +98,7 @@ static struct bin_attribute ibm_apci_table_attr __ro_af=
ter_init =3D {
>                     .name =3D "apci_table",
>                     .mode =3D S_IRUGO,
>             },
> -           .read =3D ibm_read_apci_table,
> +           .read_new =3D ibm_read_apci_table,
>             .write =3D NULL,
>  };
>  static struct acpiphp_attention_info ibm_attention_info =3D
> @@ -353,7 +353,7 @@ static int ibm_get_table_from_acpi(char **bufp)
>   * our solution is to only allow reading the table in all at once.
>   */
>  static ssize_t ibm_read_apci_table(struct file *filp, struct kobject *ko=
bj,
> -                                  struct bin_attribute *bin_attr,
> +                                  const struct bin_attribute *bin_attr,
>                                    char *buffer, loff_t pos, size_t size)
>  {
>         int bytes_read =3D -EINVAL;
>
> --
> 2.47.1
>


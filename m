Return-Path: <linux-pci+bounces-34616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E6B322B5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 21:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3EC627275
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E38276022;
	Fri, 22 Aug 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXF7ZgV0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E04A1A;
	Fri, 22 Aug 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890361; cv=none; b=QxC+iUUQb0KjBtHCbcuJ7LqIa9Sbd5uWPTzcVLS3d8r+EIVrZvTm+aDYNMJP3C4RaTdFIo6/3DFNuZNQSedUzkESYhVCR6kNDbETgD6I3JcE0xWJcgeiRpXelef9OAGRZyD31pnh/T4kU0NkK6qFx12CeNgysgv6WrZ6vm080NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890361; c=relaxed/simple;
	bh=qOjbyBxmY6N2jwMWuIegMYipIdgnTqoEJNjKy3WY4YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg3fFleCNDGnaGiZii1XGL1wW2LiGe9reIGPS41atV8n7J7HPIFDeOHsT6wbPQnTlABapVqAFcjw+gA2qU1OVucjZy1ef35/CkMZ8fnv3P9YlOZUWY0chIbt65uZQXSsuAZOPgln+7rzwMc/NnkqU+gzJ66h2MyZAETXAnxs934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXF7ZgV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D5C113CF;
	Fri, 22 Aug 2025 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890361;
	bh=qOjbyBxmY6N2jwMWuIegMYipIdgnTqoEJNjKy3WY4YQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CXF7ZgV0zypYkEwV6ARegi1H3MyZvIPkbb7v7TR+jm1c4tNC9qlf82d5V+RPvrzyo
	 3/WCa9L9OtNCamEcRp3D9bBcCHzIY8K9dtHu7qKlU6KkuXN8RWCDdP6JCCy64Ghh1z
	 AINHK8HdjPXjabB75jPwm0T41MtHxdZ4M4F/HzAXK2SyKIjcVt8N5ryBh/tSiEpG0T
	 AHgaC5FiuUrZ+979VeqAuYqSX9RYeplDoIvIsyLzOIAe90PZQgPcmCOzvA7LaLeASq
	 hdb/RWOi5nNDhev85e3u7e0jxYB2DPV9GdUdvSqUiDIcV6QR1uJ1l9DuVIHcxkJoK+
	 l64GLp2uYgZXg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce534a91so1114171fac.0;
        Fri, 22 Aug 2025 12:19:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYwaUJ1v6cUi/Zm5I6LHKeJYvb4pMnbG0HeKxW/YMX/PnSwyK9lJanIZmk/8GrzhacUDS66nCWK/Zn@vger.kernel.org, AJvYcCWymcKTRyP2dESp9mfd9z4wx/eBB5o0zh5+1xTVZP+rmNnXlMs/e+xxxf79eA6UWotqh0uYjl9l9bEu@vger.kernel.org
X-Gm-Message-State: AOJu0YwngauHneI4wrBEqenVMKfaqMvQFqdLzFva6Ap/YTl/QbYtD29O
	cC2gygqL4zS/MeW8j6Wni4t/UfnlL4ntl/Ka5yUoArWH8Bu0MwY0/G6SRoh3sXyjCxs1X6Bp7pv
	9nLDeE5tVlk3CWtVId0bLsaSeny4En7g=
X-Google-Smtp-Source: AGHT+IFpfe0e3l/uwtd2JvLB8n+LhJpZexkLKTEHaCSJ2v0cIYYtIsnI9Fc6o3YHX8vzts3+3TsPtfSejs/INvOShfg=
X-Received: by 2002:a05:6870:d114:b0:307:bb94:2260 with SMTP id
 586e51a60fabf-314dcd2a03amr1765237fac.24.1755890360256; Fri, 22 Aug 2025
 12:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com> <20250730214718.10679-15-Benjamin.Cheatham@amd.com>
In-Reply-To: <20250730214718.10679-15-Benjamin.Cheatham@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 21:19:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joDdAyqAzjbwTfR9sfSstU++SuOKZX8pL+1ZeGDqVnDA@mail.gmail.com>
X-Gm-Features: Ac12FXwcXAYLHqCeM84ga1EjauG4v-FFKkcIXVwiBTNnRDC7KokCxGEI6OmAkSE
Message-ID: <CAJZ5v0joDdAyqAzjbwTfR9sfSstU++SuOKZX8pL+1ZeGDqVnDA@mail.gmail.com>
Subject: Re: [PATCH 14/16] ACPI: Add CXL isolation _OSC fields
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: Dave

On Wed, Jul 30, 2025 at 11:50=E2=80=AFPM Ben Cheatham <Benjamin.Cheatham@am=
d.com> wrote:
>
> Add CXL Timeout and Isolation _OSC support and control fields, as
> defined in the ECN at the link below. The ECN contents are expected to
> appear in the CXL 4.0 specification. The link is only accessible to CXL
> SSWG members, so a brief overview is provided here:
>
> The ECN adds several fields to the CXL _OSC method (CXL 3.2 9.18.2)
> for the purpose of reserving CXL isolation features for the platform
> firmware's use. The fields introduced for kernel support reserve
> toggling the CXL.mem isolation enable bit in the isolation control
> register (CXL 3.2 8.2.4.24.2) and how the host is notified isolation has
> occurred.
>
> These fields will be used by the CXL driver to enable CXL isolation
> according to the result of the handshake. Descriptions of these fields
> are included in the commit messages of the commits where they are used.
>
> Link: https://members.computeexpresslink.org/wg/software_systems/document=
/3118
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

In case you need this

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 9 +++++++++
>  include/linux/acpi.h    | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 74ade4160314..33a922e160fc 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -145,10 +145,13 @@ static struct pci_osc_bit_struct cxl_osc_support_bi=
t[] =3D {
>         { OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT, "CXL20PortDevRegAccess=
" },
>         { OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT, "CXLProtocolErrorReport=
ing" },
>         { OSC_CXL_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
> +       { OSC_CXL_TIMEOUT_ISOLATION_SUPPORT, "CXLTimeoutIsolation" },
>  };
>
>  static struct pci_osc_bit_struct cxl_osc_control_bit[] =3D {
>         { OSC_CXL_ERROR_REPORTING_CONTROL, "CXLMemErrorReporting" },
> +       { OSC_CXL_MEM_ISOLATION_CONTROL, "CXLMemIsolation" },
> +       { OSC_CXL_ISOLATION_NOTIF_CONTROL, "CXLIsolationNotifications" },
>  };
>
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 w=
ord,
> @@ -493,6 +496,8 @@ static u32 calculate_cxl_support(void)
>                 support |=3D OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>         if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>                 support |=3D OSC_CXL_NATIVE_HP_SUPPORT;
> +       if (IS_ENABLED(CONFIG_CXL_ISOLATION))
> +               support |=3D OSC_CXL_TIMEOUT_ISOLATION_SUPPORT;
>
>         return support;
>  }
> @@ -535,6 +540,10 @@ static u32 calculate_cxl_control(void)
>         if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
>                 control |=3D OSC_CXL_ERROR_REPORTING_CONTROL;
>
> +       if (IS_ENABLED(CONFIG_CXL_ISOLATION))
> +               control |=3D (OSC_CXL_MEM_ISOLATION_CONTROL |
> +                           OSC_CXL_ISOLATION_NOTIF_CONTROL);
> +
>         return control;
>  }
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f102c0fe3431..f172182aa029 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -626,9 +626,12 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT        0x00000002
>  #define OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT 0x00000004
>  #define OSC_CXL_NATIVE_HP_SUPPORT              0x00000008
> +#define OSC_CXL_TIMEOUT_ISOLATION_SUPPORT      0x00000010
>
>  /* CXL _OSC: Capabilities DWORD 5: Control Field */
>  #define OSC_CXL_ERROR_REPORTING_CONTROL                0x00000001
> +#define OSC_CXL_MEM_ISOLATION_CONTROL          0x00000002
> +#define OSC_CXL_ISOLATION_NOTIF_CONTROL                0x00000020
>
>  static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *=
context)
>  {
> --


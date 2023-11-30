Return-Path: <linux-pci+bounces-282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E827FF039
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417BA1C20BC5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632447A6D;
	Thu, 30 Nov 2023 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB2D90;
	Thu, 30 Nov 2023 05:34:30 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b89d4be037so158253b6e.0;
        Thu, 30 Nov 2023 05:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351270; x=1701956070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsSkd9Z+ooFtNFrUCB0W0bjBZ4BzCMhvYDCWIVJBLa0=;
        b=OMN0Ljvg91iW3CvtWNjas0gVXQB6QkEjxF+to9Jefve1d83o7TYJY3Bdk6URSpZeZw
         7DWcsG+5jBquzOQ4enbR6yChDZfe93P9gzFQXub5/sBLOxe18ZkL3U2VI4Q/Pv/IqIPm
         xDPq6cpYlXWnVh1EOGuORJCToBp/XH7wwnl1DN08GTu7b8GwlA/VBPJdFvBlLVBMaQv6
         0XeLP4i1VR/NZdk01xyq/NhqmRS0r1pIoBRMNOFtXcnAy6lrWzhSJ/iGa9DR8eY0Pu6r
         uqixeSmQDocxdjOw6hFMwo82JpNQRAEjpPe/HBn986/lO/7Dw6KXlNHys220rJ3eF85M
         99+w==
X-Gm-Message-State: AOJu0YzcsaZujsEX5N/hsbM513uNLhT42lrroF4srNEDnoKPM0iW9dn2
	S6CXrzBxa1Be3F4+bCbx3bWBuymBF7IWLZHlF5U=
X-Google-Smtp-Source: AGHT+IEXYJjceEHnm1gru2z0MY1Ph6o5bcJvngCnRk+nJcyzn7kvn7eBTi47P8u5YV9hbA3I7mMr0z1Vcp7lJapQKeE=
X-Received: by 2002:a05:6808:2016:b0:3ae:5650:c6ae with SMTP id
 q22-20020a056808201600b003ae5650c6aemr2277022oiw.0.1701351269934; Thu, 30 Nov
 2023 05:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110185503.46117-1-mario.limonciello@amd.com> <20231110185503.46117-2-mario.limonciello@amd.com>
In-Reply-To: <20231110185503.46117-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Nov 2023 14:34:19 +0100
Message-ID: <CAJZ5v0hAw99pfdrqgg8AxfeCHcBWeoB2J9bR1sN9a2dU=x79Ag@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision argument
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 9:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The PCI ACPI _DSM is called across multiple places in the PCI core
> with different arguments for the revision.
>
> The PCI firmware specification specifies that this is an incorrect
> behavior.
> "OSPM must invoke all Functions other than Function 0 with the
>  same Revision ID value"
>
> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>       PCI Firmware specification 3.3, section 4.6
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I haven't seen much activity related to this series, so I'm not
sure what's happening to it.

Regardless, I think that the remaining two patches are better sent
along with the first users of the new APIs.

> ---
>  drivers/acpi/pci_root.c  |  3 ++-
>  drivers/pci/pci-acpi.c   |  6 ++++--
>  drivers/pci/pci-label.c  |  4 ++--
>  drivers/pci/pcie/edr.c   | 13 +++++++------
>  include/linux/pci-acpi.h |  1 +
>  5 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 58b89b8d950e..bca2270a93d4 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1055,7 +1055,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pc=
i_root *root,
>          * exists and returns 0, we must preserve any PCI resource
>          * assignments made by firmware for this host bridge.
>          */
> -       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_ac=
pi_dsm_guid, 1,
> +       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
> +                                     &pci_acpi_dsm_guid, pci_acpi_dsm_re=
v,
>                                       DSM_PCI_PRESERVE_BOOT_CONFIG, NULL,=
 ACPI_TYPE_INTEGER);
>         if (obj && obj->integer.value =3D=3D 0)
>                 host_bridge->preserve_config =3D 1;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 004575091596..bea72e807817 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -28,6 +28,7 @@
>  const guid_t pci_acpi_dsm_guid =3D
>         GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
>                   0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
> +const int pci_acpi_dsm_rev =3D 5;
>
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *r=
es)
> @@ -1215,7 +1216,8 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>         if (!pci_is_root_bus(bus))
>                 return;
>
> -       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_ac=
pi_dsm_guid, 3,
> +       obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
> +                                     &pci_acpi_dsm_guid, pci_acpi_dsm_re=
v,
>                                       DSM_PCI_POWER_ON_RESET_DELAY, NULL,=
 ACPI_TYPE_INTEGER);
>         if (!obj)
>                 return;
> @@ -1376,7 +1378,7 @@ static void pci_acpi_optimize_delay(struct pci_dev =
*pdev,
>         if (bridge->ignore_reset_delay)
>                 pdev->d3cold_delay =3D 0;
>
> -       obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
> +       obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, pci_a=
cpi_dsm_rev,
>                                       DSM_PCI_DEVICE_READINESS_DURATIONS,=
 NULL,
>                                       ACPI_TYPE_PACKAGE);
>         if (!obj)
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 0c6446519640..91bdd04029f0 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -41,7 +41,7 @@ static bool device_has_acpi_name(struct device *dev)
>         if (!handle)
>                 return false;
>
> -       return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> +       return acpi_check_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_re=
v,
>                               1 << DSM_PCI_DEVICE_NAME);
>  #else
>         return false;
> @@ -162,7 +162,7 @@ static int dsm_get_label(struct device *dev, char *bu=
f,
>         if (!handle)
>                 return -1;
>
> -       obj =3D acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> +       obj =3D acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_ds=
m_rev,
>                                 DSM_PCI_DEVICE_NAME, NULL);
>         if (!obj)
>                 return -1;
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 5f4914d313a1..ab6a50201124 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>          * Behavior when calling unsupported _DSM functions is undefined,
>          * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>          */
> -       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_ds=
m_rev,
>                             1ULL << EDR_PORT_DPC_ENABLE_DSM))
>                 return 0;
>
> @@ -51,8 +51,9 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>          * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_D=
SM is
>          * optional.  Return success if it's not implemented.
>          */
> -       obj =3D acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> -                               EDR_PORT_DPC_ENABLE_DSM, &argv4);
> +       obj =3D acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
> +                               pci_acpi_dsm_rev, EDR_PORT_DPC_ENABLE_DSM=
,
> +                               &argv4);
>         if (!obj)
>                 return 0;
>
> @@ -88,12 +89,12 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_d=
ev *pdev)
>          * Behavior when calling unsupported _DSM functions is undefined,
>          * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>          */
> -       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_ds=
m_rev,
>                             1ULL << EDR_PORT_LOCATE_DSM))
>                 return pci_dev_get(pdev);
>
> -       obj =3D acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> -                               EDR_PORT_LOCATE_DSM, NULL);
> +       obj =3D acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
> +                               pci_acpi_dsm_rev, EDR_PORT_LOCATE_DSM, NU=
LL);
>         if (!obj)
>                 return pci_dev_get(pdev);
>
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..7966ef8f14b3 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -115,6 +115,7 @@ static inline void acpiphp_check_host_bridge(struct a=
cpi_device *adev) { }
>  #endif
>
>  extern const guid_t pci_acpi_dsm_guid;
> +extern const int pci_acpi_dsm_rev;
>
>  /* _DSM Definitions for PCI */
>  #define DSM_PCI_PRESERVE_BOOT_CONFIG           0x05
> --
> 2.34.1
>
>


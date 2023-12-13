Return-Path: <linux-pci+bounces-896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8E811CC1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A071F21990
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42C31750;
	Wed, 13 Dec 2023 18:38:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B12EB;
	Wed, 13 Dec 2023 10:38:26 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b8652c0bd2so597302b6e.1;
        Wed, 13 Dec 2023 10:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492705; x=1703097505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0e9RjRusvtUVL36p2n3yW7GJ2o7hpTev/itTbWI7rc=;
        b=I+144M8ftMJAreRe6xPQdj8vySNi6X+sVzPXn/7rfWVT3Uqaqqc3p/so2G6F1PcJGL
         coXDHRWDq8Q9j6jdkpe3mk7MyrKhVPWB5CQTOVDxetL+1z7VvRffHUbMupj6iB5OTjZe
         PoCFKBHEauATKOLo2+EW4ads35M65l87tOEZ49UREEoo8YnGSCAAlFiMYw26X1gy1FF4
         xMc1wNyy3v5gsoiPXHj3+CGAGuhAT+FUL0b9QdW3TF1OQCdcSTgFUcS8Fk2PetN7XSrj
         nN3khOc8/ZMD5hfS8faPi+wLLNzLNL7kMSsydRIU3XmXxjsnHvi7XGaKlaQFb0zKV77I
         RrfA==
X-Gm-Message-State: AOJu0YwZ8PXGmkN0TVH316Dsc3+yQW8E9sckAgx8xPhDi6l0ymNiQy4C
	T74oy57enJe6CXqyLxBEgsVHwyYez26ltbEnNkqy/eFS
X-Google-Smtp-Source: AGHT+IHZKVn3E0ZO3joLhJTb7yWJ8MSomiP1GSk6a/ctZVcvYzFC2WbOfEHp3TQd+tiK5vgLIEir+LilwP7Rt6ratOc=
X-Received: by 2002:a05:6870:1484:b0:1fa:f0ee:ba9c with SMTP id
 k4-20020a056870148400b001faf0eeba9cmr16236627oab.2.1702492705309; Wed, 13 Dec
 2023 10:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com> <20231213182656.6165-3-mario.limonciello@amd.com>
In-Reply-To: <20231213182656.6165-3-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 19:38:14 +0100
Message-ID: <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:27=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When a system is being powered off it's important that PCIe ports
> have been put into D3cold as there is no other software to turn
> off the devices at S5.
>
> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> power resources may be left enabled and devices may consume excess
> power.

Isn't that a platform firmware issue?

It is the responsibility of the platform firmware to properly put the
platform into S5, including power removal from devices that are not
armed for power-on.

> Cc: mpearson-lenovo@squebb.ca
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pcie/portdrv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..08238680c481 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  {
>         if (pci_bridge_d3_possible(dev)) {
> -               pm_runtime_forbid(&dev->dev);
> -               pm_runtime_get_noresume(&dev->dev);
> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> +               /* whole hierarchy goes into a low power state for S5 */
> +               if (system_state =3D=3D SYSTEM_POWER_OFF) {
> +                       pci_set_power_state(dev, PCI_D3cold);
> +               } else {
> +                       pm_runtime_forbid(&dev->dev);
> +                       pm_runtime_get_noresume(&dev->dev);
> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
> +               }
>         }

Wouldn't it be better to remove power from the port after running the
code below?

>         pcie_port_device_remove(dev);
> --


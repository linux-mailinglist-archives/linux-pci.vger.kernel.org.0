Return-Path: <linux-pci+bounces-877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF77811288
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 14:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCED1F212F1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33E2C84E;
	Wed, 13 Dec 2023 13:08:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF3B2;
	Wed, 13 Dec 2023 05:08:11 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59158202d22so58389eaf.0;
        Wed, 13 Dec 2023 05:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472890; x=1703077690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfzhlsnoq9Ysoezun43pMBPmJAkFvJFC0eB1jMYm89g=;
        b=LLSJ6rosSw0zGs1doQW5MzW1mS2bWTmK+S29GsQkQNM+ma2nfzKcj/UaaACJoRA5pk
         4nrkPN+Xp2/NXZk4UoOcO36Eq95buwJWC6qlmI8zZSApH4ftqx2pHYkVUvCe0DF8VOVV
         +HOWZp7/kgunTBIntjL7Ngh7O0xPqruUx4Zjw0LojUUJTe3zsosTLdeVlDsakrmiXl2t
         P2Ds+qwXH816LRDucarCJyfATuYMc0EU1ovclGcAew009zUeLQdoK9i0amrbencM2pZ4
         58NYDIegCsDoVw1HS5YARNE0aFYfYzc3VVj8aEtp4fVlf5qnmt7EuwZk2RR7x+Dj3VYK
         2vgw==
X-Gm-Message-State: AOJu0Yyaywyq6fLLDllCRHOVFiHKjkWaTU7BYP1iRlCp5n8QLmvMx+Uq
	E4/1SiSJ/x7w84JbFe/FICVcF5RKjPEVl6J/PxA=
X-Google-Smtp-Source: AGHT+IEksZOaTrdaIJm4lcb85oyK5X2mMVWwsxlOxVmkTgEU6wD3nKcf13Ky+z3N80hZuRCQiIgW0WBLZWxvZNYNM94=
X-Received: by 2002:a05:6871:892:b0:203:1727:c6b with SMTP id
 r18-20020a056871089200b0020317270c6bmr2841209oaq.5.1702472890600; Wed, 13 Dec
 2023 05:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-3-imammedo@redhat.com>
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 14:07:59 +0100
Message-ID: <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com, 
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com, 
	joe.jin@oracle.com, stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>, 
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:36=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enable=
d already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug severa=
l
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 6b11609927d6..30bca2086b24 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>
>  #include "../pci.h"
>  #include "acpiphp.h"
> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  {
>         struct acpiphp_slot *slot;
> +        int nr_hp_slots =3D 0;
>
>         /* Bail out if the bridge is going away. */
>         if (bridge->is_going_away)
> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_brid=
ge *bridge)
>
>                         /* configure all functions */
>                         if (slot->flags !=3D SLOT_ENABLED) {
> +                               if (nr_hp_slots)
> +                                       msleep(1000);

Why is 1000 considered the most suitable number here?  Any chance to
define a symbol for it?

And won't this affect the cases when the race in question is not a concern?

Also, adding arbitrary timeouts is not the most robust way of
addressing race conditions IMV.  Wouldn't it be better to add some
proper synchronization between the pieces of code that can race with
each other?

> +
> +                                ++nr_hp_slots;
>                                 enable_slot(slot, true);
>                         }
>                 } else {
> --


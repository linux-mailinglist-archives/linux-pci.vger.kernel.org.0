Return-Path: <linux-pci+bounces-876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2A781124E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8946C281E79
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39682C1BD;
	Wed, 13 Dec 2023 13:01:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC046F2;
	Wed, 13 Dec 2023 05:01:47 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2033578d5e0so6200fac.0;
        Wed, 13 Dec 2023 05:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472507; x=1703077307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jg66vlrCUJ5caH3ipTFUdmcb6mbPBA/2vfEVtGjIuXI=;
        b=CQuRlJ0DBv3/8dPCNf72jH9yZJLQnawyrQteUJOqA4OjmbyvpZBoxiHiJc4YIS+KPo
         1nz7WfDIAqaVsec/dArJRK2uHu4JtwIhkw+Ruz6WXbAGjpr7lq7ukhi5ZXz44pb6xNY2
         Eq0wP9JtLcuEDjaWza+bDscOPtjEibeOE++StqXITAL6dTxbAyUCbkephqMsHValGZrh
         oahpBwVQ32eo5CzD5MxluCRjgMTEladxlS1WoayD635C6caBG1RJ1qLPQJsaxXFfxCcT
         4RCQ0f3SmFzVnZA6l+TOjjmiPM5lASWjFoOWFTYbt29297xclShTQ2NxSbNPm2hPeaGe
         L6aw==
X-Gm-Message-State: AOJu0YwkWFTH6JB139dsGDxNSps5iAVP5cOLng9rzoZDUtuv4W4PfvTX
	0PYMz5FrhmDx0KJlUa2q2xVQhs79z4DbdCFF93A=
X-Google-Smtp-Source: AGHT+IGN1RQXc5S1lW2Z1iuPftBz430GliyRNOQ/FrfR1o/t5CAfoExAW38rqTKi8eT364HVJEvngQqJo/Pf/FeY5ss=
X-Received: by 2002:a05:6870:9a8a:b0:203:36fc:6c8a with SMTP id
 hp10-20020a0568709a8a00b0020336fc6c8amr153643oab.4.1702472507203; Wed, 13 Dec
 2023 05:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-2-imammedo@redhat.com>
In-Reply-To: <20231213003614.1648343-2-imammedo@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 14:01:36 +0100
Message-ID: <CAJZ5v0jQTiLqbBQ+xMord2apaQcdXNWumZPbHqu0GOxJ3apPFQ@mail.gmail.com>
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
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
> When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> adding device to bus and enabling it will kick in async host scan
>
>  scsi_scan_host+0x21/0x1f0
>  virtscsi_probe+0x2dd/0x350
>  ..
>  driver_probe_device+0x19/0x80
>  ...
>  driver_probe_device+0x19/0x80
>  pci_bus_add_device+0x53/0x80
>  pci_bus_add_devices+0x2b/0x70
>  ...
>
> which will schedule a job for async scan. That however breaks
> if there are more than one SCSI host behind bridge, since
> acpiphp_check_bridge() will walk over all slots and try to
> enable each of them regardless of whether they were already
> enabled.
> As result the bridge might be reconfigured several times
> and trigger following sequence:
>
>   [cpu 0] acpiphp_check_bridge()
>   [cpu 0]   enable_slot(a)
>   [cpu 0]     configure bridge
>   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
>   [cpu 0]   enable_slot(b)
>   ...
>   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
>   ...
>   [cpu 0]     configure bridge <- temporaly disables bridge
>
> and cause do_scsi_scan_host() failure.
> The same race affects SHPC (but it manages to avoid hitting the race due =
to
> 1sec delay when enabling slot).
> To cover case of single device hotplug (at a time) do not attempt to
> enable slot that have already been enabled.
>
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if neces=
sary")
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reported-by: iona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 601129772b2d..6b11609927d6 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -722,7 +722,9 @@ static void acpiphp_check_bridge(struct acpiphp_bridg=
e *bridge)
>                                         trim_stale_devices(dev);
>
>                         /* configure all functions */
> -                       enable_slot(slot, true);
> +                       if (slot->flags !=3D SLOT_ENABLED) {
> +                               enable_slot(slot, true);
> +                       }

Shouldn't this be following the acpiphp_enable_slot() pattern, that is

if (!(slot->flags & SLOT_ENABLED))
         enable_slot(slot, true);

Also the braces are redundant.

>                 } else {
>                         disable_slot(slot);
>                 }
> --


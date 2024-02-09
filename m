Return-Path: <linux-pci+bounces-3287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878784F72F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 15:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E59B244F4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CA6995B;
	Fri,  9 Feb 2024 14:17:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6266B4D;
	Fri,  9 Feb 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488222; cv=none; b=gvYmZ8sLq8IkfmK2xODCxPC8n7UBcPte6BHIj8abSo3MrPquUCj0/JpPHhytW7RgUXmNbJw4p1KUcOT0l12PyEDggvo/EMxuKp97ow6IoxbV/d8uep+89UMyTmDv2R9LD1Bjy06DLGzUswwcafe/GMl5cLlXLWpz+jIkyPEIHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488222; c=relaxed/simple;
	bh=r2L5UFSd7ihDVr6WY6Nn3RvqyS3h+3YX2PpnjXQ2u1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGynaafmKBlOj1t/LMizOQF7HBVQANgjFlBebMWaHCnQvPnD/jKL8MWolYnrE2ZTdFZ7NObzu3wC39WwY2dw4uZkQxdqazWEI6Hc8naEBKBAhqmh6cPu3mFswqylEuDElT8/cURb6HV/8tWVNzO91iplT02YTzRCGI0Rcf9rq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59ceb5a0593so47573eaf.0;
        Fri, 09 Feb 2024 06:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707488220; x=1708093020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZFtzVDJeA3dXQeotyrRokt7aIBqRFpzQ2NPuZqc8Cg=;
        b=AaO8kyC6D/9VudfOyb7RQvyjgi4HuFRwEQTLFKjZftao9gRpT6xf9ScuDJNWgy8nxJ
         6VnBJyUCfVu1gUoIR2ly0t2bmyy+VyWy4+HdN5c9vWs6/YVF7EOMzXmzS7DGpPl/tUgg
         +4gQasJ6EPDjKceT8nlWPhksOoKWyh0kDe3I0+RuZaNEHlqxk1UkO87xHyKQlGGZnQci
         xWsltf3ugRX/hyRXKdwojryDwiDNhqEyviYf1mPpNj9YDiA5g00LdDVScmXUQiLWJY6i
         BeTY8JZkZqqWWgIC4UMCjQ3scGg05QZzM4AHdKz9PMyf3RyjVxLMkY0ZkjiiqYzA5Vy+
         TIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnxrwl24V+nA5Lxa+8bDlnyy9wsG8qUVpARj1nDJEjc4994MStGQkZI5B75z1Sh9Z6PcwXGuifskROeY5NDT74UqJypfmbDi2t2Pa2xC17U59N4UVDi5nbWXolkORVSaTcCXw=
X-Gm-Message-State: AOJu0YzCoEgtgt7rZtQQ/jczvKvU1KXh9aAxY4ZgVfqP9UOUJj4qyI0D
	hBYByYBLLOrohQBI4cZBHnZYkhKufe8VWkstnaFioDjj6L/Eb4vrlIWq5UbIoFonP9oBxgmx5w5
	3UYKeJYb9fJveGTpblg94cSa4I9o=
X-Google-Smtp-Source: AGHT+IES8oMBC7z9SX5lHvXAdCfvAtoat1O2cdMxhFYh3XDaUgtvCmSsL1ClJTNvAyk+uYZxXgjOsLULZz5TrFOfRbM=
X-Received: by 2002:a05:6820:1b87:b0:59a:bfb:f556 with SMTP id
 cb7-20020a0568201b8700b0059a0bfbf556mr2540992oob.0.1707488219804; Fri, 09 Feb
 2024 06:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2024 15:16:48 +0100
Message-ID: <CAJZ5v0g5iPVYtU-L=ZPwVf3gHpmJZMJ7ubQFkE=NFrJHZ4nEwQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: Block runtime suspend when handling errors
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:09=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> PM runtime can be done simultaneously with AER error handling.
> Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
> after reset in pcie_do_recovery() for all recovering devices.
>
> pm_runtime_get_sync() will increase dev->power.usage_count counter
> to prevent any possible future request to runtime suspend a device,
> as well as resume device is was in D3hot state.
>
> I tested with igc device by doing simultaneous aer_inject and
> rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> and can reproduce:
>
> igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> pcieport 0000:00:1c.2: AER: subordinate device reset failed
> pcieport 0000:00:1c.2: AER: device recovery failed
> igc 0000:02:00.0: Unable to change power state from D3hot to D0, device i=
naccessible
>
> The problem disappears when applied this patch.
>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Looks reasonable to me:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> RFC -> v1:
>  add runtime callbacks to pcie_do_recovery(), this covers DPC case
>  as well as case of recovering multiple devices under same port.
>
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 59c90d04a609..705893b5f7b0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -13,6 +13,7 @@
>  #define dev_fmt(fmt) "AER: " fmt
>
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
>         return 0;
>  }
>
> +static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
> +{
> +       pm_runtime_get_sync(&pdev->dev);
> +       return 0;
> +}
> +
> +static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
> +{
> +       pm_runtime_put(&pdev->dev);
> +       return 0;
> +}
> +
>  static int report_frozen_detected(struct pci_dev *dev, void *data)
>  {
>         return report_error_detected(dev, pci_channel_io_frozen, data);
> @@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev=
,
>         else
>                 bridge =3D pci_upstream_bridge(dev);
>
> +       pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> +
>         pci_dbg(bridge, "broadcast error_detected message\n");
>         if (state =3D=3D pci_channel_io_frozen) {
>                 pci_walk_bridge(bridge, report_frozen_detected, &status);
> @@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *d=
ev,
>                 pcie_clear_device_status(dev);
>                 pci_aer_clear_nonfatal_status(dev);
>         }
> +
> +       pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>         pci_info(bridge, "device recovery successful\n");
>         return status;
>
>  failed:
> +       pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>         pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>
>         /* TODO: Should kernel panic here? */
> --
> 2.34.1
>


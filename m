Return-Path: <linux-pci+bounces-43797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34CCE6D2D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 14:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92ABC30056D0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D93308F23;
	Mon, 29 Dec 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9QZFSCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C63112DC
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013656; cv=none; b=iYwLB3J4GWq8B3vjWpM+ksF/sVmwPrANSaJeAbWBvjqFmDHHqEqu11jaZSy9prRrTc2mqgGncX4mLoL/Z2tjBbMOmUrSAb21vGI6y4J9YO/dJ5ESIjak/RBrUDE2uwCzuFxx/0m5tx+/AgxoKoS+amJVXmRIl6PkL2oLvnqLAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013656; c=relaxed/simple;
	bh=AMUQSRG1b3Bfy03EvZuA2MH+vEg2DbG2lHxiayfH+QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHWs3kzD9odIoznM8R0V5yb3Wq0WcHBP3rUfqnKdisydYnb4U52aRZ1NlZ6DuJ9lLfuHee4pNtdnXohEDN6U0ZJTilD4fPoK4TgpKsX9IaoMSvCQ54FbDivwNPKKee8ri8aXeQQcMTy+uGfyCU5OqfMigaAk8uODmz51fGuIVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9QZFSCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E0C2BC87
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767013656;
	bh=AMUQSRG1b3Bfy03EvZuA2MH+vEg2DbG2lHxiayfH+QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A9QZFSCS3xPAwWqtCvPqrrX/p48huao8sdF4q7VJrNiDsDYyoTmKF02kun7BWCwv2
	 LlsSgFHY15pRVXlu9EATZrgsqDgunJb6wRhpRqUZyRJInOYJkjuiI8VHip1Wz6xOVU
	 2yQJ5yFOiuT2II442/1AqTt0rVIfoMRw68VLyP3xWQAWWxG14vYQv/u0d8TXQbpiT3
	 2fTIV9seyM9cn6Qy1zvrY3KNmHr5+yn5s5+hYtmiwc0eKIW4K6xX3N3o1IdiG5oPCS
	 8R/UYrqS5k4jhFz6XYIcBpiLgC/cF08TioNkA9W8Dtd0WdvxVJ2A2IV6JskQ0Wb7H9
	 Djp6vlpQmH0tQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6cc44ff62so6789658a34.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 05:07:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWl5vjBPfpMKtw66gFhtEbuQlOpXmorpiKzL/+Um5/UBghQLwsXvjT+Af9uoz9cYaQs6TZQ4Y0VnsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbRH2FyU16y3JOwfBqFUPS4nuEsuXsx+IqGKHzznP0ZJ5BQjJ
	nN1B35er811S5kmXqmb8thXR7vjGgxSDkvrZKMk/SG/1Q2kIz9RrCPLshMoDqlH9ak8vRWaCoNJ
	3sC8OajW9qVAGdUg3HfMmPUEehRdcH0Q=
X-Google-Smtp-Source: AGHT+IF44OvAT8xzPCw6GemK5RnjOaPJgRioAtH7qU3YkYnFcixJdFY9nD1Exc2RVpUjYDwkKnc/hWyfHiMYWmbrDgs=
X-Received: by 2002:a05:6830:f94:b0:7c7:68d6:5925 with SMTP id
 46e09a7af769-7cc66a46941mr12797514a34.27.1767013655638; Mon, 29 Dec 2025
 05:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7888874.EvYhyI6sBW@rafael.j.wysocki> <6115868.MhkbZ0Pkbq@rafael.j.wysocki>
 <aVGBW4UcRAaxtbCX@smile.fi.intel.com>
In-Reply-To: <aVGBW4UcRAaxtbCX@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Dec 2025 14:07:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gyhVFA65YCqrz7WiY=4H+dhKb6FYMo06sU-hF=4fLS4Q@mail.gmail.com>
X-Gm-Features: AQt7F2qdw28JM-u46gZ2DuXmSUxLEhjvbWB_OEQLQYM-tkIUpJW9B6giu1Jrkj0
Message-ID: <CAJZ5v0gyhVFA65YCqrz7WiY=4H+dhKb6FYMo06sU-hF=4fLS4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86/intel/hid: Stop creating a platform device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 8:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 15, 2025 at 02:35:05PM +0100, Rafael J. Wysocki wrote:
> >
> > Now that "system" devices are represented as platform devices, they
> > are not claimed by the PNP ACPI scan handler any more and the Intel
> > HID platform devices should be created by the ACPI core, so the
> > driver does not need to attempt to create a platform device by
> > itself.
> >
> > Accordingly, make it stop doing so.
> >
> > No intentional functional impact.
>
> ...
>
> >       .remove =3D intel_hid_remove,
> >  };
>
> >
>
> This blank line now can also be removed as the module_platform_driver() c=
oupled
> with the above structure initialiser.
>
> > -/*
> > - * Unfortunately, some laptops provide a _HID=3D"INT33D5" device with
> > - * _CID=3D"PNP0C02".  This causes the pnpacpi scan driver to claim the
> > - * ACPI node, so no platform device will be created.  The pnpacpi
> > - * driver rejects this device in subsequent processing, so no physical
> > - * node is created at all.
> > - *
> > - * As a workaround until the ACPI core figures out how to handle
> > - * this corner case, manually ask the ACPI platform device code to
> > - * claim the ACPI node.
> > - */
> > -static acpi_status __init
> > -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> > -{
> > -     const struct acpi_device_id *ids =3D context;
> > -     struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> > -
> > -     if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> > -             if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
)))
> > -                     dev_info(&dev->dev,
> > -                              "intel-hid: created platform device\n");
> > -
> > -     return AE_OK;
> > -}
> > -
> > -static int __init intel_hid_init(void)
> > -{
> > -     acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > -                         ACPI_UINT32_MAX, check_acpi_dev, NULL,
> > -                         (void *)intel_hid_ids, NULL);
> > -
> > -     return platform_driver_register(&intel_hid_pl_driver);
> > -}
> > -module_init(intel_hid_init);
> > -
> > -static void __exit intel_hid_exit(void)
> > -{
> > -     platform_driver_unregister(&intel_hid_pl_driver);
> > -}
> > -module_exit(intel_hid_exit);
> > +module_platform_driver(intel_hid_pl_driver);

Feel free to send a patch to remove it then, perhaps along with the
one in the other driver.


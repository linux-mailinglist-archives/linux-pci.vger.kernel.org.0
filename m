Return-Path: <linux-pci+bounces-24050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA8A67704
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DDE163978
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C32F30;
	Tue, 18 Mar 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVmz39mq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDF20DD59;
	Tue, 18 Mar 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309726; cv=none; b=dngIMYLLYZi0r0gK3Cios7kcW2P9gqkJ5Zk7ediyEdFP6j/q+wAd7gLLqjUY0h2RZX4m7hPxrwJDrzjEu8KUYzRTvadwz0g8aocT9HB6vsqZ8DSbBMsbdIJF0pfHM0v4KcBBsCfGK6pSM6+PaTyIbIGGmZfvepCkxggG3/LkupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309726; c=relaxed/simple;
	bh=H9DLnK3r7MFZDcbdgHuLqqfMHsM14MtRNwArj1moT8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFCAjU0BMXiz7rEoAscOLsuqYyUhArKb3pI4JoBOraz+m3v/a1HLMQ6I/BkcPOBKXFid92cGNLwGBTJEuZAdubzHMVyU/NXrqWUzM7/bbTY4jjP+QA/ImStaQ6k5ZhyzMg7KyBiX1q3KbyFr2QJ8ushhSC/DZwe27wrjj4BvwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVmz39mq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30762598511so59865601fa.0;
        Tue, 18 Mar 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309719; x=1742914519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk1MOiDuVZr9W40/mLkzWnl5G4mhGBTZpl9F//I5jok=;
        b=GVmz39mqEBqiv8gTRHV2XOtEvy6q2ngLGAkGi7Jud/dF1CdFOVlRsZ8TaEZk/Zb0RT
         RRzIxriY0Dz+oooDMvnE7CfDMoMi6okqDG918EbPdTUj/CEeh9s3DzruZd7g7CELNopP
         TqT3lI/QPBmXZSwS15fDDzWSEO3mfUg0ZiWX6WbBx4namnLwz5IytQVKaNAMU5Fm+6Zy
         4LzY/jNViF6o4SrjItBqKUO1CdP0eXefQxprGYF03RAbodiDWRRUQYb3ohnALl53mfcz
         V1+QJQhT3Ogz0J+ZlxRwOuHV4a42Zt0xhTVI3aE2MMh7fWD10RK60Oq0PVpHK8TKXONf
         Q+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309719; x=1742914519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk1MOiDuVZr9W40/mLkzWnl5G4mhGBTZpl9F//I5jok=;
        b=uQ9kpfUpGFhNl8kcmui1p9LA+4RwzP3b4vmj1gFSOA+lyY8loG4QhQ4xEHNhsjcvjn
         q9R3hFwwGOZP0uugc+Mk7SV9O1yIYvlleFbWY6qjBWdVWyeN7+qn8GxrEDTJ6b6VhnqZ
         TkaFFpGHPywzmugmBUGjRafWwqevpAC5LSc+nRUYjAw7JZ/0kUC3sbzjdF5OmyBYb03o
         xMNIG6/dO4BpHwZnmcGoJfLJSaOx+pcaDYUPIn3qwYyFZ+snPOqQcET9czC8gOsIQTGM
         Cq3ilr8QzvNQ9Krzowt6dhWIA7oz5ZTr84IZGmVDFp3CbKHo9s/uJfK0qlDqvAvykG1e
         j+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV9J5XtFwg/CdCV3v8uVvUjWUlH2VKnZzBlwZOWdV+fwE6lWEzTgB7jHypCQS/iGHNcif6Dc9y8WWoI@vger.kernel.org, AJvYcCXYk4phqeEHUbmRV9yVqs2zdRCgpYiHdgRuBWZP/UByqNYEydeLIXw+LszFQOYrjMITUbbeF0z6y/uFG5wrBWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMhItwH3TRk9rtj1D+MOaaYmEz5SHazxH6tb+j32O3bYLZoxG
	t1QyycbQqGCM1zl98gYk6O7AQrXYQUqwUxUI2P002r/r3WpKQejOqV9287QRCWLjecZ0Ntj79qe
	+TGS+ZkibfhX0271x5d/krsok7OU=
X-Gm-Gg: ASbGncsJ+/YpCY8qLNW2s/opfxlJHZn6PgepIFb8WRO/RlU8kYLUw7hPFosjp2Rfz7d
	6CkehZmVAKir9Qemkyz/xPcRsnjh56vhnrxJSMfp1qdXdLhQzabFhSuQffc5FZdOIoAAoAS9kxR
	Wga+g3j1cW5fN3IA6ae0SAOj7J
X-Google-Smtp-Source: AGHT+IGr+uYyVgPeNQu960dfIc9ujbpOwU8c48uenI1Yjyt54q2PhPy9HSGdKaQ5VuBpNHAIAArZ2K3Ckjj/ZnRlWTo=
X-Received: by 2002:a05:651c:503:b0:30b:c22d:83b3 with SMTP id
 38308e7fff4ca-30c4a861dd4mr96849811fa.15.1742309718913; Tue, 18 Mar 2025
 07:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314101613.3682010-1-chandrashekar.devegowda@intel.com> <20250314194031.GA785335@bhelgaas>
In-Reply-To: <20250314194031.GA785335@bhelgaas>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Mar 2025 10:55:06 -0400
X-Gm-Features: AQ5f1JoQCuhokgmJqmNrk8yopLZQilzqZUrF-cnQh2mSnJeE7OSgEgLfRWhXP-w
Message-ID: <CABBYNZJQn4ZYMxLqCkJwA71a_VWhu4QXTkU7vt7wiQXf3bdYdQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Mar 14, 2025 at 3:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Mar 14, 2025 at 12:16:13PM +0200, Chandrashekar Devegowda wrote:
> > Support function level reset (flr) on hardware exception to recover
> > controller. Driver also implements the back-off time of 5 seconds and
> > the maximum number of retries are limited to 5 before giving up.
>
> Sort of weird that the commit log mentions FLR, but it's not mentioned
> in the patch itself except for BTINTEL_PCIE_FLR_RESET_MAX_RETRY.
> Apparently the assumption is that DSM_SET_RESET_METHOD_PCIE performs
> an FLR.
>
> Since this is an ACPI _DSM, presumably this mechanism only works for
> devices built into the platform, not for any potential plug-in devices
> that would not be described via ACPI.  I guess this driver probably
> already only works for built-in devices because it also uses
> DSM_SET_WDISABLE2_DELAY and DSM_SET_RESET_METHOD.
>
> There is a generic PCI core way to do FLR (pcie_reset_flr()), so I
> assume the _DSM exists because the device needs some additional
> device-specific work around the FLR.
>
> > +static void btintel_pcie_removal_work(struct work_struct *wk)
> > +{
> > +     struct btintel_pcie_removal *removal =3D
> > +             container_of(wk, struct btintel_pcie_removal, work);
> > +     struct pci_dev *pdev =3D removal->pdev;
> > +     struct pci_bus *bus;
> > +     struct btintel_pcie_data *data;
> > +
> > +     data =3D pci_get_drvdata(pdev);
> > +
> > +     pci_lock_rescan_remove();
> > +
> > +     bus =3D pdev->bus;
> > +     if (!bus)
> > +             goto out;
> > +
> > +     btintel_acpi_reset_method(data->hdev);
> > +     pci_stop_and_remove_bus_device(pdev);
> > +     pci_dev_put(pdev);
> > +
> > +     if (bus->parent)
> > +             bus =3D bus->parent;
> > +     pci_rescan_bus(bus);
>
> This remove and rescan by a driver that's bound to the device subverts
> the driver model.  pci_stop_and_remove_bus_device() detaches the
> driver from the device.  After the driver is detached, we should not
> be running any driver code.

Yeah, this self removal was sort of bugging me as well, although I'm
not familiar enough with the pci subsystem, having the driver remove
and continue running code like pci_rescan_bus seems wrong as we may
end up with multiple instances of the same driver.

> There are a couple other drivers that remove their own device (ath9k,
> iwlwifi, asus_wmi, eeepc-laptop), but I think those are broken and
> it's a mistake to add this pattern to more drivers.
>
> What's the reason for doing the remove and rescan?  The PCI core
> doesn't reset the device when you do this, so it's not a "bigger
> hammer reset".

I guess it was more of the expectation of Chandru to have a sort of
hard reset, driver remove+probe, instead of a soft reset where the
driver will just need to reinit itself after performing
pcie_reset_flr.

> > +out:
> > +     pci_unlock_rescan_remove();
> > +     kfree(removal);
> > +}
>


--=20
Luiz Augusto von Dentz


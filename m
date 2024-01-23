Return-Path: <linux-pci+bounces-2496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D388399BC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048001F2535D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78F81215;
	Tue, 23 Jan 2024 19:40:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B6433D1
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038846; cv=none; b=HSCzpcZu1gbcLxnKzN0Y/jzsbkLdTKw8TeWcHan4V0zChoJFBFZsRKtNjxP1ox9ZodAkJMzLUs3bGpxRxDeBIwHUR8L3KvKAS/kI2RbDLH+KBYNJXgrAdbUjBTGNKLo/O6h0emBV5URmmNd5isjpphtgH38iLuuDS3QbHhOZHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038846; c=relaxed/simple;
	bh=WqX85Mv0YZWF7PqgZeFBw5UqIl7yPaJoqnYnEPXNSsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOKR/UCR7mdjt/uzx/S0T0WK72sOspj4y8ZAK0HbQpTxC+q1inlBHSEcqW/MpnEJ7ZBsHny2B4I9naKIduX/TL7Pe340ycbBBN8ABri7/WTEu0cL7yRwLQRnkMPnQU2R8kid1CLivQpzL3xBqmK/bC3vBhGxtHBH/EaIWRQaPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5997edc27ccso285943eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 11:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038844; x=1706643644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jafOUDMx0g8Y6kxT8gbRStVRgKKkuEgSg+VyoM7S/6Y=;
        b=ZMPyyxG0+4poxvpkCgppn2jydVQsqvPD4tJXzPBvRCEG1n4kVjjUxM3RTWcpz+BrFl
         Efvf1cRtFBAh8/tNyX4vHEcv5ME+NEJ/9tG9+rdrLXn5ldE1mfQmJhYy8GslXQuI/I6Q
         8jnEBE3fXi96MEj/bR1doawmth3G/nLCMhahODjy0jDPsHQrsvr7J3G0sYzZBqdSp3u6
         ASHHCweWcT3Qhm1VlwWTkWiSLl2yERFK/ji7UNVvdKfNaes6BZFWGDyne0EiWalsllkW
         T1cTr53mH0h7XEGc8pXIAHbIPh0mUsSIdTZNLZZQjLCzD9AyU6VGa5XICVYAnNWwMrHP
         z2gg==
X-Gm-Message-State: AOJu0YwhArRvgSbKF8nqZF/0sNfztSTWNXmcvl4+Tn1rfvQBqikYHAUf
	aYVH6GF/G+6Xj5BPyLBYjFR8GdgLSa/T4duFZysPysiTejCToVhFMz8RDzmHb6fXkD7pKP6zFIm
	PiUsBgBuwAK2hB9FG/DT2YcSj8g/d6LHAa9w=
X-Google-Smtp-Source: AGHT+IFsZQFOiAqZFKiOUN6qp0l364nSibRkcmcgO0PilnEG+nkdjDX8SiKzDFPrwGQWs48UF2z7XTQWmVuaFw8+oQc=
X-Received: by 2002:a4a:cb86:0:b0:599:a116:6ca with SMTP id
 y6-20020a4acb86000000b00599a11606camr278524ooq.0.1706038843994; Tue, 23 Jan
 2024 11:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
In-Reply-To: <20240123185548.1040096-1-alex.williamson@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 20:40:32 +0100
Message-ID: <CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, rafael@kernel.org, sanath.s@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:56=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The commit noted in fixes added a bogus requirement that runtime PM
> managed devices need to be in the RPM_ACTIVE state for PME polling.
> In fact, only devices in low power states should be polled.
>
> However there's still a requirement that the device config space must
> be accessible, which has implications for both the current state of
> the polled device and the parent bridge, when present.  It's not
> sufficient to assume the bridge remains in D0 and cases have been
> observed where the bridge passes the D0 test, but the PM state
> indicates RPM_SUSPENDING and config space of the polled device becomes
> inaccessible during pci_pme_wakeup().
>
> Therefore, since the bridge is already effectively required to be in
> the RPM_ACTIVE state, formalize this in the code and elevate the PM
> usage count to maintain the state while polling the subordinate
> device.
>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> Reported-by: Sanath S <sanath.s@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218360
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bdbf8a94b4d0..764d7c977ef4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struct =
*work)
>                 if (pdev->pme_poll) {
>                         struct pci_dev *bridge =3D pdev->bus->self;
>                         struct device *dev =3D &pdev->dev;
> -                       int pm_status;
> +                       struct device *bdev =3D bridge ? &bridge->dev : N=
ULL;
> +                       int bref =3D 0;
>
>                         /*
> -                        * If bridge is in low power state, the
> -                        * configuration space of subordinate devices
> -                        * may be not accessible
> +                        * If we have a bridge, it should be in an active=
/D0
> +                        * state or the configuration space of subordinat=
e
> +                        * devices may not be accessible or stable over t=
he
> +                        * course of the call.
>                          */
> -                       if (bridge && bridge->current_state !=3D PCI_D0)
> -                               continue;
> +                       if (bdev) {
> +                               bref =3D pm_runtime_get_if_active(bdev, t=
rue);
> +                               if (!bref)

I would check bref <=3D 0 here.

> +                                       continue;
> +
> +                               if (bridge->current_state !=3D PCI_D0)

Isn't the power state guaranteed to be PCI_D0 at this point?  If it
isn't, then why?

> +                                       goto put_bridge;
> +                       }
>
>                         /*
> -                        * If the device is in a low power state it
> -                        * should not be polled either.
> +                        * The device itself should be suspended but conf=
ig
> +                        * space must be accessible, therefore it cannot =
be in
> +                        * D3cold.
>                          */
> -                       pm_status =3D pm_runtime_get_if_active(dev, true)=
;
> -                       if (!pm_status)
> -                               continue;
> -
> -                       if (pdev->current_state !=3D PCI_D3cold)
> +                       if (pm_runtime_suspended(dev) &&
> +                           pdev->current_state !=3D PCI_D3cold)
>                                 pci_pme_wakeup(pdev, NULL);
>
> -                       if (pm_status > 0)
> -                               pm_runtime_put(dev);
> +put_bridge:
> +                       if (bref > 0)
> +                               pm_runtime_put(bdev);
>                 } else {
>                         list_del(&pme_dev->list);
>                         kfree(pme_dev);
> --


Return-Path: <linux-pci+bounces-38891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DBBF685F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894BA4204C3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222132580FF;
	Tue, 21 Oct 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0n0IjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178F332EA7
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050714; cv=none; b=RzjtGmJV5N+0XU/w1izVrYz7KB7W1rjHmdDgi7XqGMsUq5gxIfync+2NO/X3Us9/y9a9G60+VUbKi8t0dNhYR54U75calyOym4DDokChM0hWZwpsSO8o8DOLuZ+deDKJDZfvJSrcFoUCETAtNJkX2ZeKFqtM3f424bdUYcnl9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050714; c=relaxed/simple;
	bh=fNqD+B6s469Yj7Uuf2+D0qytTYH3QsTqcGglEXhywPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyBVXkePJj51fYEFd2E7BbW4qt+0jpw00LkJm2+cTeco07ZqzBz+WpoK7dGK+k6WH2TI8u1B42wjbY972C4hNJDgE5YNX6Qx5Kcw3gX661rU0KjCHRn1PZYcRd8zUYgqRx5B2gNcsVAxTrOr/ezZ371T1qADJD2WSX1MytvxNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu0n0IjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BE7C4CEF5
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050713;
	bh=fNqD+B6s469Yj7Uuf2+D0qytTYH3QsTqcGglEXhywPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iu0n0IjZdJ1BkmkUfib/wrwtDaZ6xxHsH/c9fcxkTJjMAdwzqS98vY2XcO/fnDlZp
	 w3jJfmFgk+1Px+pty5cxR0VQczTngpA2iuD22WeZm98XvhzSCPuJYTXDbFuJXUXUM1
	 sdws1JBJcySlRx3SqYvtwrpL2rqFaHzXDCzooFesdHaB6NNtPefPtIfdsfGMwupJrC
	 3u0Uk0umvEPeP/Ei35P/BRrFymRIDy/uNLraeQX2nAxGbHlG+0kNp4HFW7jLoM28ec
	 kAoRz8OcCUravdQt/zI4VWy0/VrLeTWbg+xWB7UesTOpYB4aRKhD/L05DtyCkprZFy
	 aBVoJ4agTixUA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4444887d8d1so1510140b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 05:45:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX23OzupcaY/DqJtWhpWC+GAlJLdxQQEttG36Jm/RrWydhPnqZbz7AK+C5YAmGcTJGlrRcHcOCf7DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PEcZRG5jMSfR+Z3wvLO6oviq8DB6pn9aNRZtVBxumucqyrLQ
	rib/S0JSWsnVSq7+4WXkmsT2HdKWiDfIDcFNbY2DrB7hUybB9ySN52vGIIr/p5+74K3E3X0b/tD
	v7ND+1u6vRK8mk9S64FGquH4qkj4RAz0=
X-Google-Smtp-Source: AGHT+IH6obx8zcmEauqGoNYLVkeBLUIIr0ww8RYLI2qsmTsgyzzB7QT2RsZlbIpSX2hhGlD1fpjflbZtgs/poJLEHoA=
X-Received: by 2002:a05:6808:1383:b0:43f:5b28:f0a6 with SMTP id
 5614622812f47-443a2ee46d2mr7050078b6e.1.1761050712765; Tue, 21 Oct 2025
 05:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki> <2323750.iZASKD2KPV@rafael.j.wysocki>
 <25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com>
In-Reply-To: <25435d82-575d-495f-ae61-bd38570ff9ad@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 14:44:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iC-Lz59iu+5Ps-T9W5Ow__pm_0-txF2mDERypPFQYFsw@mail.gmail.com>
X-Gm-Features: AS18NWBovxp0gk85Y0l34CMY9sPShK1oLNJ-hGiHVklLTkmzTqdfgdStD1r2e9w
Message-ID: <CAJZ5v0iC-Lz59iu+5Ps-T9W5Ow__pm_0-txF2mDERypPFQYFsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/sysfs: Use runtime PM guard macro for auto-cleanup
To: Farhan Ali <alifm@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:07=E2=80=AFAM Farhan Ali <alifm@linux.ibm.com> w=
rote:
>
>
> On 9/26/2025 9:24 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use the newly introduced pm_runtime_active_try guard to simplify
> > the code and add the proper error handling for PM runtime resume
> > errors.
> >
> > Based on an earlier patch from Takashi Iwai <tiwai@suse.de> [1].
> >
> > Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de [1]
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v3 -> v4:
> >     * Use ACQUIRE()/ACQUIRE_ERR() (Jonathan)
> >     * Adjust subject and changelog
> >     * Take patch ownership (it's all different now)
> >     * Pick up Bjorn's ACK from v3 (Bjorn, please let me know if that's =
not OK)
> >
> > v2 -> v3: No changes
> >
> > v1 -> v2:
> >     * Adjust the name of the class to handle the disabled runtime PM ca=
se
> >       transparently (like the original code).
> >
> > ---
> >   drivers/pci/pci-sysfs.c |    5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     pm_runtime_get_sync(dev);
> > -     struct device *pmdev __free(pm_runtime_put) =3D dev;
> > +     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > +     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +             return -ENXIO;
> >
> >       if (sysfs_streq(buf, "default")) {
> >               pci_init_reset_methods(pdev);
> >
> >
> Hi Rafael,
>
> This patch breaks updating the 'reset_method' sysfs file on s390. If we
> try to update the reset_method, we are hitting the ENXIO error. eg:
>
> echo 'bus' > /sys/bus/pci/devices/0007\:00\:10.1/reset_method
> -bash: echo: write error: No such device or address
>
> I don't think s390 does anything different in this path, so this could
> also impact other platforms? Changing this to something like this fixes i=
t
>
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9d6f74bd95f8..d7fc0dc81c30 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct device *de=
v,
>                  return count;
>          }
>
> -       ACQUIRE(pm_runtime_active_try, pm)(dev);
> -       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +       ACQUIRE(pm_runtime_active, pm)(dev);
> +       if (ACQUIRE_ERR(pm_runtime_active, &pm))
>                  return -ENXIO;
>
> This changes the logic to what it was previously which used
> pm_runtime_get_sync and pm_runtime_put. But I am not familiar with the
> PM runtime code, so not sure what would be the right fix here.

Can you please check if this helps:

https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/


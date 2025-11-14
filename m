Return-Path: <linux-pci+bounces-41248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D6C5E7DB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FE89361B90
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921B33A021;
	Fri, 14 Nov 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP3K86rE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246ED338925
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135279; cv=none; b=bLOhUf3cacWMuuBEGEdakyyy8K8T6OGrZ8TPTtvKiQN+Dad1QqBTH91BUN6mkRmSbh3vCIbNKKpwu+PHihjbkYQ6zAFnRq1QDIYJelfXrn5WCs7fosZDgqeALdINGvWohxdqeOeti20S/DTPXaqp8mZOgbidrthyuXNmXn/aNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135279; c=relaxed/simple;
	bh=stYMW1rnbrIOJU/HCe8c2XsnCESX1XxV9Q1N61dG3jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBq253Db2dcjxUf5jTxxKLMfvxOcljO55PQ0f3FcNQAE5ZECrkE7AKq76kOZaHE6REKkOMusRfpHvUCbl+ZokFwMpmNBCIoApMqOGNW02V+3Bx4ICnj0hWMxFih5AOk8MvSsbtYJMvGWC+9GjKC1XEPhCNCFWxHYCo05HRPl5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP3K86rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9466C19421
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763135278;
	bh=stYMW1rnbrIOJU/HCe8c2XsnCESX1XxV9Q1N61dG3jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OP3K86rEqOOedxu0J/P76Rk+kow+D7WLIX3DMZlvwxBWrm3yiFHSbphY56kFmXxU6
	 +Rr6drKWcLKQ+HwDffJEr2pSHOwJjludNFsUqyGNXc30PWUabxBZOWG1OlE2A+sXAu
	 yhXfBW0zlgV34Jj9QLyLIblZnK2MiLcisSLXE83x6YdNpk6O7tOk0nEc6c92Z3lYVh
	 6y+UT3Kl+LVuSDuroBaAqV3EKzcfIJcLpPzbh1/jxXDRyhYSfX9stjxH7QmaRuAvIJ
	 qDGWGiuH9tOSrBWcBlXwRBVTjzy9HQ82zsC2DeavTZvUqj6217RJ9sNjXWQIcilwPe
	 TkL65g8okOVnQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3c96de7fe7eso1387198fac.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 07:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUev7DgVfLX77U8CFtQrgNxrOSwkbKqyLBfLoyORv+nTGvkmfGrOXusLwpI0TqYF/3qLwWsP2zd/Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtuP2jGIOMBW1xEkDq0JLtw4yGx0Jqjsx7NngnOLPuErw+FYM1
	Sp6i3lVH8Lq+6lwaDZJbTFpiNb7PA9wRjX3LmhWUd1NubgmgfriRwTSqPAEr5xega5d8hxdz0/q
	43ZeF+FztTizZmUDvYbFkag4Otni/j9c=
X-Google-Smtp-Source: AGHT+IHRit2A37TKNPjuZK9ZMkd4G/ceai1V9BJH04MolVXSzi+VFZEKcQYGSg5c5s8cFBv+m2f2WyG2KFLGrtPtfpY=
X-Received: by 2002:a05:6870:2f0f:b0:3d2:4319:38eb with SMTP id
 586e51a60fabf-3e86920a6f1mr1978863fac.47.1763135278183; Fri, 14 Nov 2025
 07:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5959587.DvuYhMxLoT@rafael.j.wysocki> <3932581.kQq0lBPeGt@rafael.j.wysocki>
 <20251114090253.n5m43jdvg5rv2bbb@lcpd911>
In-Reply-To: <20251114090253.n5m43jdvg5rv2bbb@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 16:47:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9fpyrfAR_rsJqm2vRniHoztthn-qMT6qCVjSuOoWRrA@mail.gmail.com>
X-Gm-Features: AWmQ_bmmfmp7pAFxwns4oHH-oyDNtWInQ7WBvGgBPjiZSsHM2lTNZuByPJ6fxoc
Message-ID: <CAJZ5v0j9fpyrfAR_rsJqm2vRniHoztthn-qMT6qCVjSuOoWRrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/sysfs: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
To: Dhruva Gole <d-gole@ti.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Frank Li <Frank.Li@nxp.com>, Dan Williams <dan.j.williams@intel.com>, 
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:03=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Nov 13, 2025 at 20:35:27 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macro=
s
> > to make the code look more straightforward.
> >
> > No intentional funtional impact.
>
> Same here ...

Yup, will fix.

> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks!

Bjorn & PCI people, if there are any concerns regarding the change
below, please let me know.

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Adjust to the changes in patch [1/3].
> >
> > ---
> >  drivers/pci/pci-sysfs.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +     PM_RUNTIME_ACQUIRE(dev, pm);
> > +     if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> >               return -ENXIO;
> >
> >       if (sysfs_streq(buf, "default")) {
> >
> >
> >
>
> --


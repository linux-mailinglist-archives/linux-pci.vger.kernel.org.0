Return-Path: <linux-pci+bounces-41683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74BC711DE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 555274E2935
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA862EB85E;
	Wed, 19 Nov 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD7N46aZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604D2EB843
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586570; cv=none; b=g3+wJ0aAgbI7eq/uPoIyJ0rb0lxhoARBqsIwiKL678/LTfcnULtn9OnAzZD7sbXEezTkIYWFsrWYWlnJMYTNiNEToddHf5E2YGfWjff+aApZGEKIvZO/rf2NlP5uX9qQwscJWZXNi3stUejVuvYcaC/kPWtZCZdk5umiPMic9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586570; c=relaxed/simple;
	bh=ALiAoPFh+7d6jvxH/rpqsdYFWQcbl2zG1BxLXGez5XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj98LZIvnx/v0YtfJVHceUzlm+XSi8W6tu3Lm99XFe2FtAT3vR7AVPdWSIVfKxnVhZ8uabzXo+bAbyrZXyjF9bh0s//iKddy7MICO7oTKLYxjwU8wem+FV/8FckLqJBpqzECMPd2efs8hIt1G5hcWaC4O07Q9uejYEYzuNPUkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD7N46aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F11C4AF0D
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763586569;
	bh=ALiAoPFh+7d6jvxH/rpqsdYFWQcbl2zG1BxLXGez5XQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nD7N46aZWHJ+Wo3KNMH/jvXrjYU/pqm5xTFVDiID18eOriD4REaARfU8e4GlzjUgB
	 zNqXMRnrxczHmXh4EJw8+KqWXffxnfV1jAMFgIsEDVIBgHbfVVNO6Q7birtBDcZZGy
	 2qltbncX8DU/Xwe9bLp276eCnF+musNN1PG+IRp6shsDBWyec09h6HusYZnPfq8MaO
	 YlfeqE7vs3tNqrC+aLj4IMEN8yLi4zEWXFSZmK8GP5sOPkpr9NL5XDhAA9D8xpYNK9
	 qVRdkQFI2X+jw/qP4vQMaQQc9rDniJBWMJJMTLopioRSfV+f3wLereg7E2ZRJ2y0xH
	 MxaoCHDQ8A9Nw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65748e230f9so59765eaf.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:09:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3UfqtGyo09z/wi0lbkvbD3ZAgmx0S6JZibH3D+tm/vFBBGWBr76oJJ9eCEWD7OSiC6yiuD2rGbbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqLR1vB0F9Qr5L5rCEiAt9UwLxyqaqIcDW2g/3rEd5RRSKzbb
	mAPUkxsHtGsaZQELHMQnrvqF2b4UKArXSIgmdDVQn8iePJsS5WRfjb3mnpJpebBqP80b/XBZ2nE
	+cJElMAM7oowVVDkvFu7p3uQx3FaPtKM=
X-Google-Smtp-Source: AGHT+IHdBeILW7V2DuqukUG0SISKpI2F03mL4V4skXrvNzoTRwo3eTblu3arg8RKsvgCNSGs5tk7s70+XawXsjd8Eck=
X-Received: by 2002:a05:6820:4b0d:b0:657:5f19:55fa with SMTP id
 006d021491bc7-65783cf909dmr292259eaf.3.1763586568798; Wed, 19 Nov 2025
 13:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763483367.git.lukas@wunner.de> <fd167945bd7852e1ca08cd4b202130659eea2c2f.1763483367.git.lukas@wunner.de>
In-Reply-To: <fd167945bd7852e1ca08cd4b202130659eea2c2f.1763483367.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Nov 2025 22:09:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTvvsWn0FO5CsT2heDTGPDZ5Uc-g4pGzXTagqjf7RxAw@mail.gmail.com>
X-Gm-Features: AWmQ_bmTfc46Iw5EuQkflyLfsk8kS5doZ8gM6NgTXuLmICwPYjJ05TLP9xgYuGk
Message-ID: <CAJZ5v0jTvvsWn0FO5CsT2heDTGPDZ5Uc-g4pGzXTagqjf7RxAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/PM: Stop needlessly clearing state_saved on
 enumeration and thaw
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, 
	Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:02=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> The state_saved flag tells the PCI core whether a driver assumes
> responsibility to save Config Space and put the device into a low power
> state on suspend.
>
> The flag is currently initialized to false on enumeration, even though it
> already is false (because struct pci_dev is zeroed by kzalloc()) and even
> though it is set to false before commencing the suspend sequence (the onl=
y
> code path where it's relevant).
>
> The flag is also set to false in pci_pm_thaw(), i.e. on resume, when it's
> no longer relevant.
>
> Drop these two superfluous flag assignments for simplicity.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci-driver.c | 2 --
>  drivers/pci/probe.c      | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 327b21c48614..7c2d9d596258 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1133,8 +1133,6 @@ static int pci_pm_thaw(struct device *dev)
>                 pci_pm_reenable_device(pci_dev);
>         }
>
> -       pci_dev->state_saved =3D false;
> -
>         return error;
>  }
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c83e75a0ec12..c7c7a3d5ec0f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2747,8 +2747,6 @@ void pci_device_add(struct pci_dev *dev, struct pci=
_bus *bus)
>
>         pci_reassigndev_resource_alignment(dev);
>
> -       dev->state_saved =3D false;
> -
>         pci_init_capabilities(dev);
>
>         /*
> --
> 2.51.0
>
>


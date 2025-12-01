Return-Path: <linux-pci+bounces-42382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A4C986E0
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF97B3444AA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B202335BA0;
	Mon,  1 Dec 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhh5fsHD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC136335556
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609049; cv=none; b=jo9SCXLsXTaZhxdjYJO/RN4VFVc7a6byQOJ2HeYfczpi+BJ0NMjYcA7vXQfWnPZOyltAxFT8IWO2D4CaBKMVAco7OlT8p0MgGbBIQU4cgIh4bhZhVpn2E5ijUnyneK8xlOmPVNI9dT2bD+jvh4p1qrEKm04ROnwnFlh/3VINAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609049; c=relaxed/simple;
	bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa7Migdnm/R9xmCNTwP+5n2O2uN6cskc2F24Qc3CiXuy3euvsLRI5C5+5RJIHeOp4+FJ2VwoMEn4gnlqFrTRmZCmrS5Tmn3xPg6l1Et63Lkmrus/05OLdUDpcnp1xK6rFJKg1rYjXcsvueLM9yObPTJZYjooXTj0LtxeNjktlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhh5fsHD; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dfccb35b10so2830290137.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764609046; x=1765213846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
        b=yhh5fsHDBjkVzRANRdKSBsBu84Ropy/Qn3HvlpFzj2LlDEE3V6wiS/r4OXmD98LW+O
         4oQ0v5mHWZ5p9ZW3EgRrq3uZyzYRzIaAVtX6k3vxzZU9Lk5GtRrSaC4Y8PgpivLfto7s
         CDPWN3XozV9ZAvDufdeqdMEX2vMIIeN8Y19gKmxeNHcWi4te47AwnM+YVdmOMRx9SjmH
         6+XpTkraUJjttwSmxVirKn0DhCazGIRCERyRXHnoAtHgSqQfaC5tDbg5NahXOru3Y9aY
         6vOB2qzaZOTQoJQOenw1pcbFglRobhNFGL7vefjVKRLSGMvVri0qsYcVU2ZES8ZROYys
         c8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764609046; x=1765213846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
        b=QXA+B3rFyJbwYgkvEIjPphBsw/HwLPfSG6l66xzrFaijlVqtyv/Ks7JLEuegbT5Bbe
         4RypJGtrOBuCN2b/ZZfrMOsLF24nKthao6PcW8fNUzHpU8+LFB9GWJEz94KPeiDKehg2
         4zb6dZLXQ+xJSMp131ADuIBBo/wRwFRvhFjnpRNy9ropPGSyfvIjOoBvPNaHy7NvBkW+
         uG7lm+gEvb7j3dzBY1fr8O5W2Sen1WL8YNauc01LWs94043f3BPwqxwBfHqpMZGgpUT+
         S6luhNkj3MHxrJ+/EctGx4s3sqmP9JwjvclTkkdhg7rg8/Cd6c7PhI8FEi9dDXGgrubC
         VOOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOXwLzDJJiulFW2SiQC12B4VRnvpCuGRMUukBrbUiAb88lMN+tyUYrzbNAER7ZZ75Kghgc854Lh5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZMAO5YdcIuqS2ShfSYvXrVCJvenu0ZsVFQ3QWpCJbgI6yQYf
	ai4+E8w8hwvSzbDLuqBi/pE0CMo1VpRMRdUs/2sQmkwsjbnYLLL0h6RJxD4ac7J31W3XFDAnU23
	A2FFqo8ttpeqSdRJF2dMHKD5WxW2e9c9yL2WBhpT3
X-Gm-Gg: ASbGnctUrPZco9I4b5zlusO6zlAo26u5FFiHjQQ55yRJbQVplUVO4aEURF46WR/UnBN
	x/FO82BWMzSM/TUJzwUILDYbvICvCxXl+uIX0dNDminWp6byXeUWK5UnshLP1BmB1lf/RCGjFeN
	5kD+t1vrWO0+8mJsA5LpFifBmCgBK1tsWD19LmcDOL578HGj50Bn2oAWormjNWxdpikcXGS1dj0
	gaqBl9Dch7WlHMlf43wr/C4eYU+anYLU17a5jTp4zK01qd+7kFEGTWbVZ7elWcG0wACmly9
X-Google-Smtp-Source: AGHT+IGFiOVRHpVtJg9de3U4NUDUwYt8a2SWwlK1RQVEQJYikxaSGrWA23uPIDLSWQ7bG1vfGanH0O9/XxW9Q0wDVag=
X-Received: by 2002:a05:6102:50a3:b0:5dd:b2a1:e9a5 with SMTP id
 ada2fe7eead31-5e22424060amr10237999137.5.1764609044530; Mon, 01 Dec 2025
 09:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
In-Reply-To: <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 1 Dec 2025 09:10:14 -0800
X-Gm-Features: AWmQ_bmDimn0Dqk7l1xtbjMVwD_y8nzSoh4S7ZJEc0qhkhUQGkqBsopla8gxr6s
Message-ID: <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 7:49=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
> =E5=9C=A8 2025/11/27 20:56, Zhu Yanjun =E5=86=99=E9=81=93:
> > Hi, David
> >
> > ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
> > vfio-pci-core.ko] undefined!
> >
> > ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
> > undefined!
> > ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko=
]
> > undefined!
> > ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
> > vfio-pci-core.ko] undefined!
> > ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
> > undefined!
> > ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
> > core.ko] undefined!
> > ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
> > pci.ko] undefined!
> > ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
> > pci.ko] undefined!
> > make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[3]: *** [Makefile:1960: modpost] Error 2
> >
> > After I git clone the source code from the link https://github.com/
> > dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> >
> > I found the above errors when I built the source code.
> >
> > Perhaps the above errors can be solved by EXPORT_SYMBOL.
> >
> > But I am not sure if a better solution can solve the above problems or =
not.
>
> I reviewed this patch series in detail. If I=E2=80=99m understanding it
> correctly, there appears to be a cyclic dependency issue. Specifically,
> some functions in kernel module A depend on kernel module B, while at
> the same time certain functions in module B depend on module A.
>
> I=E2=80=99m not entirely sure whether this constitutes a real problem or =
if it=E2=80=99s
> intentional design.

Thanks for your report. Can you share the .config file you used to
generate these errors?


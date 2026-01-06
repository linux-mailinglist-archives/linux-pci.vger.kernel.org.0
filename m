Return-Path: <linux-pci+bounces-44069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7CCF6112
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 01:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8083034372
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4265464D;
	Tue,  6 Jan 2026 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZMkMUcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01592A1BB
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658826; cv=none; b=fH+y4/R+ejMVf3argU/p4TRIbEfHncJnFIuMZA45LXZln3rBdW176G+wxSDbdENAmwRZZAHrldm2+A+dGU14h0moOiWwBxc1caIAsb4YL32DVeVh/2F2+oYVr9ZygenoQwnXNI4Ril34k9rKff7Dpyj6xB/lpwbP+uMGm6bw6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658826; c=relaxed/simple;
	bh=MRUlSzIlu0yCi9v9X+L6K/SPUeN5X4HBatQrXbmsoNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMy2+sK+kzfwny4eTZrUr3H++A+KNdvh3pxLRFBRuqEE0FxMacPdMqlPiHoVhHwE94GdHcpUa8b7gjX/T9d37UZ/tbsFMhskDTa8Mdy8DDqekBrjtmAqQLoHnTUnTNMdS+7CvxvIEsAq7ryqQw+BLHaUTPj8+srGC1Z56lahZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZMkMUcv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594285c6509so487117e87.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767658823; x=1768263623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao9G2tm5rq8JriKrggBN6pUBzceguMNi3YbflNISZIM=;
        b=LZMkMUcvAvgHKQNzUZ7Fbj0z3lKIKmf4Gxb/rPbw1+ZvJxY8x0YMB6NaxPha3fKCvy
         lnpwLxqxHhI6H26s/0qtuYMfYrurs3a4fcFM2p9+LeM0PngYRAP7Q0lsDgwvsLo+nrBw
         ZZaGR5rNLWbmm9bD+0aOGxTc4mfVO7iR6ZXh8GmjNkCk82m47GGi6mZPJJfOe5gUvShF
         rtOFQQeh80W9UmJ42awq/OY3pSIqnSLe0hCgpOv/pyFzgZjYtPTX0vICcPXb5TDDaXQc
         mjjuyvfhSIgzxRPxsOvTnOu+EsZFxWUbfkHEKoDhUNcKjoaM9luxleYL85JQBIDLXmgG
         Thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658823; x=1768263623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ao9G2tm5rq8JriKrggBN6pUBzceguMNi3YbflNISZIM=;
        b=bka/du+YnGh6IPewIoaDRW0Rt5A15GP3ayxTNcLx5X8B2Ak9ScNl8iXygNo9lXDtPv
         Nmzc6cN1r52KHEmbVD0z1GdcqdE44JXiRQyt+L9a/jdlKzGhEMpP0T3ykRFwqL8cw+fK
         vXXB4pXfniG6ozpwq9LOzycUfpQTWP0ZoDjEux7S1Gg8yEG/QYMAZGETvldNTnsUw+ci
         0ITgiFeym3iwOjS+vmhV8Uuvp129mt/MlUpZ1VZ0iCM6Cq7Xi37ieC4z7lNoFhCWiDgk
         SftKMHp/Eq2rnCMu4o87wf+aoUmZ9jstyDPkbcjRB9GZ6V9TuNuH8vC+/aXj3WK6ASA/
         WNgA==
X-Forwarded-Encrypted: i=1; AJvYcCXFvzFVP2lNFL7kHBXLQMyk4otjQZi5wrFZVCK0zX+TOjhh2LKP5RDwh2/pvaGZ46kNz1dl0Yk5uOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUSO8y35SWxfH0SeK71nZjwyTeWgXbmWC1ud3hAHpOPRIQJ4b
	Ap+KTjeCPlLPwP+gbiJ82IFupGL5srVjuDSd/RSsdmohy4y5u4bC0Hgpbrf3iT0fFTZKnMsH5KM
	Wup5yxPNmd05Ww2/yJDJqrK13rmOzpjY1g+cX3fC7
X-Gm-Gg: AY/fxX6byBvgNQsj7BhypKFzhtzouviBmzr9yFgDP3N3BIY63mYKgi4EiSL4ClLwRge
	FwQVwjANgOiRIqeNNtQdMkb6/Ynm8mdaXWPMrWNsLMAD437fqb+lQ2MpBvv4L8gDEwq1UvqysD8
	7yOQ9qMBvRykhDNUw5P8SGZAWry2Y0beKupAJzHDUru6L0CJO1YBM7bdfgX7a4b48xsuZj3WaDF
	2PhliTjjkJOZ41tMHfyQiY6Hn5uXqAeLzM3uoU0Wom/ZRRsnBZMc/cleZkvOFrQ/mKacOsn
X-Google-Smtp-Source: AGHT+IHb+AObIa8Xpi5KrmBllTV6a796WAN4T+3NWWccFiSvRWXKvYgmkKUjKvZYKPMGu7V/b+Y+kIuARsuoKdYKTCo=
X-Received: by 2002:a05:6512:b90:b0:59b:1d24:7dcd with SMTP id
 2adb3069b0e04-59b6521549emr381820e87.12.1767658822753; Mon, 05 Jan 2026
 16:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-20-dmatlack@google.com>
 <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev> <CALzav=duUuUaFLmTnRR41ZiWZKxbRAcb9LGvA5S8g2b5_Liv4g@mail.gmail.com>
 <2779d6a2-d734-4334-befc-99f958e1d1ef@linux.dev>
In-Reply-To: <2779d6a2-d734-4334-befc-99f958e1d1ef@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Jan 2026 16:19:55 -0800
X-Gm-Features: AQt7F2ooQV8QHcMMN8oMqlI2XNP9S0NGm7FbnT15j4rY2pjwAwVxgbJOfVYkhMc
Message-ID: <CALzav=dbvQ67Mb=ayjPmgTtL9GQvusRe=PzBjcLMJrh4sii-0Q@mail.gmail.com>
Subject: Re: [PATCH 19/21] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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

On Mon, Jan 5, 2026 at 4:08=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
>
>
> On 1/5/26 9:54 AM, David Matlack wrote:
> > On Sat, Dec 27, 2025 at 8:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> >> =E5=9C=A8 2025/11/26 11:36, David Matlack =E5=86=99=E9=81=93:
> >>> @@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(c=
onst char *bdf,
> >>>        device->bdf =3D bdf;
> >>>        device->iommu =3D iommu;
> >>>
> >>> +     return device;
> >>> +}
> >>> +
> >> In the latest kernel, this part changes too much.
> > Can you clarify what you mean by "changes too much"? What is the issue?
>
> I tried to apply this commit to the linux and linux-next repositories
> and run tests.
>
> However, I=E2=80=99m unable to apply [PATCH 19/21] vfio: selftests: Expos=
e
> low-level helper routines for setting up struct vfio_pci_device, because
> the related source code has changed significantly in both linux and
> linux-next.

Ahhh. This series depends on several in-flight series, so I'm not
surprised it doesn't apply cleanly. There is this blurb in the cover
letter:
---
This series was constructed on top of several in-flight series and on
top of mm-nonmm-unstable [2].

  +-- This series
  |
  +-- [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
  |    https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.=
com/
  |
  +-- [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
queried IOVA ranges
  |   https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb=
.com/
  |
  +-- [PATCH v8 0/2] Live Update: File-Lifecycle-Bound (FLB) State
  |   https://lore.kernel.org/linux-mm/20251125225006.3722394-1-pasha.tatas=
hin@soleen.com/
  |
  +-- [PATCH v8 00/18] Live Update Orchestrator
  |   https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatas=
hin@soleen.com/
  |

To simplify checking out the code, this series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v1
---

Cloning the GitHub repo is probably your simplest option if you want
to check out the code and run some tests.

>
> If you plan to resend this patch series based on the latest linux or
> linux-next, please feel free to ignore this comment.
>
> I look forward to testing the updated patch series once it is available.

I will send out an updated patch set hopefully within the next 2 weeks.

Thanks for taking a look!


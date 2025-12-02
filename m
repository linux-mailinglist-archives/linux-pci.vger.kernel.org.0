Return-Path: <linux-pci+bounces-42533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9067C9D167
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598843A6636
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C152FAC18;
	Tue,  2 Dec 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDCY9dk+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263D2F9DAA
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711010; cv=none; b=UyRQF57NJLdHtFTW6j6rgKQXkB8/cKUZ8Krwp72R7vWf0QIu97eB41p9icooU2OOMrDr+HQA1Z1TXQ+oWe1xqxP/6dHNNVwuKI3yZ8I9/cAPqn0sUB2B7EFGUGagyQNd8a7WigUnx7B4upMlSiRL3QICehTsG3B8gy8ilgl3EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711010; c=relaxed/simple;
	bh=4mAECnBT0GLqaUGCbUVvv1BgD9slq+DDHc3MT4Qfhgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TALXKkXSorGunQm3qFF7KiB6Dh+FsZTFyVSH4m640Jua70tE9R/ow5KImXwoTpO1qQZ0ZgiKNHbLCMeQWiInD0B7f2jnve1qpKiZWkfav4cIN9rzIfZpJMAOw0a3M7Sw4STjIJvH9DmuCzXSimJR/LhCRXea671TLLbfARuYluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDCY9dk+; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-55b4dafb425so183642e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764711008; x=1765315808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7su52te45M2cD5cYZfeIyUKvZtz5ws178yIllLdY38=;
        b=eDCY9dk+UrTrNFiPL9Tw7iHuECH4xsdBYH0Bo6nNQbhVRNUlqsuqbT1d1uIRNTcyVL
         K/HNWhtfH4QwW739L6ZKQovkAt74CZOmtFURhqZSdrkkLFYADsL+K2txOrKIn1i2VPLV
         hmQuFFU9Rex7+xO73an1u2Z3NjsvS09WTd9UTETZ5cRbwWKvCzWVsC0HM0c/696dNHzy
         qDBBJbOFUdc6p2+ZBVCvfls+bx8g7hrob5Y08XDyI/l2wbO3NWD+2LoRnDoMTlT2wu9H
         naytxoPca8rhopYB+1NfFx4EV8ttCz9FjVk8Mz+nsCBSRr9jmCTxmQoRkPN8tEnMX9p8
         b0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711008; x=1765315808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7su52te45M2cD5cYZfeIyUKvZtz5ws178yIllLdY38=;
        b=NGJZVMdJM3owccU6dppddXfp1Y3I071ff4tUhEtTKoJPEpUSOqKAwtFv9M0t5xfpQS
         2JuLxArRv4QQ8mvfrgGOaxuhs07Z2ZK5pNpKDgDom+6/zacuNHFwpz4xkfyhfrDe5WDy
         WUNu8wOjAWpRhSZ8kWVfnG/y/Fi+VFlcJn2PdWP3tZD4wfxgEAtJyQJiPa9m7k4j/q1v
         3p+e15iOiERmZU3KvEndtbDhx5Il9dZi1zXK2e8ShArRdVDanfMAveKwJZNcKuTEaso3
         Vv1iQNPjg0SFslY4dk/nkG3/Efd/cFVgocGbhwHXT3nO6ub+NL6hNMq8gtvcNFHubIYJ
         K7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRiDEAuIEzOeU78QxCNBbE3Kd+bGU0LYU+6tnxC/vFm0ocReQGgO1y8lt/j+bsj59RZcAJ/Rva24s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0y6h2oMY5bh3ukg3j2w56GEWh8OeQd7gHUDU66OI5pokmuPfa
	zFJ5NyEqngWGGmjOQ+sNAqsJwS+NAbhRtG0mDYWf88im2kn8fZ9f/teGNQJztupwlHOggOTt8mE
	dSMeOfkdlOrnGqcK6jgORs8ud2xSfXUc/ehf82iF0
X-Gm-Gg: ASbGncs8UuJsl+M5Vv/0Scde2MzOrW7SFTY24el8lAcON9jfy2gqlc5riZVL8WsvDms
	4Q8KHtj8JlVtEYB3uuPBranQSxS/AT5c2N53hVO3qMV/Oid8g8Bgelkkl/ZbvUzYAMt4zTAC+OP
	25fqGL3dcSDgREBFkp+uSOO7eERvbkbp4Xe6DaiQVhCuaVZbAgQdjFIPJ6gZvkFnmjmLwAyjxGP
	CK9NhPOixeXUZSJzBgBYj7pXySj288E7rPqawHBOURsmSElUGY3Q6voyCgOrWqbnnCp1QPx
X-Google-Smtp-Source: AGHT+IFpYAAsGy3oNM7Mb+lKNTvoCoDd5AD7g1adQp/M5NYzyZ+Sr2dWktsn4qG6B1Xs7hMA84tqYi0d1fCvoV1bfCE=
X-Received: by 2002:a05:6102:80a6:b0:5dd:37a3:c389 with SMTP id
 ada2fe7eead31-5e40c731398mr2852845137.2.1764711007486; Tue, 02 Dec 2025
 13:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
 <86bjkhm0tp.fsf@kernel.org>
In-Reply-To: <86bjkhm0tp.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Tue, 2 Dec 2025 13:29:34 -0800
X-Gm-Features: AWmQ_bknnx7BOEcQ6Zd5SqbqHsbQAiPXPlN7KmTjA9pACVrivKKqlwCOGHKn8aM
Message-ID: <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Dec 01 2025, Pasha Tatashin wrote:
>
> > On Wed, Nov 26, 2025 at 2:36=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> [...]
> >> FLB Locking
> >>
> >>   I don't see a way to properly synchronize pci_flb_finish() with
> >>   pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex =
is
> >>   dropped by liveupdate_flb_get_incoming() when it returns the pointer
> >>   to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
> >>   could result in a deadlock due to reversing the lock ordering.
>
> My mental model for FLB is that it is a dependency for files, so it
> should always be created (aka prepare) before _any_ of the files, and
> always destroyed (aka finish) after _all_ of the files.
>
> By the time the FLB is being finished, all the files for that FLB should
> also be finished, so there should no longer be a user of the FLB.
>
> Once all of the files are finished, it should be LUO's responsibility to
> make sure liveupdate_flb_get_incoming() returns an error _before_ it
> starts doing the FLB finish. And in FLB finish you should not be needing
> to take any locks.
>
> Why do you want to use the FLB when it is being finished?

The next patch looks at the PCI FLB anytime a device is probed, which
could could race with the last device file getting finished causing
the FLB to be freed.

However, it looks like I am going to drop that patch. But the PCI FLB
is still used in PATCH 08 [1] whenever userspace opens a VFIO cdev or
issues the VFIO_GROUP_GET_DEVICE_FD ioctl to check of the underlying
PCI device was preserved. Offline Jason suggested decoupling those
checks from the FLB, so I'll look into doing that in the next version.

[1]https://lore.kernel.org/kvm/20251126193608.2678510-9-dmatlack@google.com=
/

>
> >
> > I will re-introduce _lock/_unlock API to solve this issue.
> >
> >>
> >> FLB Retrieving
> >>
> >>   The first patch of this series includes a fix to prevent an FLB from
> >>   being retrieved again it is finished. I am wondering if this is the
> >>   right approach or if subsystems are expected to stop calling
> >>   liveupdate_flb_get_incoming() after an FLB is finished.
>
> IMO once the FLB is finished, LUO should make sure it cannot be
> retrieved, mainly so subsystem code is simpler and less bug-prone.

+1, and I think Pasha is going to do that in the next version of FLB.


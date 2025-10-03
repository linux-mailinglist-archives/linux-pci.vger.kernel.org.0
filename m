Return-Path: <linux-pci+bounces-37592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA2BB82B9
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 23:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21FE19E4025
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5325C809;
	Fri,  3 Oct 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKkjCDp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481C25A33A
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525813; cv=none; b=cEE8KzsUg+EAp17UWV/EwsujyvZYolNi93xAQg2HMPpTuXuN52AVg2uKW8s4oq5KEGNvMK1QiNDLf8xiELAzaotTHmdbBHfLSAQqWFo1Gr/pztadGgNsas26KDd8UV+VgmxHjfgdSxAAS5pSzfI2+g87JyLlO3FTiSFpvSmB+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525813; c=relaxed/simple;
	bh=dop2CffQ6z/331nTr4zwzO8M3dzvJ69PFQZ6dAIoGgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHuNqd7TYQnU80DKEmWZDPeSDwZI5B2y/vpdT0s4u/zvm5x95am0qDcH+ghtX4/shWY0fWNAHiWPwLMtWEkdxCUq7xlYZ6eafhq6Sy2UR8QWIXkgC/iDuNATtE1goJjLndsiNV7Sx/48/XFpSoWB6DhIsh49TN7naGEke+4P9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKkjCDp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD913C4CEFA
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525812;
	bh=dop2CffQ6z/331nTr4zwzO8M3dzvJ69PFQZ6dAIoGgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lKkjCDp3Nt7kSvz+JMeJe2S2z7EWk5lNLv/gkWtcCUpqUixSesTHV9p1SlenPu6SR
	 clRBkoxqOAGk/N2K9JQo/Y6GvWW3DPCTLtFVV6zPihb1i/qQU4wRcm7PYCWbW7tVpA
	 oZ1yaXvBu65oyJv+zadXVQbvwA1BetH13pCIigEDwZgo4QFEwnNQwmKVBiVusHE4+S
	 I6UBmV7AA0d6Aic836riuZc0AXI/6Tn5w0IBM/2DdNJOBjFLF4zYD6JmFbW2KEdQ6G
	 LrMSbmYO/6JJXMlJ++ELCPrmPJz72W2RwHM1MnI/iJ12r849onvaTbwNmKnP6L5HQQ
	 ISSPDvuIlW2xw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b60cbso29099857b3.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 14:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbJBetcjm4w/bNpI25nz9M1u+enG1zIF5fb7jmW6b6u64iFdpbuP/PfbnkALTg/AIetRHgBcJgquA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUggEhZxkFCuCCQ2ifdAzjeN51f8lZNfwRv08dt6CyBAzhtq+O
	jFTmdbJPIYeHCTiARNAv3QZi8oTWOt2RxB8ZH0qwE9a3fo2rhb/RITNX0DA5PwSLQtXp/2ti2cu
	VS+Coze1CPnkqY5xRngmFnIe5so/+DfgYrBSiKBJEkQ==
X-Google-Smtp-Source: AGHT+IFJr7BiUayheYtB01AyImhAOf9wqzzEYmC0SkKmmA6WyBELYscGL+EKGMFFmZXYioQm/V7KmDabskfxKC6Q5vA=
X-Received: by 2002:a53:c053:0:20b0:631:d1f8:38b4 with SMTP id
 956f58d0204a3-63b9a05e073mr3596797d50.4.1759525812076; Fri, 03 Oct 2025
 14:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <2025093044-icky-treat-e1c3@gregkh>
 <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
 <2025100323-sneer-perennial-55e1@gregkh> <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>
 <2025100317-backroom-upside-c788@gregkh> <CACePvbW031fW8dqswwXp=Z6H3jv2BiBSJFyGiXCKzZUSKRnxqQ@mail.gmail.com>
 <CALzav=edEDvz98KKtmMLWcW33PgE4aTy6K7YLSK0_jx1PdRqBw@mail.gmail.com>
In-Reply-To: <CALzav=edEDvz98KKtmMLWcW33PgE4aTy6K7YLSK0_jx1PdRqBw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 14:10:01 -0700
X-Gmail-Original-Message-ID: <CACePvbWbW-YVHAL0rO-6Ao16LELnd8R70Gj0+QZHptVRk0C50A@mail.gmail.com>
X-Gm-Features: AS18NWDm6P1reKqIX5KYR5IcC1q6_QkQpinihwQ1iy-jdQBkz0LnX3DWVnmxEi4
Message-ID: <CACePvbWbW-YVHAL0rO-6Ao16LELnd8R70Gj0+QZHptVRk0C50A@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: David Matlack <dmatlack@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:28=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Fri, Oct 3, 2025 at 10:49=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Fri, Oct 3, 2025 at 5:26=E2=80=AFAM Greg Kroah-Hartman
> > NVME is not a GPU. The internal reason to have NVME participate in the
> > liveupdate is because the NVME shutdown of the IO queue is very slow,
> > it contributes the largest chunk of delay in the black out window for
> > liveupdate. The NVME participation is just an optimization to avoid
> > resetting the NVME queue. Consider it as (optional ) speed
> > optimization.
>
> This is not true. We haven't made any changes to the nvme driver
> within Google for Live Update.
>
> The reason I mentioned nvme in another email chain is because Google
> has some hosts where we want to preserve VFs bound to vfio-pci across
> Live Update where the PF is bound to nvme. But Jason is suggesting we
> seriously explore switching the PF driver to vfio-pci before trying to
> upstream nvme support for Live Update, which I think is fair.

Ah, thanks for the clarification and sorry for my confusion. I think I
was thinking of a different storage driver, not the NVME you have in
mind.

Chris


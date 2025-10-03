Return-Path: <linux-pci+bounces-37563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F33BB7CDA
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B7B19E12B3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F262D8362;
	Fri,  3 Oct 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXyIU7SA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A03594F
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513796; cv=none; b=BKU6Zx03YTwg9/tQaxcDrnkCRNMTqLTcVwIO8nN9rDp/sRyGtOP4LadLZyBTzJPbEXasQew1UBuCTQlQTsGl2Jm5cA9iBZOf/ub9WJ7xAUrMpGHnbbO5pN2hNkCZNRwJ+ro4fgUDyt1w+IMEW58PfkOybGNM7GBJ7aaQaCcZMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513796; c=relaxed/simple;
	bh=cacXrZ5z9YbNTWqER/goLpuZZfmv00rsI9pNCHiO7z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIGAqQb1iYl/U0Nhr/DEuNQIrZu+edq6jo44aKSbzxjQxdAoDaTdiWhMVcMSp9ANaq5AIyA8eT5L6RlvS2GqsKiPOlmljCFbeRYHE5ZnphpdY0hEftI7Dn04owCCjU2nUkr6dcVOC6XIUb6ZoxYiOnacjB9DNdp/9X6bKhKkFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXyIU7SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B1C16AAE
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759513795;
	bh=cacXrZ5z9YbNTWqER/goLpuZZfmv00rsI9pNCHiO7z0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXyIU7SAAdPbD54C3zQP4MRoj1dJrflHZZevuymDUukvUXdLyYC0cJKl6EBvcvKtK
	 Mbz7FgEM8PEEp9ZQUW/wqar3R8u3pNuNBQPnz6FavXlgwlYAwuEzypSkfHF/UAUXxv
	 F5dozC27PZw8BCvLrAt9MKfEs4uc2Jr/A93Ex+umNwNIIHhTg8eCIlqLVYZnMnAqfv
	 QM2rqkH/gcv9av6PwX33UutxKiy6ZYT5S70sFO8s6l0ox+E7L57YgjssoQ7xIQ85Rb
	 /OtNkcd65h5PQdsnfuMzBdSBiX1/8KKSTARVsWjcTWhWpColMiEVzCL6+ExKIHwwxo
	 VeBFBW7gFzQFw==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6014810fso28160077b3.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 10:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsKzOXLY4XR2BVpXrwd1EKV4MvB85TMEIf1zMVe2cQBOJy7JQ8dBCABfTTaiMiOlFnfaiwWthA40Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7YE6l+hl4MjWyi5Vu/jWjZUHECoTiuhPEwwTEYWaTW9P2FCA
	UyVkOhAjtSBRhF9iSgF9ga7JK93griHVDN3zouN6IPe/eqq1Yn1pjwVp9mXdgQOMLaYFulQPb9c
	wvgu25YgTv5OgbgA/P2Fqi66WLVn14vjgSSVyEFNecw==
X-Google-Smtp-Source: AGHT+IF4CFMGmbb3qC9SaSuNe7zN0UD4dguyiAJTIYQ00mlB0WS0aVkoOC8ZShpucLIxiyUO/5gC5rrl5YqX+8edHd0=
X-Received: by 2002:a53:8641:0:b0:62a:b339:20d4 with SMTP id
 956f58d0204a3-63b9a0728c1mr3157725d50.21.1759513794903; Fri, 03 Oct 2025
 10:49:54 -0700 (PDT)
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
 <2025100317-backroom-upside-c788@gregkh>
In-Reply-To: <2025100317-backroom-upside-c788@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 10:49:43 -0700
X-Gmail-Original-Message-ID: <CACePvbW031fW8dqswwXp=Z6H3jv2BiBSJFyGiXCKzZUSKRnxqQ@mail.gmail.com>
X-Gm-Features: AS18NWBU4Jzt2fUR_8gMq-y1kDOK32INOSA1BzTNS8pwMMdpaUZ32L7UxC5W6wM
Message-ID: <CACePvbW031fW8dqswwXp=Z6H3jv2BiBSJFyGiXCKzZUSKRnxqQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 03, 2025 at 12:26:01AM -0700, Chris Li wrote:
>
> > It is more than just one driver, we have vfio-pci, idpf, pci-pf-stub
> > and possible nvme driver.
>
> Why is nvme considered a "GPU" that needs context saved?

NVME is not a GPU. The internal reason to have NVME participate in the
liveupdate is because the NVME shutdown of the IO queue is very slow,
it contributes the largest chunk of delay in the black out window for
liveupdate. The NVME participation is just an optimization to avoid
resetting the NVME queue. Consider it as (optional ) speed
optimization.

> > The change needs to happen in the PCI enumeration and probing as well,
> > that is outside of the driver code.
>
> So all just PCI drivers?  Then keep this in PCI-only please, and don't
> touch the driver core.

Ack. Will do.

>
> > > was that you were claiming it was a PCI change, yet it was actually o=
nly
> > > touching the driver core which means that all devices in the systems =
for
> >
> > In theory all the devices can be liveupdate preserved. But now we only
> > support PCI.
>
> Then for now, only focus on PCI.

Agree, thanks for the alignment.

Chris


Return-Path: <linux-pci+bounces-37514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 593AFBB6241
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05E4334476E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05A235063;
	Fri,  3 Oct 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL4sQ3l/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A872343B6
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475369; cv=none; b=H/mq7rqTKlIXAHSEt+gnxPuvCcfPX4XvRWV16v0IoFdTw28Ov9ET31VDXlNQTN62OxUVN5JkSDLO975wDXzbj1HlK0pyFE8brYC1CEy9A6RBID44mmsZnO3rP9YhzJy4GJM3xUfgn0z7hPtYL7yn/aVJLFUYBMAfLmBT+UpgHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475369; c=relaxed/simple;
	bh=zx2owurHFfkAoHhzYNDDvjYONBg7XXGf7hyYmx9Idvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0oSg1/1PYVaJweLBti6UIVp7ACx7qoHMo6wOngGjL7zoWJ+zTjmFmrddPZBDJ0KLWyT7kFAQOt0srvc9CEAegD2im+3eZdNyBPxccS+wMGCs2VYcgn91gvY3q1FPOraj/yS2dE7LBRxA5h3d3Y9bOzLETQIXOzI9X/SKSKWuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL4sQ3l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D17BC4CEF5
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759475369;
	bh=zx2owurHFfkAoHhzYNDDvjYONBg7XXGf7hyYmx9Idvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CL4sQ3l/V0RLfjdUNSOs8eS8NlBhgXaTNaEO1A2Wx7qPBtyg4IUbPIdOv4qy8mYxI
	 IT52JBK2GUNcbD4r8bdSIerF4RH/60XrENk9Dq5y4EIPgedP1pVFcZBItdxeIM96Jy
	 D9SRqRyAfdVbY3330vkq77votMI26b3fy4yz8rVVzz7Bd9ckSv1Og7qM0oJ3mMl2RI
	 zlv1pzjOvEfQm7iaVJ3OZnCrFEElz64uIzcAR58XsmIGfzxAa3sarJ9sb4UQYhB3lr
	 /a0kBjpP2mgYLKROjhCjOPS5OJKxRZUMWR+lIhQSFhy1hzpoGPJSSHd2PzLWRtBVJA
	 5q5oLd6/2AREg==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63497c2a27dso2490152d50.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 00:09:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVG6wYg+v7+eIFkVZTAXmMDeqM+As47Z+JTrllUOrL6S9+FxJVkFnRHzGDrEt9gm0+3S0Iglbke3rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBE2weuXwBgWUbxRZnOIF76KvAZqlkuGyu4Vhqqk3ZV1dikMY
	RTBgJbxSL3c/u0ngu6KFZUmhdY9HNZnzY7eIW54FJhlLiZUZFw8QtrZTIgDIJ5whWqHb8OiKc89
	TeXBtii06L2aIZCywpNGHAtU+FwDzKOgvXXfbHeqzSg==
X-Google-Smtp-Source: AGHT+IFEA0NhirwPGgcphjG0fmApdQNf9P4ICBae69kfL2JodwSZCLWlp251XiujpsESiyOGRzhhBlkoU1i9wi0ONVg=
X-Received: by 2002:a05:690e:2513:20b0:632:3cc7:c8cd with SMTP id
 956f58d0204a3-63b9a073829mr1721525d50.23.1759475366088; Fri, 03 Oct 2025
 00:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
 <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com> <20250930164705.GR2695987@ziepe.ca>
In-Reply-To: <20250930164705.GR2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 00:09:15 -0700
X-Gmail-Original-Message-ID: <CACePvbXSc=k-ivLE-ukuXaKO73mDm=tZBA82c6W+6-i3NnJriw@mail.gmail.com>
X-Gm-Features: AS18NWAqOUXihtz1zjCgVeWOSSOOP1uiZ1AkbQp8d_YOzMx9hgHpSXuyfXEL7Bo
Message-ID: <CACePvbXSc=k-ivLE-ukuXaKO73mDm=tZBA82c6W+6-i3NnJriw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Sep 29, 2025 at 07:13:51PM -0700, Chris Li wrote:
> > Can you elaborate? This is not preserving everything, for repserveding
> > bus master, only the device and the parent PCI bridge are added to the
> > requested_devies list. That is done in the
> > build_liveupdate_devices(), the device is added to the listhead pass
> > into the function. So it matches the "their related hierarchy" part.
> > Can you explain what unnecessary device was preserved in this?
>
> I expected an exported function to request a pci device be preserved
> and to populate a tracking list linked to a luo session when that
> function is called.

The current PCI subsystem is designed outside of memfd.

As for the request PCI device function and that function populated a
liveupdate device list. It has been considered and the current
approach is simpler.  The reason is that, if you want to populate the
device list, you will have to know about all device dependent rules,
devices depend on parent bridge, the VF depends on PF. Because the
request can be canceled as well before reaching the live update
prepare(). Those derived dependent flags need to be tracked and
reference counted. Even worse, it needs to be reference counted by
each liveupdate feature. e.g. LU_BUSMASTER vs LU_SRIOV vs LU_DMA each
need to have a reference counter, so it can remove that dependent flag
when its refcount drops to zero.

> This flags and then search over all the buses seems, IDK, strange and
> should probably be justified.

The current approach is much simpler when request and unrequest a PCI
device. Don't need a recursive walk parent or the PF relationship.
In prepare() it only walks the PCI root bus tree top down one pass.
That is the only place to deal with dependent relationships. It is
simpler and doesn't need to maintain per live update dependent feature
refcount.

That is my justification.

Chris


Return-Path: <linux-pci+bounces-39054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A99BFDB25
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077961A61715
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DC34DB60;
	Wed, 22 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atNBGco7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076834D4F2
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155164; cv=none; b=k17wrCLBNq4uYKb28x7T44H9cBulDhRr+8R6Cp90+lfL/BNUfFLcM1pHTYdhOrLznDn85vDYvNuecxAJtX3JpuGuD4hSLO/z9i9AS1WrDK1/ReJ2ep+M/RebXA8jRBrtPixznPRCu19hkcyKxP3BHe5k10CGqqHDMxE6WWoL0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155164; c=relaxed/simple;
	bh=w44LeRp54sTqbX/iWtLb1Tria6cTie5Yoc9NwjTV03E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3z5intsBfidsUbVb9qsWYvKemh/O6cudgxTliIB9kAgcxSwPTBMK3tj2XLNjQ2j5/0wHvwIXB/UuVyzPXE+zo2UbzUL+eaTa5EPmDEZUxnYU0tZPBla7q+hlvW0UyZ+M6AsfDFZouNehaP50Vx8Lh+tgfujk37dq+VJ/dVV8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atNBGco7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57b35e176dbso8756775e87.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761155159; x=1761759959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w44LeRp54sTqbX/iWtLb1Tria6cTie5Yoc9NwjTV03E=;
        b=atNBGco7osuea5VMUbyMpNmXHQ6nUTWdPGiLcrFLLBAhUybuFsGJ9pryNUy51AIpEB
         b/7ifVwBmLbFpCo9DmN68vBZyxyj+RXWWX7hWDXR+NH2CQOSrC5Hk7bDAVkm+WO//QUm
         zrZnnExfeqZZw3nVG5O4VBcGoWuGQnq0z6uyUQwndD1ZPmt+NF7P4GwLnG5ZnvGMj8P6
         ABHN55LS9yrqSdisZkBlSaCf51iz1f16BbiQWk2Jk8XsO4pMB/B2navDcmy/4xyo6QEz
         LIXQwtkOWhuXac9MgostG9IW/QBXO5CGy4uK6tmTv0A4l76PN9m0f2LdwQVPSZ+XJShs
         ptBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155159; x=1761759959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w44LeRp54sTqbX/iWtLb1Tria6cTie5Yoc9NwjTV03E=;
        b=I/0S9fU7JEp/RaJ4wHcdR2j5YqtwB4HR+qf5EwczL2UAlWQ+3ed3i2IkvWiPrkeolP
         pAsNVMSlWfxLz8HGf9np+XXaWrJEkd2dFqAn/TSl7+bYu2uL7C+dCv1mDoy9li0OqG28
         24SHs4SdR7O53yFF7Ncoh8gbXddDk4tupHiNWF1agiT54/pML5QDryEEx6MotHXJuXvd
         NOSUtHDfyV1pazgRo5IIbgSPOdRfWBchZsDB5/uwQ+sGjEbOl5tE/dsWsvmByenaRX5X
         rf7ddMW9b+D/maZKkJVCXda+zK/hHLNOETrJySsVK04OdvlXjzXCMSPYSRuXrNbH4sIq
         as2w==
X-Forwarded-Encrypted: i=1; AJvYcCXC1YwtJd/tOrp0w38wwxLht26E9/3ZxNz59rfiOdUKzSUcnqlnjTzoZEJFfXpytpJNeVkl5CNCgKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjW74yazu/vKRTmE/4zBS/gD0XGJL/njywn+16ADobTfb8LqnU
	VFoiQKsscymXjEnl5sncoU3oFAIYg4rstlWk3wVGG3rJn7t14QkMluqUcAirjHSi3dlo7vgGVlm
	wkPmqcaT0VWIpEAr+v6EMK4MX/sUihGrTYsnI6X9P
X-Gm-Gg: ASbGncu9riN6vsRY8wK9Dxs6bIr2nKOZmnVWf83maih1Q+wPOxBcYb3rAJnOW00bmtx
	x4I0p37NCFHAMDdGM+T3Z9pkydzoVJxvT/1kRxzJGvNGmzhpav10dWn/vxDNo2HuZxr6HSat5j7
	EN1PttKjeUzuOvBnCi1HeFWFZ7C7W17t2f42pyWnzQNoFwxsG2lwrCc23TWRhWMUajUGJj61n0Y
	/YzWsSiM3mHA/V+w3B2GHu/oqavgzF21R7fegkB0mfLVQ8h9fLaDox8YXA7WDRXgMn72z+XS4J4
	t0e72HKFWlbDF7Ng8cxov8Mh
X-Google-Smtp-Source: AGHT+IERtALG14+f5W16Jg/OM+KyHdPxafnN+x4hUkjVrvC5OblFTQMWIsl1hIUlOV4L6HUL5X9QRIe35lXhPZ/o3oM=
X-Received: by 2002:a05:6512:b87:b0:592:f441:9283 with SMTP id
 2adb3069b0e04-592f44193a6mr38873e87.5.1761155159123; Wed, 22 Oct 2025
 10:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de> <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca> <20251020234934.GB648579.vipinsh@google.com>
In-Reply-To: <20251020234934.GB648579.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Oct 2025 10:45:31 -0700
X-Gm-Features: AS18NWBDwI8X4gUgX9jxxmPGL4H9LlvpDngwDEMW5KSJ3qFfWS4FLNUGpgZ_www
Message-ID: <CALzav=eO4Lc15NV5fh-=LCaXz+s4-5+UxPLC4ePMqwUatvLXtw@mail.gmail.com>
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
To: Vipin Sharma <vipinsh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com, 
	alex.williamson@redhat.com, pasha.tatashin@soleen.com, graf@amazon.com, 
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:49=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On 2025-10-18 20:11:26, Jason Gunthorpe wrote:
> > On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> >
> > > Having __packed in my version of struct, I can build validation like
> > > hardcoded offset of members. I can add version number (not added in t=
his
> > > series) for checking compatbility in the struct for serialization and
> > > deserialization. Overall, it is providing some freedom to how to pass
> > > data to next kernel without changing or modifying the PCI state
> > > structs.
> >
> > I keep saying this, and this series really strongly shows why, we need
> > to have a dedicated header directroy for LUO "ABI" structs. Putting
> > this random struct in some random header and then declaring it is part
> > of the luo ABI is really bad.
>
> Now that we have PCI, IOMMU, and VFIO series out. What should be the
> strategy for LUO "ABI" structs? I would like some more clarity on how
> you are visioning this.
>
> Are you suggesting that each subsystem create a separate header file for
> their serialization structs or we can have one common header file used
> by all subsystems as dumping ground for their structs?

I think we should have multiple header files in one directory, that
way we can assign separate MAINTAINERS for each file as needed.

Jason Miu proposed the first such header for KHO in
https://lore.kernel.org/lkml/CALzav=3DeqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28a=
g8Zr_8Q@mail.gmail.com/.

Following that example we can add vfio_pci.h and pci.h to that
directory for VFIO and PCI ABI structs respectively.


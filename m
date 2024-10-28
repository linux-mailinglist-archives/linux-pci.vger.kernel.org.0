Return-Path: <linux-pci+bounces-15461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A459B3460
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F91F226F4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3D1DE3C4;
	Mon, 28 Oct 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyiae9qP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1818FDB0
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127928; cv=none; b=h/tlhKQl8pH/lnd7SVce51+DEyCZf439bAznhwHhsrzH9LmenE+AyWc4SqIv5fIM69o/m3OhxdPkXw+ddDkfLkdkgWpiAQoml+l9fIdZNMO8lq16AYeksFj5of/ROQt1HV0Q27YZJbHmM1UaX1H1mlJ+KwsJ1Z+B0WSjHAQCqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127928; c=relaxed/simple;
	bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cUxGplf4t2nu1tCWawqIVxFmMF3WBRHoFOpZHogPDQFuxYWR6GHzUMfrkZ424LYqilHjt1ZcT1I/18lwVFMQicjANgQOMMlEzx+9t1w2dliOdeIityLuGVm1rrPqhqNU/gsPMQN/59Wa/z6itNf+5hKvpPbPVpoqYP8Q3ogZ+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iyiae9qP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730127925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
	b=Iyiae9qPUztR9+ij3Ga2WHdU1pjjCR5FTO7XbBdM10IS4niLdh/S+fs2foUBOBR5OuGlRo
	drsg/+Fi/9BgYeX/igbgwuW65hPlEiH5OJg5naNyv8a2FPG+1grPfFgLUzv7O9WMWKHd0M
	ngUg9KMkH5dQFny1v/bs5xZ4i4vgYPg=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-mGjGBBpQOzCke6axQ4frsg-1; Mon, 28 Oct 2024 11:05:23 -0400
X-MC-Unique: mGjGBBpQOzCke6axQ4frsg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50da7722724so4687673e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127922; x=1730732722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
        b=lhX9GtJrT2++ylAFjY8+JuKzP85HyEldnRj2g/T5oGF4TANkEFXs//Anh2OET09er0
         fLU3H+4xMTQ7eJAiS3H+ErmNFMaKYdO/OkWojwFlvzYI5mvnsUT/UmayoeXZtEBRUOzK
         yOC3YFVe5tn0WTj0w89r/FgzK08Qca0I4sFP8yhcLUcqT30UPxe39L11A4j/d04MDASD
         0gmEFkcOyYSd+CDzwjKP7l040byyNmSt+1aMEyP/+jk5GiCTBpfPePpabGqxnT2AQQVy
         59TD+Jk8CJXaM7TOmnh44hntw9hW0c8vZ1BRVvZfBzLpZp4TqNaCbks7GGTO1mJ7fgld
         4Rmg==
X-Forwarded-Encrypted: i=1; AJvYcCXmkN1oVd8/g1yB7Q+KXzzWQtIQUlJX7PBxaX0Cvj9yZn1B7SHMD/0GFulOjTMm1vsUny+8JxzCtLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQcmKMQbKkcjKlJHh9MG0xhWM0praxYYf3+oWB+SmLvWbyFZz
	i6xN/AywPZLcPWIKh0SoGv94XUwZW5c+PvAMc6o5rrQsJ6KkrN3g6nGgaXd1da0oCmJTLD8ulWZ
	lnUOtBum7cxlEbgKDunQCQ2NUylo2dpoGpK4GBX/AfTt+8C1dNH964Y1HNY9+3edOfg==
X-Received: by 2002:ac5:c20b:0:b0:50d:530b:6c0d with SMTP id 71dfb90a1353d-5104b56c556mr227494e0c.1.1730127922244;
        Mon, 28 Oct 2024 08:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcOyMqz9vSNaECCD5Jog/jP+S1JE0g9vBbOaYmAJuZixiPu4F1kf2Bp8UpkY+b+0W9NOOMaA==
X-Received: by 2002:a05:6214:3c8c:b0:6d1:6fae:6451 with SMTP id 6a1803df08f44-6d19e8862f8mr2136586d6.10.1730127910992;
        Mon, 28 Oct 2024 08:05:10 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0c4f2sm32929126d6.95.2024.10.28.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:05:10 -0700 (PDT)
Message-ID: <f1ecab3f7703cd251275ecb141cbb4a24acafa2b.camel@redhat.com>
Subject: Re: [PATCH v8 0/6] PCI: Remove most pcim_iounmap_regions() users
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>,  Al Viro <viro@zeniv.linux.org.uk>, Li Zetao
 <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Mon, 28 Oct 2024 16:05:06 +0100
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

@Bjorn:
Are you OK with taking this?

Regards,
P.

On Wed, 2024-10-16 at 11:49 +0200, Philipp Stanner wrote:
> Merge plan for this is the PCI-Tree.
>=20
> After this series, only two users (net/ethernet/stmicro and
> vdpa/solidrun) will remain to be ported in the subsequent merge
> window.
> Doing them right now proved very difficult because of various
> conflicts
> as they are currently also being reworked.
>=20
> Changes in v8:
> =C2=A0 - Patch "gpio: ..": Fix a bug: don't print the wrong error code.
> (Simon)
> =C2=A0 - Split patch 1 into two patches to make adding of the new public
> API
> =C2=A0=C2=A0=C2=A0 obvious (Bartosz)
> =C2=A0 - Patch "ethernet: cavium: ...": Remove outdated sentences from th=
e
> =C2=A0=C2=A0=C2=A0 commit message.
>=20
> Changes in v7:
> =C2=A0 - Add Paolo's Acked-by.
> =C2=A0 - Rebase on current master; drop patch No.1 which made
> =C2=A0=C2=A0=C2=A0 pcim_request_region() public.
>=20
> Changes in v6:
> =C2=A0 - Remove the patches for "vdpa: solidrun" since the maintainer
> seems
> =C2=A0=C2=A0=C2=A0 unwilling to review and discuss, not to mention approv=
e, anything
> =C2=A0=C2=A0=C2=A0 that is part of a wider patch series across other subs=
ystems.
> =C2=A0 - Change series's name to highlight that not all callers are
> removed
> =C2=A0=C2=A0=C2=A0 by it.
>=20
> Changes in v5:
> =C2=A0 - Patch "ethernet: cavium": Re-add accidentally removed
> =C2=A0=C2=A0=C2=A0 pcim_iounmap_region(). (Me)
> =C2=A0 - Add Jens's Reviewed-by to patch "block: mtip32xx". (Jens)
>=20
> Changes in v4:
> =C2=A0 - Drop the "ethernet: stmicro: [...] patch since it doesn't apply
> to
> =C2=A0=C2=A0=C2=A0 net-next, and making it apply to that prevents it from=
 being
> =C2=A0=C2=A0=C2=A0 applyable to PCI ._. (Serge, me)
> =C2=A0 - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
> =C2=A0=C2=A0=C2=A0 stimicro" as the last user for now.
> =C2=A0 - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
> =C2=A0 - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet"
> instead of
> =C2=A0=C2=A0=C2=A0 "snet"). (Christophe)
> =C2=A0 - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
> =C2=A0 - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
> =C2=A0 - Apply Reviewed-by's from Andy and Xu Yilun.
>=20
> Changes in v3:
> =C2=A0 - fpga/dfl-pci.c: remove now surplus wrapper around
> =C2=A0=C2=A0=C2=A0 pcim_iomap_region(). (Andy)
> =C2=A0 - block: mtip32xx: remove now surplus label. (Andy)
> =C2=A0 - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
> =C2=A0=C2=A0=C2=A0 occurs. (Andy, Christophe)
> =C2=A0 - Some minor wording improvements in commit messages. (Me)
>=20
> Changes in v2:
> =C2=A0 - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
> =C2=A0=C2=A0=C2=A0 patch, put stable kernel on CC. (Christophe, Andy).
> =C2=A0 - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
> =C2=A0 - Consequently, drop patch "PCI: Make pcim_release_region() a
> public
> =C2=A0=C2=A0=C2=A0 function", since there's no user anymore. (obsoletes t=
he squash
> =C2=A0=C2=A0=C2=A0 requested by Damien).
> =C2=A0 - vdap/solidrun:
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 make 'i' an 'unsigned short' (Andy, me)
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 Use 'continue' to simplify loop (Andy)
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 Remove leftover blank line
> =C2=A0 - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)
>=20
>=20
> Important things first:
> This series is based on [1] and [2] which Bjorn Helgaas has currently
> queued for v6.12 in the PCI tree.
>=20
> This series shall remove pcim_iounmap_regions() in order to make way
> to
> remove its brother, pcim_iomap_regions().
>=20
> Regards,
> P.
>=20
> [1]
> https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
> [2]
> https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/
>=20
> Philipp Stanner (6):
> =C2=A0 PCI: Make pcim_iounmap_region() a public function
> =C2=A0 PCI: Deprecate pcim_iounmap_regions()
> =C2=A0 fpga/dfl-pci.c: Replace deprecated PCI functions
> =C2=A0 block: mtip32xx: Replace deprecated PCI functions
> =C2=A0 gpio: Replace deprecated PCI functions
> =C2=A0 ethernet: cavium: Replace deprecated PCI functions
>=20
> =C2=A0drivers/block/mtip32xx/mtip32xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++--------
> --
> =C2=A0drivers/fpga/dfl-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++------------
> =C2=A0drivers/gpio/gpio-merrifield.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++-=
------
> =C2=A0.../net/ethernet/cavium/common/cavium_ptp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 +++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 30 insertions(+), 35 deletions(-)
>=20



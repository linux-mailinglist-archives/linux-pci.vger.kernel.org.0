Return-Path: <linux-pci+bounces-13994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECED994E6F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EF01F24F86
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929E1DF266;
	Tue,  8 Oct 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwKrvnV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2D1DED48
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393421; cv=none; b=hf7D1bPzLSxB/LN0L24UmBsD30lL4jFXLKOjHDAh7AGq/UcV0L1DKRmL0sJ9zYlfdoqGCQJoKwgvMIz0NGp+W8dOI/plOO6x3BiX1Npq0w1ihPCpU9NQCYPYi4Goa2xiE7s9uZyGiiGmtbG3nN1HkU/t+SxI+fdqV69p2Lu7H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393421; c=relaxed/simple;
	bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oe3n8JAaC8oXooob7w4i84hWx3B1r2GABZOV0DUGUezSvvnu2dTFAw8pBb7JFDkbolohQHM2RtIexiTXiSrXF2rlG+7lbGHseg6ys4Uu5YCO2aCIm8HtDFC9RX0L3dqH2mmO6U7gGmpt+JGT41EZy9OSOE7jql7Lh7PmTMoXLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwKrvnV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728393419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
	b=cwKrvnV8H8+KuAHDSydwGGyWaog86Z03EjBlIWCg+0at9HxqI5fO8ndwpsGa0ukufQ1rp1
	hVLW+wWKbM2W7m+qWQefhemnyTUC61IKbPbUNDJXAnV2acX7IXmB0eb/yHyI598E+AJWEk
	OvmOe3NX1h5x+J/0vMe2QwQbzCmZl0E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-GXgUSY8TO4SMWgdYKtLTjw-1; Tue, 08 Oct 2024 09:16:56 -0400
X-MC-Unique: GXgUSY8TO4SMWgdYKtLTjw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c87b5179d9so5475833a12.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2024 06:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393415; x=1728998215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
        b=B0rQDx0PGbH6mYNkOw2ub1i5ouAxiiP6Pps/pV+j7PxPHRBsyrvRP3bco1zC3dRZck
         cpz4mRUus5d0WNcH3M/kkoPiHeeLxyzl3CiIofDJI6tKHhwVmDWFDhoqK+i2qvFFoqbl
         bgc5rBt1SlIHR7IuI//oghNCpIBvYwPni9J1sKGUG/Yks0r39+YPatVhzEnaSR7XspOd
         TDqqSOmAQdpT2RAMqw8E3TEGbdnqTg5oMA2hcVc7KIeYUexJCSqYOAqKTTN22rBQRovR
         G3tv0SN1QDyTpRcNuNPcOlpqspvacqKEhNNKy299EMJCEYjX/kh19zSZVnLqp9BhfNyD
         jFdA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5b1vpf7R9zAkrbbGlNW7HD3MciDv9ykDDFY8UKHy84uDyTSg5oJJ6EpRjA3AtPi/+uJWRhHpsdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcx13DO3zUweIB8kCIJYdYNUBrGDIbDbrhG9UablEzQz00QFQ
	QhEiioBhSSGvTXxE9jbWoyyrRt26dLfvuF9IaS971CkUWt4KmTVreacabulKswYMTT7rhTHcNzK
	kR3dNBBC03cwgoH2AFW0bpDt1DUuVs8CeRZGyIox2e1f9g2XzycURrKV/Dg==
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a991bd16c3fmr1579991766b.13.1728393414784;
        Tue, 08 Oct 2024 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEFEZcrmlRMftqLlmOZSsoDK/ZCIPnc3OiarQfc2zlGz6X81vFDMyJSw+zoGP5nEXTggdgtw==
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a991bd16c3fmr1579987666b.13.1728393414320;
        Tue, 08 Oct 2024 06:16:54 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d43760013399881f4bcf5cb.dip.versatel-1u1.de. [2001:16b8:2d43:7600:1339:9881:f4bc:f5cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993ed35544sm441427066b.73.2024.10.08.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:16:53 -0700 (PDT)
Message-ID: <dfe23f1344f0a74d05d5a605aa78c5989be22619.camel@redhat.com>
Subject: Re: [PATCH v6 0/5] PCI: Remove most pcim_iounmap_regions() users
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, John Garry
 <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Tue, 08 Oct 2024 15:16:52 +0200
In-Reply-To: <20240902062342.10446-2-pstanner@redhat.com>
References: <20240902062342.10446-2-pstanner@redhat.com>
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

How do you feel about this for v6.13? :)

All Reviews / Acks are in place.

P.

On Mon, 2024-09-02 at 08:23 +0200, Philipp Stanner wrote:
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
> Philipp Stanner (5):
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
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++--=
-----
> =C2=A0.../net/ethernet/cavium/common/cavium_ptp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 +++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 29 insertions(+), 35 deletions(-)
>=20



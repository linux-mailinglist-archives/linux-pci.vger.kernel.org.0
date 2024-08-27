Return-Path: <linux-pci+bounces-12305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB296179B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D14B219E6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A231A01C8;
	Tue, 27 Aug 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azWWZbeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFC1CDA32
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785320; cv=none; b=N+c5oAIr0yvWpIvIN1UQid2SDFRHr4QqBLQW7gsz7n5bQPKe0EuCfSR5Wj8xDmiejZXsw9w172yJE7KsVLdy8s4YbMfl/sjHfd/QGg91NfxQDOvPSuUbE/jzcmIgJeB9PHqAIRPWUfZKoyFveYxXgTgUOhMWcyatUS2G+yg9nHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785320; c=relaxed/simple;
	bh=MG+1JwSVWzI4JEBvm3KwyK2QGGWa4BG6fPSkkFcFZ9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeV4M52MKDCY0Ckk37MqueG1PBlQgegaN59T9O+uBLinr7pEX3wtLU5SWR+CeiEyKBKHb8NLeV8/cXYppAfJWe+zQtyj5OV4AiXjetjVvxelXQDHZjahEqmMCvBCG43ApxRR/GGcuvsB8yunR2zRqTk8mafTHqsBEkNE94VxZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azWWZbeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724785317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MG+1JwSVWzI4JEBvm3KwyK2QGGWa4BG6fPSkkFcFZ9c=;
	b=azWWZbegyaJDS8ju6wGBAW7rEGEv01dWbICGQ166DSf4p7iUhi2xeYN1+koCfqpCde5jP5
	SWFKHbYVXRnGGcS/i+XpLjZ9Ld1K5k8rqs2duVd4uCkkGzEvc5PQFD0n4x5GNHKsvGFLtQ
	X12OONTShu805ytgBprLDJEEkTuvkPg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-sXCct0j6NcWpUZwfGCZnGw-1; Tue, 27 Aug 2024 15:01:56 -0400
X-MC-Unique: sXCct0j6NcWpUZwfGCZnGw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a868b6d6882so838056566b.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785315; x=1725390115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MG+1JwSVWzI4JEBvm3KwyK2QGGWa4BG6fPSkkFcFZ9c=;
        b=kjrilUzUOE1crihlVDNzolZG+diQntYlx7FyDdItCnVAGz0f1KL3TjyBYAS6BuAyRu
         t+eQ8jSoXGwQpSfmuua2VyUw4O76xHZwumcwkGFppqtsBQOQdWThe8GHVjq4k7FmClqO
         vXtBP/6+yHhJOrh8g47Gw1zzPl+56PhmA8OszB5OwBpxxrfwiCCGR7UmAGh4n22Nmale
         OarGZNXE0eaNAOZb8UIapBDicitEKTftIaHNlmR68lfB/pwtoJ0Z9ZJEmIaXZ9M7O8sw
         tDHGBt41Rtc1soI4B7zFj4xD46prPHW5Holb22XWRq8TGuNdt7lJOZQJs93BCacJWIOd
         GYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6EfJ7y+WqkKPQBsAQJqO/Twt2MvXKF0yHnwForlio0Le0AM+uEPvZTqGmMqA3pn4TeAK26gIt38s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvDpodtcafeiRDzXIJuFToC/4SqvrmvAH99IXCD9setl3VJg2
	sqnWf5DLem6He+1oUVFJAm0f0Lg0H7SFJy4L4VcBQOHuChQcFIicHV3x2xGWGQnldwnhscEzH5o
	6Kt2xrjF310aWs0QMDjrP88mUkt1qfW15vuK98vdpA5lMiIgXHNF2Jc0Jcg==
X-Received: by 2002:a17:906:c141:b0:a72:66d5:892c with SMTP id a640c23a62f3a-a87070ec53fmr13247966b.18.1724785314752;
        Tue, 27 Aug 2024 12:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu6wGbiomauwZEYTCN/vBiJQQuMuuwKpc/s7DQcNYQx3NMc5fWjOy1EYaWCWHMYlMXPLBPhA==
X-Received: by 2002:a17:906:c141:b0:a72:66d5:892c with SMTP id a640c23a62f3a-a87070ec53fmr13243566b.18.1724785314196;
        Tue, 27 Aug 2024 12:01:54 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5? ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594eb1csm142585366b.212.2024.08.27.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:01:53 -0700 (PDT)
Message-ID: <a00ede68e809a5bd2fea5b7174536b3d4d44b949.camel@redhat.com>
Subject: Re: [PATCH v4 0/7] PCI: Remove pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Moritz Fischer
 <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 27 Aug 2024 21:01:52 +0200
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PS:
This series's title should now obviously be "*Mostly* Remove
pcim_iounmap_regions()".

On Tue, 2024-08-27 at 20:56 +0200, Philipp Stanner wrote:
> OK, so unfortunately it seems very challenging to reconcile the merge
> conflict pointed up by Serge between net-next and pci-devres
> regarding
> "ethernet: stmicro": A patch that applies to the net-next tree does
> not
> apply anymore to pci-devres (and vice versa).
>=20
> So I actually think that it would be best if we just drop the
> portation
> of "ethernet: stmicro" for now and port it as the last user in v6.13.
>=20
> That should then be trivial.
>=20
> Changes in v4:
> =C2=A0 - Drop the "ethernet: stmicro: [...] patch since it doesn't apply
> to
> =C2=A0=C2=A0=C2=A0 net-next, and making it apply to that prevents it from=
 being
> =C2=A0=C2=A0=C2=A0 applyable to PCI ._. (Serge, me)
> =C2=A0 - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
> =C2=A0=C2=A0=C2=A0 stimicro" as the last user for now. Perform the deprec=
ation in
> the
> =C2=A0=C2=A0=C2=A0 series' first patch. Remove the Reviewed-by's givin so=
 far to
> that
> =C2=A0=C2=A0=C2=A0 patch.
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
> @Bjorn: Feel free to squash the PCI commits.
>=20
> Regards,
> P.
>=20
> [1]
> https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
> [2]
> https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/
>=20
> Philipp Stanner (7):
> =C2=A0 PCI: Deprecate pcim_iounmap_regions()
> =C2=A0 fpga/dfl-pci.c: Replace deprecated PCI functions
> =C2=A0 block: mtip32xx: Replace deprecated PCI functions
> =C2=A0 gpio: Replace deprecated PCI functions
> =C2=A0 ethernet: cavium: Replace deprecated PCI functions
> =C2=A0 vdpa: solidrun: Fix UB bug with devres
> =C2=A0 vdap: solidrun: Replace deprecated PCI functions
>=20
> =C2=A0drivers/block/mtip32xx/mtip32xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++--
> =C2=A0drivers/fpga/dfl-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 16 ++---
> =C2=A0drivers/gpio/gpio-merrifield.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++---
> =C2=A0.../net/ethernet/cavium/common/cavium_ptp.c=C2=A0=C2=A0 |=C2=A0 6 +=
-
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++-
> =C2=A0drivers/vdpa/solidrun/snet_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 59 ++++++++---------
> --
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A07 files changed, 51 insertions(+), 69 deletions(-)
>=20



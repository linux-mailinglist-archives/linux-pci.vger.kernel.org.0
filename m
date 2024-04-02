Return-Path: <linux-pci+bounces-5537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7F895512
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECFB1C226CE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142181AB2;
	Tue,  2 Apr 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1NWipWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA67F7FD
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063884; cv=none; b=rPhiCLxJjrvAn6zvipUGj49unJ7DG7AWYjqzrIh8oJTmrUMzrm6JDm/tVfnFBVUcIG9uEjouQAIokEODPSz+HYrjtU+rvkXO3vpO/Mllk8SYP8IwEEzH30W/qDGelmdaI8kfvAnoOpZtU/rjEOcRwqbY5NrfbOLKkMP31AG3wDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063884; c=relaxed/simple;
	bh=PU8e+iIYGTu09EvDAIMMFH5RenifQoc8Af+tvO74/d4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y132f1uvOI6WW/HQ1QxiyAHq0sHCx6D4qWNMZx6HvmkXeARd/3WUemsndUW7JQVT7YUfIa9yFUlU4nZgOJlP59N0Qd8vO5inLcY3ki8giZIsoXSvayg8D3lplG9J8FqyzNAWf0VAf6PScC7rD4YaLTWoQwFWT3i9DG0YdCiR3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1NWipWd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712063881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PU8e+iIYGTu09EvDAIMMFH5RenifQoc8Af+tvO74/d4=;
	b=G1NWipWdzFnJ/GzYsSeowR0v3qR+I+ur0UoB8gFLA7driGIY1vnN+ozREY5PotLeMElhbE
	9sk5vy2s2IdxxIkhnsUMyoaCvMaRdljblKc/QLemVCRrW62ewk+ER3PjG4oApRuq2Ik9xU
	X4LFjkLnuzXjvNo49zY3tWsZNQaoSXU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-kJmkFgwQN92ddHu7DkpNbQ-1; Tue, 02 Apr 2024 09:17:59 -0400
X-MC-Unique: kJmkFgwQN92ddHu7DkpNbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4155db7b540so6262655e9.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2024 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063879; x=1712668679;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PU8e+iIYGTu09EvDAIMMFH5RenifQoc8Af+tvO74/d4=;
        b=ayH4pBcxmfaA/3q8npCZq8HL5T8jRe3bjKPseW0M+ab2jUFijjAFgnWgSnz9hRUYBn
         R+4vsZLN8C1ml4igzq+MdYGQP2kWCsAC9C08uZUoaoUEvOBAK9+O8wSPvKyfd0ofIWyM
         piTMNoXREPvgqh4yrfOzO5u81U0D8tEICzAyBXSHsZAWyDTI823WPw8iaQO9PYax9fJm
         4Rbh8C+00haD4z/DywctI4M8eKZS3icPiSNmiyiMJVr8d6wtXZqZt1DlI1shIiu4WsrA
         n+7dSDctE4uFWtiXexnaTqV35KM6ppUakadiiCYFLzRXCf1pc1AFYW1X6O3Bzo3KkeMj
         2qzw==
X-Gm-Message-State: AOJu0YyIziodflS7qNLJCp7DP4WMzlfq6X2Yjw7o+RnFqLFGJKVZhRzX
	UqV0NdxPWm1Q8T8G0h7kHRvM7rdZDR7KtXLnS0GDncMfvkX6ntcAkw6UZIrSwrj+chD4MuzrryK
	1B2DNZoTs/rQn62XKy6nlbnp9U7e1msghxhyxnv97i94E88dVb/G7sdAyMw==
X-Received: by 2002:a05:600c:5114:b0:414:8070:cdc9 with SMTP id o20-20020a05600c511400b004148070cdc9mr9709307wms.2.1712063878758;
        Tue, 02 Apr 2024 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxChee4ihAhzMMU+U8ThOu2Z8pGkOAaAkyDBP2LZiAO+4fIE+eH5KfxbBik1I6m4qtaE/rHg==
X-Received: by 2002:a05:600c:5114:b0:414:8070:cdc9 with SMTP id o20-20020a05600c511400b004148070cdc9mr9709294wms.2.1712063878345;
        Tue, 02 Apr 2024 06:17:58 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm21201064wms.20.2024.04.02.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:17:57 -0700 (PDT)
Message-ID: <a0d0b6b1269babb6a8f4e3bcceafee87bb49dcd1.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Tue, 02 Apr 2024 15:17:56 +0200
In-Reply-To: <7af7182d-0f14-4111-b0c4-b57d2d24edd9@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
	 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
	 <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
	 <7af7182d-0f14-4111-b0c4-b57d2d24edd9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 23:03 +0100, Heiner Kallweit wrote:
> On 28.03.2024 18:35, Heiner Kallweit wrote:
> > On 27.03.2024 14:20, Philipp Stanner wrote:
> > > On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
> > > > Several drivers use the following sequence for a single BAR:
> > > > rc =3D pcim_iomap_regions(pdev, BIT(bar), name);
> > > > if (rc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error;
> > > > addr =3D pcim_iomap_table(pdev)[bar];
> > > >=20
> > > > Let's create a simpler (from implementation and usage
> > > > perspective)
> > > > pcim_iomap_region() for this use case.
> > >=20
> > > I like that idea =E2=80=93 in fact, I liked it so much that I wrote t=
hat
> > > myself, although it didn't make it vor v6.9 ^^
> > >=20
> > > You can look at the code here [1]
> > >=20
> > > Since my series cleans up the PCI devres API as much as possible,
> > > I'd
> > > argue that prefering it would be better.
> > >=20
> > Thanks for the hint. I'm not in a hurry, so yes: We should refactor
> > the
> > pcim API, and then add functionality.
> >=20
> > > But maybe you could do a review, since you're now also familiar
> > > with
> > > the code?
> > >=20
> > I'm not subscribed to linux-pci, so I missed the cover letter, but
> > had a
> > look at the patches in patchwork. Few remarks:
> >=20
> > Instead of first adding a lot of new stuff and then cleaning up,
> > I'd
> > propose to start with some cleanups. E.g. patch 7 could come first,
> > this would already allow to remove member mwi from struct
> > pci_devres.
> >=20
> When looking at the intx members of struct pci_devres:
> Why not simply store the initial state of bit
> PCI_COMMAND_INTX_DISABLE
> in struct pci_dev and restore this bit in do_pci_disable_device()?
> This should allow us to get rid of these members.

Those members have been there before I touched anything.
Patch #8 removes them entirely, so I'd say that result has been
achieved.

Besides, considering the current fragmentation of devres within the PCI
subsystem, I think it's wise to do 100% of devres operations in
devres.c

P.

>=20
> > By the way, in patch 7 it may be a little simpler to have the
> > following
> > sequence:
> >=20
> > rc =3D pci_set_mwi()
> > if (rc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
> > rc =3D devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
> > if (rc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error
> >=20
> > This would avoid the call to devm_remove_action().
> >=20
> > We briefly touched the point whether the proposed new function
> > returns
> > NULL or an ERR_PTR. I find it annoying that often the kernel doc
> > function
> > description doesn't mention whether a function returns NULL or an
> > ERR_PTR
> > in the error case. So I have to look at the function code. It's
> > also a
> > typical bug source.
> > We won't solve this in general here. But I think we should be in
> > line
> > with what related functions do.
> > The iomap() functions typically return NULL in the error case.
> > Therefore
> > I'd say any new pcim_...iomap...() function should return NULL too.
> >=20
> > Then you add support for mapping BAR's partially. I never had such
> > a use
> > case. Are there use cases for this?
> > Maybe we could omit this for now, if it helps to reduce the
> > complexity
> > of the refactoring.
> >=20
> > I also have bisectability in mind, therefore my personal preference
> > would
> > be to make the single patches as small as possible. Not sure
> > whether there's
> > a way to reduce the size of what currently is the first patch of
> > the series.
> >=20
> > > Greetings,
> > > P.
> > >=20
> > > [1]
> > > https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.co=
m/
> > >=20
> > >=20
> > > >=20
> > > > Note: The check for !pci_resource_len() is included in
> > > > pcim_iomap(), so we don't have to duplicate it.
> > > >=20
> > > > Make r8169 the first user of the new function.
> > > >=20
> > > > I'd prefer to handle this via the PCI tree.
> > > >=20
> > > > Heiner Kallweit (2):
> > > > =C2=A0 PCI: Add pcim_iomap_region
> > > > =C2=A0 r8169: use new function pcim_iomap_region()
> > > >=20
> > > > =C2=A0drivers/net/ethernet/realtek/r8169_main.c |=C2=A0 8 +++----
> > > > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 28
> > > > +++++++++++++++++++++++
> > > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > =C2=A03 files changed, 33 insertions(+), 5 deletions(-)
> > > >=20
> > >=20
> >=20
> > Heiner
>=20



Return-Path: <linux-pci+bounces-12752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091096BED8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23483B29721
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002911DA630;
	Wed,  4 Sep 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpfYKAi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB9185948
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457052; cv=none; b=j2D4K2LJNiBlETlZNTyj/4VcN1fbv277CD9c7G/IyKtwWfIFlyCGn4bGptCB8Bzlb9H3fGBBoN789aET+wMc0ZLIkq8XbpFD0arqr7dLMv2FKzwdAaLuriNAlyjJN9WKok2o8kyhRAQNdwHF9LoOuasv7nFqHjrlCAgwdh2/FHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457052; c=relaxed/simple;
	bh=BINDG+h5Rx9JyjiVgATPaQ1ON/8FRd4Uo930XEEoRdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ds/3mNkfeM11Cd+WkR8/xXYYHRh9uU1HXBVIPI0prjPHRF4ykc2S9mXbD7Zyhp543J2kHrKeSpjjpyoPAZQkHfKJiAAUuGXmabfJveMlg7b4OUtTeOuEMCdJU/XiR+orqrhWk1At0pGwgJNRBlGk5e6fU1ic/i3WDjXvWwGTbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpfYKAi3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BINDG+h5Rx9JyjiVgATPaQ1ON/8FRd4Uo930XEEoRdI=;
	b=VpfYKAi3gVY53XDDMvBP+RE6RLRuBJ/cZWyQjdyy4I13Kh6Zv0k7aORLcRcqiIXT+yULNn
	2e0ZguoHE3sRTIDrJLvh/je75NEfHY/EXaEY7+ny3s9h88dnB9S5ROqnMi+V1OKVBvfNWs
	zZis+fx74VCE1XCIVVlCncO6z0mNwkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-yZ9r8tf2PMGhnVBNAb9DNA-1; Wed, 04 Sep 2024 09:37:29 -0400
X-MC-Unique: yZ9r8tf2PMGhnVBNAb9DNA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bacd5cccso3299773f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 06:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457048; x=1726061848;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BINDG+h5Rx9JyjiVgATPaQ1ON/8FRd4Uo930XEEoRdI=;
        b=PiA34SSNpOvqGuTPFIrACwcotOskIsC/5bS1euyBSQcBJa+9C9xqEBs9zJbWWN0ntM
         9Y+H8+BQTtc+djCcp4RhX5nfFHVHN/wTXxH5TfTYzPQZYqSv9SgiCLFa3lvOkcnUdDbO
         u7G9Hiojhb7VtWP6E8HU1lr1Y+Vjv8FwoE933xq6BHXv+kWcVjYh4LWTZlPuyVPtxJZJ
         ri0a0lVh2E7vgrWNJuJtgj4QEiidU1W6WFOF2AKXvJXwBCqR+t4x5Y1qxXp8GYHsLXKL
         zz7eZ26TNqGzGAUhzR7rGufkH8zwu+nAdBSR/KSKfYGWOHuXAri2Q5457PLBZk1KmRdp
         xjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUIm7geH4YN0acotZVrL0Kk4qg5xcinHIaNhauqt/S8WjP+mbUef+ph/RkXdQr74QyCtILzb4KQxj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyytq0gt6yOE3WEQW9+DOLCstsUMJBMPWNqAZYu+ugcBOWtxqbm
	66GjAoGqSH8ADKgGjc9JWGPQkYLXJGVQ7TBnSEikLD3vd++Rje8B6ZUi7SJkvtboL05CQ01PSDo
	6ppZcMvNiwGKaSBJiPgFQOlStzCJAh5PbXEN7rQbtjvoapHtc4xRL11ZWWQ==
X-Received: by 2002:adf:e98f:0:b0:374:c287:2af9 with SMTP id ffacd0b85a97d-374c2872b74mr7672907f8f.46.1725457047813;
        Wed, 04 Sep 2024 06:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxB+ozwdpXZ1ywtiN1p4tBdOX0ZCg6hM/KW4WkMtObdCBTq5iYWfbp++lwQXsKtQ4M4kZH3g==
X-Received: by 2002:adf:e98f:0:b0:374:c287:2af9 with SMTP id ffacd0b85a97d-374c2872b74mr7672885f8f.46.1725457047215;
        Wed, 04 Sep 2024 06:37:27 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9e7b7f87sm203837005e9.1.2024.09.04.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:37:26 -0700 (PDT)
Message-ID: <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Alex Williamson
	 <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 15:37:25 +0200
In-Reply-To: <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <20240903094431.63551744.alex.williamson@redhat.com>
	 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:
> On 2024/09/04 16:06, Philipp Stanner wrote:
> > On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote:
> > > On Thu, 25 Jul 2024 14:07:30 +0200
> > > Philipp Stanner <pstanner@redhat.com> wrote:
> > >=20
> > > > pci_intx() is a function that becomes managed if
> > > > pcim_enable_device()
> > > > has been called in advance. Commit 25216afc9db5 ("PCI: Add
> > > > managed
> > > > pcim_intx()") changed this behavior so that pci_intx() always
> > > > leads
> > > > to
> > > > creation of a separate device resource for itself, whereas
> > > > earlier,
> > > > a
> > > > shared resource was used for all PCI devres operations.
> > > >=20
> > > > Unfortunately, pci_intx() seems to be used in some drivers'
> > > > remove()
> > > > paths; in the managed case this causes a device resource to be
> > > > created
> > > > on driver detach.
> > > >=20
> > > > Fix the regression by only redirecting pci_intx() to its
> > > > managed
> > > > twin
> > > > pcim_intx() if the pci_command changes.
> > > >=20
> > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > >=20
> > > I'm seeing another issue from this, which is maybe a more general
> > > problem with managed mode.=C2=A0 In my case I'm using vfio-pci to
> > > assign
> > > an
> > > ahci controller to a VM.
> >=20
> > "In my case" doesn't mean OOT, does it? I can't fully follow.
> >=20
> > > =C2=A0 ahci_init_one() calls pcim_enable_device()
> > > which sets is_managed =3D true.=C2=A0 I notice that nothing ever sets
> > > is_managed to false.=C2=A0 Therefore now when I call pci_intx() from
> > > vfio-
> > > pci
> > > under spinlock, I get a lockdep warning
> >=20
> > I suppose you see the lockdep warning because the new pcim_intx()
> > can=20
> > now allocate, whereas before 25216afc9db5 it was
> > pcim_enable_device()
> > which allocated *everything* related to PCI devres.
> >=20
> > > =C2=A0as I no go through pcim_intx()
> > > code after 25216afc9db5=C2=A0
> >=20
> > You alwas went through pcim_intx()'s logic. The issue seems to be
> > that
> > the allocation step was moved.
> >=20
> > > since the previous driver was managed.
> >=20
> > what do you mean by "previous driver"?
>=20
> The AHCI driver... When attaching a PCI dev to vfio to e.g.
> passthrough to a VM,
> the device driver must first be unbound and the device bound to vfio-
> pci. So we
> switch from ahci/libata driver to vfio. When vfio tries to enable
> intx with
> is_managed still true from the use of the device by ahci, problem
> happen.
>=20
> >=20
> > > =C2=A0 It seems
> > > like we should be setting is_managed to false is the driver
> > > release
> > > path, right?
> >=20
> > So the issue seems to be that the same struct pci_dev can be used
> > by
> > different drivers, is that correct?
> >=20
> > If so, I think that can be addressed trough having
> > pcim_disable_device() set is_managed to false as you suggest.
> >=20
> > Another solution can could at least consider would be to use a
> > GFP_ATOMIC for allocation in get_or_create_intx_devres().
>=20
> If it is allowed to call pci_intx() under a spin_lock, then we need
> GFP_ATOMIC.
> If not, then vfio-pci needs to move the call out of the spinlock.

If vfio-pci can get rid of pci_intx() alltogether, that might be a good
thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
There's only a hand full of users anyways.


Best solution would be to avoid GFP_ATOMIC and see first if setting
is_managed =3D false solves the reported problem for now.

Other problematic users should hopefully be found through lockdep, too.
Though I think they are unlikely to occur

>=20
> Either solution must be implemented regardless of the fix to set
> is_managed to
> false.

Yes

>=20
> So what context is allowed to call pci_intx() ? The current kdoc
> comment does
> not say...

the old pci_intx() did not allocate.
It only calls pci_read_config_word() and pci_write_config_word(). If
those cannot block etc. it should be save from any context.

Though I'd like to hear from one of the maintainers about it.

The new version allocates if pcim_enable_device() was called when it
runs for the first time. That first run would then be illegal in must-
not-sleep contexts.


P.



Return-Path: <linux-pci+bounces-13071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB6976275
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823731F27BE5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B618BBA6;
	Thu, 12 Sep 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnCNyjsF"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558F383
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125505; cv=none; b=dN7LX+eLRCW1iu075nXPCNtv9VznnlVz8NeSCFC5gukXRst/dwA0yzRftx0QaaU7FPOGTAgQauclJ0xY4wRxuNXOnUZU4TUP9U8QZPaCy+qdkkuu9oBjZDfLNl36ONSyIDOMCZkublhvOSqnAYdJBu1EiTXZYzj8Bj/jGwSMr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125505; c=relaxed/simple;
	bh=tDRYya0TsHFGDxZ8F301jENFAzP53SAsZCLcPbpCCdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKFNJJBJIPJDfxPDx1zmMTB8t9NBjPTVs9HMLUQi9I8FC45cdJ1g+3paB/bJzS8CmUs07yh/h6AsDfv3s0QYk53vmZ6fNKU5kg3ZScB5J2XmLvckRGj/u8kuJzKigEi3glqPUQZHBofrqiXkxprCPUyIwNleIwyiTEjtlBHTKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnCNyjsF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726125502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng/Wv3SjMafqHDnEQxL5Gk+9aNAlMK9OwCvyz2GjmoE=;
	b=WnCNyjsF8H1jY/h6hHGRxmVhbqT+a1+o11KKCRC7tduBqaPMn6UGi+jSqicQ721Yh0YEWu
	PhqH8GFLYmBO2dXGgRE7Hvk5241XJ/Jd5KUtKpWMJ+8IjQm2bTIoWZiclt/n/CMJPZmXuS
	+u9lKN9od+crB8Dl2pilN9yUqDM32so=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-32vIKAnJPpKX--gF3_jFKg-1; Thu, 12 Sep 2024 03:18:21 -0400
X-MC-Unique: 32vIKAnJPpKX--gF3_jFKg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5356a102038so581913e87.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125500; x=1726730300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng/Wv3SjMafqHDnEQxL5Gk+9aNAlMK9OwCvyz2GjmoE=;
        b=O98gptUK9Wpeujpx3aC17eX88zZka5o8oBIP8BMY2KH83Ei4vbB1kFQy1ZYcPSCphI
         wL7PcgUKxdplH471WdX/DaXQZBOCgggVctBD2xLmirCJKqSB9ahO8cYlhh4hjY+Jf3+8
         xBS9PKXalNryPm5lNN4C3sL0F5fpO4NTnLwHNUdh8qBnFbvN5/IKBsl8HuVf5r+90cKq
         RAnzgPCXWLO6c145cKXY2/gQ6z3P5Lk1/rjIYcRgcxoPXfKJ2280DBcSgW3gahqdwGjD
         ny5JlPUQ1mXCYu4hP8H9MyRPotFleng6X2AuNYwDb7SGU/tTEeIWMh4+uEMNjbUCbcTI
         /lKg==
X-Forwarded-Encrypted: i=1; AJvYcCU1RznaYmelz1rV0IFZUP1yaenGB5wqmzbX5e3X/WVVPaeBqFbmrgDxftsN3fbAbMPbb2z3vJSSdTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwwr+6RJtbQEvmF9nZrMQ7PnXDDFk/iD5A9M6myYCA48R/g0bo
	zG9f0iWJxS2ECmKDmy5c36S2+ez41I7tJb6jXJs610SZDRf/47XD56reFC243/+fOA8wgyXb2Z3
	3kWvkQuDDPbzbNiC+0QloAMT187brxn8G4nGIngU9WdsS8usJ1OcVh7RhCw==
X-Received: by 2002:a05:6512:3f12:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-53678fab58amr1478447e87.4.1726125499573;
        Thu, 12 Sep 2024 00:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe7XIb2EFBn/Z1Epr+lb0Jwmkoq0FmRkddcNWCITRgSJWeHhVTlASvfPZR/6hRm/kWG3ahfA==
X-Received: by 2002:a05:6512:3f12:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-53678fab58amr1478406e87.4.1726125498979;
        Thu, 12 Sep 2024 00:18:18 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d380100c5821a103cc35bac.dip.versatel-1u1.de. [2001:16b8:2d38:100:c582:1a10:3cc3:5bac])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c74286sm708647066b.123.2024.09.12.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:18:18 -0700 (PDT)
Message-ID: <dd2b8dd20ce3e7a26b6eb795dd7c496a7d91fd01.camel@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix potential deadlock in pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
	 <alex.williamson@redhat.com>
Date: Thu, 12 Sep 2024 09:18:17 +0200
In-Reply-To: <20240911142715.GA633951@bhelgaas>
References: <20240911142715.GA633951@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-11 at 09:27 -0500, Bjorn Helgaas wrote:
> On Thu, Sep 05, 2024 at 09:25:57AM +0200, Philipp Stanner wrote:
> > commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
> > allocation step for pci_intx()'s device resource from
> > pcim_enable_device() to pcim_intx(). As before,
> > pcim_enable_device()
> > sets pci_dev.is_managed to true; and it is never set to false
> > again.
> >=20
> > Due to the lifecycle of a struct pci_dev, it can happen that a
> > second
> > driver obtains the same pci_dev after a first driver ran.
> > If one driver uses pcim_enable_device() and the other doesn't,
> > this causes the other driver to run into managed pcim_intx(), which
> > will
> > try to allocate when called for the first time.
> >=20
> > Allocations might sleep, so calling pci_intx() while holding
> > spinlocks
> > becomes then invalid, which causes lockdep warnings and could cause
> > deadlocks:
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible irq lock inversion dependency detected
> > 6.11.0-rc6+ #59 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W
> > --------------------------------------------------------
> > CPU 0/KVM/1537 just changed the state of lock:
> > ffffa0f0cff965f0 (&vdev->irqlock){-...}-{2:2}, at:
> > vfio_intx_handler+0x21/0xd0 [vfio_pci_core] but this lock took
> > another,
> > HARDIRQ-unsafe lock in the past: (fs_reclaim){+.+.}-{0:0}
> >=20
> > and interrupts could create inverse lock ordering between them.
> >=20
> > other info that might help us debug this:
> > =C2=A0Possible interrupt unsafe locking scenario:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CPU1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ----
> > =C2=A0 lock(fs_reclaim);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_disable();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock(&vdev->irqlock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock(fs_reclaim);
> > =C2=A0 <Interrupt>
> > =C2=A0=C2=A0=C2=A0 lock(&vdev->irqlock);
> >=20
> > =C2=A0*** DEADLOCK ***
> >=20
> > Have pcim_enable_device()'s release function,
> > pcim_disable_device(), set
> > pci_dev.is_managed to false so that subsequent drivers using the
> > same
> > struct pci_dev do implicitly run into managed code.

Oops, that should obviously be "do *not* run into managed code."

Mea culpa. Maybe you can ammend that, Bjorn?

> >=20
> > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > Reported-by: Alex Williamson <alex.williamson@redhat.com>
> > Closes:
> > https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@red=
hat.com/
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Tested-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > @Bjorn:
> > This problem was introduced in the v6.11 merge window. So one might
> > consider getting it into mainline before v6.11.0 gets tagged.
>=20
> Applied with Damien's Reviewed-by to pci/for-linus for v6.11, thanks.

thx!

P.

>=20
> > ---
> > =C2=A0drivers/pci/devres.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 3780a9f9ec00..c7affbbf73ab 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -483,6 +483,8 @@ static void pcim_disable_device(void *pdev_raw)
> > =C2=A0
> > =C2=A0	if (!pdev->pinned)
> > =C2=A0		pci_disable_device(pdev);
> > +
> > +	pdev->is_managed =3D false;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > --=20
> > 2.46.0
> >=20
>=20



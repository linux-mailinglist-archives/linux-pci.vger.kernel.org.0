Return-Path: <linux-pci+bounces-8867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22D90A846
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE76B1F216DE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDB190043;
	Mon, 17 Jun 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heGlY2D8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7387492
	for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612477; cv=none; b=UPn/QeG2pr20G6tPK3j3Q9pWXapE0fapMS9CYjHiFGG9oGEsQhx8oCHx9dvX7sBertjDs0G6zdxc9Q7c60tJGW/5l4cM04orn45oQ/vEau7Xfz/O+qdr4N2sUmNHgV5OpNASkM/o9RZJNAGi//U3P52l3v0ByFnG6iOIX6SN/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612477; c=relaxed/simple;
	bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwDXODZMgYsyw4xksuZyXjum68rqUkx2FlQEee8j/Lv1ggccFd2hawS+WqQ/VUPFIrckpMfsZEmBHNGrSjrk3+/TqAGLxpN+CUU1+0nol8aGCN1ezkn8ADmTGZUPOhXDYf5PoAotxA43qjzQQcE5Sgdtq1WD4f74ZQTfEbDo7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heGlY2D8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718612474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
	b=heGlY2D8y+UOBnTrDKk2AX8//JOpy9r/qO4RupDJtI+8RWmiY6LfRWnWj4THfSGbnKXzgx
	QAjcEmlyXXGTyfk4Xl3rmsjKjtTsYcyfzyBzIbLe7hVmdWEnmFy0yfvaoaYHh3XDEPPBm8
	8eeMs71b8xb1sgUYLUuCuahIxB/Q7zQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-OpZAY2vmNBmMSh6kRpGP3g-1; Mon, 17 Jun 2024 04:21:13 -0400
X-MC-Unique: OpZAY2vmNBmMSh6kRpGP3g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4218118d1efso6430515e9.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2024 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612472; x=1719217272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
        b=WsTsnpRIjvbfLPlS9M7pds24dfPUB9VLpkR/zgUSRfKYpogvTirlQ8SZqQVgeTAmWD
         gnKMyB6lR2Y2P9IdUtKDX0jTb4FrySGIBoXG0eLMQsg4QMq+oJLU8jbpUJ0f9o9c5aPG
         h5ogm73FPXodDbErbMnPXlRQTcvTmSBXdhzkfvG7OWy1bvUnnBEuS4eOO9vFeAfL5ZZC
         tlNn8MQkLViEWvSs86C5HZyfHXVEWxQ/7494si03YQE1Ra/btWtsMLzZvADY91z7dCxw
         DDusOGsgKRxCfaBPxkUL90mXdT1/kV+kWpmiAyJnLFMNEwv3DCFH7sJVHoEWUp7YLOPn
         m0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsnoCKWSynMk5JCEQFLj10F2NOCKwgJJGYSPqwJZaLYsMivBFcQVCzu/XTLvjVl9AjMSUznnHju/rEHaTjfC0Le6HrHNM3tXbu
X-Gm-Message-State: AOJu0YxZUuuR/8tYOr4gh3el2CHGuPRmaNIuxbTyRSTHr20I1xq4yUgV
	f4ABrM06e6Owf8JP/u+nmUhJINrvv8PMsnzlJFByhJHNYJGZVAlj0I2oE1CsdpDZQFQ88aVd42e
	vichmiNbsvCqLSNeOLWlQ5aDXLPS4rtyEY6OWzGlpQFxJPv2G3GtW750TPQ==
X-Received: by 2002:a05:600c:3510:b0:421:7dc3:9a1d with SMTP id 5b1f17b1804b1-42304855035mr66204735e9.4.1718612471939;
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5EsN4snPVwwdJpY6BujEFyiznYI79kUxwQuEaA6q+Ugp50bjVUn6XOpisZtSD3pKxm3q1hw==
X-Received: by 2002:a05:600c:3510:b0:421:7dc3:9a1d with SMTP id 5b1f17b1804b1-42304855035mr66204555e9.4.1718612471570;
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e95eesm189677815e9.25.2024.06.17.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
Message-ID: <bdfd5c582e7b858d3f32428000d2268228beef5f.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>,  dakr@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Mon, 17 Jun 2024 10:21:10 +0200
In-Reply-To: <20240614161443.GA1115997@bhelgaas>
References: <20240614161443.GA1115997@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 11:14 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> > On Thu, 2024-06-13 at 16:06 -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 13, 2024 at 01:50:23PM +0200, Philipp Stanner wrote:
> > > > pci_intx() is one of the functions that have "hybrid mode"
> > > > (i.e.,
> > > > sometimes managed, sometimes not). Providing a separate
> > > > pcim_intx()
> > > > function with its own device resource and cleanup callback
> > > > allows
> > > > for
> > > > removing further large parts of the legacy PCI devres
> > > > implementation.
> > > >=20
> > > > As in the region-request-functions, pci_intx() has to call into
> > > > its
> > > > managed counterpart for backwards compatibility.
> > > >=20
> > > > As pci_intx() is an outdated function, pcim_intx() shall not be
> > > > made
> > > > visible to drivers via a public API.
> > >=20
> > > What makes pci_intx() outdated?=C2=A0 If it's outdated, we should
> > > mention
> > > why and what the 30+ callers (including a couple in drivers/pci/)
> > > should use instead.
> >=20
> > That is 100% based on Andy Shevchenko's (+CC) statement back from
> > January 2024 a.D. [1]
> >=20
> > Apparently INTx is "old IRQ management" and should be done through
> > pci_alloc_irq_vectors() nowadays.
>=20
> Do we have pcim_ support for pci_alloc_irq_vectors()?

Nope.

All PCI devres functions that exist are now in pci/devres.c, except for
the hybrid functions (pci_intx() and everything calling
__pci_request_region()) in pci.c


P.

>=20
> > [1]
> > https://lore.kernel.org/all/ZabyY3csP0y-p7lb@surfacebook.localdomain/
>=20



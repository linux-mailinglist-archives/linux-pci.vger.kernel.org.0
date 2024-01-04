Return-Path: <linux-pci+bounces-1661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783AB824164
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80ABB234E8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410A2111A;
	Thu,  4 Jan 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKhsu7W3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7821366
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704370335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7iFE0cJqYSxbPNQPBRUKOHpRKlp3NQlliF2b2TCRgY=;
	b=CKhsu7W3YbWZ6SNrleq2efB3r7kiMzzzKAnw5qTZxy5O1h4wpoxtnUr0Qi1699M3ld29C6
	toaWryjT9ROex1iwJYUebbpJqqOO7Djka/rQs2XgcKhRQx+tFWVKKFnL5Ne9wym7oaBlt4
	h06t39HsmeKKXOj29vzobhbL7i2qBGM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-OuvkDs6xM0SHREzcDP1BaQ-1; Thu, 04 Jan 2024 07:12:13 -0500
X-MC-Unique: OuvkDs6xM0SHREzcDP1BaQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e8b421301so574361e87.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 04:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704370332; x=1704975132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7iFE0cJqYSxbPNQPBRUKOHpRKlp3NQlliF2b2TCRgY=;
        b=MlqqLs9fziklLNSj0KxVTiZF5F8zzekI00qCNdoI5v013e/NwCqH5PHAFjAPhAmLxW
         Z+azQ4Xz9JMTufae6EyCOi9h6rwYIh/bBVbgKGxXbMMuMFdjSCTTACz/Pn+Z+T2tm7HT
         ghyE2LwhUTQmLh24hyvjwiO3UncfsrQ0zwtqHmUxf5D/CPBIkO6HBXoJ3ljL033MRqTU
         c+bzahKXRdyQaKh0h14Y4mcNehqHq8q/P+rPU93vroicFwUaNAtI/4Ufxd6rQtfVUiWT
         2BCIC/1SwgUxFLGKH5BYM+agbTf5u0Zxv7FvV58nEQpS76ujKRY9qMOkgR9LYwQOn0g9
         45vQ==
X-Gm-Message-State: AOJu0YwTs5vzL8c4MMmNBPidnqNgPrzd5S+nJG5K3O+NcW3PI1RGNoMT
	epSeHx1SA58fSSwgreBqzsOEgQM3z8zCL7dOm1Qn1pzLvPLi9Zc9FLogIxJb/0foSul79F8QjxZ
	/O2o1HplI+k13TvVUl8UMYxuuMZ7r
X-Received: by 2002:a05:6512:398c:b0:50e:3645:96d2 with SMTP id j12-20020a056512398c00b0050e364596d2mr191998lfu.96.1704370332190;
        Thu, 04 Jan 2024 04:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjMJzXx79ftMb3MWAwcCtyNKToAA0llaPqTtEa13OwyifLCeR+EndGQhHxpb8+oa6NKGZGAg==
X-Received: by 2002:a05:6512:398c:b0:50e:3645:96d2 with SMTP id j12-20020a056512398c00b0050e364596d2mr191990lfu.96.1704370331884;
        Thu, 04 Jan 2024 04:12:11 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402428100b00556ee10cfe3sm1287360edc.92.2024.01.04.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:12:11 -0800 (PST)
Date: Thu, 4 Jan 2024 13:12:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>, Lukas Wunner
 <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Woithe
 <jwoithe@just42.net>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Dec 2023 18:57:00 +0200
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Hi all,
>=20
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
>=20
> For the second fix, I chose to expose find_empty_resource_slot() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.
>=20
> Unfortunately I don't have a reason to suspect these would help with
> the issues related to the currently ongoing resource regression
> thread [1].

Jonathan,
can you test this series on affected machine with broken kernel to see if
it's of any help in your case?

>=20
> [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.a=
u/
>=20
> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
>=20
> Ilpo J=C3=A4rvinen (7):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_empty_resource_slot()
>   resource: Document find_empty_resource_slot() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_empty_resource_slot()
>   resource: Export find_empty_resource_slot()
>   PCI: Relax bridge window tail sizing rules
>=20
>  drivers/pci/bus.c       | 10 ++----
>  drivers/pci/setup-bus.c | 80 +++++++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h  | 44 ++++++++++++++++++++---
>  include/linux/pci.h     |  5 +--
>  kernel/resource.c       | 68 ++++++++++++++++-------------------
>  5 files changed, 148 insertions(+), 59 deletions(-)
>=20



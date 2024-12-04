Return-Path: <linux-pci+bounces-17630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED09E36CA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 10:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E97328483F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E61A4F2F;
	Wed,  4 Dec 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByQbtb9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312419992C
	for <linux-pci@vger.kernel.org>; Wed,  4 Dec 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305184; cv=none; b=heb5zriWT+BKZN97mvd965QjtzaMy6V7A0toxkoT5oe3TVjYcZyFJINz3u1ZDqGvQzY9Ykv46hVGV5NN4ZwG4UUvLCe5CE1Imw1vNr9SU7ABBxlPmk1cFcZZl0320smqgnjHAr0OVgmkbVwbCcb3YbtyNEQK+IiPDR9pszDuniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305184; c=relaxed/simple;
	bh=DP/JFqa156kR78Xda16UXbLaKJmv9TXbqhDy3RLVVuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trHb5/M59QC2i2H9YCYQ0bMNxqYEHMNONFPMIPZ/2OrxDU53ByL71Yhyj1A+KxkF1FUnbvtyjHu/uV3UG16vDPk6uW5XVxdQURPt4MoF15DyhpSY2exUolChzyfjbj8deVaBzBbiwLvOCkVjhDBXMlrUd9/0LCBLVXMriSVOxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByQbtb9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733305181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DP/JFqa156kR78Xda16UXbLaKJmv9TXbqhDy3RLVVuc=;
	b=ByQbtb9or+O2V6v2DqnrzZ9qpAEP/LPQ7FJlZR6e+v5f6nfxxHwpLPGMWKxvO7ecp/xELZ
	8LHy+KlVSbO66RoPo7KftIiak7jVhA4l1rnzdd+2EwmWkEG/tYoI1FmRCOcFfsiEmWNDdf
	pS/yWEnXYZZf4nVMP3iOoeZRViCke9E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-B1haYfGsN0yshQ4_fMivDA-1; Wed, 04 Dec 2024 04:39:39 -0500
X-MC-Unique: B1haYfGsN0yshQ4_fMivDA-1
X-Mimecast-MFC-AGG-ID: B1haYfGsN0yshQ4_fMivDA
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53de3a4752eso5504471e87.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2024 01:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305177; x=1733909977;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP/JFqa156kR78Xda16UXbLaKJmv9TXbqhDy3RLVVuc=;
        b=IUoZBdzHTV0iPuItK2We36LX4pkto211U4EuJbF5Kp5lZFuHnq4bthht1Xr26T5CcW
         mKBMo5c6/2HEcGl/cuMeXp4qAmyNTyWH70XeZUinsGCunD8ynIWdQPuum0vkITChpgJ6
         x33CdFo5jz9znynPuwxQJ0vR9Py81vxesXVifOdZM7YnQjrm+JzOBmIe5kbR3sKHhcEK
         fWf2qTUYtSCjj27X+kBNdF1BBdhQj7PXdCWrZ2FvsPza5Aeh7QHyYV7DyBrYXoNoRyEI
         oU2l0fPjU9hzGw/cQVq5UPdrqJatZyjpFGMrzreWzkHW1jyUkWq3THwbqvTWMBRlTKpY
         6NlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPMMgf9RlFeqeqJ8P9dbh01A6GfqnpfhmSgYmf9w2KVcIYXiLon+kwcG5+LlWC6i8hey/zDj3REpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmRc6nTCkDlWgod0ZiTPnqqFgszJHfbEhDPsyNpXEWa3ZmkAU
	jTXrPNYrC6ZaQYgLU+VuOE30/Kt3Y2ROvT4sOMj/ptnZ9G47bp0kLQ/UAsiSTYHhpFUT/Yp01SP
	xf7HMktiuzSwlk5Ip8RRl6EkaXYvnraw3oSHKK87clQEJEPesqOjYOCsO2g==
X-Gm-Gg: ASbGncv3+WuuqNt2DcqhqK9ruUi+B1nanYygP9H170vJ9SzCynEtLxeo0DYYmSboHuW
	2YWJeDRXcjhJn9pr4Rav0jK9BMmeSiwsuu2ki1nMEAp3Uoyl5W35iqjtvMSZpoBzKFZ8lMzXopX
	8T7rFDiIASeLBlUM/Mv4dbXgHm+pbNgFr6JSZ5MCY43ufM3SiJJBIGDuXvE3FRxIXaZORmKeTVY
	Vd2q81p3GTTDQMXC4W4ywEvZhfRbtFvHAS1CxEm2m2ucrO4ircUoEyKjqkSclZ+WzLqs5GcM1Sl
X-Received: by 2002:a05:6512:1089:b0:53d:d3ff:7309 with SMTP id 2adb3069b0e04-53e12a01ee6mr3617852e87.32.1733305176865;
        Wed, 04 Dec 2024 01:39:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE20k0Tu7rKuaCQLclSqEIlzr7i/kc78TnwszhucH69vAKub5K7XtOsnAMHlz3iBsfatbgDOw==
X-Received: by 2002:a05:6512:1089:b0:53d:d3ff:7309 with SMTP id 2adb3069b0e04-53e12a01ee6mr3617845e87.32.1733305176454;
        Wed, 04 Dec 2024 01:39:36 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527eeedsm18093745e9.19.2024.12.04.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:39:35 -0800 (PST)
Message-ID: <5852280fa2764f9ca17f95f66541a945ad5b37ae.camel@redhat.com>
Subject: Re: [PATCH] PCI: Improve parameter docu for request APIs
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Dec 2024 10:39:35 +0100
In-Reply-To: <20241203213758.GA2966054@bhelgaas>
References: <20241203213758.GA2966054@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 15:37 -0600, Bjorn Helgaas wrote:
> On Tue, Dec 03, 2024 at 11:00:24AM +0100, Philipp Stanner wrote:
> > PCI region request functions have a @name parameter (sometimes
> > called
> > "res_name"). It is used in a log message to inform drivers about
> > request
> > collisions, i.e., when another driver has requested that region
> > already.
> >=20
> > This message is only useful when it contains the actual owner of
> > the
> > region, i.e., which driver requested it. So far, a great many
> > drivers
> > misuse the @name parameter and just pass pci_name(), which doesn't
> > result in useful debug information.
> >=20
> > Rename "res_name" to "name".
> >=20
> > Detail @name's purpose in the docstrings.
> >=20
> > Improve formatting a bit.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 12 ++++----
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 69 +++++++++++++++++++++---=
----------------
> > ----
> > =C2=A02 files changed, 39 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 3b59a86a764b..ffaffa880b88 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -101,7 +101,7 @@ static inline void
> > pcim_addr_devres_clear(struct pcim_addr_devres *res)
> > =C2=A0 * @bar: BAR the range is within
> > =C2=A0 * @offset: offset from the BAR's start address
> > =C2=A0 * @maxlen: length in bytes, beginning at @offset
> > - * @name: name associated with the request
> > + * @name: name of the resource requestor
>=20
> What if we say plainly:
>=20
> =C2=A0 @name: name of driver requesting the resource
>=20
> I can tweak this locally if you agree.
>=20

Yup, sound like a good idea to me.

(nit: though I would say "name of the driver". But I'm also not a
native English speaker, so..)


P.



Return-Path: <linux-pci+bounces-2257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168D830320
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6E5287CF5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DBD19BA6;
	Wed, 17 Jan 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbnyZAoH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EEC14A83
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485577; cv=none; b=hsx/3pu783BOjLj4VqgZIAe3VPLHmTv4HEv1KxrYr/bUJi/dPmEgYJzzDZpJaZWaWujavFUulhoFeambV976pahXoMtLCLktySAl6p8pCP5oWjPSvEOED4PseV8pLk9JcjvO1vMKcU6ATRTTiAA2hsmuJbndQi+OItUr6hl3F/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485577; c=relaxed/simple;
	bh=BXWuaM6cUVSlh8BuiMCFX+aJ/lumUdUFLhol1mX3ptg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=sqfuFr6Y/vkWJ70gPkHnpeY0hqJSeFklIKzNtEJER10rK9hmw6ECpDTEm5ABMnD7qzmOIebhx7CnoH1DZUyeprIUjcQpPfKwGPctb8mMVmpcD/STzXbnihAPXuNyhVe0LXFwuSQPsqnKIKi+GVTOyYAxbRqhUNfWn4F0vNAOhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbnyZAoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705485574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXWuaM6cUVSlh8BuiMCFX+aJ/lumUdUFLhol1mX3ptg=;
	b=BbnyZAoH62b58IPXKoIkpMV9SVK+sTZkVFeiWSWOkSFH9Fy+e9rLwUKGRux3drUYy+kWUi
	f3TENXbuMn6f2vTaAvgIIpGA65RISF6/Uh6Ez5SZBKweALQwXFQLc8/9uczT/j7JTZlBwo
	jHFfgJi9dcjnOVYbtLoJrolOxfMD+Q4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-AS8-7XWiMb-F4igsuu6wpA-1; Wed, 17 Jan 2024 04:59:33 -0500
X-MC-Unique: AS8-7XWiMb-F4igsuu6wpA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f4f5c2so194913485a.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 01:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485572; x=1706090372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXWuaM6cUVSlh8BuiMCFX+aJ/lumUdUFLhol1mX3ptg=;
        b=RFiFMQi1Pyf3ruMbkDEWyyoFReYc+qgpBKhjvs9vrsgB4v1RQBjl6+TbF/QelpQHtf
         V8HT1thzvx1AQcaMeK1MCwY550v4vx32znx3kB4rfkc6xIhmDC/Sj1z5S26OXBvDrR8m
         lopKG3SCZ1XTt/488EQReYXUnLE0xFkbNjdwOHmnDguqkATL52gJUIzZ5MynDi/ovW/T
         W+dtiPXc1AAVjDwLu1fcATSjN1KHXp4GEgAhZVwW1RgnwacLruD6PLVmnMfEPuxtsGIx
         Kr+oPCH6KApQWNtaL/1uNrBBnBx6zta4alJucab8BxeKmoLRsgwG4TycYcxfRt7TmQyu
         2p5g==
X-Gm-Message-State: AOJu0Yy0xv5bElbnZ3BZM/qG7BBeKbeSM1GbtckqcV8IfH4vhZhE8Z1S
	dmqxu7JJExHMylvS/UML+hnXbYH5YfITinjiwq++GT3hBdrrW3XHBVgFncK6l71OwLldwMFb7ok
	1RtAZXbCIAq857wfsCxolAblDCx18
X-Received: by 2002:a05:620a:2712:b0:783:54f7:87e3 with SMTP id b18-20020a05620a271200b0078354f787e3mr1912719qkp.3.1705485572529;
        Wed, 17 Jan 2024 01:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSqiqfszMpvjq99qT6Qsh4E31ne0xTg2kSjDD+8OcYXlRuSFlLMN+j9bbV0ag4d0WislsuJQ==
X-Received: by 2002:a05:620a:2712:b0:783:54f7:87e3 with SMTP id b18-20020a05620a271200b0078354f787e3mr1912700qkp.3.1705485572147;
        Wed, 17 Jan 2024 01:59:32 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a148900b0078322355fb7sm4380924qkj.20.2024.01.17.01.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 01:59:31 -0800 (PST)
Message-ID: <5e760f104c75efe37100cee5a26b7ee3581f03b4.camel@redhat.com>
Subject: Re: [PATCH 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: andy.shevchenko@gmail.com
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas
 <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linux-pci@vger.kernel.org
Date: Wed, 17 Jan 2024 10:59:29 +0100
In-Reply-To: <ZabyY3csP0y-p7lb@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
	 <ZabyY3csP0y-p7lb@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-16 at 23:17 +0200, andy.shevchenko@gmail.com wrote:
> Mon, Jan 15, 2024 at 03:46:11PM +0100, Philipp Stanner kirjoitti:
> > =C2=A1Hola!
>=20
> i? Vim user? :-)

The Dark Side of the Force is the path to many abilities, that some
consider to be... unnatural
https://www.neo-layout.org/

>=20
> > PCI's devres API suffers several weaknesses:
> >=20
> > 1. There are functions prefixed with pcim_. Those are always
> > managed
> > =C2=A0=C2=A0 counterparts to never-managed functions prefixed with pci_=
 =E2=80=93 or
> > so one
> > =C2=A0=C2=A0 would like to think. There are some apparently unmanaged
> > functions
> > =C2=A0=C2=A0 (all region-request / release functions, and pci_intx()) w=
hich
> > =C2=A0=C2=A0 suddenly become managed once the user has initialized the =
device
> > with
> > =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). This
> > "sometimes
> > =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confusing =
and
> > =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already caused a =
bug in
> > DRM.
> > =C2=A0=C2=A0 The last patch in this series fixes that bug.
> > 2. iomappings: Instead of giving each mapping its own callback, the
> > =C2=A0=C2=A0 existing API uses a statically allocated struct tracking o=
ne
> > mapping
> > =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't cre=
ate
> > =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers wan=
t.
> > 3. Managed request functions only exist as "plural versions" with a
> > =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered
> > considering
> > =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
> >=20
> > This series:
> > - add a set of new "singular" devres functions that use devres the
> > way
> > =C2=A0 its intended, with one callback per resource.
> > - deprecates the existing iomap-table mechanism.
> > - deprecates the hybrid nature of pci_ functions.
> > - preserves backwards compatibility so that drivers using the
> > existing
> > =C2=A0 API won't notice any changes.
> > - adds documentation, especially some warning users about the
> > =C2=A0 complicated nature of PCI's devres.
>=20
> Instead of adding pcim_intx(), please provide proper one for
> pci_alloc_irq_vectors(). Ideally it would be nice to deprecate
> old IRQ management functions in PCI core and delete them in the
> future.
>=20

In order to deprecate the intermingling with half-managed hyprid devres
in pci.c, you need to have pci_intx() be backwards compatible. Unless
you can remove it at once.
And the least broken way to do that I thought would be pcim_intx(),
because that's consistent with how I make pci_request_region() & Co.
call into their managed counterparts.

There are 25 users of pci_intx().
We'd have to look how many of them call pcim_enable_device() and how
easy they would be to port to... pci_alloc_irq_vectors() you say? I
haven't used that before. Would have to look into it and see how we
could do that.


P.



Return-Path: <linux-pci+bounces-8713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF290646A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616C7B20F8F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96697135A6F;
	Thu, 13 Jun 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFObZEp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4022119
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261470; cv=none; b=iaPylcgnqxbTQ1siyxEoG3U2daBhdWXNuS5X3Exvr9goIw2Xuswdi4tXm0D/VrzN/2wqc1t+TgnX7WhN741vFbwMvVsdxsOV6z/rUQHlkonsBhrCBrPb6C9vOEEb5zo0uDtKXz/uPJGPu0ASPhCwYX1KSu7p84+UuqvmfnFOais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261470; c=relaxed/simple;
	bh=dCYSl6m4zIwH4JbW6vfy7hbe96U8QsTjiiAI04n+hHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sd4Nwtu0fzLsjO9dUUVWOqCbW6+bX/PhlhyTa3DO9gz0koxJtkWT+qg21ODPflV7G6S+VZ2HBA3p9TIPHMnfYbakJQBaDxsDFuwtnkjuVYpIBNJeq/qGrpEzr282Hvq8WnKoNl3rFa0xTGezXpIjtuqaPZYvsRisINT8UbvJMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFObZEp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCYSl6m4zIwH4JbW6vfy7hbe96U8QsTjiiAI04n+hHg=;
	b=WFObZEp6kOWqJqPBYyLY0uFWLHFl2TMDoUCrS350aHinF9tOK/8iFJ7+y1BgNooot+dMgr
	IUN8+eN8cPDaVmMSx7kmyghQ8eB21E0efvK5Z6NUu3YWqJKyg3XTk24h/StNFCoP2klNOh
	ZOAcHM3Yo9Ww9qnHhKmMlgEdg4jzZvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-TwHS1KUMMBy8jMJ2A0Uwnw-1; Thu, 13 Jun 2024 02:51:05 -0400
X-MC-Unique: TwHS1KUMMBy8jMJ2A0Uwnw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f2ae13e4eso111099f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 23:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261464; x=1718866264;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCYSl6m4zIwH4JbW6vfy7hbe96U8QsTjiiAI04n+hHg=;
        b=bFhPDu9wlh3KEFJYPfbz1auYBUA277Chc4wVS4W75lCTnQ0/P7ZuW3zY14dnwX+Ia6
         MtQI7iTvoBhMv4gxPo9HNT+yon7nLVS2A07JjGxws+oTorFi50mKv/dEVZvzpQJ5/YQa
         /fQl/3fV5HTW/scw59NAfZwKRy7HcPE5ZhbM3qk5aOKwLyApXPCQEsummTFLMcsxBxqW
         UWuyoXUfRMYFHNSSRYCy0YPCTT60tVHQBjEtG5nEWozDRHViK4DpOPZILfIoH2eq/U7X
         ux94LJbnB+5M0/X5tk7xxD5RQ3Izw9rZ9WhodndK4go4Sry/7KnMUwQpE2t8qk4JqhcX
         cKPg==
X-Forwarded-Encrypted: i=1; AJvYcCUiyTLd/WNLmENYC8t8SAmUBTx3PS+KEb24vBqPh9KUFqNvEfAqH6Owz0OLq2oJMpdAkPJIUErZjl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypvs3xLnlaVwmQlmmre0Fm9AeVooZsHqcgFkJIKUEmZNNYnIm8
	FQ9y205wJIq3AHShqxVLhqHNEh30B7hCTPybOrqeWWfkFdWPi+z4mYyVEJfOfONP07M8m7MViXG
	y4+LB7nF0pEL0vOAuFhJ6AnC2Uhj0Q7iCdsggLB81ztYRjWkgkBtDaRV5aXjB+ixFBA==
X-Received: by 2002:a05:600c:511c:b0:421:7f30:7ccb with SMTP id 5b1f17b1804b1-422863a85d2mr28530785e9.1.1718261464145;
        Wed, 12 Jun 2024 23:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEne33eg3SL5vDGQDj3JXJ9FvT7/47jv8TG8IqrLLqDZjm0NwnmBgsExGCfn22f4gGdxb3/Tg==
X-Received: by 2002:a05:600c:511c:b0:421:7f30:7ccb with SMTP id 5b1f17b1804b1-422863a85d2mr28530655e9.1.1718261463751;
        Wed, 12 Jun 2024 23:51:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de607sm49767315e9.34.2024.06.12.23.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:51:03 -0700 (PDT)
Message-ID: <ef32b9184700a07048fbb387f7d42410f7db308d.camel@redhat.com>
Subject: Re: [PATCH v8 03/13] PCI: Reimplement plural devres functions
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Thu, 13 Jun 2024 08:51:02 +0200
In-Reply-To: <20240612204235.GA1037175@bhelgaas>
References: <20240612204235.GA1037175@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 15:42 -0500, Bjorn Helgaas wrote:
> On Wed, Jun 12, 2024 at 10:51:40AM +0200, Philipp Stanner wrote:
> > On Tue, 2024-06-11 at 16:44 -0500, Bjorn Helgaas wrote:
> > > I'm trying to merge these into pci/next, but I'm having a hard
> > > time
> > > writing the merge commit log.=C2=A0 I want a one-sentence description
> > > of
> > > each patch that tells me what the benefit of the patch is.=C2=A0
> > > Usually
> > > the subject line is a good start.
> > >=20
> > > "Reimplement plural devres functions" is kind of vague and
> > > doesn't
> > > quite motivate this patch, and I'm having a hard time extracting
> > > the
> > > relevant details from the commit log below.
> >=20
> > I would say that the summary would be something along the lines:
> > "Set ground layer for devres simplification and extension"
> >=20
> > because this patch simplifies the existing functions and adds
> > infrastructure that can later be used to deprecate the bloated
> > existing
> > functions, remove the hybrid mechanism and add pcim_iomap_range().
>=20
> I think something concrete like "Add partial-BAR devres support"
> would
> give people a hint about what to look for.

Okay, will do.

>=20
> This patch contains quite a bit more than that, and if it were
> possible, it might be nice to split the rest to a different patch,
> but
> I'm not sure it's even possible=C2=A0

I tried and got screamed at by the build chain because of dead code. So
I don't really think they can be split more, unfortunately.

In possibly following series's to PCI I'll pay attention to design
things as atomically as possible from the start.


> and I just want to get this series out
> the door.

That's actually something you and I have in common. I have been working
on the preparations for this since November last year ^^'

>=20
> If the commit log includes the partial-BAR idea and the specific
> functions added, I think that will hold together.=C2=A0 And then it makes
> sense for why the "plural" functions would be implemented on top of
> the "singular" ones.
>=20
> > > > Implement a set of singular functions=20
> > >=20
> > > What is this set of functions?=C2=A0 My guess is below.
> > >=20
> > > > that use devres as it's intended and
> > > > use those singular functions to reimplement the plural
> > > > functions.
> > >=20
> > > What does "as it's intended" mean?=C2=A0 Too nebulous to fit here.
> >=20
> > Well, the idea behind devres is that you allocate a device resource
> > _for each_ object you want to be freed / deinitialized
> > automatically.
> > One devres object per driver / subsystem object, one devres
> > callback
> > per cleanup job for the driver / subsystem.
> >=20
> > What PCI devres did instead was to use just ONE devres object _for
> > everything_ and then it had to implement all sorts of checks to
> > check
> > which sub-resource this master resource is actually about:
> >=20
> > (from devres.c)
> > static void pcim_release(struct device *gendev, void *res)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_dev *dev =3D=
 to_pci_dev(gendev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_devres *this=
 =3D res;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < DEVIC=
E_COUNT_RESOURCE; i++)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (this->region_mask & (1 << i))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
pci_release_region(dev, i);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (this->mwi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_clear_mwi(dev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (this->restore_intx)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_intx(dev, this->orig_intx);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (this->enabled && !t=
his->pinned)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_disable_device(dev);
> > }
> >=20
> >=20
> > So one could dare to say that devres was partially re-implemented
> > on
> > top of devres.
> >=20
> > The for-loop and the if-conditions constitute that "re-
> > implementation".
> > No one has any clue why it has been done that way, because it
> > provides
> > 0 upsides and would have been far easier to implement by just
> > letting
> > devres do its job.
> >=20
> > Would you like to see the above details in the commit message?
>=20
> No.=C2=A0 Just remove the "use devres as it's intended" since that's not
> needed to motivate this patch.=C2=A0 I think we need fewer and
> more-specific words.

ACK. I will rework it


Thank you Bjorn for your time and effort,

P.


>=20
> Bjorn
>=20



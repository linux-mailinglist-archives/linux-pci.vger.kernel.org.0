Return-Path: <linux-pci+bounces-2553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37683C77E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C491C24D7D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EA74E04;
	Thu, 25 Jan 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcIQjCT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E587317F
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198818; cv=none; b=j8QF7cLXBDiRsA5x72Z0+7UufdJRLzxhA5cKsPQoXUFVllKM57vKK1PWMs2ZnIz/8bbcGM5grvu87kAOUgw8DUTTVIja11kWCKstPnAfbf2vLKGvZibMYIGi4A7zerTDApKi0S59FLhgCUDjA/z+/H0jVkNPOHB2tY6a80JcvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198818; c=relaxed/simple;
	bh=mxpNg8/1ezqQlLi/nL6WpBh0YQxmcWqg4k8WpwRk6L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYpmqiscQVyuHZgG1W0cqpqSK3JrzUxKJT637yITALHaQlhvPVFsQ+AbWt4LQnRkZo6lljJfJG8feenRfR64hJiirS6X9tLmmvxmVxSGC525uJls+myobqxxvSkQksfRwHHEJNzCfsNhpfW4n4OjisVdgSo1mnB4Nsg5pTnEYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcIQjCT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706198816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxpNg8/1ezqQlLi/nL6WpBh0YQxmcWqg4k8WpwRk6L8=;
	b=hcIQjCT8o75xvYc/QecNfaHM6s9bJBxD5kPdtnTz5c3OyqEbeB1+aNm6+31ZoU8gMyMfJz
	rL50WqLCnPV/ak5+eeb58kaNNvhQ7jA00OZoLzNBX9RkMQhqqVnEMTj+RULcXdM6ZWUlXZ
	16quqrS5fDJevCrdWRmBeQ5FML+OTvw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-8TUtODJxP8ypdjTrUIaT7A-1; Thu, 25 Jan 2024 11:06:54 -0500
X-MC-Unique: 8TUtODJxP8ypdjTrUIaT7A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e743156d0so1495807e87.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 08:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198813; x=1706803613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxpNg8/1ezqQlLi/nL6WpBh0YQxmcWqg4k8WpwRk6L8=;
        b=UK+5ofUuZkycRfw+mA4FQI3e4sdLlqIMKnyKexuBwAbq9VhK5TdNsxcS4hwek6FOvb
         BQ97gsN46J5zSszfPTXJF/kTS5pjOSxibGlVM4c2VkEDGH0yLzZFSmXPUCmiEYDpkxpz
         dLhLW0PmNg61rWVoKgOgNbBv5eeaW7djUtD2+7QA6aUSceZB90tBCUvLBywqsmb230IU
         nDDSmxDnOiaAp/E7bhoEbVdNMKOPgaHfr2zl7dFMfR3tniyI8chI4rUnjTHfbXD2j5KC
         rpa/CjvOCvDAy1tJr5Avj1J2dyjV6vlgaOOGa6bYlc1UGRrJV7GczH3K+WDksNz34wU+
         5SKA==
X-Gm-Message-State: AOJu0YzZYBWtiu8GKEnzidPhK/JxM46mKPDSTGT1xHrfNPl7RnnId7NR
	zTplGJnA/fv9Syv1LerGwtA5w7HIWbNzYEStTc9UIS5GMM2+4pTUbpolKxONTei39gfk8BKe7gx
	KeugOJxhV3JK3tKaBCbdEpgGcpZZlxrGBn9R6T53GZ7Fmw/1PHse0XbmaVQ==
X-Received: by 2002:a05:6512:60c:b0:50e:7f87:f5aa with SMTP id b12-20020a056512060c00b0050e7f87f5aamr12434lfe.3.1706198812939;
        Thu, 25 Jan 2024 08:06:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBkcCfKPSYS4yUtZFQ7r7nSyx1JvC1HiMYB6WLPCzF5Q9dQrseRgsbWq9zVsViEq5CRZzQeQ==
X-Received: by 2002:a05:6512:60c:b0:50e:7f87:f5aa with SMTP id b12-20020a056512060c00b0050e7f87f5aamr12394lfe.3.1706198812557;
        Thu, 25 Jan 2024 08:06:52 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b0040e5cf9a6c7sm3073530wmb.13.2024.01.25.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:06:52 -0800 (PST)
Message-ID: <13319e46cf2a8caa0b397ef67db7d406261a64b0.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 1/5] lib/pci_iomap.c: fix cleanup bugs in
 pci_iounmap()
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org,  Arnd Bergmann
 <arnd@kernel.org>
Date: Thu, 25 Jan 2024 17:06:38 +0100
In-Reply-To: <20240123184622.GA322265@bhelgaas>
References: <20240123184622.GA322265@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 12:46 -0600, Bjorn Helgaas wrote:
> On Thu, Jan 11, 2024 at 09:55:36AM +0100, Philipp Stanner wrote:
> > pci_iounmap() in lib/pci_iomap.c is supposed to check whether an
> > address
> > is within ioport-range IF the config specifies that ioports exist.
> > If
> > so, the port should be unmapped with ioport_unmap(). If not, it's a
> > generic MMIO address that has to be passed to iounmap().
> >=20
> > The bugs are:
> > =C2=A0 1. ioport_unmap() is missing entirely, so this function will
> > never
> > =C2=A0=C2=A0=C2=A0=C2=A0 actually unmap a port.
>=20
> The preceding comment suggests that in this default implementation,
> the ioport does not need unmapping, and it wasn't something it was
> supposed to do but just failed to do:
>=20
> =C2=A0* NOTE! This default implementation assumes that if the architectur=
e
> =C2=A0* support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
> =C2=A0* be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
> =C2=A0* and does not need unmapping with 'ioport_unmap()'.
> =C2=A0*
> =C2=A0* If you have different rules for your architecture, you need to
> =C2=A0* implement your own pci_iounmap() that knows the rules for where
> =C2=A0* and how IO vs MEM get mapped.
>=20
> Almost all ioport_unmap() implementations are empty, so in most cases
> it's a no-op (parisc is an exception).

That sounds correct.

>=20
> I'm happy to add the ioport_unmap() even just for symmetry, but if we
> do, I think we should update or remove that comment.

Yes, I think it's the right way: either all architectures should
provide ioport_unmap(), empty or not, or all should use a centralized
PCI function

I can remove the wrong statement.

>=20
> > =C2=A0 2. the #ifdef for the ioport-ranges accidentally also guards
> > =C2=A0=C2=A0=C2=A0=C2=A0 iounmap(), potentially compiling an empty func=
tion. This would
> > =C2=A0=C2=A0=C2=A0=C2=A0 cause the mapping to be leaked.
> >=20
> > Implement the missing call to ioport_unmap().
> >=20
> > Move the guard so that iounmap() will always be part of the
> > function.
>=20
> I think we should fix this bug in a separate patch because the
> ioport_unmap() is much more subtle and doesn't need to be complicated
> with this fix.

If we agree that one is a bug and the other isn't, then ACK, we should
probably split it.

>=20
> > CC: <stable@vger.kernel.org> # v5.15+
> > Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make
> > sense of it all")
> > Reported-by: Danilo Krummrich <dakr@redhat.com>
>=20
> Is there a URL we can include for Danilo's report?=C2=A0 I found
> https://lore.kernel.org/all/a6ef92ae-0747-435b-822d-d0229da4683c@redhat.c=
om/
> ,
> but I'm not sure that's the right part of the conversation.

He pointed out it's a bug in an offlist conversation with me. The link
you provided is his only public statement about the topic.
The Reported-by served more acknowledging the contribution than issue-
tracking


P.

>=20
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > =C2=A0lib/pci_iomap.c | 6 ++++--
> > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> > index ce39ce9f3526..6e144b017c48 100644
> > --- a/lib/pci_iomap.c
> > +++ b/lib/pci_iomap.c
> > @@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void
> > __iomem *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (ui=
ntptr_t) PCI_IOBASE;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uin=
tptr_t) p;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr =
< start + IO_SPACE_LIMIT)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr =
< start + IO_SPACE_LIMIT) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ioport_unmap(p);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0#endif
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(pci_iounmap);
> > =C2=A0
> > --=20
> > 2.43.0
> >=20
>=20



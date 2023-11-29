Return-Path: <linux-pci+bounces-242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35217FD6F1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AD22823C0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AEA1426B;
	Wed, 29 Nov 2023 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXf0d4/p"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85D10F0
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701261624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9CdZJhC6mWbHtgRNx7rPmbL35uryCNbMAEfF46nxeQ=;
	b=NXf0d4/pfFxHI49y2qzbkj+EcG2FltTBwLI5THuxIl8vV6RMY6Bj3iHWSIxYmAMrKi4Zpz
	WcpZueO3vvdhxtsVEYoq+GSFRBUOmcAJQANuRGx8H22aqmz1Ac6QzqdBQFDsYZqE3zw4sz
	D4GCy7Hk3mxiteNbuzgXBGY0PIuQwto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-gZPL3aNfPJGXUauvQXzFlw-1; Wed, 29 Nov 2023 07:40:23 -0500
X-MC-Unique: gZPL3aNfPJGXUauvQXzFlw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b2afd72ecso8516395e9.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 04:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261622; x=1701866422;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9CdZJhC6mWbHtgRNx7rPmbL35uryCNbMAEfF46nxeQ=;
        b=ehm2n2hoze6saDxkTXpghoNinENL7sAg8zYBw8RJKNKVnTSvbdSGgkJl98nBCa+NMF
         kGXO6LB9hx+wSfszD3eIxuFNNZPGRdX6dbjnF/AV0xvRK5qAlmPxwkNngzNDXfFyRAv2
         r+AHnmLFu3ZKl8y8yfJkV93M2O+v5Oj1rwf5j5kaO6hnG/fu80rSc8DOeLCD+DI/Pk1a
         Ace+cuGpGowFmE07Q876ZM92GS1Q1uP/xbKdl9K0JKVntPIIonGBpWTt8hk6x0bZV1Oc
         qTduAoFHkQDML9Emu0nrof/VX1iUpKnudODi/t+AI3DG7kkhziSzdOJFgr7JTVEbA8P3
         CpDA==
X-Gm-Message-State: AOJu0YwpPyE/ckq+5uTjSBhvU6iLHO0PFTI2fRXfasXPVNMtQKueKf3x
	tegXMmCSGxFwnDkHOF1IAdSUEwNAPXeDaJrHs7exJDTURTquPox6XGlk79vTI3SyCCh08KR5d3h
	coZlLxJbUzBbhRxs7Mv2F
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr10799105wmp.2.1701261622235;
        Wed, 29 Nov 2023 04:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDtsYehLQlGFAIq6LJfqx7ddMLE4aygnDQtPMeQpUfzDCDfQtjWHWiJiovDFxaX8BThshwZQ==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr10799082wmp.2.1701261621881;
        Wed, 29 Nov 2023 04:40:21 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b0033308db2576sm5830499wrp.56.2023.11.29.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:40:21 -0800 (PST)
Message-ID: <10ef8eac12c01f52ec3b8c0bedf6cf34627d1ceb.camel@redhat.com>
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,  Eric Auger
 <eric.auger@redhat.com>, Kent Overstreet <kent.overstreet@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Neil Brown <neilb@suse.de>, John
 Sanpe <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Yury Norov
 <yury.norov@gmail.com>, Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Jason
 Baron <jbaron@akamai.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	pstanner@redhat.com
Date: Wed, 29 Nov 2023 13:40:19 +0100
In-Reply-To: <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
	 <20231120215945.52027-6-pstanner@redhat.com>
	 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi again,

so I thought about this for a while and want to ask some follow up
questions in addition to those by Danilo in the other mail.

(btw, -CC Herbert Xu, since the mailserver is bouncing)


On Tue, 2023-11-21 at 11:03 +0100, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > lib/iomap.c contains one of the definitions of pci_iounmap(). The
> > current comment above this out-of-place function does not clarify
> > WHY
> > the function is defined here.
> >=20
> > Linus's detailed comment above pci_iounmap() in drivers/pci/iomap.c
> > clarifies that in a far better way.
> >=20
> > Extend the existing comment with an excerpt from Linus's and hint
> > at the
> > other implementation in drivers/pci/iomap.c
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> I think instead of explaining why the code is so complicated
> here, I'd prefer to make it more logical and not have to
> explain it.
>=20
> We should be able to define a generic version like
>=20
> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> {
> #ifdef CONFIG_HAS_IOPORT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ioport_unmap(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> #endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
> }

ACK, I think this makes sense =E2=80=93 if we agree (as in the other thread=
)
that we never need an empty pci_iounmap().

>=20
> and then define iomem_is_ioport() in lib/iomap.c for x86,

Wait a minute.
lib/ should never contain architecture-specific code, should it? I
assume your argument is that we write a default version of
iomem_is_ioport(), that could, in theory, be used by many
architectures, but ultimately only x86 will use that default.

> while defining it in asm-generic/io.h for the rest,

So we're not talking about the function prototypes here, but about the
actual implementation that should reside in asm-generic/io.h, aye?
Because the prototype obviously always has to be identical.

> with an override in asm/io.h for those architectures
> that need a custom inb().

So like this in ARCH/include/asm/io.h:

#define iomem_is_ioport iomem_is_ioport
bool iomem_is_ioport(...);

and in include/asm-generic/io.h:

#ifndef iomem_is_ioport
bool iomem_is_ioport(...);

correct?

Still, as Danilo has asked in his email, the question about how inb()
is related to it still stands

>=20
> Note that with ia64 gone, GENERIC_IOMAP is not at all
> generic any more and could just move it to x86 or name
> it something else. This is what currently uses it:
>=20
> arch/hexagon/Kconfig:=C2=A0=C2=A0 select GENERIC_IOMAP
> arch/um/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC=
_IOMAP
>=20
> These have no port I/O at all, so it doesn't do anything.
>=20
> arch/m68k/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
>=20
> on m68knommu, the default implementation from asm-generic/io.h
> as the same effect as GENERIC_IOMAP but is more efficient.
> On classic m68k, GENERIC_IOMAP does not do what it is
> meant to because I/O ports on ISA devices have port
> numbers above PIO_OFFSET. Also they don't have PCI.
>=20
> arch/mips/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
>=20
> This looks completely bogus because it sets PIO_RESERVED
> to 0 and always uses the mmio part of lib/iomap.c.=20
>=20
> arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP
>=20
> This is only used for two platforms: cell and powernv,
> though on Cell it no longer does anything after the
> commit f4981a00636 ("powerpc: Remove the celleb support");
> I think the entire io_workarounds code now be folded
> back into spider_pci.c if we wanted to.
>=20
> The PowerNV LPC support does seem to still rely on it.
> This tries to do the exact same thing as lib/logic_pio.c
> for Huawei arm64 servers. I suspect that neither of them
> does it entirely correctly since the powerpc side appears
> to just override any non-LPC PIO support while the arm64
> side is missing the ioread/iowrite support.

I think by now I get what the issue with GENERIC_IOMAP is. But do you
want me to do something about GENERIC_IOMAP (besides the things
directly related to the PCI functionality I'm touching) for you to
approve of a modified version of this patch series?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20



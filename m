Return-Path: <linux-pci+bounces-237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DA7FD3DC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D15B21A0C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB31A592;
	Wed, 29 Nov 2023 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBNJJsL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDD51AE
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701253002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcguwJOZbBrEOKJtIaNOv7UFSPg18lyOYHkppcsG19M=;
	b=YBNJJsL/T5QDo9uTxzlTERtsi0aEtagjLelVCvpJ1rGG9kBIR7Vhc2nZf/XEkzKlgQ6h5C
	EpeUHvwbf2S+GiYBEWegpQodzLG+4fUwj6KA3TY5oevcMwdVASwpdEm6CgTDqjtpD21gNd
	Qn/GOzDJXwrDM3J3U//b79zkICqgq+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-oKVkj8HrPo-8K10j3npYfA-1; Wed, 29 Nov 2023 05:16:40 -0500
X-MC-Unique: oKVkj8HrPo-8K10j3npYfA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332eb96529aso694104f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 02:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252999; x=1701857799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcguwJOZbBrEOKJtIaNOv7UFSPg18lyOYHkppcsG19M=;
        b=J99gkN7m+OVdmFKCfGeCmdj5croUqf+h4ACmE5oCE/JzxN49nvCxx4MGl8x16nnPVT
         WHHLG496uGxhZzk0GAeCcrAhH29TfI9QsP7iCdWGqKsS1OcV6UgrmJz6sU101ufrIOJp
         ZSpxVZAgiWtG+l2PUzoC4a68/aq09P6NXueYlt7M3thdzGSApf2WaX22xYVns0aZ/JpA
         MpDjdKHs20D8yu9wTyHir6SnMMAMKJ65ZGW0vqxrqXcHG7vEMQqKibbf7B1ojkGIzd3r
         M1vj+62BN4kOUqj4RNN7NMXD/RVw5esDq8zy0ziVD2UzhApvK/nPAbNfsfVNQhXYR07p
         A/iA==
X-Gm-Message-State: AOJu0YzHXEb1KFqugum/iJB1bfNERaecS1OuIG3W5RomoclxVRj3C2Vh
	3zaPWbg7ozK06NL4GT8LUfwRY5Bt4By6TqfC1R1+CzOTAFWu8bPN1n0k5hFl0c380n5S4EZY82S
	u1XPiadl0RQLDJCF155/L
X-Received: by 2002:a05:6000:80e:b0:332:ff23:588a with SMTP id bt14-20020a056000080e00b00332ff23588amr6881035wrb.5.1701252999393;
        Wed, 29 Nov 2023 02:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6LSedjrZ8RJnZJI/bDCD0iKBZk/BPNcdizN27Ik6/SdJpvaue2AjhSFctCQHULCS6cWvStw==
X-Received: by 2002:a05:6000:80e:b0:332:ff23:588a with SMTP id bt14-20020a056000080e00b00332ff23588amr6881020wrb.5.1701252998987;
        Wed, 29 Nov 2023 02:16:38 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa40b000000b00332cb846f21sm17455107wra.27.2023.11.29.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:16:38 -0800 (PST)
Message-ID: <b13191e7a5ad63de23adb8ec3f8a3699a0dd236e.camel@redhat.com>
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
From: Philipp Stanner <pstanner@redhat.com>
To: Danilo Krummrich <dakr@redhat.com>, Arnd Bergmann <arnd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Eric Auger <eric.auger@redhat.com>, Kent
 Overstreet <kent.overstreet@gmail.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Neil Brown <neilb@suse.de>, John Sanpe
 <sanpeqf@gmail.com>,  Dave Jiang <dave.jiang@intel.com>, Yury Norov
 <yury.norov@gmail.com>, Kees Cook <keescook@chromium.org>,  Masami
 Hiramatsu <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Herbert
 Xu <herbert@gondor.apana.org.au>,  Thomas Gleixner <tglx@linutronix.de>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>, Jason Baron
 <jbaron@akamai.com>,  Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 29 Nov 2023 11:16:36 +0100
In-Reply-To: <a6ef92ae-0747-435b-822d-d0229da4683c@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
	 <20231120215945.52027-6-pstanner@redhat.com>
	 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
	 <a6ef92ae-0747-435b-822d-d0229da4683c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2023-11-24 at 20:08 +0100, Danilo Krummrich wrote:
> Hi Arnd,
>=20
> On 11/21/23 11:03, Arnd Bergmann wrote:
> > On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > > lib/iomap.c contains one of the definitions of pci_iounmap(). The
> > > current comment above this out-of-place function does not clarify
> > > WHY
> > > the function is defined here.
> > >=20
> > > Linus's detailed comment above pci_iounmap() in
> > > drivers/pci/iomap.c
> > > clarifies that in a far better way.
> > >=20
> > > Extend the existing comment with an excerpt from Linus's and hint
> > > at the
> > > other implementation in drivers/pci/iomap.c
> > >=20
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> >=20
> > I think instead of explaining why the code is so complicated
> > here, I'd prefer to make it more logical and not have to
> > explain it.
> >=20
> > We should be able to define a generic version like
> >=20
> > void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>=20
> Let's shed some light on the different config options related to
> this.
>=20
> To me it looks like GENERIC_IOMAP always implies GENERIC_PCI_IOMAP.
>=20
> lib/iomap.c contains a definition of pci_iounmap() since it uses the
> common IO_COND() macro. This definitions wins if GENERIC_IOMAP was
> selected.

Yes. So it seems the only way the implementation in lib/pci_iomap.c can
ever win is when someone selects GENERIC_PCI_IOMAP *without* selecting
GENERIC_IOMAP.


>=20
> lib/pci_iomap.c contains another definition of pci_iounmap() which is
> guarded by ARCH_WANTS_GENERIC_PCI_IOUNMAP to prevent multiple
> definitions
> in case either GENERIC_IOMAP is set or the architecture already
> defined
> pci_iounmap().

To clarify that, here's the relevant excerpt from include/asm-
generic/io.h:

#ifndef CONFIG_GENERIC_IOMAP
#ifndef pci_iounmap
#define ARCH_WANTS_GENERIC_PCI_IOUNMAP
#endif
#endif


>=20
> What's the purpose of not having set ARCH_HAS_GENERIC_IOPORT_MAP
> producing
> an empty definition of pci_iounmap() though [1]?
>=20
> And more generally, is there any other (subtle) logic behind this?

That's indeed also very hard to understand for me, because you'd expect
that if pci_iomap() exists (and does something), pci_iounmap() should
also exist and, of course, unmapp the memory again.

From include/asm-generic/io.h:

#ifdef CONFIG_HAS_IOPORT_MAP
#ifndef CONFIG_GENERIC_IOMAP
#ifndef ioport_map
#define ioport_map ioport_map
static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
{
 port &=3D IO_SPACE_LIMIT;
 return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
}
#define ARCH_HAS_GENERIC_IOPORT_MAP
#endif

As far as I understand the logic, an empty pci_iounmap() is generated
(and used?) in lib/pci_iounmap.c if:
 * CONFIG_HAS_IOPORT_MAP has not been defined
 * CONFIG_GENERIC_IOMAP has been defined (makes sense, then we use the
   one from lib/iomap.c anyways)
 * ioport_map has been defined by someone other than asm-generic/io.h

Regarding the last point, a number of architectures define their own
ioport_map():

arch/alpha/kernel/io.c, line 684 (as a function)
arch/arc/include/asm/io.h, line 27 (as a function)
arch/arm/mm/iomap.c, line 19 (as a function)
arch/m68k/include/asm/kmap.h, line 60 (as a function)
arch/parisc/lib/iomap.c, line 504 (as a function)
arch/powerpc/kernel/iomap.c, line 14 (as a function)
arch/s390/include/asm/io.h, line 38 (as a function)
arch/sh/kernel/ioport.c, line 24 (as a function)
arch/sparc/lib/iomap.c, line 10 (as a function)

I grepped through those archs and as I see it, none of those specify an
empty pci_iomap() that could be a counterpart to the potentially empty
pci_iounmap() in lib/pci_iomap.c

All of them use the generic pci_iomap.c, which can _never_ be empty.
Perhaps when the functions returning always NULL in include/asm-
generic/pci_iomap.h were to be used...?
But I think they should never be used, because then pci_iomap.c wins.
Arnds seems to agree with that, because he pointed out that these
functions are now surplus relicts in his reply to my Patch Nr.1:

> From what I can tell looking at the header, I think we can
> just remove the "#elif defined(CONFIG_GENERIC_PCI_IOMAP)"
> bit entirely, as it no longer serves the purpose it originally
> had.

So it seems that the empty unmap-function in pci_iomap.c is the left-
over counterpart of those mapping functions always returning NULL.

@Arnd:
Your code draft

void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
{
#ifdef CONFIG_HAS_IOPORT
if (iomem_is_ioport(addr)) {
ioport_unmap(addr);
return;
}
#endif
iounmap(addr)
}

seems to agree with that: There will never be the need for an empty
function that does nothing. Correct?


P.

>=20
> [1]
> https://elixir.bootlin.com/linux/latest/source/lib/pci_iomap.c#L167
>=20
> > {
> > #ifdef CONFIG_HAS_IOPORT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ioport_unmap(addr);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > #endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
> > }
> >=20
> > and then define iomem_is_ioport() in lib/iomap.c for x86,
> > while defining it in asm-generic/io.h for the rest,
> > with an override in asm/io.h for those architectures
> > that need a custom inb().
>=20
> So, that would be similar to IO_COND(), right? What would we need
> inb() for
> in this context?
>=20
> - Danilo
>=20
> >=20
> > Note that with ia64 gone, GENERIC_IOMAP is not at all
> > generic any more and could just move it to x86 or name
> > it something else. This is what currently uses it:
> >=20
> > arch/hexagon/Kconfig:=C2=A0=C2=A0 select GENERIC_IOMAP
> > arch/um/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENER=
IC_IOMAP
> >=20
> > These have no port I/O at all, so it doesn't do anything.
> >=20
> > arch/m68k/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
> >=20
> > on m68knommu, the default implementation from asm-generic/io.h
> > as the same effect as GENERIC_IOMAP but is more efficient.
> > On classic m68k, GENERIC_IOMAP does not do what it is
> > meant to because I/O ports on ISA devices have port
> > numbers above PIO_OFFSET. Also they don't have PCI.
> >=20
> > arch/mips/Kconfig:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_IOMAP
> >=20
> > This looks completely bogus because it sets PIO_RESERVED
> > to 0 and always uses the mmio part of lib/iomap.c.
> >=20
> > arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP
> >=20
> > This is only used for two platforms: cell and powernv,
> > though on Cell it no longer does anything after the
> > commit f4981a00636 ("powerpc: Remove the celleb support");
> > I think the entire io_workarounds code now be folded
> > back into spider_pci.c if we wanted to.
> >=20
> > The PowerNV LPC support does seem to still rely on it.
> > This tries to do the exact same thing as lib/logic_pio.c
> > for Huawei arm64 servers. I suspect that neither of them
> > does it entirely correctly since the powerpc side appears
> > to just override any non-LPC PIO support while the arm64
> > side is missing the ioread/iowrite support.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd
> >=20
>=20



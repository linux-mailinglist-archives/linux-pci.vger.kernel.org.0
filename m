Return-Path: <linux-pci+bounces-41-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E47F3139
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1347B217F8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4FF4A9BD;
	Tue, 21 Nov 2023 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/mtHLJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526C170E
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700577528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgy9FU1P/mtjjmGhgeXi9H78tlxIy2hISiHhoOKv2hU=;
	b=J/mtHLJrpUlsmPtQUkSp8H4QlkMLdnwahp3vBAwJCpAKE1lEAHem/yhMjekhqdlPLBBKW3
	culAyTF0TI37jzBK2m5Xe9c4bGAuluVRXzO/Ekz/t8GuBeE/BciQ8qhDzZWkqO2vFd/9/Q
	R7CCCa5hyxYEPpQ+rAf3XSZcHtkj22E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-nznnJI4hOm6eozQxNjswKA-1; Tue, 21 Nov 2023 09:38:47 -0500
X-MC-Unique: nznnJI4hOm6eozQxNjswKA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77a6f87b78fso44834685a.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 06:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577526; x=1701182326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgy9FU1P/mtjjmGhgeXi9H78tlxIy2hISiHhoOKv2hU=;
        b=AALawTkLZ+2OKczoOMifCuNqUtODu6aTG5/6w5Di8fOmZ8xf/1OyxRy7QwxUwEYRBD
         jyNynFGU+TJxwhjE45uzDqzQa/7gvs8XnTCcilZmfXGY14VLRSNniw26vtt5V0gbm7RC
         z/QNxFIIdNGM6RWtspAiRsfBHla7j5M0h3I1qTxtGY/hLO8uqTqM137kuudk69lr2Iz9
         0+/eJdIdQ1d6rnYfB03LIh1o9A0Fb5euGvv6FOxCT5gcsNtS8cwxpmdWoJ9WD70se6y0
         v3UgtZJdqtBLZRz3fsDJI3PhTyTRTAzrq7+f8qH+8jP3/YoGd8VfxKfgGYWAWCI3cEof
         vhzA==
X-Gm-Message-State: AOJu0Yyu3floP2PEFVbz4fJQgtqWq6C+KAmecN2n7jcIuL0X2vS2vOh/
	ca4VmGxzx5hIXqdLX7957INOg50l3xKBWqcBxAgleLPX/jx4r1d/d7hhUmfrHs6gvPMmZVP1BKE
	ZhUGRnX4SeUc6VmI4WzYt
X-Received: by 2002:a05:620a:1994:b0:77b:dce8:737 with SMTP id bm20-20020a05620a199400b0077bdce80737mr10669002qkb.7.1700577526616;
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIPpkU+2GCN9FoFyUK9CChv2vU5606IxhwK6RzXGPX/QXF9WkCmnmU726ssCw+wPxvrSAQ6w==
X-Received: by 2002:a05:620a:1994:b0:77b:dce8:737 with SMTP id bm20-20020a05620a199400b0077bdce80737mr10668980qkb.7.1700577526343;
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p10-20020ae9f30a000000b0076d08d5f93asm3657668qkg.60.2023.11.21.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:38:46 -0800 (PST)
Message-ID: <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,  Eric Auger
 <eric.auger@redhat.com>, Kent Overstreet <kent.overstreet@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Neil Brown <neilb@suse.de>, John
 Sanpe <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Yury Norov
 <yury.norov@gmail.com>, Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, 
 "wuqiang.matt" <wuqiang.matt@bytedance.com>, Jason Baron
 <jbaron@akamai.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Tue, 21 Nov 2023 15:38:41 +0100
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

And where would you like such a function to reside?
drivers/pci/iomap.c?

P.

>=20
> and then define iomem_is_ioport() in lib/iomap.c for x86,
> while defining it in asm-generic/io.h for the rest,
> with an override in asm/io.h for those architectures
> that need a custom inb().
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
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20



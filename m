Return-Path: <linux-pci+bounces-248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3C7FDDA4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DA3282439
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC4F34546;
	Wed, 29 Nov 2023 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqoWy209"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194F1DA24
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4CFC433C9;
	Wed, 29 Nov 2023 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276787;
	bh=Wq314BYKXeWO/ild5QLd+lHLiRCms0SQlJmL6wGPBJM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=FqoWy209TmDsyBgUFiqxVEPB2XWsdPHtmG/sotJQe/IEJYujb16IlSBJwZ0Qx0RTl
	 2MEGxlyw6xauYSO6C2cGaz8RJUd7WGiAX4s/qsJ8IbzvJGMi26k+/mTXTnyRbTIfUO
	 QdPF337YzmTGdpJusTFQU3xDx3tLXYhdgvTuZ3y/0Vt2bqKvQVSCqFdLl4LltUfQTO
	 T9cvwSWpKunFz4I5Jpvsn6QK4ARQx6hLxYgzYwX0YJDGqKHi5GMrkTTkrz94//uH4N
	 IZM7mOniapsS/ULcIZOR7rvpEfhlQ1WKJnWOQK64DcsvO8pWxj3FZMmkN9ajUUShrQ
	 e3CxBs0L5yyvg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8A00227C0054;
	Wed, 29 Nov 2023 11:53:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 Nov 2023 11:53:05 -0500
X-ME-Sender: <xms:cGxnZeTTtOyVpk-cRmmoiwrYDH1DkUZfLk90ERNaykxKvEDjy2y_4g>
    <xme:cGxnZTwsg5VCca6muzoZCpHQKhD6Pln0rZTos9G7yHpRmj1mA5NSIFoG79hu55QpD
    CAXNPshhQSqTHNXDTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:cGxnZb0VSEnpA6iHzPw0GLaBaCMDRQH5iHKZW_YhuWg8JndZK_r9zQ>
    <xmx:cGxnZaB7WCzJzZM8Kx3sdD6KsiDl1_IDt3w9PmlQmGLf-gqJw9jsNg>
    <xmx:cGxnZXgnglQkXF3UNPjNKJ015-mrKdpfZfdhvZ8jxN84LBP_IbLk_w>
    <xmx:cWxnZU2Y2Vd1oyyrW5XzOtn_cs7xdkCknlfNE2aW0fJl40u9kKUB2YT-rvw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A96E8B6008D; Wed, 29 Nov 2023 11:53:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b80338ac-bf2c-49d0-b772-e3b66e8e056d@app.fastmail.com>
In-Reply-To: <10ef8eac12c01f52ec3b8c0bedf6cf34627d1ceb.camel@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
 <10ef8eac12c01f52ec3b8c0bedf6cf34627d1ceb.camel@redhat.com>
Date: Wed, 29 Nov 2023 17:52:43 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Eric Auger" <eric.auger@redhat.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Neil Brown" <neilb@suse.de>,
 "John Sanpe" <sanpeqf@gmail.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Kees Cook" <keescook@chromium.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "David Gow" <davidgow@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>, "Ben Dooks" <ben.dooks@codethink.co.uk>,
 "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023, at 13:40, Philipp Stanner wrote:
> On Tue, 2023-11-21 at 11:03 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
>> We should be able to define a generic version like
>>=20
>> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>> {
>> #ifdef CONFIG_HAS_IOPORT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ioport_unmap(addr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
>> }
>
> ACK, I think this makes sense =E2=80=93 if we agree (as in the other t=
hread)
> that we never need an empty pci_iounmap().
>
>>=20
>> and then define iomem_is_ioport() in lib/iomap.c for x86,
>
> Wait a minute.
> lib/ should never contain architecture-specific code, should it? I
> assume your argument is that we write a default version of
> iomem_is_ioport(), that could, in theory, be used by many
> architectures, but ultimately only x86 will use that default.

I would hope that eventually we can build lib/iomap.c
only on x86, as everything else can live without it.

>> while defining it in asm-generic/io.h for the rest,
>
> So we're not talking about the function prototypes here, but about the
> actual implementation that should reside in asm-generic/io.h, aye?
> Because the prototype obviously always has to be identical.

It could live in lib/pci_iomap.c or in
include/asm-generic/pci_iomap.h, it doesn't really matter
since the definition is trivial. asm-generic/io.h is probably
not the right place, unless we want to merge all of
asm-generic/pci_iomap.h into asm-generic/io.h. We could
do that now that all architectures include asm-generic/io.h
and that includes asm-generic/pci_iomap.h unconditionally.

>> with an override in asm/io.h for those architectures
>> that need a custom inb().
>
> So like this in ARCH/include/asm/io.h:
>
> #define iomem_is_ioport iomem_is_ioport
> bool iomem_is_ioport(...);
>
> and in include/asm-generic/io.h:
>
> #ifndef iomem_is_ioport
> bool iomem_is_ioport(...);
>
> correct?

Yes.
=20
>> arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP
>>=20
>> This is only used for two platforms: cell and powernv,
>> though on Cell it no longer does anything after the
>> commit f4981a00636 ("powerpc: Remove the celleb support");
>> I think the entire io_workarounds code now be folded
>> back into spider_pci.c if we wanted to.
>>=20
>> The PowerNV LPC support does seem to still rely on it.
>> This tries to do the exact same thing as lib/logic_pio.c
>> for Huawei arm64 servers. I suspect that neither of them
>> does it entirely correctly since the powerpc side appears
>> to just override any non-LPC PIO support while the arm64
>> side is missing the ioread/iowrite support.
>
> I think by now I get what the issue with GENERIC_IOMAP is. But do you
> want me to do something about GENERIC_IOMAP (besides the things
> directly related to the PCI functionality I'm touching) for you to
> approve of a modified version of this patch series?

It would be nice to clean up some of the architectures
that incorrectly select it at the moment, but that
can be a separate series if you want to get this one
done first, or I can take a look myself.

      Arnd


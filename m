Return-Path: <linux-pci+bounces-43-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78C7F314A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7132A1C20BF9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2615483;
	Tue, 21 Nov 2023 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgL2ucQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157656749
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 14:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB7C433CC;
	Tue, 21 Nov 2023 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700577706;
	bh=C7C7k7MQyKejZFr0pldTQeSMPk6gsd2UxQYtxinu5pw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=CgL2ucQdy94yOgeIDAUwoCO7aWp99U7UxUB44vIJ3zoQMnIR3udHQhZIN5sXyibxH
	 czAz+Vx7RKPr3AxsKhd//nrVd+r4N6i7ApCx4lYT3p9DQ1FAkUO2nrLt1C0OvO9hu0
	 GyxDqgbOTvqZ+c7ie+Cpemx6xHP6JTyW3ruN+ht4bp54BYF69fMaDHagP5C+KWqEZR
	 2GijwYoxOkrfOh8SuugWFy/NFjq/L/cG2cnPsXdIiJTdRvS4sgOyqNK92uVAfKrcXW
	 /1IJfJPYZxTj5HxtbY5vKw7lmpV/AzMLvdDw7rTTx/pSoeXW8MDSz83AYujBr+LtqC
	 MPuYqOIGMysAw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 51B9927C0060;
	Tue, 21 Nov 2023 09:41:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 09:41:44 -0500
X-ME-Sender: <xms:pcFcZdsWGDQlhmI6n2v2STwpRur8Ex5jMj-OfonBvkm_qP9u5Vehkw>
    <xme:pcFcZWeZpBbfB55MnYno9359Tfus34ITY1sDhe4hW7V3SABXCwWvG2hyrWlObjFSY
    GxTFDh4hpfPDZC8XQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:pcFcZQwzPDqKgO1eLy9fMP5k2YNWEMyxrZNGFyRrVEVQYyKof1N0OQ>
    <xmx:pcFcZUPwcZ2E04cngCvFBms1fpBUlzIk4d9BIyGmL2zgsp3AgKymCA>
    <xmx:pcFcZd9CZzsabkHxDxckarU4_obPREarv2t_-o-ecM-cKfM6Kg3-eQ>
    <xmx:qMFcZYdm9j_565d_pkgW7CpQU98cxirDUwH0UjRGVxVLDJqpUCXQGyo-hO4RixM3>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D1C33B60089; Tue, 21 Nov 2023 09:41:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5bd85a64-5161-4312-831d-cba420e20bfb@app.fastmail.com>
In-Reply-To: <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
 <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
Date: Tue, 21 Nov 2023 15:41:21 +0100
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
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>, "Ben Dooks" <ben.dooks@codethink.co.uk>,
 "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023, at 15:38, Philipp Stanner wrote:
> On Tue, 2023-11-21 at 11:03 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
=20
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
> And where would you like such a function to reside?
> drivers/pci/iomap.c?

Yes, I think that would be the logical place. It could also
be an inline function but that's not great on architectures
that don't also have iomem_is_ioport() inline.

    Arnd


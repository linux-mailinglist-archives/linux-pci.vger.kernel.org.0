Return-Path: <linux-pci+bounces-24-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B785E7F26DF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 09:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84811C20EC7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98438DCC;
	Tue, 21 Nov 2023 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM9q9+bG"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DBC3
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 00:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700553667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T40r14k+GJH8froFyeHTEYys3h09bU1RbAgHUM0HR7M=;
	b=jM9q9+bGHWIk7zvOCHzv4hHr7tjXTTKnSHerOsKtouK1XB4yR+gwVuuNQXCvqeE0lLV1xI
	ScF5g1JwWZINgZlMeuUsQfoMONKdIcF4ndetnqA974iBdstUIMSg8DhUO22Cdia1uYfe09
	8kF92Pg+gULbhXLAfy1SCUHh5FpjoCs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-1BMS7GRVOlaG1fLBCf3ajA-1; Tue, 21 Nov 2023 03:01:02 -0500
X-MC-Unique: 1BMS7GRVOlaG1fLBCf3ajA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778b5c628f4so71626985a.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 00:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700553662; x=1701158462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T40r14k+GJH8froFyeHTEYys3h09bU1RbAgHUM0HR7M=;
        b=hSEJIJqiGIUoIBgh/aevap0FqhDSQiwv4Idsd+kBfn3v9nYQHdy8o2eJRPVXGxj6kW
         zMUg1VeklKcmq69EY2MEntwkYBWBwHnV3ewUQCx6R+wu8vW3jGAOTzs+CmcJidmg7rc/
         TYB0+sJsMfGmb/9lmpAUycHqVTAoZcsSZ+vrO+11zBNHDDOpL7v3VH25LE8Ra7V3+rRD
         o1rBtg4Iv7LhPjkyvcFsmsa/1bq1lYm1sAy7v/NruTJ44dedPDXLfZgopoEeIAvoaCsW
         nGFQxwsWpqZE2SUpmS5YAE4oH65f/TWF5iYn0toQVQvThFT/xmLo6o9POo18WgLoH7nF
         SpQA==
X-Gm-Message-State: AOJu0Yzcb8sbywmBhL/BamX4Cfo6g4Ubj8KIuBxlmq/c/1EQQxmNI27L
	T3eCsizVzsyZiUS6YiasQ/1sayI+bV6xYvKVgqaqjXfpmWXW9AZw4xnAgH1/ArUxWRH9m7IBvos
	6zQO5BsUhwaAIvGkIJ10m
X-Received: by 2002:a05:620a:1993:b0:776:f188:eee6 with SMTP id bm19-20020a05620a199300b00776f188eee6mr12064308qkb.2.1700553662449;
        Tue, 21 Nov 2023 00:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/fxOrCTKTFdfBU3FfgYL3cQyMCOz/S4+5mT3QDjRE+h9BN8/orrFqxzG87zzge1Rl/wF8Pg==
X-Received: by 2002:a05:620a:1993:b0:776:f188:eee6 with SMTP id bm19-20020a05620a199300b00776f188eee6mr12064272qkb.2.1700553662102;
        Tue, 21 Nov 2023 00:01:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a113900b00767dcf6f4adsm3394581qkk.51.2023.11.21.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 00:01:01 -0800 (PST)
Message-ID: <d38d1149fdf5eb0cc4da12402ca03604beba1881.camel@redhat.com>
Subject: Re: [PATCH 2/4] lib: move pci-specific devres code to drivers/pci/
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
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	pstanner@redhat.com
Date: Tue, 21 Nov 2023 09:00:58 +0100
In-Reply-To: <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
	 <20231120215945.52027-4-pstanner@redhat.com>
	 <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 08:29 +0100, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> > CONFIG_PCI and, thus, don't belong to this file. They are only ever
> > used
> > for pci and not generic infrastructure.
> >=20
> > Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c
> >=20
> > Suggested-by: Danilo Krummrich <dakr@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/Makefile |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/pci/devres.c | 207
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0lib/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
8 +--------------------------------------
> > ----
>=20
> Since you are moving the pci_iomap() code into drivers/pci/ already,
> I'd suggest merging this one into the same file and keep the two
> halves of this interface together.


I'd argue that they are as much together as they were before:

Previously:
 * PCI-IOMAP-code in folder lib/ in its own file (pci_iomap.c)
 * PCI-Devres-code in folder lib/ in a distinct file (devres.c)

Now:
 * PCI-IOMAP-code in folder drivers/pci/ in its own file (iomap.c)
 * PCI-Devres-code in folder drivers/pci/ in its own file (devres.c)

Or am I misunderstanding something?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20



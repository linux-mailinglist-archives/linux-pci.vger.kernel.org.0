Return-Path: <linux-pci+bounces-29-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D87F2A87
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 11:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F1B216B6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9942F2F;
	Tue, 21 Nov 2023 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcECAx3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD995
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700562971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fXaJSQMl560/CujFDTiC43FQHsULeYQafoon8VIZRg=;
	b=XcECAx3zcWDWQaB/bSd+hrmZaIJOlsLM6DqfRl3hzQANLoFVOL77SGXb2U4fL8F77j/gKn
	BMgosbRIPpNlT0f8xf+ol8VbjzRgP+mnubw3bzeEayNMo1hIVcVyRcCxCm+enU/B7XM5Pg
	tKzC2gJGy3A3VxT6TUW2xJlVuQl5fJo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-nH0zdaEsNGu6oiVNQQFSIg-1; Tue, 21 Nov 2023 05:36:09 -0500
X-MC-Unique: nH0zdaEsNGu6oiVNQQFSIg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-677fb270eacso9829246d6.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 02:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562969; x=1701167769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fXaJSQMl560/CujFDTiC43FQHsULeYQafoon8VIZRg=;
        b=sNCob+TNbLkW0V//E9c8rcsYVCK4rReEn4q3Ye4B8LAGre3z7btRt9GRd5/+3QWyhF
         PdOxqiaL9UMIP9gcSXtSg2uZMe9oNLXekdgt/vnIOhlysz6L4Bm9Ij4j/e8xuGPA5XGh
         hL5WLRJcc14iAS7ccxMiOM4gHj91jRXAdgpgpm464v+sXbgbrt2K/AI6cxJO8DaiFwxu
         RVXKXlsGXezNs0penkdzLTZixPpStuu2wKVY799z4xarlHx1V+5SPRjTxofdGoHVY1oA
         mRgm+MRsr/+RAoTGw2kwrsUR7C+0JtksIp3CLTqXVLyqqtgyT98s5fvk5quCDeWco4uk
         LuqA==
X-Gm-Message-State: AOJu0YyUXi0jbP47xWXqOYmchzQARok7Wzg3saEVoaevmQbqJGZdAnfR
	3fx7Zh5cLoa6rHM0vdW/Ee78oOJDMhffz1hOBGyvKXcWi2ZPoEsZ2r+6QpaiGwuXaf+rzkyi2xW
	7nVuH8ckn0u6krj95W4ZV
X-Received: by 2002:a05:6214:57ce:b0:677:f602:2c8 with SMTP id lw14-20020a05621457ce00b00677f60202c8mr9752802qvb.0.1700562968888;
        Tue, 21 Nov 2023 02:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY4doARu4ZHeRkzNNccAiknJL4TYHiR9HZAQAnjFH9cc5wuobHdC7aG9Z2rHzinx5NFU55Cw==
X-Received: by 2002:a05:6214:57ce:b0:677:f602:2c8 with SMTP id lw14-20020a05621457ce00b00677f60202c8mr9752787qvb.0.1700562968587;
        Tue, 21 Nov 2023 02:36:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id k27-20020a05620a0b9b00b0077d5cf2108esm201580qkh.73.2023.11.21.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:36:08 -0800 (PST)
Message-ID: <fbf91189babaf640b573dfe3a1c68932718bda4e.camel@redhat.com>
Subject: Re: [PATCH 3/4] pci: move devres code from pci.c to devres.c
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
Date: Tue, 21 Nov 2023 11:36:04 +0100
In-Reply-To: <3bc69019-7867-4f51-806d-02bf85a3cbf9@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
	 <20231120215945.52027-5-pstanner@redhat.com>
	 <3bc69019-7867-4f51-806d-02bf85a3cbf9@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 11:17 +0100, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > The file pci.c is very large and contains a number of devres-
> > functions.
> > These functions should now reside in devres.c
> >=20
> > There are a few callers left in pci.c that do devres operations.
> > These
> > should be ported in the future. Corresponding TODOs are added by
> > this
> > commit.
> >=20
> > The reason they are not moved right now in this commit is that
> > pci's
> > devres currently implements a sort of "hybrid-mode":
> > pci_request_region(), for instance, does not have a corresponding
> > pcim_
> > equivalent, yet. Instead, the function can be made managed by
> > previously
> > calling pcim_enable_device() (instead of pci_enable_device()). This
> > makes it unreasonable to move pci_request_region() to devres.c
> > Moving the functions would require changes to pci's API and is,
> > therefore, left for future work.
> >=20
> > Move as much devres-specific code from pci.c to devres.c as
> > possible.
> >=20
> > Suggested-by: Danilo Krummrich <dakr@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 243
> > +++++++++++++++++++++++++++++++++++++++++
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 249 -----------------------=
----------------
> > ----
> > =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 24 +++++
> > =C2=A03 files changed, 267 insertions(+), 249 deletions(-)
>=20
> I had just commented in the other mail that you'd have to move
> these functions to devres.c for the file to make sense, but that
> I think the existing state is better.
>=20
> Just to clarify again here: this patch does not seem to improve
> anything to me,

Have you read the cover letter? It elaborates on that.

The idea behind centralizing devres-pci-code in a separate file is that
the current implementation is strangely torn.
My mid-term goal would be to fix that, but that's beyond the scope of
this series.

PCI has some separate devres functions, prefixed with pcim_ =E2=80=93 and t=
hen
there are some other functions that use a crazy hybrid mode:

drivers/pci/pci.c:

void pci_release_region(struct pci_dev *pdev, int bar)
{
	/* ..... SNIP ......... */

 dr =3D find_pci_dr(pdev);
 if (dr)
 dr->region_mask &=3D ~(1 << bar);
}

Some functions without pcim_ prefix switch to managed mode if
pcim_enable_device() instead of pci_enable_device() was called.

So some functions are sometimes managed and others never are, which is
totally inconsistent.

This is bug-provoking because programmers won't know without looking
very closely which functions become managed and which don't.

That should be fixed. And a first step towards that goal is to cleanly
split them. Everything managed should reside, on the long term, in
drivers/pci/devres.c

>  I'd much prefer leaving it the way it is, and
> moving the pcim_iomap family to corresponding drivers/pci/iomap.c.=20

We could branch that change out of the patch series and handle the
topics independently

P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20



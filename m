Return-Path: <linux-pci+bounces-21094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02AA2F3BB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6C93A6DC1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB91F4616;
	Mon, 10 Feb 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KELOZZRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559311F4615
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205408; cv=none; b=gFIrGDIbL21dXHIuUd+VoFac/AWvM/XTq9/laWUcuhjeA3tThH/tS+5nP4vHV9DrdsmIrD8HEODO1Ku1r494P2jKPyTAUCZ2YDqwKTC0ZCryVCYcUzgO5C/JgO0BYycoiGtPFR0BpaLC0lhhev+LnhI2rgFXg1Hd+LogxFsThp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205408; c=relaxed/simple;
	bh=SZpHciN/vra1qgjlq2N/I116fAj16TIxGXtrqaH0H2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9AjcCC0sDK3909BHOu9xBliDhDZRHlWEnmOD1Fe4LcPOkSLE6dWoQC6oALo7lb6r2+7ijaUWNBuwx+AlX9Ga/9GYBV2cxC/JtwLcbfNSnKivj8faYzf4Osf4BS2fyXmtf434gbx7DcPzQ8yvyqGhGeACdLzhT2LtGFVEdrw3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KELOZZRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739205406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fnD7VJVCXYOV9Bma2SXbyYmBE+oALQ693M8QQFnzSI=;
	b=KELOZZRbZqN3kN+s3foSFWbQqj4NyeT41Mf7gf1yRqTBhmO9XTBDleV974x41T1t6STCPz
	50cNdTAluPuPw7OvCUFJCSJXBv9A7qAEE1deG9TT2VIm1mYWaabQavTMZVywTgA6ueWbqK
	lIksmn7jFnimw+xxlaM08ioS4T4YZlY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-8Sc8qj3WNHWRqlvsxgyXOg-1; Mon, 10 Feb 2025 11:36:45 -0500
X-MC-Unique: 8Sc8qj3WNHWRqlvsxgyXOg-1
X-Mimecast-MFC-AGG-ID: 8Sc8qj3WNHWRqlvsxgyXOg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-84f54d63095so42932139f.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 08:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205404; x=1739810204;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fnD7VJVCXYOV9Bma2SXbyYmBE+oALQ693M8QQFnzSI=;
        b=VBAARL0/Kx78nBGpfEd0Utyi7FjslHN2XFhBW+Chh/ipNorXnoJ3T3zYyh2bu+Bp98
         lWA/NU56yqTWHnkjQpt+CAHkwtVlrqujwhOFDYGZcAG06+Q/Q3sZWP3lZwpx5bIqH49i
         3irQJbsoQ8DXzpTga5BndauBlGqvk7a6ckqNjF8PYEoi4IxVPv7U/9stHunFM01mJje4
         w0+Wbifk//mDvolhE3M9mRYSIVdYew0GPk6d69775slYrQ6YneDXaZuftRJ3E/8UhtuU
         k6IbHYuGgUcsfq0qD+WTl/g4o8U3jKOa0cvbO9pmJhOus+mGewf70bIASJYIV7JAACHV
         zjJw==
X-Forwarded-Encrypted: i=1; AJvYcCVABdXHNjIAZSkS/H4n+uCQDzDDWFm9LY75dGX8DVjey9vVe2GCnXQF9aEe4ZZMPAaKlcEsPRj1dWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cm/PsyG0CWtJR2jul34Ye+AKi5JFpFYojgdVvBtcmGS+HuzG
	FZAA8tgWcVyzw7yKtojWNf23ld0w8hQNMrEu3mW6KATn4rb21QnAHAc3IY1otz+fn0DPmYJHakS
	frgJjcozsIuT68n1yWg8Z1svOpp9F03nNswqxM0Cm4EsDZaLk/gZuguQ65v8+i0xz1Q==
X-Gm-Gg: ASbGncvMa3ltWtjEib/O2W8eL3JaT2F428C6kFcTdHn8vzu4k3Q17gYLOJSk3JRwxe1
	q49pCwHbnuVPQ/C5OABBuheCFmdSy2Jv1FHB08xZBKcsugPv57tyoZvi/mS9JJo6iH0IIIQJjFl
	I5owBB9u8kEOs5pE159g8YLkndcsEPTd90z2765jkHgiHDDdxa8iJRkBkMDL87t8PjbNORZ/JUr
	8MVKYHF/LOsyGyFIWPpxafTzjQx7/vQmSGDWE9VbyRmr8m1dHp6UIQ0wLHXfwQe6k5ymlkgSIwI
	CdJb2Ikq
X-Received: by 2002:a05:6e02:13ec:b0:3d0:4db5:cd1d with SMTP id e9e14a558f8ab-3d13dec320cmr24801465ab.3.1739205404073;
        Mon, 10 Feb 2025 08:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRk8NJl73TmUwUC+h3niqjf0Ri2nfIXsthmmINyfXdYM6EHo7T7KYqjOFeUHPdp1FrFbaTGw==
X-Received: by 2002:a05:6e02:13ec:b0:3d0:4db5:cd1d with SMTP id e9e14a558f8ab-3d13dec320cmr24801435ab.3.1739205403770;
        Mon, 10 Feb 2025 08:36:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed08c21f5fsm69458173.49.2025.02.10.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:36:43 -0800 (PST)
Date: Mon, 10 Feb 2025 09:36:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
 ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210093641.0be242ae.alex.williamson@redhat.com>
In-Reply-To: <20250209154512.GA18688@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
	<20250209154512.GA18688@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Feb 2025 16:45:12 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/20, Alex Williamson wrote:
> >
> >  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, =
int rom)
> >  {
> > +	u32 rombar, stdbars[PCI_STD_NUM_BARS];
> >  	unsigned int pos, reg;
> > +	u16 orig_cmd;
> > +
> > +	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS); =20
>=20
> FYI, I can't build the kernel after this patch:
>=20
> 	$ make drivers/pci/probe.o
> 	  UPD     include/config/kernel.release
> 	  UPD     include/generated/utsrelease.h
> 	  CALL    scripts/checksyscalls.sh
> 	  DESCEND objtool
> 	  INSTALL libsubcmd_headers
> 	  CC      drivers/pci/probe.o
> 	In file included from <command-line>:0:0:
> 	drivers/pci/probe.c: In function =E2=80=98pci_read_bases=E2=80=99:
> 	././include/linux/compiler_types.h:542:38: error: call to =E2=80=98__com=
piletime_assert_338=E2=80=99 declared with attribute error: BUILD_BUG_ON fa=
iled: howmany > PCI_STD_NUM_BARS
> 	  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 					      ^
> 	././include/linux/compiler_types.h:523:4: note: in definition of macro =
=E2=80=98__compiletime_assert=E2=80=99
> 	    prefix ## suffix();    \
> 	    ^
> 	././include/linux/compiler_types.h:542:2: note: in expansion of macro =
=E2=80=98_compiletime_assert=E2=80=99
> 	  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	  ^
> 	./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98=
compiletime_assert=E2=80=99
> 	 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> 					     ^
> 	./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98B=
UILD_BUG_ON_MSG=E2=80=99
> 	  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> 	  ^
> 	drivers/pci/probe.c:348:2: note: in expansion of macro =E2=80=98BUILD_BU=
G_ON=E2=80=99
> 	  BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
>=20
> Yes, my gcc version 5.3.1 is very old, but according to Documentation/pro=
cess/changes.rst
> it should still be supported, the minimal version is 5.1.

While I try to setup an environment with an old gcc, can we do something
with __builtin_constant_p() to only evaluate this on versions of gcc
that can determine howmany is constant?  Ex.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..c70cb480125e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigne=
d int howmany, int rom)
 	unsigned int pos, reg;
 	u16 orig_cmd;
=20
-	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
+	if (__builtin_constant_p(howmany))
+		BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
=20
 	if (dev->non_compliant_bars)
 		return;

I welcome other suggestions too.  Thanks,

Alex



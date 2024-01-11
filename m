Return-Path: <linux-pci+bounces-2045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F182AADB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB7BB22CF6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705C10788;
	Thu, 11 Jan 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlPkcq1G"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1811C8C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704965272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
	b=XlPkcq1GRhIvbuQEvmG6gkHkC51E5TS2OXPQ+QtyXHewtPHlneEjVA5bp9ixPY2nLoO58+
	8yGslIuvj7uRcu0H1JGf9rfx5EJ7eAoI86fKnw4B9LdGEVWq59voUIn15IUGifZJee8a9s
	sD5nrWe+Q3EsRLgxm1SnbPjcIxFf8dI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-MUGnHAVoOpGCVayqRzKyMQ-1; Thu, 11 Jan 2024 04:27:51 -0500
X-MC-Unique: MUGnHAVoOpGCVayqRzKyMQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d44608e379so8302585ad.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965270; x=1705570070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
        b=JjKPv1dr+S0ydc1RULdR9ZlBwF2onrIDIqI4NC0LH0B+xEOPrGifwxKqKEf+2OJRfU
         47vTW7O7UAk6eN13SLZym42AorROsBzr3a3/5q99Nhy71rCkt/ysClz5u9XHrOv4xKeU
         J/j8HOgqeY5n337rvB51FCube4xBFByOi0o7AyA5FMPS4kjSap6oNJdTtNxnYR+9sV14
         f8kj7sVQh1nBM+ytjE9jgzKWbF6pw5FaqExF1zsuZCywZjWBgCP44tgPXFmb8ZvVyxYy
         XEUjnolvXvyHHJY0Oz3Gi6OfbOKcgPHfKZ+/1GmW1aZ9vTuNNLCCZbdNB5ts7Tz6ql20
         Om/w==
X-Gm-Message-State: AOJu0Yx360/8mAugEVu68h5OV1fbRKCXPDXZ5MAqvvJjL7HOQ/pTLYVj
	lNMZk6yKwfZ5oGlLWqjlfwu1g72khQGMTrK7AxjTkDJYIkLVNjn7ToirgsD2HgmmlO5Gdwm7akD
	Uix9JICEsHpYzwIh0fxGlPbocBxdP/9E97/nQ
X-Received: by 2002:a05:6214:3009:b0:680:fea0:6fca with SMTP id ke9-20020a056214300900b00680fea06fcamr1571914qvb.6.1704964870124;
        Thu, 11 Jan 2024 01:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsCflr1cnBg8FbDO4MmTrvarkaVOthrTYfY/uZOhpa7zT35UnHSVpI8slHFl4ak53EWIvl9w==
X-Received: by 2002:a05:6122:4104:b0:4b6:e3fa:7599 with SMTP id ce4-20020a056122410400b004b6e3fa7599mr1396985vkb.0.1704964487656;
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ch7-20020a05622a40c700b00429970654b6sm281418qtb.33.2024.01.11.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Message-ID: <42cf5ca70c940b3e68c8ad0e4bab6f14f87d4486.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
From: Philipp Stanner <pstanner@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>, John Sanpe
 <sanpeqf@gmail.com>,  Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 dakr@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jan 2024 10:14:43 +0100
In-Reply-To: <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
References: <20240111085540.7740-1-pstanner@redhat.com>
	 <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 10:03 +0100, Johannes Berg wrote:
> On Thu, 2024-01-11 at 09:55 +0100, Philipp Stanner wrote:
> > Second Resend. Would be cool if someone could tell me what I'll
> > have to
> > do so we can get this merged.
>=20
> I don't even know who'd merge it, but um doesn't seem appropriate...

UM isn't a recipent, I'd guess it's some mail filter which might make
it appear that way :)
The lists I sent this to are
linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
linux-arch@vger.kernel.org, stable@vger.kernel.org

Anyways, PCI is for sure who should merge this, since it's 100% about
PCI.

> >=20
> > @Stable-Kernel:
> > You receive this patch series because its first patch fixes leaks
> > in
> > PCI.
>=20
> Too early for that, stable just ignores stuff before it hits
> mainline.

I know, they're in CC because of the "Fixes: "

P.

>=20
> johannes
>=20



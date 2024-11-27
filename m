Return-Path: <linux-pci+bounces-17417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD39DA863
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D82A162908
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D311FCF4F;
	Wed, 27 Nov 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBXA3cOB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB931FC0F3
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713653; cv=none; b=rt7DUTl0v9tFlMBi8ZwTWIYogigmvlfDIxvfhxMMjREasCorZL7feOtWQ3wbetispWLDfdMO2DEW0uyxtaIVzjHli/wi+XB9FLKZgQ7dwPTEoVlaSvD9wU+7XKiJgak0qkVx1jEvGRdsCGiLIXFM+QakdN+MAnCaEecK2ITlHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713653; c=relaxed/simple;
	bh=WTt75bBcJkp5uZEdeVnXg+4b8wvHx7hFnzaZQb7uQHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRUZHnfWS0mx4c5FcZvZ/sNx5PRr6DrZ9wT0RFtmD7T1p9tvIR+HJqtsH5xDkWoIBV27FlkO/wEMhtL8FsL0HIhREdKxpHTVfedH0C2G22UXaHgEclzcLOArUfiQNpbCwyDM0gHItMDzxS4cTjAtiiOo29j05GaDm5ptvYR0qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBXA3cOB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38232cebb0cso5106397f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732713650; x=1733318450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqRMluSX7bPKY9IoaSKl+6ql8Su2K5GfIIK1LXdOHlE=;
        b=ZBXA3cOBEI5/Qe8ReYvO3hkSY90x55CeSTikUYNZ+2SLkoaOsLNLCPfD79SjZocmJz
         40zR9+dniP1gZwe/pdfeOB7w6Gx29IqcDJiekO/zikrW6MkNpHeQjZ/cxVJQwwiwMlTN
         d9t4JsWc4lQlJ7oV2etqBc328AJ48YgjkSdud9+zaa39EUyJjB6SelhwIZ8YQ0b0qnhr
         jMceuX79rzufNjaGpLwnzeFSrwlI+D88SvGhuK8rY2DHWLi7aT/BmQTPGYxCU8PIC0wP
         DYVZDN0J9FJe/ZQGnHe7vJcZvc/re1BM+evo8bHgMrwziHmQvdO0Ff93/sTAdmjZhtIu
         +dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732713650; x=1733318450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqRMluSX7bPKY9IoaSKl+6ql8Su2K5GfIIK1LXdOHlE=;
        b=V97JJpuR7ss5oCrsi3ccVfjThRq+rELHVBIfYq5/5J8bxUycTs8ZJ1EWDEkIrGHehr
         KlNE8HwvlEPQ8hzATfBZ3lJ0BsztXoBbUnWRuIvX4DWcQCNgAk5rHoDAv9IGGUGiC0Dm
         5POBBL/Ri2LnZ2AQgvCgewsrzCzeYr1Jn3XvmK9U/c0JOAGo1rG9A0aKdlvMBl8t3q3Q
         WfveQzu0Q7vRywotZy00mP3hpyNK65B8hvJSShhmWM54D9eNj0srexQyFQid1zOoT+ID
         DCR3dMn0q3Kes7JlcTyjoTqrEputdF7fLOiomI9A3oMODppDuFf97ytWK8RMGJ4bqiUU
         dCWg==
X-Forwarded-Encrypted: i=1; AJvYcCVCWJiEPoE+j4tm0iI4Namc1vGMQKKKVZa53Npgg1fokV0GxfIYHKhOvTWhK8M2znS7EQjJVXGKHBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3rCMzfZphbvRnLU9oAMfbYjjep9yCWsvZWitgzNn8mdbpYpA
	9+fhnf+tujhxPo7WpWTxximgR5Ho0wjRRdZ/hk/nlzhX5L4LrPMXwC7DpYtindBq+E4qISjtKOs
	zEj+nMzHdaVdVdMyJVgx+cDnUiwQyAFj9NIXS
X-Gm-Gg: ASbGnctmJiSqg3anz+fEV0aAW+LCxYRTRV3Q56OO9mrcqef4FbhBcrJseJhFgPeHBmI
	WvVkxu6TXKOTsM6HtRDHPC6J3eDaps+Q0S57jYQn/m4UnuYPVQj+pat6veTHJBg==
X-Google-Smtp-Source: AGHT+IG4+Q9bIy7rext2rN+trmXuD+MQjvH5vE635+hgAaEldDWE5YGrYgmPhGJKwuHwh/U+sltj/EcCSBTAHe6mJJI=
X-Received: by 2002:a05:6000:1562:b0:382:383e:84e2 with SMTP id
 ffacd0b85a97d-385c6edb2a4mr2585883f8f.46.1732713650357; Wed, 27 Nov 2024
 05:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-11-dakr@kernel.org>
 <CAH5fLgjdKRCECmZbjC-+6SQffFtgimfxhDJ3grVw1_hbQec1-Q@mail.gmail.com> <38d708b5-7a73-4736-909c-eefd3c938769@kernel.org>
In-Reply-To: <38d708b5-7a73-4736-909c-eefd3c938769@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 14:20:38 +0100
Message-ID: <CAH5fLgg9xkMeGZi_4aN60UMtpvOx2CY5JQc26swMtXTaJsE=-w@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] rust: add devres abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 2:19=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 11/27/24 1:21 PM, Alice Ryhl wrote:
> > On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
> >> +impl<T> Drop for Devres<T> {
> >> +    fn drop(&mut self) {
> >> +        // Revoke the data, such that it gets dropped already and the=
 actual resource is freed.
> >> +        // `DevresInner` has to stay alive until the devres callback =
has been called. This is
> >> +        // necessary since we don't know when `Devres` is dropped and=
 calling
> >> +        // `devm_remove_action()` instead could race with `devres_rel=
ease_all()`.
> >> +        self.revoke();
> >
> > When the destructor runs, it's guaranteed that nobody is accessing the
> > inner resource since the only way to do that is through the Devres
> > handle, but its destructor is running. Therefore, you can skip the
> > synchronize_rcu() call in this case.
>
> Yeah, I think this optimization should be possible.
>
> We'd require `Revocable` to have a `revoke_nosync` method for that I gues=
s...

Agreed, you could have an unsafe method for revoking where you assert
that nobody else is accessing the value.

Alice


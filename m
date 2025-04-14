Return-Path: <linux-pci+bounces-25855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32EA88A6E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91007A5F44
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE5261575;
	Mon, 14 Apr 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAdTFaXo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395851A3A80;
	Mon, 14 Apr 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653269; cv=none; b=SL+6+f5dH83ELhNV+7RRWbniFr/dIrzNYXUyeE6x2gJQtPvM7XjlR5ciGjj1VKml1/iyjH6Au2uRW2DTOhFBT9OiADyfdZ2FNbObiH82YNgGbSVheqlfZrce5bUHSDnNGgajPoPzYYr4zvrtymKgZT7Bcs/fMPICTUxQkhYRhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653269; c=relaxed/simple;
	bh=8Qgdtz9ypU0oOKwpTo4JmZbvXA3PP/my4vKhuAjzLqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1sTT5judPuB2FkQ43WAwrGbiupnRwTfaO5SEmewv+5In001nqXpBVGvcJmy937Ru+Kv/lWyc/6UMohO2Qd3Gc0nzVfWMjpCJUvij4Fqw+akl/SO2GBobGU6aqEPwKedgag2HLvDZk4KLfW783rCd/2S25/cC5Q0heMsrMFsKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAdTFaXo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso49769011fa.1;
        Mon, 14 Apr 2025 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744653266; x=1745258066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qgdtz9ypU0oOKwpTo4JmZbvXA3PP/my4vKhuAjzLqU=;
        b=bAdTFaXoQDkXuWn+j+2Ki26w9N3dx+PirvmT1z9MZ2FSv0VgfHSw+d8nmCq3f0Z63k
         ANML4xa5HJ0hHJRVkw1SL42WxxzezC/b7h+LnWN+onjuz/OjG07jJdoO429xTZ4Vym8r
         ORMYFgFepYVFwOPLCc2xULVxqWlMeDEm8445wY4Aac8hPnWziLdHZSJsz88CE2Wo8/d9
         rIx9UJRLzqN2SEla9pwvzsefNbSNJ2hoSf5jOQrLVoD3SOXWLH/BaRLB7+iZ74yQF434
         8xIYmH6DKpTx1q00p2oTMBcBj6yNh5QmCRrjRaHwRDSfxjYVQu5vL90dU767M4yjbTeu
         7AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653266; x=1745258066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Qgdtz9ypU0oOKwpTo4JmZbvXA3PP/my4vKhuAjzLqU=;
        b=GIjiwwhK5VvNkDpHSJq2dxnqfVks247Fo7KqGvW14S+KJRZB1nU1onwPhw7c5ZecxK
         EVeYEmliTKW1Es3vxLIE+k54a3Jzo0GSqq5aqshNoenCNGx42s6rkIS/XgydOSKuDABH
         3cCW8wZ2dWe/cHstiIOaQfOYGND8EB6qlnhjd6XUCpTdrW+dgxE7k2CRGn+Nq/SWGuMx
         XHC/AUAyejrL+n1WZjAeke/p1BkXd26BiHKmx7qsz250q3WJcDeId53w1pLeAUQ53BCL
         9JdZkBif3zvlwL94v3WLyudcYHuIxYsRIknGXU48cJWn2QK2FhFp27SB2QmjFbXfKXzB
         wH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV4IkxeeuL5q2PskyUhJb5O4tbXLjMH+TOz58+rdAjGI6ljOuU1/Hyae3o+d3h2OX06GSTKhlIHYgfyws=@vger.kernel.org, AJvYcCWE9cNB4gD7K374JiEIaJGmJWdU6dsdihrH1+kAjudH1hqPweKkRQmdWtJodpUfiz7szg8CGAH7FMH6@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdnzl99lvgY6QGDHoPEdv6qkOKNWmDrqumcGTf0QcCqBVsBpf
	i+Seu4VVhQIXIyqDpb44Zqe5QCACHha213r6+MA33K4SsGz+vhgGnIvbFm+Edh+1iAo3wBrFCbM
	e/kaK8TgalxxFdy+1m4V0oSELSjQ=
X-Gm-Gg: ASbGncty+H7w1TjAVKLwV25IYUpVb2GKuK2aD8Gtj3iYr81+PGHWmkNmygNZMfBk2Nu
	Junu2CVjdRsbZm9o3K5BtPqz8AjX3r2BM/W00wZNXVwE2Ypldgiu3xad1ssiAMW0oox3IfBz5FR
	dAHTDc+aiQcSNGm+Rc3tkGoll9FVRLadyWx7FXNA==
X-Google-Smtp-Source: AGHT+IFVPoTOrkVrYxVlcM8cXIdY5bKGK1WEIii/EImf8ccKrpxD0VGODBV4dBlCqt6Av0nOgZPgtEoUzN4eQ8JSR/k=
X-Received: by 2002:a2e:9217:0:b0:30d:6a77:c498 with SMTP id
 38308e7fff4ca-31071be6bcdmr1293361fa.4.1744653265954; Mon, 14 Apr 2025
 10:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com> <CAJ-ks9=Q_s_XnyeZSUC+yABP+BrH+7LnJkg1mHDuH7k18vLR2A@mail.gmail.com>
In-Reply-To: <CAJ-ks9=Q_s_XnyeZSUC+yABP+BrH+7LnJkg1mHDuH7k18vLR2A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Apr 2025 13:53:49 -0400
X-Gm-Features: ATxdqUFQ53tseeFKH--QP0JaZ_cPJ6zrezNHeZdYNl10Q6bQyc6ROto2ROD0eGM
Message-ID: <CAJ-ks9=Nq+UbVMh6iqUdTk_5og6+WwTjifXKRjc=SRbpY0g8gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rust: list: remove HasListLinks::OFFSET
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:53=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Apr 9, 2025 at 10:51=E2=80=AFAM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > The bulk of this change occurs in the last commit, please its commit
> > messages for details. The first commit exists in 2 other series but was
> > picked into this series to allow using `container_of!` without the need
> > to cast from `*const Self` to `*mut Self`.
>
> That first commit is now in the prerequisite patch, not here.

Gentle ping; this still needs a review. The first two patches are
trivial, and the last one is similar in spirit to
https://lore.kernel.org/all/20250411-no-offset-v3-1-c0b174640ec3@gmail.com/
which was reviewed by Benno Lossin, Alice Ryhl, and Andreas Hindborg.
Could you folks have a look please?


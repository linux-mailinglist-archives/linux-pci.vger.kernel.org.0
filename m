Return-Path: <linux-pci+bounces-7687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC98CA1F9
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41781F220B3
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88719137744;
	Mon, 20 May 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtBfyvIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864F137935;
	Mon, 20 May 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229511; cv=none; b=Xs9l8D79nirkOGhBOyf4jhoRAnSKSoKhIlKWSofQJ+kC6t2JND9dhfBjchWzcz/OSfFo+77ls+74LZf4+F6ZaYzMDYEmtJJLq5GuAei34GBRYK4Evv7VppJNo6hlZMF0EnnFrVwlttigDKnCtHk5JxKJmaaEZlLMmUzBSLWpwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229511; c=relaxed/simple;
	bh=p1xprU4vOea7uqODiskzLhgw/kUfj5m0dleX5y0RR/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUh6uxqV6usAEHI+b6nc2Jh0nB9t853B6pISc9yrSVmQs2fU2RKbRiSWdsRRTVw4NVxNotIFFNRbIXg+wuOFFll4APsBe56Bds0H0ZF8mx9Ke8erilLyuXtV24AlXWjdk4UccufUwAXAZgcytfeiwYo5I3JgvM+ox2rzA/p9aME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtBfyvIG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f2ecea41deso76436725ad.1;
        Mon, 20 May 2024 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716229509; x=1716834309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCzsMXCJzJib1Vj/052OC8Unse2419z65QvsV8mXP9k=;
        b=UtBfyvIGNkbMGJgFZDWHS7kOxfVXqfk0U3AYzudbmebCCfbKOjVGV7+RC74bZdm8lg
         VaMNMcPBOPa8nzgAA4Y+bBEInmJpysHo3LoT0W3Tmzy8Y/75V5mVn3KM/mL0NIPJBfn0
         TVOrW57kz+XMIHlMO6MYr1Yp7xzq5HyfjNsx1olHdyKe9KDNkW0jUkcF+WdPTETa11mI
         KWnLC0lwPiIY7NZ/pnO8xmApg2q2dlAVhLOWqk2wsWuRiQQ2Jx7WzssUdVoi85N9mq86
         J9H05pSJvbIYwxSc73n+lH/1KyVG/wuIfaSPLpMD7VTBOiSOQnGC6h99vRxqoNmMTaVW
         UR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716229509; x=1716834309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCzsMXCJzJib1Vj/052OC8Unse2419z65QvsV8mXP9k=;
        b=Ovy4NAqgi5ozyBrT+6v8ZKJg6KEe0SonNhQuTsEEy0VY2LtPS6G+vT4n1hyQa3VX77
         jBZDMHObBXu7Njla6WXHCShd8jAhvjZWz417I+r5mou7LZLRKv2LwV5Ig1lOw4bPGTYg
         gQTBpvOo5rEVNu7LoQBBW8AOZJWnzv8WuCZVlaaKPqUSyRokYj4y7FOrTgYgMooABnNl
         1vHMQmsY0OGY0t79rAIZGopEri2o6j0cjqdgO29OEgpRQYdx6YivNozvU+s0+CUuuHEu
         IrnyX274prwGBJnmtmvkgeaq6Fw6VIxxvcyxFIvcU1jTh45wlWoFHqUo+Gh3d67pi7Pq
         Sr1w==
X-Forwarded-Encrypted: i=1; AJvYcCWg2epGNq9yAwrIXPvEaJCyv0oLekWE7Qxwe/4MJAR5guH0CGbkXg9oZg8udKg7Bmpqa4plwHM/auudDiK+FjNjI82JDoJGqaS6pmbWARUq5c7x5YNTG4HDYLn01XlPAUeXMWiqILZXqE0kdAiglguVBY64OswUyG7+nBItx3hhwgF4iHoCfuI=
X-Gm-Message-State: AOJu0Yw2b2VLkav8pbbTfdK7BLmRqwREbbEFDrzGB6O+aJsDhpyL1QjV
	uv1/4jSfPjGh/a3CRazEEA05/8rC4Hsfyxb8bWhDi1/LAqtf2XVkMnsyHFVsrxlguRaWLWHyD4h
	QMjVpxnLboLhCRg3pYoxsSTEXomqLoiIG
X-Google-Smtp-Source: AGHT+IEo5H6eSId3eMYUGGmgFGcoQeNlGjDqS05obW5JIaQ7xwgIbgIbOQXUmPJK+Mk8Q73L4WM10QgiqrVY9P+5AOk=
X-Received: by 2002:a17:90b:d0b:b0:2a2:c16:d673 with SMTP id
 98e67ed59e1d1-2b6ccc73005mr27772865a91.36.1716229509274; Mon, 20 May 2024
 11:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
In-Reply-To: <2024052038-deviancy-criteria-e4fe@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 May 2024 20:24:56 +0200
Message-ID: <CANiq72n5Cb9dyzRozt9_SWknm9JOuZrY0jo7sLrC9AGkdKR9Qw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 8:00=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> What's the status of moving .rs files next to their respective .c files
> in the build system?  Keeping them separate like this just isn't going
> to work, sorry.

In progress.

> > +//! Generic devices that are part of the kernel's driver model.
> > +//!
> > +//! C header: [`include/linux/device.h`](../../../../include/linux/dev=
ice.h)
>
> relative paths for a common "include <linux/device.h" type of thing?
> Rust can't handle include paths from directories?

We have the custom `srctree/` notation for that (which the patch should use=
).

And eventually we should have support for easy-to-use links to C
structs and so on (i.e. to the C docs) -- today I happened to be
talking to the `rustdoc` maintainers about this old idea of ours.

Cheers,
Miguel


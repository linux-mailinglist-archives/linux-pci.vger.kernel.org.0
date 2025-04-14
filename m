Return-Path: <linux-pci+bounces-25856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C96A88A7C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEE7A67CA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9E1A4E9D;
	Mon, 14 Apr 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdhHuxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053D19CC0A;
	Mon, 14 Apr 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653459; cv=none; b=t8B3J6ASymPDD57fQP5vfaOY/P+Qw1pAn2FcZ/D//GNcR/W3jMBNJb+JlIQr/13CIUdXP7ELoJYO0Qf2z+xdQyR+7FbjwqWIVWp9sO9IuAGpnzsaJ5Z6pFc06mZEidLbp58zAEMTJBtdQEV0zpp7XsVLD5HI2XEmOqDGOwmUCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653459; c=relaxed/simple;
	bh=bPgiMMaSLc+eDmqSe1HgWrhG1+XNyTjVIkUO8El3Ov0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxUGIOUJ6N41VMyEuRzt3liP0I/7uOwt67K5z9Rkoih/1U6awzvBP+VRDpZ3t2bHDWeK1T4TcazDtWnDozy0VDL1rjrsHpuBr9OQOcYZ5IyAqmj5Cq1hbM2LFagjbxH/6etD7qp/iUk84+Vaid0gZAj8c4ZHno/DyMh7puYRFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTdhHuxd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so832698a91.0;
        Mon, 14 Apr 2025 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744653457; x=1745258257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDLmjU5aYGkKFZNBVtYIN1e2hFVEh2qpAqVYEYhienw=;
        b=hTdhHuxdhSwDtbGcBB159Q2Fp7c09aipzhnzz4sjS5Pzaqe8YpctwO5A9UXsga1OsD
         i93ri8kIt1pe8NuLnhYdEsGie4kUskRXtw0mZ9CTJDZ0R3sQ1zLBjUyPFnvL/7xiDyig
         lV8KPjiNV1IFDWTp2kcBq4Ihk1KN7nXm5uOozsosReKVw72lz8BKu66FWAp2DSfe0+qI
         VtQMTmIW2kPHrXvfObYilXom21cUU+13nTZURH4mYMPw7cGA1+A2kzJ6ITlQPexro694
         xBlcWRaG7+FVz7OUKg7saTGJAElGNVzgQIG4zzsVYMSdsA8fWan0sjgM4L/g2Wimxd5Q
         CmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653457; x=1745258257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDLmjU5aYGkKFZNBVtYIN1e2hFVEh2qpAqVYEYhienw=;
        b=qatDCySmNJoamGqZKS1eFAbOKpm97jJIIp2u2eGq0aJnnkuSTNaZJXlhO3ZXgo7Cd7
         Tk/O3Noo54kdy5AhLOPd2RTdAw24iS/7ckweBy50BWhHyckPazmjI02o4aCKwRkszGG+
         vFzjYwfL+Z0o8/4m4QqQwjU/kHqUyTQ/dCqPsIxMvls9QTdOM5y0yey8sxwwlI+qjodM
         jWE1CUoPt2E117TJ+tvvgtAGV3uZM2msoun8RwMiddrpTT6sYrQ6R+SAaBp8amZCXil5
         HuKHdDm64xG2X6U7fq5cvIIS+4ZdqNYtaJnk7mGXkTuATf7LJ94tILJLtCpKDihyYLG0
         zwOA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMfkKvGcpcuU+hFiLxHRuUzlUGHOkNAW75gw1rRq4dLA0jg0QekBAHS1HTfWwG83BryURbzyW9NrISgY=@vger.kernel.org, AJvYcCXJG3hZz9Uoc2AXPfsHAZpoxJJgVYp06rddBWL0GQp5acOPA+bPn3QyuxJPpV3J5BlHnTCfnI2Py/T7YByQygc=@vger.kernel.org, AJvYcCXg1jLAPrFW/TDOtKH70PpjboFhCXQ5EtvBJ5QqQZHOIGTtD/flDDYm/OS/oRBnHx1XYFTVAOhIPIwn@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPNOJmx4T+YmQ+X06qxgEy/Ilcmq0zauxUifM1onrKQe2MmW5
	5rm8ovtyZmgDkfu0sbxy9dmvE0LurLsz7oz+TrKAGg0OHIS4kx3ge2Cf4/r5W7uXkC1OeEOzm9n
	cycbD8tijoY8m+x1L3GLVS9cgEeY=
X-Gm-Gg: ASbGnctU7OBXeRZ5+PsDhcq4L/y1+h2sKOzlTCXN+Vv6/89osJVzOJpY7eIjqOpT9o2
	NdKHATvumKyc9tei/4j3807IVopRHkfLD4q0ETb+SUHiXJEYvdZ128iiqImyx3k/ui1KEKoYoh9
	U/jSAf1TreQKXFMEgYWUXZuQ==
X-Google-Smtp-Source: AGHT+IF2Ts02o34q1ZddiSdxAxXqspzleZrPHKOELQW3P4amtTQc9cNxfADcwUNFlZEsEvxMFZpUTX9koDttANypnEw=
X-Received: by 2002:a17:90a:e7c1:b0:306:b593:4551 with SMTP id
 98e67ed59e1d1-30823775704mr7205617a91.6.1744653457143; Mon, 14 Apr 2025
 10:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org> <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
 <Z_1H6KkIt0YnkeLB@slm.duckdns.org> <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>
 <Z_1KR_b0KEcqF4K8@slm.duckdns.org> <Z_1Kr71BMpXPoXS5@slm.duckdns.org>
In-Reply-To: <Z_1Kr71BMpXPoXS5@slm.duckdns.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Apr 2025 19:57:24 +0200
X-Gm-Features: ATxdqUHa6RevVC4GEHkHk4oL9wvRUYrFYW64d-y3KmyUkrzC2yzmhJbVksGvOA8
Message-ID: <CANiq72nDtMKNYqxrxj6gNYaJwPzqe0U6CkSQakRrV2rDKF1ZJQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Tejun Heo <tj@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 7:49=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Miguel, now that I thought a bit about it, I probably shouldn't be applyi=
ng
> patches that I don't understand enough to tell which one depends on what.
> Can you please apply this series and the delayed_work one?

Yeah, sorry.

Tamir: I know you the "prerequisite" at the footer, but it is best to
explain what has happened in words. If I understand correctly, the
last "version" is:

    https://lore.kernel.org/all/20250409-container-of-mutness-v1-1-64f472b9=
4534@gmail.com/

Right?

Cheers,
Miguel


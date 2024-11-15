Return-Path: <linux-pci+bounces-16918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0EB9CF382
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D45281285
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6A41D79A5;
	Fri, 15 Nov 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmeIC7Vy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37631CEE9F;
	Fri, 15 Nov 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693639; cv=none; b=gfqpmcLa0VJAkP234/qJkENcSf5ndGHeGq5X83jvhHlVgkYAtYboLwYBH50rQhhe+S6Jn8EDh42Mcz3Oi458UN5mt/so/+CS+xwkhHeNpwWJvv8uKy5MhBw0sV+1RlqAyjt1sX7OL1E9kJ+b8KUDYlaEgvsSgq962cFjnHk5pCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693639; c=relaxed/simple;
	bh=HD6EHe2dtbiS7iGX242qTl9rs76EJx0ol+5Hb4GXUdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgTQTlehEkTaDwG85XaBZ0sCAwlD5ta3PQd664B+gVKPrRRNHYwaXrbu1QCnpdtHCTxSgzQYxD/a9Y1n0Pd+MPfWcwbFUWNG+g01z8EZ0wEWBdpmj/LLkRr3STG3tx7KRoqIN0b2yicldnXvCpOIrzWBdO44AyztnlvHoo7aqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmeIC7Vy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so296273a12.1;
        Fri, 15 Nov 2024 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731693637; x=1732298437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T/DTdOy6aMNB/YBpuF0zWWa9iIy4yJ/yJGqVpwd2Xk=;
        b=SmeIC7VyIeiWYTy4Ruvr8ooUMSqJqlE2qCRhT1z1x57N1NY/B+goR0nBxsAvPrTW0i
         fNUlkY6lcKGqxvJzm5f+ZMtackcyAAQFmzM0mgGfrtrYZjLTvqb5TxW24XbJwMZWEgLU
         D1kV5/dezaUwcs9wTO4staW9DdFcYT1MN/2eqbV0qSA8MFYsE7v7lcpTjnhgGbKe268Z
         /EIJ8D3H6kgy61UgkDzzsdT8evrjDfazx9JgUOq6M0E8AWz5qvaaNlnlKcwR1w/z2Ucm
         y5oJo4EYmNcaZBWgVicLKt1Fv9rB/LOd8WysaenFTo6iAIr+Zosi3MS5HO9Gv8TGcap2
         iN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693637; x=1732298437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+T/DTdOy6aMNB/YBpuF0zWWa9iIy4yJ/yJGqVpwd2Xk=;
        b=BEcUTij9iJUG8V3rjId3CtLBL+0Y6PmjD5fTxGcG5Ajtvq0v9UvuG21z0Ewt+WAUQW
         i4KvKTuwm7jh9ek8QWTLbEi/IGrutvWIEvXTLdFp95Iv7MfvlMCDnEjca0W9XmyhoU2t
         jAXs45CsQ7K1Hu5vR51QugOhTmSJzUMWrSOrWKtO1Q9Svemao0xxEPC2vOafXOROCdwp
         cFMDPGwYxblhcgKUQWX6xizT/1W9zQvrByoviI5M0whvhuadXt9LZfTOQ/eszWPaqmyL
         +syItimfuU+OWFA8zziPGyZhZnt3VcLp73r+XYxdE0sZykSYzidKASOdiVxJqCTTdHUG
         /yAg==
X-Forwarded-Encrypted: i=1; AJvYcCVyq5S/kWMy1+EHos9kzs1anYRxLVOPI6DptA0YHzx8V4dAbtAt0OdooWK/rrXTn9EMvb8beT3cGFQv2lvk@vger.kernel.org, AJvYcCW34Q7XP/uq1JZAjXhBXrf2+6m8pY9oYCr56oiwTnAP6JH/u+I0mA2tYPWGWq/1HHN3tzbDH0Y5YGk=@vger.kernel.org, AJvYcCWJQ2akKyiIh2Z2JE1XWLfWAI1oLIruDDm4xTVswv9k64ENF6GaaStFxCbWJr1ZFeDbPyzAtFX5NV9t@vger.kernel.org, AJvYcCXbC/Kjcae7tUNzuytfUajJlpRszt1nml14jhB6UK0bnvmB8mf1SbN3R6YvHcuhn1usMYYDcfnSgDMgBTQKFl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1YpttD0ysCMSx+88SEU/d2Jb76Wj8N1r8F4+0z+njFhimkjv
	6Gm/3m2lyMRokb1X0rvE1ibSeo19YJSHwQlXj2PRQTBE8qRDDaG7tEbyUDq3uSDkrnnYtFmniSI
	UXFiQnuDVzdRBAce+EiUwp9d4kcI=
X-Google-Smtp-Source: AGHT+IHBWVGgm4NH0OavgO0mYdx8/AJ/4FG/ZcgImOHvrop0lwwqASHqFDarw7Q/bv3A4lK+O8D7zvDeOzSblr0zZs8=
X-Received: by 2002:a17:902:d510:b0:20c:8ffa:7dd with SMTP id
 d9443c01a7336-211d0ec3017mr21674865ad.11.1731693636804; Fri, 15 Nov 2024
 10:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115054616.1226735-2-alistair@alistair23.me> <20241115175346.GA2045933@bhelgaas>
In-Reply-To: <20241115175346.GA2045933@bhelgaas>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Nov 2024 19:00:23 +0100
Message-ID: <CANiq72mzbZidoRZALCmO68efnigyxLf0Vv0pLYWVxD0PJPj1Vg@mail.gmail.com>
Subject: Re: [RFC 1/6] rust: bindings: Support SPDM bindings
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, lukas@wunner.de, Jonathan.Cameron@huawei.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	tmgross@umich.edu, boqun.feng@gmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, wilfred.mallawa@wdc.com, alistair23@gmail.com, 
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 6:53=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> Usually an additional #include goes in the same patch that makes use
> of the new .h file.  Maybe there's a different convention in rust/?

I think doing it in the same patch makes more sense, i.e. please feel
free to avoid a "rust: bindings: ..."-titled patch.

It is also how it has been done in the past, e.g. see commit
de6582833db0 ("rust: add firmware abstractions").

Cheers,
Miguel


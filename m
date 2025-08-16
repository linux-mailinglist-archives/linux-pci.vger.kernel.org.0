Return-Path: <linux-pci+bounces-34132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09569B28FE9
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123E917E0CF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B282FE046;
	Sat, 16 Aug 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAGmBXvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CB8632B;
	Sat, 16 Aug 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755366145; cv=none; b=s0YqVJoxh/OBLLTBefjV7urZhvyMxRKm7D0xh+ZgSevpc/aDMYGcXlHf/ikWsR3HPeqfW1h+Rw6xvL78GColRyjVfw59FsRrxyHLKMs51unO678LTvOPOA52JQbStzoBX7JyqJMzj0GiYcz3fy+hr+DYnwUuno/dbS6CdKDmnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755366145; c=relaxed/simple;
	bh=I3vMfyrtLehulT/uDIRiRDFx53H6QZHkIxJ/o80KZzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXEdLvgYwNfY9sRvwiuItTdRJpSFYRHH1ir2xPzZd28Vnn4nKpSYqzGB5NNnGaeMXNFSV4D/+n92udr7cvOxVTNS2fsp8y0G9LxS+U3HbENwvGkpVVU0TI534G/q5CxVh5QZAQNnV5fBZs3xCOZBkEgxvXhCxuHjOC6gDlkHgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAGmBXvX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4717384710so438295a12.1;
        Sat, 16 Aug 2025 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755366143; x=1755970943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3vMfyrtLehulT/uDIRiRDFx53H6QZHkIxJ/o80KZzk=;
        b=FAGmBXvX5FMvW5ZML6S1r57UszCsTt/JFPcDjijiEVPwujBMeImL1nlMiZrqsxMLpD
         fTDIi2yAhB+FdQRZYfd7k3HIvscILop4yDkBy/yUphYRSVwDXfLVsuwGG9HOpNKh/idK
         iUDC4ihAOMYsbM/zAU5li8E05AgyeuFXX07+bVTz2TtqBnHycHKdzzsyMDRpR8fElv8V
         T6FFCgeKCv9Cnf9xoD5PfpwziSi+JvObWr+PsCVD0m1jL16WRxemqX/ArS6IDuu8LMS+
         HJbxvWNY85sXzTslKrJp8IRXMdfbRZ0t7VNml3M1/t9CwPxUjf6F/pmUCyJWrr3pvqVQ
         xbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755366143; x=1755970943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3vMfyrtLehulT/uDIRiRDFx53H6QZHkIxJ/o80KZzk=;
        b=LsN1tnmz/STlVHoJ8EULIjr3XtSt0h9P5rQwFVvTWlx8Hwj6wjd2zo9+zwQvULHVwx
         GSInLbl4mYjQBxVzGNwEYi0X6REr/FrL5AxTVNHRBZ+dcmzQJ6t+y58GfcNoNdsHOHUi
         iFL3GCQ2lKBH0TsSHrVWfSaB9pn32Q2txoH9e0i73PndPYH0MUMxZhHB/iUH2Oun7u9H
         WioAtClFFXyoctZzfrpY7QsDF0qotBszqWP3TWqh7+K0KiiBt4bBVX+9KbUkZKPMOmua
         cXqBbBDwxK+4tvivyDE687y7dyHkFetIbgH2gfve2r0EWQ26H0GgQbXtGG3CJ3KvduTi
         ZOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRxAShHRMLtGiAehzylmfqTVRx/GGumNEYnJ8t4qYkCwy9hv/LQTezPeiZq9Z4u/ApzTFsNB5xPC3sHJA=@vger.kernel.org, AJvYcCWX+RgyNhcDRGUOggoDbmqd/ifFo46bStZYsCcW8X8Ldx9t4RRddoYpc4qyelmvR28k2tToSJlztnVJ8he2jTM=@vger.kernel.org, AJvYcCWidEwgj7P0TTpsdKiso945w4e/LyuPCLcOmR5t29K55N5HWDi1NxN6e6FiylLTPdOo8mHvVHc5aQra@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlQRIqp/muGI0lMxu262EkNjEN3au77BRua99mdHVOUt7Hfj8
	8YkoxXSDGqs3i5TD+sLq1jnRtrqxCucTM4XtMAI0oJ4zmPQeCk0Ph6ChW7sY3uRH20/ajvpEbxc
	sci3lT6AXh6U3+xcXLy3OUJ87rZE7NCtzQMgq
X-Gm-Gg: ASbGncsSLSpGomgLdEDkCGZZZ2qnQVjtfWDMGjRSuSVhdE0k2ND2/HKQtWtMsBFMzie
	nendTCxNiJlLUKLsqpr9zbg9cuHwK6MJxKm+REx/wxLov8D5mWmB9Kac6h++fk7j5+J95StyiGR
	tTZqVekznK65ZBfI1gpClg/sF9r9g9It463Ve1WdOTB1qdfTSCa7CZX5UX/q02AmgYpPHuE24+H
	naVszCU
X-Google-Smtp-Source: AGHT+IHlQsV4GycB52BzhRwkDRLtjvxrQ+cbXUbc74lreY2uTeXUumP5G+WHOSpEqijFuv9OQXfRvfatZunpoMoI/YQ=
X-Received: by 2002:a17:903:41c8:b0:240:58a7:892f with SMTP id
 d9443c01a7336-2446d82d032mr43565365ad.5.1755366142978; Sat, 16 Aug 2025
 10:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <jjFmLoNIrT4EPz7LdN97j6uH8O6tsBHwC7-j9YfE6wdzydDFNRGMiVFcv5GI4waWhs_jdhILALP1ObzX7GEzzQ==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com>
 <87349seqsj.fsf@t14s.mail-host-address-is-not-set> <9FDC8FB8-B8DA-4647-A602-4732EFA4CCD6@collabora.com>
In-Reply-To: <9FDC8FB8-B8DA-4647-A602-4732EFA4CCD6@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Aug 2025 19:42:11 +0200
X-Gm-Features: Ac12FXzo7tnNWESuz8OX3agPLNAOz8S4rnjLuHaovL39WDB4sOnjJj6FAgzY0QQ
Message-ID: <CANiq72nW=XuUFqOB-6XavOPXtpbkHsagEkYvcD2JfCEiopYo=Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] rust: irq: add flags module
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:24=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> This is just a way to validate the cast at build time. IMHO, regardless o=
f
> whether this can possibly trigger, it's always nice to err on the side of
> caution, specially because this type doesn't have a fixed bit width.

But this could be an `static_assert!` -- no need to use the `value`, no?

In fact, we could have this cast provided somewhere, like `.into()`,
since it will always work as expected within the kernel.

Cheers,
Miguel


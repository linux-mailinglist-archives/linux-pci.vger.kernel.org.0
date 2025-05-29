Return-Path: <linux-pci+bounces-28624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C533AC7D89
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490D31BA7F65
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A322256F;
	Thu, 29 May 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA9QiceY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E3621884B;
	Thu, 29 May 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748520027; cv=none; b=EyrodI/JXMq/zm3yFdYf/puMeAwEwSuk+HdD8C+XPGJelGgC3LiQPIZbTevP686Yr3uIx0pn0KutuZsWof/6OlnJ+wqJ4YoyHVJwQPXPRupeY7J+3mmNWAjQW6YbUDnXnW+uiJ55O1SQRvOX+7bwWGYbIp8JYFpbSp/09sW66OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748520027; c=relaxed/simple;
	bh=60FYkyD6do9p4UudiOmbEoZ1xKf8mgTv2wUpIq/BSHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hELPqV9pw0VSs+/7Hhl/LkDQbBYt8fx5P+lmlCM7xM6lDarajN8C/UbLeW1rW4a3qMQe984XBDIlFa1NO16nEYo4HV5JimUQvSk5Ak3n2jLAtd2FhEQPPUy9lEhv9jPx18j4RTLaQARzpRojU9MTw1bp7cxvHKT8oThReO1QF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA9QiceY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311f6be42f1so153016a91.0;
        Thu, 29 May 2025 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748520025; x=1749124825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60FYkyD6do9p4UudiOmbEoZ1xKf8mgTv2wUpIq/BSHo=;
        b=jA9QiceYi5qUxmtjnVnF2meNRK0tBdP8Jx/xqFnFY6XhFMwUfvu3bl0YgUh5DAExXT
         XOaTdOkp7iTkEvfluugjCCBRB2A6ATh0z9YzSFlsHJtM9M7CzT50uCW0WOxL53gmTCR4
         4lhKdAUCsdTkudBMDLZl0iu9a+LMV3hpwnJFYBKYmiEbd4uHvIXBZLI9AK2W69sjmBN3
         Zp6Z1h0j5JnDw9pWd34mAKUvIsqusQ4XNvs1IQaWOukaNE3U/822JJHwzpNsN7hSdsYx
         wfhJFabo7oUMTWAlgb9m3dDbbWRkXy3FiNT2d8GRH9gH34XezJGKCzfRiqgyRYriTSld
         nmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748520025; x=1749124825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60FYkyD6do9p4UudiOmbEoZ1xKf8mgTv2wUpIq/BSHo=;
        b=GGRm9BJ0RNAGWynU0DccWEk5Cd5LF5jxUpcOkgZikfPBcVOCdo6kOa+COTweZvzY3l
         cLRTy/EUEnWKxvq2QUjSl2iaCkHUCDxBKLQJatJJEvC8ujIpg1ObNxlSDU4wSzwXwc85
         2tLQDqZq2Dr600D+yL5g5/yZVMjN7RgGFZbkqVaFlje5e2Zb9hYjoia/F42Ndv4dcA21
         OhGOWEsU4XzbwtneN72ps8qERz50HTGgNaHd7lmNTHJ0BF//h2M83NRq1cXOYhNpdk+W
         yDYSXpRAKV6FObpqjzNxCERqsxpDJt3m7BeXU7MQFlK4lyLr3K8TL8UNbXDVQMaGH/p7
         VmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9vqoS+jSZ4DLT9Sp05xOnB2Vyr85VR40rVXicjM04Qsm5K1teylWtMMNAM3JluQ/tdyKvfjE8KP/6fng=@vger.kernel.org, AJvYcCWjUBSJ1VHxO7w7lCiwDKW/PtGUOzIxil2c8+CsdnnYbgyQ3OpAjLWrkxqXRna6JhE8zsi7W1i+kT0x7vyqXws=@vger.kernel.org, AJvYcCXfyPkJRr9xDjs3caX9PKB1PcI2o2TEj4Q+4544jjUNVcsag1RRiiY9R6wqwDyODp55dDK/sjNZ8Hp6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5d2qyw+8QLZK7IaCOlwCDjKyrXGVhCF07NxE9uciHaYGOiOM
	hu+0NSXJ8PQu9yaAUZtPeWC8PszJuTvGmoKOfj1wXn4Li8QlKAKMP4kq35jGO7sMf6zZ6tq43cI
	n/tGZVgoz+5Lp5xJD+Sry5LXL0FYS9yw=
X-Gm-Gg: ASbGncto2kBmxZ4fGdyh1EoQWK23vtM6TDJXeLeQaVOv7nmCKEqDZ78cQLajqKjv/TZ
	0jua6OWhRyq+BX17nxsUFv/Wsv98z+JNzyRfjhl2GYls7EJXSF7m/8ioNqx2HttOxHr9WVLHnvi
	vEc+CDhLBISMtbIKuXbnUSJRHmbESvf2HW
X-Google-Smtp-Source: AGHT+IF75ho/kgNnnTXuMAltdbtGZYLJZ/94+KUjiLaubj79XSsKCgqw3GVpE6j+S857NIT9CPov9gHyW/6fKcp47Kw=
X-Received: by 2002:a17:90b:4d8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-311e03a7f6amr3684332a91.0.1748520024854; Thu, 29 May 2025
 05:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
In-Reply-To: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 May 2025 14:00:12 +0200
X-Gm-Features: AX0GCFt-4gSlJ1etQ1r7td4PbY9q2MXspqbPouc-iPgb8c26SqL1WVCj3ZLqUvw
Message-ID: <CANiq72n-ccQ5D+0m1TAs64tcOJB-QtLwyru2b1NK6tCP-atyuw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:08=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
>
> A similar API change was discussed on the hrtimer series[1].
>
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3=
bf0ce6cc@kernel.org/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


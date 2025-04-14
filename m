Return-Path: <linux-pci+bounces-25850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447EA889EF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1371B1898D6D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FE28A1D2;
	Mon, 14 Apr 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzak7Bp+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEF289364;
	Mon, 14 Apr 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652107; cv=none; b=UuDOf1+TTs0NpAcJUI0mp0vDcYxr4VAcoYn9K7kifMqhMtKQj3lGmgx5Zz2zkj0Dk30nJIRCZZ5cuMZdC7S/zVESc8EI2ELbyHOwwqVxlblsFSNNAW3JPDr8Bf8o5WaIaoO5ijjzZX4/OD11WX1g4lrJLuJenWpo5t30IM3O1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652107; c=relaxed/simple;
	bh=hnCqke+KYEWsbRH+n/2MbSls4gRBzabjtFY6nYemYPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmLWL3zqpI5Qn+4Pgvxd8L7zmrULPqRooxnq5Khdj3KWYkfjhNS54nfYeR3MBJ9UwAYOzqBoDllPKMjlZ9NMAcrBKIfh+hWMZIrvxh+XyIruNzTYRUpzXH4pX88ZaHCH8m7pp6B6LggG8ocNyLtKY2ZZdmh8E04aQlX6VpClUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzak7Bp+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso862380a91.1;
        Mon, 14 Apr 2025 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744652105; x=1745256905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnCqke+KYEWsbRH+n/2MbSls4gRBzabjtFY6nYemYPA=;
        b=hzak7Bp+/kZc6lOgxhSBr9iKN6OgdAOP2bf5/flbg7CPESYI0PINgXR7baNVnidN0S
         V8LWeEbq3jWehvxnfWycxe2+4Emu85MT7rrDYfYGofuyl4A0mUYD10cUUHHAaWJR4WPu
         klmF8B+4rHAoq5DBsbbcN8TOB6MayLXWC3OoHFKhKIV5DIaAz9hX5LMYew0twJZIZS5G
         kdPA6hUEdsvA1dlzs8eHTUDmszZJHt1pZ0gMscsdSqX7csppFLBvHuG4nfWmchc+6O8Q
         YOWz/cuSuhdjHEZaOPIpfdqTNcJBs2njyP7ffoD9o8PRSsF+xvP4FIkvBhvVUTnV76x1
         Avyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652105; x=1745256905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnCqke+KYEWsbRH+n/2MbSls4gRBzabjtFY6nYemYPA=;
        b=DRt3Icmo9qj42TA4K4TqB+ZLZwIUQdbiCXmuRaP6gXsCFVvxIBbNb1XxeS1U4h77Pf
         I4kaF4kTh58V8J+4rXn5cuOZc82sikc3AsUgbE3Pb1nzW7KKTb93LAnN+eqWNrXSfh8A
         HHdkGYqXb2C5KxB89Lwe8nRo4upE0Bj4tiYMsuakfs2H0khJI4JhMuVlaRtTa2+MQ5kP
         VpDe+rjjIaBv+vw82gX6Nkpw+RN3px9xEtC0TJ2BcKEUIajJssu7rb21Z7mb4q6ajhWT
         lVkz7U0GR5KqU8q7CKdlOsutJxRjMiR/tVGctxdaobDAiVcdJbZ8vDPAVdNqQzPQtWRB
         OBbw==
X-Forwarded-Encrypted: i=1; AJvYcCWyf9gn44Q0YDqOeNXTaSC3pekAjwBXc3G2XD6Bm+VcqkG2RrE5aqwk+aIz7dJ29jkKOb7A4UcVco41@vger.kernel.org, AJvYcCXNEs+8k2aPGHtctwXyFnjpMjAAwfzLVk3foWxyig63CKVSGa2Y3irHjUYPsilhVHUkRjrD+zDR8HfLxs8=@vger.kernel.org, AJvYcCXwH7/yBJ0bD4dnNp4+KhM3MAhaUXjSKkaUBhqspo02hre7vKkFh8pK7vzB8C9wj0DpPcobTFJXzIlj1nuRJ1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59SrLJJ/VnGj54YWbNfn+ONaG0iTfpF8H9F/O0Gv3XGrPy/aS
	nK2p1uch6AYu/8QivjfbP38j3HGlzGnU/FzZmJxB3DwK643gC+ZmFy109Rn7N7aM7OBwq+KVTOJ
	MjJmAW+tdKg94H8Axx4zNsxaeuxo=
X-Gm-Gg: ASbGnct0L3viOIzt9/eEQxSsMo6BX0ADNU8VyUIBiobvwsOU5ggLHi5CafXILcOGANt
	bnAVe38L23+FNQpiLVxa2cnr+WcaulptAKf8B80CHjbpfzxSGUDwBo91re9BcTPu8VPwG2uC/Ba
	UDJkYMefnlfBPi7vy6O83sYA==
X-Google-Smtp-Source: AGHT+IEiX5HOql1Behi5jkLzmw54WU/0LI8y3MDjwTeXZWJSMxCU6ssUQq9vNwiDGP9M2/NeyvAyM0pzLPiYXq47u8g=
X-Received: by 2002:a17:90b:3b4c:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-3084e6f3e13mr420967a91.1.1744652104535; Mon, 14 Apr 2025
 10:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com> <Z_1E2z-l1xG--BSc@slm.duckdns.org>
In-Reply-To: <Z_1E2z-l1xG--BSc@slm.duckdns.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Apr 2025 19:34:51 +0200
X-Gm-Features: ATxdqUEzSxdx6sOQ3IAHBXJpdp1RewVIQEw06kaYohz9SvIiNEakVjahBYqNxIU
Message-ID: <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Tejun Heo <tj@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@gmail.com>, 
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

On Mon, Apr 14, 2025 at 7:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Please let me know how you want it routed.

If you would like to take it, then that would be nice. Otherwise, I
can also take it.

Thanks!

Cheers,
Miguel


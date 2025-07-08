Return-Path: <linux-pci+bounces-31685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173CAFCAD2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 14:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CAA561227
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC72DCF46;
	Tue,  8 Jul 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgXycVGu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C102DCC1C;
	Tue,  8 Jul 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978880; cv=none; b=PQjSXL8ZTM408+aRjh4Cp/jr4UC45XJWTfvHp3FcLxinuWpF7xG2eG/SXYGIMAdx58cZ7fvduWeSTUol0cgohZaAqnnDy/QZ5r9k/nEeLEMj5P9TDSwIdoKeCpa4iiu3Jz/Ykdk+PxfUrX6EZyQqyYfxkDaPX/L2jKnz0PnUobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978880; c=relaxed/simple;
	bh=7Qurdz4aVYMfN9sFAFacpmxMjZnnqVQebraOUXVsBCM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TFV1CFNLVSOzRSLmKWzhu8hbpq1eQnkxv0MGw1Nb+fHMUYcMZeK+K+MCYnxJ3AYTGvVdZbgEzO1HX/uf8+XYD+1hx8rRDAJrS+y5oMc1TnmuEy1NK48mlx8e5kDqjSY5dQ8TAk+SECPQmWbGwUjT5dU+GDbzH5YGUB5eguIIbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgXycVGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D4C4CEED;
	Tue,  8 Jul 2025 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978880;
	bh=7Qurdz4aVYMfN9sFAFacpmxMjZnnqVQebraOUXVsBCM=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=DgXycVGuufy7piLeRQjyhQlzrNE0hZdKp4cjBcTDxSI0NWCDN1ZtBjS8gvNllyPw2
	 9CElScLabmvEo3ghfUhW3H5IWqSGp3KwXjQRUBdsTZ6/4abQ+WF7s6cUEkC51pPFq1
	 npQ/iMFGeFA1TUPuOA5Wd56lM+9jCFfap5uLraBLtlsvAQkMLLAkTHpuV0ajbiFdXc
	 Q6PbotifxMp+FK3S60iaHDghUjwP+lNiOJNXZmwu5lxUY6e1bnLuDSwFYkG9L5iU2K
	 qQf71eINShephrna6B8zDaagVsD772CHvp4UBHD2aqZrjNAsYN7DjstembP7T0by9p
	 IcAyeGZtlcguA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 14:47:53 +0200
Message-Id: <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
Cc: <miguel.ojeda.sandonis@gmail.com>, <kuba@kernel.org>,
 <gregkh@linuxfoundation.org>, <robh@kernel.org>, <saravanak@google.com>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <rafael@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <david.m.ertman@intel.com>, <devicetree@vger.kernel.org>,
 <gary@garyguo.net>, <ira.weiny@intel.com>, <kwilczynski@kernel.org>,
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250707175350.1333bd59@kernel.org>
 <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
 <20250708.195908.2135845665984133268.fujita.tomonori@gmail.com>
In-Reply-To: <20250708.195908.2135845665984133268.fujita.tomonori@gmail.com>

On Tue Jul 8, 2025 at 12:59 PM CEST, FUJITA Tomonori wrote:
> On Tue, 8 Jul 2025 12:45:20 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
>> On Tue, Jul 8, 2025 at 2:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
>>>
>>> Does not apply to networking trees so I suspect someone else will take
>>> these:
>>>
>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>=20
>> Thanks! Happy to take it through Rust tree if that is best.
>
> This is based on Rust tree. If I remember correctly, it can't be
> applied cleanly to other trees because of Tamir's patch in Rust tree.

Had a brief look.

There will be two trivial conflicts with the driver-core tree, which fixed =
up
some of the safety comments you modify in this series as well.

The other way around, there is one trivial conflict with Tamir patch in the=
 rust
tree fixing up an `as _` cast.

So, either way works fine.


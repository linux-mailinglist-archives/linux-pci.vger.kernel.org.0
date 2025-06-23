Return-Path: <linux-pci+bounces-30396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6149AE450F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E07441680
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196F24E019;
	Mon, 23 Jun 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js8sLov/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C492F24;
	Mon, 23 Jun 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686011; cv=none; b=CN0NPFWI+FtS/k6zAjECHclq5v5bQkCjaud3LfytRlgob5RMzGHniPC/qHcDusBzCoxl4qdKhVjGYV5iO068tLGEcU4YtTb2TZIlnpSe4a6oZz/sX+Gk6gEPHeF7HbHQpKRddB8QOKNtr+I8E1FyMmCybJKLEesaQB2chQLSUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686011; c=relaxed/simple;
	bh=qnHvdmVdYs0nnag2h7hKE4fgRHvgo6WvZD5OV+POaY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DoXnYY78M8ONvTY6fHp0tvEVEN+bvv5/LTAeDp3x9EFBE0dzxrv2JU8yBs4HHdpRJiohpdiaHpevi9n0ibFvm5Bs6fD1b15t9FfIKFMB7ixXxk1uNC7cIulaZb2qpuiP2S7778OFLXzL0frE0l0YrqXtyUYkTom1M5ozLA2T+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js8sLov/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331F4C4CEF2;
	Mon, 23 Jun 2025 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750686010;
	bh=qnHvdmVdYs0nnag2h7hKE4fgRHvgo6WvZD5OV+POaY4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=js8sLov/BP9FlRMoc4tY1e0WWeYcmDQVuJVLydSzGnZ7Lh5QqJq7uW4PF33enURpr
	 qF3rg+hAfIEOZyROfJZEPFJu6vfhosqtjLEVu43zDztrBkz2IYZ1y1VOcG599M0iPS
	 wYbhN1XD0ssP3vHD1SLHyH6PNkb7bSKIMm7SuUzwggwvy5LORILxK+gO2ANYjqvupe
	 FznZvPXFMR4eQ9sq6G5aqxgnhe2qa70ga6cRVau4w5ndcZw2lDSl+ksx/A9t+Na3A4
	 wAoM6RgkP87XK6LCC5z/vPRwZ/gl9DC2r37Rpy6Y8PKw6FRujgpKwQ38v1DUWadIVT
	 3eukMSIDrkHQQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 15:40:05 +0200
Message-Id: <DATYE858ERJP.9B9NY8NPMOM2@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org> <aFlCCsvXCSJeYaFQ@google.com>
 <aFlN7W5rMRcmE300@cassiopeiae>
In-Reply-To: <aFlN7W5rMRcmE300@cassiopeiae>

On Mon Jun 23, 2025 at 2:51 PM CEST, Danilo Krummrich wrote:
> On Mon, Jun 23, 2025 at 12:01:14PM +0000, Alice Ryhl wrote:
>> On Sun, Jun 22, 2025 at 06:40:41PM +0200, Danilo Krummrich wrote:
>> > +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
>> > +where
>> > +    P: ForeignOwnable,
>> > +    for<'a> P::Borrowed<'a>: Release,
>>=20
>> I think we need where P: ForeignOwnable + 'static too.
>>=20
>> otherwise I can pass something with a reference that expires before the
>> device is unbound and access it in the devm callback as a UAF.
>
> I can't really come up with an example for such a case, mind providing on=
e? :)

    {
        let local =3D MyLocalData { /* ... */ };
        let data =3D Arc::new(Data { r: &local });
        devres::register_release(dev, data)?;
    }
    // devres still holds onto `data`, but that points at `MyLocalData`
    // which is on the stack and freed here...

---
Cheers,
Benno


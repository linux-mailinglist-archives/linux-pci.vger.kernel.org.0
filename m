Return-Path: <linux-pci+bounces-45055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77922D32D4D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E4B7302FFB4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF43358C0;
	Fri, 16 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuPVVuLI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90874283C82;
	Fri, 16 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574678; cv=none; b=StfLKQ8FPLU2/gmMt78uiXR4XddtiSHZhBLz/BrvVVbWt+Yw1Ih9mQX1XwWIA4q+z7RcMrZi09xLPjmErTIM5qvuOXKfR+HGOX4ffMZrR332hoQPdPqQoN9upulyyPG4FwsHfBKm0hbScYk6tgxopa0dRJOi+o67DQmYE9WBByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574678; c=relaxed/simple;
	bh=61fy6Mnnpx20EnlCkLTdEgNa5Ha+/Wl49x/fXuW+URA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lQ92kis/yRA2QijgSaVyeRwd/l5LL48ClXCUArHQ1n2jVU/yS4ri19J5ICk5INnUn4qT28rtIkzSQVXLRjQJaILQzIsZ1TDJoDju0AeVn7pA85HtiMWkMr8XILhwAUS873umU9xXF4K5VZNYbXGN9u/WuF+MVT8Yc6OjNm59kXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuPVVuLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB85AC16AAE;
	Fri, 16 Jan 2026 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574678;
	bh=61fy6Mnnpx20EnlCkLTdEgNa5Ha+/Wl49x/fXuW+URA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IuPVVuLI75qTWa6hTHbrFu8mtR7A0gMMMvBAShEimA/y68CRwjjJrJsGOxUL1NG9x
	 jSY4Dh9+MofdAryPMYPXlUgmZnjzdUStB7L/4Gcf2DE5miSg/VUmWDVNPJefLc/iYL
	 6OUaQU6jv24BvKwoaiCPn4XYZmA8Jn5rRsYxkcmSgevAP3ZyPabP1lceONp245PJzB
	 Otle5WQOHbo8QqLIW1qQIBiKkR14QnHGXMno0FROnUj33WYLqqaUIsi47E7r9TzL7d
	 IQHR8p/vzm0ywOmKziwZzomqJdgC3swYk1gXw7CKhFzUcLkOC4pYlba8lpkHoQqbSJ
	 wbvalAxUQSf5Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 15:44:31 +0100
Message-Id: <DFQ3EBMAI2N2.O6CY0ZGSL2JH@kernel.org>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io
 trait
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
To: "Markus Probst" <markus.probst@posteo.de>, <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260115212657.399231-1-zhiw@nvidia.com>
 <20260115212657.399231-3-zhiw@nvidia.com>
 <08956b4fe99619064a4424d500837807ba4c92e6.camel@posteo.de>
In-Reply-To: <08956b4fe99619064a4424d500837807ba4c92e6.camel@posteo.de>

On Fri Jan 16, 2026 at 2:57 PM CET, Markus Probst wrote:
> On Thu, 2026-01-15 at 23:26 +0200, Zhi Wang wrote:
> How would this work with I2C as a IO backend?
>
> I2C by itself doesn't have 32-bit IO, which the trait requires.
>
> There is
> "byte data" - 8 bit
> "word data" - 16 bit
> "block data" - arbitrary number of bytes (in SMBus limited to 32 bytes.
> Outside of SMBus it could be higher)

You can use a block data transfer to implement 32bit.

> Note that I only require "byte data" for my led driver.

That's fine, not ever driver has to make use of all capabilities.

However, eventually we want to be able to use regmap to implement I/O backe=
nds.
For this it could actually become necessary to have separate traits for 8, =
16
and 32 bit. But I think this is out of scope for this series, let's leave t=
hat
to a subsequent series. We can always split them up when necessary.


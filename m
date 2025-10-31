Return-Path: <linux-pci+bounces-39925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FFC25146
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF534D8B4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5007183088;
	Fri, 31 Oct 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPRsw+hx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7E3F9FB;
	Fri, 31 Oct 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914796; cv=none; b=p+SKN3KQVwmyc4RVAef2x0O5G29Ua0sCpmit0sTTDbB6RcpRZ/unbeMbgNV4EZlzwP54wYfaBkW/optpKQxYVJh0tWYShR/0KkzylPACR3+aIv57elH3vZn+R7+6dtvcqC7ERugLbzBWDeWkWEErTN/QfApR4g0/dnkHBLLUhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914796; c=relaxed/simple;
	bh=VvHbEhqP4vrrRtNq8/jm4qCTNHw3PAK7ds5gnC1tL0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XxaLjfdl5eJEKZ5yd4EuTshdimkPWB98mnwLPUOZV+2EOevx9whRk+FORArOEDmCXbBkBEjNhK7plsKG5xfvLE+HDuLLj+o6JIP3EU9RGXZzDuQ1/HxdOZ337UrZSw3iFsqy8gm48ryVc/7OygDF8otpEbl4KnQfw9samciUFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPRsw+hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3362CC4CEE7;
	Fri, 31 Oct 2025 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761914796;
	bh=VvHbEhqP4vrrRtNq8/jm4qCTNHw3PAK7ds5gnC1tL0k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IPRsw+hxmv9zPYcK1RRTEsNyW4ERl/lvUKF3SM0t/rpZuqY3YzdxFwBu9tBlA38D3
	 Nmf1+/hxjVCl7CNwNxqLztrbMQj0Yfo0Z+ePE6ADYI3x6FD+7xWhLwVRpLQ75dJFBw
	 Qk6ma3wPPC/eGtialLau5OjzQcZoIkcPDlZH9Pr6ffCeOYOang5zd1gCq2nBJ0Tt1F
	 YWVfFl87VxC+xTxpOR/Kcdg/Yhpc5qu0IP8EitOffQxdIrq7kri5jo0+NkXxgp8rOB
	 x0GKZMsWIoasBIWz472JLYCCPvNktUfCTxF/HL2G14YmM8ldhW2YIMAuPDckAe6o5k
	 0PcTRkozwLKeQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 13:46:28 +0100
Message-Id: <DDWINZJUGVQ8.POKS7A6ZSRFK@kernel.org>
Subject: Re: [PATCH v3 3/5] rust: pci: add a helper to query configuration
 space size
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030154842.450518-4-zhiw@nvidia.com>
 <20251030165115.GA1636169@bhelgaas>
 <20251031141611.669c5380.zhiw@nvidia.com>
In-Reply-To: <20251031141611.669c5380.zhiw@nvidia.com>

On Fri Oct 31, 2025 at 1:16 PM CET, Zhi Wang wrote:
> On Thu, 30 Oct 2025 11:51:15 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>> Apart from pci-sysfs and vfio, I don't really see any drivers that use
>> pdev->cfg_size today.
>
> It is for the framework so far. If we believe that driver doesn't need
> this in the near term, I can make it private in the next re-spin.

Device::cfg_size() should indeed be private, I don't see a reason for drive=
rs to
call this directly.

However, enum ConfigSpaceSize has to be public, such that we can implement =
a
method:

	pub fn config_space<'a, const SIZE: usize>(&'a self) -> Result<ConfigSpace=
<'a, SIZE>>

so the driver can assert whether it requires the normal or extended
configuration space size with e.g.:

	// Fails if the configuration space does not have an extended size.
	let cfg =3D pdev.config_space::<ConfigSpaceSize::Extended>()?;

Subsequently, we can do infallible accesses within the corresponding guaran=
teed
range.

Given that there are only two options, normal or extended, we can also drop=
 the
const generic and just provide two separate methods:

	pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, ConfigSpaceSiz=
e::Normal>>

and

	pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Confi=
gSpaceSize::Extended>>

Allowing drivers to request a ConfigSpace<'a, 0> with only runtime checks m=
akes
no sense, ConfigSpaceSize::Normal is always the minimum.

- Danilo


Return-Path: <linux-pci+bounces-40524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9493DC3C7DC
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B91618962F5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809434888A;
	Thu,  6 Nov 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH1JpBbk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950F21A447;
	Thu,  6 Nov 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446648; cv=none; b=uZ417Z2kk/4BGS4NunszAt4VQdwz3/c4LDfZgn+q0VCSq6z3+onW1WOFF8yqqVGsrm9W5thiw5IDG+1r4KWFCS7jtLFYi/6m/1TZF93zKldQDTU1MpllODcvcrj+wlMNrjeWJv10ymHclqLq9u458tDnNy1PC3tUmV+Gyt1ZsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446648; c=relaxed/simple;
	bh=2NTUHWqf1qau7veU3PKoiP154ztHLX5ZmfnSdksBHic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlgkdvGlbTVC1HKnpSCTRAAihUUKtvDWsy3gTzNulNLNgL3PGmZ6jbws+/OZHrT4oeN/vBs7Y6gb/fRsDnih557jID+3xmSDdpHdrWux/leABgdcN760aeQkWjU1HvrdrqrkgfKE26nW+kFzjgoNYfvta2/VagQTw7TpBakKTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH1JpBbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D0FC4CEFB;
	Thu,  6 Nov 2025 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446645;
	bh=2NTUHWqf1qau7veU3PKoiP154ztHLX5ZmfnSdksBHic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dH1JpBbkZtmxABwSsWHd1QeVGJUmK1heuJAc7RAIsl4kdfE7dzGmhQ7MR9TIUWpvN
	 30UqsyeOEEJ1JsJoYcwK8wKD+8bxlMqygzmzQpNx3Cgi/IQe0o5B9EskYi9smW4N4f
	 LSxLpHz72HPdiTQVaeAE5Q9yZrrDtfxwT3llA+UdTGiWYiavIJKuKObYHwTHru1zCW
	 ENf/uIW0jjpqcOgDizSV8RxARPFrWLkbEHnAol93LHIPa26mf1JtSjzEJcfUzrkyNn
	 Fag6Lk1I1ygnoGE6bUtS+MVtQM7kK59DaieoJO5c6nyIPYB5mCLgBT98+lzSX4LEgo
	 995u0ZFyhNDjQ==
Message-ID: <d6b4df47-87f7-480b-b837-0835b8df54fb@kernel.org>
Date: Thu, 6 Nov 2025 17:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] rust: pci: add config space read/write support
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com,
 smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com,
 joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
References: <20251106102753.2976-1-zhiw@nvidia.com>
 <20251106102753.2976-7-zhiw@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106102753.2976-7-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>  impl Device<device::Core> {
> @@ -441,6 +480,20 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_exteneded<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }

Please implement them for Device<Bound> rather than Device<Core>. Also, the
methods seem to be infallible, hence no need to return a Result.

> +/// Represents the PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space). The actual size is obtained
> +/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
> +pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
> +    pub(crate) pdev: &'a Device<device::Core>,

/Core/Bound/


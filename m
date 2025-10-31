Return-Path: <linux-pci+bounces-39926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A1C2516A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C863A6F87
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342E1E834F;
	Fri, 31 Oct 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBqFIu8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FB1A23B6;
	Fri, 31 Oct 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914929; cv=none; b=LiMTvVjN6f3/iPi8l2i3XiWqaobNlq34cKSgpL9JpkIiCEMwcRwvwG5RaSfzJf2RvGCxS41AjqTkHnGHVIxwbaIeRvEPrTtyrNu52VlkxU847puv27It1D/uuLUTkMU1cVqQTpozfNu1Zi35RaNElJTUq4FziZUjfguEo5Xj0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914929; c=relaxed/simple;
	bh=qJZZbyHsXGInSaxUw1uSFmkVRHGNpqvQTdMgquB7srU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NnBOTOWg5Ld8NaVzaGUMDYCVF/ShMzHSH5V1HOLUtMy3+LQkAbpFZ9doxlKdtm2WxAr7ssmHOh8SaqHAcIaW7WYlSro0f0jmSD8A/z9WxKkenIqVXbcpAnjldVICbPK/XzIJBisQLvA8mjyqGxngykGkkBIoeYwQXUl1d91vlcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBqFIu8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8341C4CEE7;
	Fri, 31 Oct 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761914927;
	bh=qJZZbyHsXGInSaxUw1uSFmkVRHGNpqvQTdMgquB7srU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mBqFIu8WiJWXPBpSurmGzYSyFhByUUCnEU76WOIUz5aj12MtcvbdsmiwnMRINjKHS
	 sExKaZNFDEf6EmKVmjZMCi1/dfVvCH1kB0g+kAGMBnIqcHCKXAd3NdnKLyrxPqMXlX
	 y4vWKKTyaGx3CFPU4uZkb84/zOFyjHX5LFGSzyfGau2pyuVEoUpHlw4/WL1MTS1sH5
	 QUVy2qc3wfpYHqOETxU4Vn8qfLqR490UY2Bn93ipBUPBzbgZ1DeAoKTdswx6lAr2vI
	 S1PvV47Id3rzo41d2IvmGTDJ+tqcgJZWwNUldr4nB9utjkDeYUgyqZ6eghVSc0NWoF
	 q2vf7MBXDNQbg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 13:48:41 +0100
Message-Id: <DDWIPOOIN5X6.3EJE6QNXV61PX@kernel.org>
Subject: Re: [PATCH v3 4/5] rust: pci: add config space read/write support
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030154842.450518-1-zhiw@nvidia.com>
 <20251030154842.450518-5-zhiw@nvidia.com>
In-Reply-To: <20251030154842.450518-5-zhiw@nvidia.com>

On Thu Oct 30, 2025 at 4:48 PM CET, Zhi Wang wrote:
> +impl<'a, const SIZE: usize> Io<SIZE> for ConfigSpace<'a, SIZE> {
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.pdev.cfg_size().map_or(0, |v| v as usize)
> +    }
> +
> +    define_read!(fallible, try_read8, call_config_read, pci_read_config_=
byte -> u8);
> +    define_read!(fallible, try_read16, call_config_read, pci_read_config=
_word -> u16);
> +    define_read!(fallible, try_read32, call_config_read, pci_read_config=
_dword -> u32);
> +
> +    define_write!(fallible, try_write8, call_config_write, pci_write_con=
fig_byte <- u8);
> +    define_write!(fallible, try_write16, call_config_write, pci_write_co=
nfig_word <- u16);
> +    define_write!(fallible, try_write32, call_config_write, pci_write_co=
nfig_dword <- u32);
> +}

Please also implement the infallible ones.

> +
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
>  /// # Invariants
> @@ -615,6 +670,11 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }

Please see [1].

[1] https://lore.kernel.org/lkml/DDWINZJUGVQ8.POKS7A6ZSRFK@kernel.org/


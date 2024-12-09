Return-Path: <linux-pci+bounces-17916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510AD9E90B9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD7916384A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDC21764B;
	Mon,  9 Dec 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkHQAPky"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE16217643;
	Mon,  9 Dec 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741069; cv=none; b=bVOS+dWWVYwjM6ckctSh0/S2AuQsFP6S3Qmou9zQh46UITpU7F+oFrem69srrLInhUhpOVR78ud3Lq4tu6+y9B5JV3nq5yLug+QeYtsy7jck4gq69U0GfPj2cPnKP12QLGYKSGvjkdcgVXBD0FlCOi49ec60hsNFpprsMQIZV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741069; c=relaxed/simple;
	bh=RDbbth+yBn5BvjrE9s3O5WT4459T0tfMcTs5CZI6T3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=losHxgKzEX0ZdlLh/Lb8qYmPXGK+wJqoWXeiOgxZeNXPOT5Jl2qctLeZkfjNXNCZ5gUZDcpiScsQF9jmWlMht1CZp47hxzg/fO7YoueWx5LMjamV27Dd0o1InafDgyL96l439Pug9Xu4IvjHB/FJV/LXEXwLBf/rhGOky2AHkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkHQAPky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACA8C4CEDE;
	Mon,  9 Dec 2024 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733741068;
	bh=RDbbth+yBn5BvjrE9s3O5WT4459T0tfMcTs5CZI6T3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkHQAPky5XFsoEhxxhzvx4NQA4Zi03nZwRA5vXjG/THm/vSuGVc2Y+rTvyR+TxxBl
	 TZbLyLj5i+VRaHLSiu87xSBX0wr/F3BSQDkXibfS8S27TNOcB2zAgWUeNufoimxlSk
	 ZgPUXplgwv6DtbVfkWr/dsiySw7Wi8vOhVw2m+Qh1iI186omzL+2tRX43ppYeVBWw4
	 V03GQIxvznpTm8bgNzb8FnxyTzIjETkUDUepvb234vV5uLoiQJkHNFrxFyv7DUBbtk
	 cBHKd+oNpwAaeUYQt58uMhiHhSXlXmrAFitMfgmOwOmzbWhlU/Q/7LpCaK81We3Xfc
	 KIb43Y7d+nUCQ==
Date: Mon, 9 Dec 2024 11:44:19 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <Z1bKA5efDYxd8sTC@pollux.localdomain>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>

On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Implement the basic PCI abstractions required to write a basic PCI
> > driver. This includes the following data structures:
> >
> > The `pci::Driver` trait represents the interface to the driver and
> > provides `pci::Driver::probe` for the driver to implement.
> >
> > The `pci::Device` abstraction represents a `struct pci_dev` and provides
> > abstractions for common functions, such as `pci::Device::set_master`.
> >
> > In order to provide the PCI specific parts to a generic
> > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > by `pci::Adapter`.
> >
> > `pci::DeviceId` implements PCI device IDs based on the generic
> > `device_id::RawDevceId` abstraction.
> >
> > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> > +/// The PCI device representation.
> > +///
> > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > +/// device, hence, also increments the base device' reference count.
> > +#[derive(Clone)]
> > +pub struct Device(ARef<device::Device>);
> 
> It seems more natural for this to be a wrapper around
> `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> ARef<Device> depending on whether you want to hold a refcount or not.

Yeah, but then every bus device has to re-implement the refcount dance we
already have in `device::Device` for the underlying base `struct device`.

I forgot to mention this in my previous reply to Boqun, but we even documented
it this way in `device::Device` [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/device.rs#n28

> 
> Alice
> 
> > +impl Device {
> > +    /// Create a PCI Device instance from an existing `device::Device`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
> > +    /// a `bindings::pci_dev`.
> > +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> > +        Self(dev)
> > +    }
> > +
> > +    fn as_raw(&self) -> *mut bindings::pci_dev {
> > +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
> > +        // embedded in `struct pci_dev`.
> > +        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
> > +    }
> > +
> > +    /// Enable memory resources for this device.
> > +    pub fn enable_device_mem(&self) -> Result {
> > +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> > +        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> > +    }
> > +
> > +    /// Enable bus-mastering for this device.
> > +    pub fn set_master(&self) {
> > +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> > +        unsafe { bindings::pci_set_master(self.as_raw()) };
> > +    }
> > +}
> > +
> > +impl AsRef<device::Device> for Device {
> > +    fn as_ref(&self) -> &device::Device {
> > +        &self.0
> > +    }
> > +}
> > --
> > 2.47.0
> >


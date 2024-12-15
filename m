Return-Path: <linux-pci+bounces-18457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82B9F23AE
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 13:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DBA1656EC
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C621547C0;
	Sun, 15 Dec 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kIJiwKGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A331A89;
	Sun, 15 Dec 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265407; cv=none; b=JO4PnGSl23airO1iGQNWxPwzeYhTJMP2qceAq1U+LdFXqive8lWEWNukZE4s9WGflAp24Ww0Z993GibRbS9Bb+QPR+o773/Gg36eisWt+nKfes/Tzzvdmbr5vEYGZHETTL+BQEsTblf4YQ0E2kwXvluBwAm81xh/anplYRUafOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265407; c=relaxed/simple;
	bh=6sWA6RD6sI21HgaJ9Py54d9y+hSF7rcUUntCASvIJY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au8mX3eQ9iyTX0BrCxzlj0g2fdYE1cL4YksCRrF0UMOS55vOjVKnlwVZYDMm8iMSiiHomktByaDDM78+nIrGSTzCYSoHgEEpjbIy5O124NLwjBB2x3RCQtsA9w7XzGdWXZQTM3GFRyOR6b3FSaFSW7bnJY21FcyiQRfrO34TIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kIJiwKGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B5C4CECE;
	Sun, 15 Dec 2024 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734265405;
	bh=6sWA6RD6sI21HgaJ9Py54d9y+hSF7rcUUntCASvIJY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIJiwKGxB+LozKxA21ZaFJ9b0OWQhSKP+M9QtDRxaKPR/zNmOT7YUZhv5tdqZ0xE1
	 YsHAzOpJEiRojaXZhrLU+SDt17ITfmyelo17kKka8q4tuFIO+NCNMB7zF2c8b44PvU
	 jp8ouSbGo/eZgHMYTTcV1bynooRylb9a5YtEee1I=
Date: Sun, 15 Dec 2024 13:23:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v6 09/16] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <2024121520-groove-outshine-f7f4@gregkh>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-10-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212163357.35934-10-dakr@kernel.org>

On Thu, Dec 12, 2024 at 05:33:40PM +0100, Danilo Krummrich wrote:
> +impl DeviceId {
> +    const PCI_ANY_ID: u32 = !0;
> +
> +    /// PCI_DEVICE macro.
> +    pub const fn new(vendor: u32, device: u32) -> Self {
> +        Self(bindings::pci_device_id {
> +            vendor,
> +            device,
> +            subvendor: DeviceId::PCI_ANY_ID,
> +            subdevice: DeviceId::PCI_ANY_ID,
> +            class: 0,
> +            class_mask: 0,
> +            driver_data: 0,
> +            override_only: 0,
> +        })
> +    }
> +
> +    /// PCI_DEVICE_CLASS macro.
> +    pub const fn with_class(class: u32, class_mask: u32) -> Self {

I know naming is hard, and I'm not going to object to this at all, but
using "new()" and "with_class()" feels a bit odd and mis-matched.  How
about spelling it out, pci_device(), and pci_device_class()?

Anyway, not a bit deal at all, let's see how this plays out with real
drivers and we can always change it later.

> +// Allow drivers R/O access to the fields of `pci_device_id`; should we prefer accessor functions
> +// to void exposing C structure fields?

Minor nit, do you mean "to avoid exposing..."?

Other than these, this looks good!  If I can get an ack from the PCI
maintainer, I'll be glad to queue these up in my driver core tree...

thanks,

greg k-h


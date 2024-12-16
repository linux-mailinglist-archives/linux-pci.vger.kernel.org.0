Return-Path: <linux-pci+bounces-18524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0A9F35E8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BC7162916
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826F1531F9;
	Mon, 16 Dec 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrtMqtii"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F491494CF;
	Mon, 16 Dec 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366307; cv=none; b=ij8nygzo85/Iz+aJ5lLsiakKNWnatMgyjI+ABovkiO+L/53UAwmQVHNXhR5o/sGa1ag1ua7ZH1KjP+kf0UQft7R46w+1+pf7G26Vk+Hg6xf+3zhg4j/dQaVfdITx8ekUMgRzxd6+baYHIxJsG98V6bUqIE7WMf4bALIhYklp1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366307; c=relaxed/simple;
	bh=AfpiH03Dwq5jbe1qk/9fAEbmREGRRVXzD/kHrF1vMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs4drUqZbNiVtA35kq29OeWX0pvgaWj89W9f3F7sUCn0H3vqGLOV/eP0H210Iavtq9/JA+Oz5s51Q5fm6BZInUSkFhqUjwey03mCY1H/kMmcFHV3rjPNnAgl5ZSDcRj05r/9tnkRWbQi/LcDdSp+n339jootqMOg5vfVvKVFov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrtMqtii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E0C4CED0;
	Mon, 16 Dec 2024 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366305;
	bh=AfpiH03Dwq5jbe1qk/9fAEbmREGRRVXzD/kHrF1vMS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrtMqtii2r/jJfFjw5RU+XqWBH1jbTWtbRTOSAhsf2wwjv9vKCkxfE7+4UeQtkz2q
	 hqhvU7BZtC4wFlt6hsR9ujR27r3N2bR4dBI11NzsSw0ufwdkBFY8iKDedMZiUYRqQc
	 WdR09DkTjBs5B/ZPIXvuX8QhJjeIAFN16YRg7+PuyGtoDQuWuv7bhHJQqVIiNU1Vtr
	 cJZEIEGN4eDD3KY3xGkEIJ+HHqd+GGMDW3nNHmfEfeHHp6C7zpEDVEC6i3B+BSSlBc
	 qE32cDpBcfTX6VtsftjgBtDiaowmRzNeA7TEDWPuhGmYXQQxzapR+idgCy1iGHuPTY
	 POgfoHLbBckqg==
Date: Mon, 16 Dec 2024 17:24:57 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <Z2BUWSdxDU6S5mtr@pollux.localdomain>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-10-dakr@kernel.org>
 <2024121520-groove-outshine-f7f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121520-groove-outshine-f7f4@gregkh>

On Sun, Dec 15, 2024 at 01:23:22PM +0100, Greg KH wrote:
> On Thu, Dec 12, 2024 at 05:33:40PM +0100, Danilo Krummrich wrote:
> > +impl DeviceId {
> > +    const PCI_ANY_ID: u32 = !0;
> > +
> > +    /// PCI_DEVICE macro.
> > +    pub const fn new(vendor: u32, device: u32) -> Self {
> > +        Self(bindings::pci_device_id {
> > +            vendor,
> > +            device,
> > +            subvendor: DeviceId::PCI_ANY_ID,
> > +            subdevice: DeviceId::PCI_ANY_ID,
> > +            class: 0,
> > +            class_mask: 0,
> > +            driver_data: 0,
> > +            override_only: 0,
> > +        })
> > +    }
> > +
> > +    /// PCI_DEVICE_CLASS macro.
> > +    pub const fn with_class(class: u32, class_mask: u32) -> Self {
> 
> I know naming is hard, and I'm not going to object to this at all, but
> using "new()" and "with_class()" feels a bit odd and mis-matched.  How
> about spelling it out, pci_device(), and pci_device_class()?

This is likely being call with module prefix, i.e. `pci::DeviceId::new`, so I'd
rather not encode "pci" again.

Maybe `pci::DeviceId::from_id` and `pci::DeviceId::from_class`?

> 
> Anyway, not a bit deal at all, let's see how this plays out with real
> drivers and we can always change it later.
> 
> > +// Allow drivers R/O access to the fields of `pci_device_id`; should we prefer accessor functions
> > +// to void exposing C structure fields?
> 
> Minor nit, do you mean "to avoid exposing..."?

Yes, but I don't think we need this comment any longer, now that we do not pass
this to probe() any longer. I'll remove the `Deref` impl.

> 
> Other than these, this looks good!  If I can get an ack from the PCI
> maintainer, I'll be glad to queue these up in my driver core tree...

Sounds good!

> 
> thanks,
> 
> greg k-h


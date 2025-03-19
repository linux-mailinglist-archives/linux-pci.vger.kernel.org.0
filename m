Return-Path: <linux-pci+bounces-24150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6AA69753
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B85D42784F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B9207A2C;
	Wed, 19 Mar 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qBYLy7sn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC41DF996;
	Wed, 19 Mar 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407040; cv=none; b=qcnx9WaUIIH/PWeaE3ngEvQQPFcOwDGoFMDBxy7kcoR9aSw0UbvzTufHJo7rguqQQ0mmALpOGZs+8S5ncY88l0wpobGneQ93eyWZ+x/lEAYW4Y6lPF1G9oVBe6NZ0zEJGCoXZ3RjrImMc51X4OZWKuE4BMsV09ky379P8fesVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407040; c=relaxed/simple;
	bh=x/hWcu7hfGNMhMcXsuOe2hPqkjtVovgGKFse7OI9onY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOijYX20jMUmt2A5vijUs7d5axnegGqZ/X6pV68kGy9vZ9NqKstejIRvYwEMK0NkBwi7UJfq/GnuII8Ur/CDKcR/e5oZajFEJC+ajHr9sMhLOYBaj3eEMlMkcsWArSY8S1MH2FvGpeXLE5bC0YLvgA31eFZoZP1w8Lg5GNIocxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qBYLy7sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FDC4CEE4;
	Wed, 19 Mar 2025 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742407038;
	bh=x/hWcu7hfGNMhMcXsuOe2hPqkjtVovgGKFse7OI9onY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBYLy7sn/IUoHj3YtwIbjzLk/w5aSov6AnOGf5SPYY3L7a8BBfBU2l8TNmAICt3wh
	 PBJSRG8BtJhCrkJsZFrog9DGcL3NKCi62g/mlenJGW0GfQ6fQLuUExpyp+nMRi8K0B
	 efQ7+N9kGJrTLBOkaRDr3nHaxIGPL+d7PqFbFqwI=
Date: Wed, 19 Mar 2025 10:55:59 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: require Send for Driver trait implementers
Message-ID: <2025031938-dismiss-specked-a590@gregkh>
References: <20250319145350.69543-1-dakr@kernel.org>
 <2025031914-knelt-coffee-8821@gregkh>
 <Z9r6sUYPOajnkiHD@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r6sUYPOajnkiHD@cassiopeiae>

On Wed, Mar 19, 2025 at 06:11:13PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 10:03:49AM -0700, Greg KH wrote:
> > On Wed, Mar 19, 2025 at 03:52:55PM +0100, Danilo Krummrich wrote:
> > > The instance of Self, returned and created by Driver::probe() is
> > > dropped in the bus' remove() callback.
> > > 
> > > Request implementers of the Driver trait to implement Send, since the
> > > remove() callback is not guaranteed to run from the same thread as
> > > probe().
> > > 
> > > Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> > > Reported-by: Alice Ryhl <aliceryhl@google.com>
> > > Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/pci.rs | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > As there's no in-kernel users of these, any objection for me to take
> > them for 6.15-rc1, or should they go now to Linus for 6.14-final?
> 
> I think it's fine to take them for 6.15-rc1 only.
> 
> --
> 
> Note that, while those patches can be taken "as is" to stable trees, they
> require
> 
> 	rust: platform: impl Send + Sync for platform::Device
> 	rust: pci: impl Send + Sync for pci::Device
> 
> as well, if
> 
> 	7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> 	4d320e30ee04 ("rust: platform: fix unrestricted &mut platform::Device")
> 
> are in the same tree.

Cool, I'll deal with that in a few weeks when -rc1 is out, thanks for
the warning.

greg k-h


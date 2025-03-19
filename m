Return-Path: <linux-pci+bounces-24147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F9A6960F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E283817A299
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046F1E3DCD;
	Wed, 19 Mar 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XArfv0PW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151301AAC4;
	Wed, 19 Mar 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404279; cv=none; b=EG564gwAkx8rcW8HzmXSaaI17sWIQE0tIGCfDtBxGoIAHGUwxH447NLOtnt1KI7qiuK2dpU4YI2WqE+xvcW2Ea9tPaPt22oB9S9SViwJ+lRNl2tEaq7EO1461YaYmYKEwexMUUL3tDqStpaPo6EEiplsSvQ8++Ytx2zFPbBM8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404279; c=relaxed/simple;
	bh=GMp7LMG2il8B0IyAgcjhCSz5w3px7FVm2W9ov08nXrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJt+Gqd2Bv8J6Bl41EtUKE7anbFfnJCCB01QWC/xR5fDwzEz3W08EdRZe6EgjaNcrb+xx0ciMRgMJUZHSrefkU+qhd3QbM9mCkCpscZusNxcjdaJQTn7egmvLnlTLaewwyQJteAg9wKqC8M6e4U6HmJ9RDHwOK8dCqN6k8U9dfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XArfv0PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB6CC4CEE8;
	Wed, 19 Mar 2025 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404278;
	bh=GMp7LMG2il8B0IyAgcjhCSz5w3px7FVm2W9ov08nXrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XArfv0PWOLsGYP/039RLwSeB5Cbcey/tZmGCF7iB8BCQP45bLt9s8pFxrU2ZbydmZ
	 nM2OSg5xdvTeegXFH1PTBkz+K4wYHxCX8t5OJv2g0dL2JcsAvrFaiFS1AAHltOsV9U
	 +CFg0pB0xygx7sRwhgqxSEJJy6T/5sR3FbZiRolHEZIDUYv3ZRiSe4zVauYbBkLm5Y
	 nkvs3LqBA+XFwkKgXHeiEO0KRaw1sbFeR2bV70ckL8y61LHYQYSVVDr1kxxylZIPWn
	 gJWzutSUkZWEg8aGNDIp0Kf4Y9OXK6sKcQMMiwelOvC2c8pcQhdKRn3p150jTZ+8rc
	 WioyPyhfHNv4w==
Date: Wed, 19 Mar 2025 18:11:13 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: require Send for Driver trait implementers
Message-ID: <Z9r6sUYPOajnkiHD@cassiopeiae>
References: <20250319145350.69543-1-dakr@kernel.org>
 <2025031914-knelt-coffee-8821@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031914-knelt-coffee-8821@gregkh>

On Wed, Mar 19, 2025 at 10:03:49AM -0700, Greg KH wrote:
> On Wed, Mar 19, 2025 at 03:52:55PM +0100, Danilo Krummrich wrote:
> > The instance of Self, returned and created by Driver::probe() is
> > dropped in the bus' remove() callback.
> > 
> > Request implementers of the Driver trait to implement Send, since the
> > remove() callback is not guaranteed to run from the same thread as
> > probe().
> > 
> > Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> > Reported-by: Alice Ryhl <aliceryhl@google.com>
> > Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/pci.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> As there's no in-kernel users of these, any objection for me to take
> them for 6.15-rc1, or should they go now to Linus for 6.14-final?

I think it's fine to take them for 6.15-rc1 only.

--

Note that, while those patches can be taken "as is" to stable trees, they
require

	rust: platform: impl Send + Sync for platform::Device
	rust: pci: impl Send + Sync for pci::Device

as well, if

	7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
	4d320e30ee04 ("rust: platform: fix unrestricted &mut platform::Device")

are in the same tree.


Return-Path: <linux-pci+bounces-42915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E783ECB42DA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 23:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5002F30D0EAF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963472D3A70;
	Wed, 10 Dec 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="QaD2TaZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D9284686
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407085; cv=none; b=uJwt9x+XWblwVXkbYPMJrozyc7xshvFRZoEJUJi2jzRsnuRtO+DppccL8T94PuqKxQCl2/Y/rDn9jWPjBXKw0Di35Pzwj9IYpVwNBuH76BeKd2tAfEk/oGDDqbOTdQXZFmP1DMjbGnKRQcrjyN6guoqsYAJihlFR2cCOIotcU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407085; c=relaxed/simple;
	bh=gLZFd0X3P8YbqJjv7prlihyxrq1Bm8MnG4Rhz+JPNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY86EIOPr824LMlWM21d1ItfdRe6w+O/MF93GEPb1WoZAmP5O146D5kSsNwi3X/SMgxoywuAF/hSncMWumUVYXP2tSO6MXukkEX2xGZvO9G28vskE/kB/Cszurc9DX7BKTSOVb2XTIgDlfkDfQAusy1h+Vvl/PBb2df2LKjw95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=QaD2TaZh; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dRWD12Ggzz1vB;
	Wed, 10 Dec 2025 23:51:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1765407073; bh=BwZcPkwxeUAPL1DWDSRbquoxF+EJnKJ1r4hZeUQymzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaD2TaZhg0TFtupyfZM5xCP4WsywzUEHpzzBsYYPiXYZ/m3s0/IbmQhdF5xuMHtwd
	 6hG6fqOqqVtSgQR4FIT5qaOacumxNSStIqR8J9JSl7ArDdXEgwuku8HaLJe917eAUl
	 iRnKXRUjv+qpqzxJUA9EcbCe+43w/1iE7+UtrHoI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dRWCz43vVzwVg;
	Wed, 10 Dec 2025 23:51:11 +0100 (CET)
Date: Wed, 10 Dec 2025 23:51:10 +0100
From: Ewan CHORYNSKI <ewan.chorynski@ik.me>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@gmail.com, dakr@kernel.org, 
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, alex@shazbot.org, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com, 
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com, 
	zhiwang@kernel.org
Subject: Re: [RFC 2/7] [!UPSTREAM] rust: pci: support configuration space
 access
Message-ID: <h5pp4aqaglql5gak2ni7pw2jrcuecjaog3fmeu72p4kbcn6vgf@pzfiofsvoxe3>
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-3-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206124208.305963-3-zhiw@nvidia.com>
Feedback-ID: :67b9f1ba44ebda2:ham:e74197f626dda86
X-Infomaniak-Routing: alpha

On Sat, Dec 06, 2025 at 12:42:03PM +0000, Zhi Wang wrote:
> +    /// Find the extended capability
> +    pub fn find_ext_capability(&self, cap: i32) -> Option<u16> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
> +        let offset = unsafe { bindings::pci_find_ext_capability(self.as_raw(), cap) };
> +        if offset != 0 {
> +            Some(offset as u16)
> +        } else {
> +            None
> +        }
> +    }

This is a good candidate to use `Option<NonZeroU16>` for the return
type as you don't expect Some(0) to be valid. It will also enable niche
optimisation for the Option. The whole if statement can even be replaced
by `NonZeroU16::new(offset as 16)` which return an option directly.


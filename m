Return-Path: <linux-pci+bounces-23597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECECA5F110
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592C43BA5F3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC8262D2B;
	Thu, 13 Mar 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg/z8ohw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3B25FA25;
	Thu, 13 Mar 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862466; cv=none; b=JrLhgj+7FLLxHrCPfsUH7A4wXIVzf0Zv67ePA6AJJn9urPLHIvDQbsspRRLkrP1BtZ0BGC5bqWhYkwTdZGdE4rU2qB46if69vAm+L3Cah0+WBNdBAIEPCBal/opsGkZRDnYgTIqKYCIXp2AANI5nvoJp7lUVa63w5GATi50awo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862466; c=relaxed/simple;
	bh=A10PaF7SMYGMs3Gp/it3dF15h0gkDON52e3DjkxQH0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5n88HV0r1XJjUOrXDBysM+eTdBZ18NXkiQPqgmSXbPn5muaIn8sP/vQqvnxQA+UwYfJPVVJJriQMfezqtgiNQ0kve+lfhxO2MLaC0lNMG028WOFKFtJoylWpVu2zIkNWzmPS7h+RVmDaPvDvEwclxHISVtgrwjrpFdpbM1Qy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg/z8ohw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E81AC4CEDD;
	Thu, 13 Mar 2025 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862465;
	bh=A10PaF7SMYGMs3Gp/it3dF15h0gkDON52e3DjkxQH0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zg/z8ohwPjuM7X+cqGI203Ti1jcueE4TnNQiuZ3HRxzHfw0J4+UBq3uE4NowqK7dp
	 Bo4A2l/0Tjo1hQaYxZ7RJf/Qp19p5gGIcpxUgkJyOAfFDrvgO2JywhAkM7ILwHv4Sn
	 dXGVxd3pU4SrSt1Ry59T2okruy9ri3ThjBuSacbvH85hzM+X9T1pfHDAqwDhvkyloX
	 tT3049WazKopHrLD2eEFGe2UxGLr4sqOgv4T43bGpuomueiM0+05akDEXnGTuZrdTS
	 ftJwukDTHYZh+9PurYycWiTtL0bpjMKRly/7Jy++5mS80fmiLrYYPv64a/jJRwrm5x
	 09/me4xe0g2NQ==
Date: Thu, 13 Mar 2025 11:41:00 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <Z9K2PJEoymuhamT-@pollux>
References: <20250313021550.133041-1-dakr@kernel.org>
 <20250313021550.133041-3-dakr@kernel.org>
 <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>

On Thu, Mar 13, 2025 at 10:29:35AM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> > +/// Marker trait for the context of a bus specific device.
> > +///
> > +/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
> > +/// callbacks, such as `probe()`.
> > +///
> > +/// This is the marker trait for structures representing the context of a bus specific device.
> > +pub trait DeviceContext {}
> 
> I would make this trait sealed. ie:
> 
>     pub trait DeviceContext: private::Sealed {}
>     
>     mod private {
>         pub trait Sealed {}
> 
>         impl Sealed for super::Core {}
>         impl Sealed for super::Normal {}
>     }
> 
> Since currently a user can create a custom context (it will be useless,
> but then I think it still is better to give them a compile error).

That is intentional, some busses have bus specific callbacks, hence we may want
a bus specific context at some point.

However, we can always change visibility as needed, so I'm fine making it sealed
for now.

> 
> If you make it sealed,
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>


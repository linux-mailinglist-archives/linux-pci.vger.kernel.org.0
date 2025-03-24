Return-Path: <linux-pci+bounces-24547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1185FA6E026
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E206F16BE8A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7D263C8A;
	Mon, 24 Mar 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Z6IMN+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069052620C3;
	Mon, 24 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834963; cv=none; b=a4R/VVjTVjiNxm6IrAutfdtUmNkRzS+NuHRQnj84vH9FCiw7WDWJALSyXaDxvJtcUbtCRVehqHRaeAENrnIkQb0QhenSYHwGCTkvz8S0G8hNWmverDgV/m6HvnJynTeQjLFu1O+imsBkS2cm+5G5+L3gAf0kEHuwOETYrfSZa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834963; c=relaxed/simple;
	bh=KJqgtiZ5ZdlB750vGe4zUjRFX7IN6DR7LFII+F/opFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibECJvvgYOafanJWubwM291DMczISUTicgP0UUggWrseZnTrEW0K8HFtTqAIl5XtkCfd8EX7b8ZvQ4NAA4hA/7FEv+2GVqzkuvOJxcecEbZSUxDlc78oSPpbJ8Y7DJgqAlo5BbWul3QyzoXgaLO7KjYCZlXN7lP3GRE6nytWuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Z6IMN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AD2C4CEDD;
	Mon, 24 Mar 2025 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834962;
	bh=KJqgtiZ5ZdlB750vGe4zUjRFX7IN6DR7LFII+F/opFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1Z6IMN+gzcXp78xjN9Nz7rDBrBS1QswNCk7WK8ESxNOrWujJyeza3GcQrTfIf37S
	 2lelpI7YanKBeKFlRvkThrBaXOYvrJohirHQvR9RfHWbIn/zNzD0io7b71eJnkps+d
	 uHe0awWqgGx0aL5BHfwu8JPwsqPTs5f1TbsnFqJiqTRKJ2rXA2S+dnV3aKxCou0W2b
	 foXKV0Jh20xLNCLiWr9DOMTsQxiFjBLhGv+iv9Cu3ON9cPLizbME3C+jEZPGLcrmWE
	 IbfmxoIBr/hFklaCe37r84kuauHt8FUqXYsN68pw1l8G4GLbce7Ie7XrjED7n/YPXJ
	 Zs5f6xNLK34cA==
Date: Mon, 24 Mar 2025 17:49:16 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z-GNDE68vwhk0gaV@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-3-dakr@kernel.org>
 <2025032158-embezzle-life-8810@gregkh>
 <Z96MrGQvpVrFqWYJ@pollux>
 <Z-CG01QzSJjp46ad@pollux>
 <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me>

On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
> >> > Along these lines, if you can convince me that this is something that we
> >> > really should be doing, in that we should always be checking every time
> >> > someone would want to call to_pci_dev(), that the return value is
> >> > checked, then why don't we also do this in C if it's going to be
> >> > something to assure people it is going to be correct?  I don't want to
> >> > see the rust and C sides get "out of sync" here for things that can be
> >> > kept in sync, as that reduces the mental load of all of us as we travers
> >> > across the boundry for the next 20+ years.
> >> 
> >> I think in this case it is good when the C and Rust side get a bit
> >> "out of sync":
> >
> > A bit more clarification on this:
> >
> > What I want to say with this is, since we can cover a lot of the common cases
> > through abstractions and the type system, we're left with the not so common
> > ones, where the "upcasts" are not made in the context of common and well
> > established patterns, but, for instance, depend on the semantics of the driver;
> > those should not be unsafe IMHO.
> 
> I don't think that we should use `TryFrom` for stuff that should only be
> used seldomly. A function that we can document properly is a much better
> fit, since we can point users to the "correct" API.

Most of the cases where drivers would do this conversion should be covered by
the abstraction to already provide that actual bus specific device, rather than
a generic one or some priv pointer, etc.

So, the point is that the APIs we design won't leave drivers with a reason to
make this conversion in the first place. For the cases where they have to
(which should be rare), it's the right thing to do. There is not an alternative
API to point to.


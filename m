Return-Path: <linux-pci+bounces-24555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB95A6E21B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681C21889BE0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCB2638BF;
	Mon, 24 Mar 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTopPn3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99776189520;
	Mon, 24 Mar 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840001; cv=none; b=hUJrrYpFU1HTIUcPut2FAm+V7/jP6ygJhltTS3sZmw6h/1U5fEgeaiJD0cHUkWOBjIsGjPrIMI7wBa2vCIl5s3jvt7q/DWY+v578dGzorLTULZQK/zmp+uvbPYqPN3NzdfNuSHKFKBpbnr3BDE9SGxgOR9iRn2lm8vFfCiMGWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840001; c=relaxed/simple;
	bh=HxL4j75EqQZXg4nUUxuhCgYtvVucbH/8DgVWCMZjacs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+n+ycl03d+++GEcuR+ur4bddkaynnuq95dPKk4jVVf94kMkiM39qlApOJtM4NXJizhcRiqIP2434x0nRIPVDj+TRs/Tv/nZy+wlYqIWGu7HYvmyRUSI2nIc6BxeFW7Wn68uyUFqmysGYz4+bG6ftk2TfGDvc+2k6phEQXSRdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTopPn3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB14C4CEDD;
	Mon, 24 Mar 2025 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840001;
	bh=HxL4j75EqQZXg4nUUxuhCgYtvVucbH/8DgVWCMZjacs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTopPn3RAljPZx+g/g5IBXvkmaMMWchrjVzdIS5V9f1ViyUW54vubwIMO5krcXWTw
	 OZ4UKGnqeSCBtW5zqETbG8Dd0YK/R0pzIruYv/EmUdSCCtWJt0AE6MZhKtzeMEllnx
	 1nWBCPV8k4QUXdNoaR8sVG6iVYagoSnYXXLAvwanO/tUfJCAyhyTNoNjdH31isHCPD
	 TLjbvBDUkHiw89+DnTz5Lm8BjqUQ/GHT0yi9QwS5IrQ187nIIucvuA+jt99reEwYXz
	 DOQINh8mr5aC1FeTB3dIzkvg02/s7PyItJ7fxP3Penwt/LXlpHBQ9sNuszRlsJnNQ7
	 deC1Xd8wYuDnQ==
Date: Mon, 24 Mar 2025 19:13:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z-Ggu_YZBPM2Kf8J@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-3-dakr@kernel.org>
 <2025032158-embezzle-life-8810@gregkh>
 <Z96MrGQvpVrFqWYJ@pollux>
 <Z-CG01QzSJjp46ad@pollux>
 <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me>
 <Z-GNDE68vwhk0gaV@cassiopeiae>
 <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me>

On Mon, Mar 24, 2025 at 05:36:45PM +0000, Benno Lossin wrote:
> On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
> > On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
> >> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
> >> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
> >> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
> >> >> > Along these lines, if you can convince me that this is something that we
> >> >> > really should be doing, in that we should always be checking every time
> >> >> > someone would want to call to_pci_dev(), that the return value is
> >> >> > checked, then why don't we also do this in C if it's going to be
> >> >> > something to assure people it is going to be correct?  I don't want to
> >> >> > see the rust and C sides get "out of sync" here for things that can be
> >> >> > kept in sync, as that reduces the mental load of all of us as we travers
> >> >> > across the boundry for the next 20+ years.
> >> >> 
> >> >> I think in this case it is good when the C and Rust side get a bit
> >> >> "out of sync":
> >> >
> >> > A bit more clarification on this:
> >> >
> >> > What I want to say with this is, since we can cover a lot of the common cases
> >> > through abstractions and the type system, we're left with the not so common
> >> > ones, where the "upcasts" are not made in the context of common and well
> >> > established patterns, but, for instance, depend on the semantics of the driver;
> >> > those should not be unsafe IMHO.
> >> 
> >> I don't think that we should use `TryFrom` for stuff that should only be
> >> used seldomly. A function that we can document properly is a much better
> >> fit, since we can point users to the "correct" API.
> >
> > Most of the cases where drivers would do this conversion should be covered by
> > the abstraction to already provide that actual bus specific device, rather than
> > a generic one or some priv pointer, etc.
> >
> > So, the point is that the APIs we design won't leave drivers with a reason to
> > make this conversion in the first place. For the cases where they have to
> > (which should be rare), it's the right thing to do. There is not an alternative
> > API to point to.
> 
> Yes, but for such a case, I wouldn't want to use `TryFrom`, since that
> trait to me is a sign of a canonical way to convert a value.

Well, it is the canonical way to convert, it's just that by the design of other
abstractions drivers should very rarely get in the situation of needing it in
the first place.


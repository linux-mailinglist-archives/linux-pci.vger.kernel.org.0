Return-Path: <linux-pci+bounces-25853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4ADA88A52
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667B63B4693
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88B1B3929;
	Mon, 14 Apr 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQAO09BC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2019F416;
	Mon, 14 Apr 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652872; cv=none; b=DQ0hSwmVFJ7Q2SUI4G5IZYujySg9wNstuNdu6oa+zI7jrIjaSo6Tvf6wnTPakT95Ogd0kTZyaLPvJD65VdLZoI54t/RPXovYI3uc8wc/VyNph72uHBFMatHig/xQVkiCDkStBFI6bTPRHpp8DEwSU/hBC5eOcdvNoo0PMw6Nfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652872; c=relaxed/simple;
	bh=IK0QzALc3l3nTUoKpKZeFp2WTECzmtukmpBgk0s1pus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op1c4jRPj009UH0YJQGGB9jUu074Ywu6dBKUXHizOeTARwm3Y2IpWwiAurC4KDFwNUFUqIoJ3eaP41sC23c+4aStMHh9wmcFU6JjNpPkCs9zbpq4ETacdGhHi7XCHf2e2ZNWoBOoNa4Xeb43SFWKylR8tMyDjpmr3pw/kkAfYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQAO09BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6259C4CEE2;
	Mon, 14 Apr 2025 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652872;
	bh=IK0QzALc3l3nTUoKpKZeFp2WTECzmtukmpBgk0s1pus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQAO09BCQagPkBXBmg+CUVTsWDRtuyiUyuQsgVlHVB++meFe7aSxbqHVER3jTGksa
	 9BWaxhY6DKJLry+d4ixp0wgVRLIEcwvBaGEvWE0qDN5M6BvUUwd/k6a1XAPUm6QtIA
	 IjSS7p2BkRybthrJoyDtn7Q8pRAGD8+OhSVj4ekE9dMNsNb1XGnKESWl8Hmnu9iyyu
	 dNTJm0/wQpnCzRrqmvEdZfP3cIjXTx2YxuxKPxSPgV4WQXCtKF1QuTzzmOoF7QekrR
	 0KYGcw+xkCRiEruS+G/XSzhSBGeJs4ZvMSQaVELHTmiN0G7KNyp7zbltKBa2PxwqZV
	 FA2wy4sQgUblA==
Date: Mon, 14 Apr 2025 07:47:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
Message-ID: <Z_1KR_b0KEcqF4K8@slm.duckdns.org>
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org>
 <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
 <Z_1H6KkIt0YnkeLB@slm.duckdns.org>
 <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>

On Mon, Apr 14, 2025 at 01:44:31PM -0400, Tamir Duberstein wrote:
> On Mon, Apr 14, 2025 at 1:37 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Apr 14, 2025 at 07:34:51PM +0200, Miguel Ojeda wrote:
> > > On Mon, Apr 14, 2025 at 7:24 PM Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > Acked-by: Tejun Heo <tj@kernel.org>
> > > >
> > > > Please let me know how you want it routed.
> > >
> > > If you would like to take it, then that would be nice. Otherwise, I
> > > can also take it.
> >
> > Alright, applied to wq/for-6.16.
> 
> Looks like you took it without the prerequisite patch.

Ah, okay. Lemme track back and apply the prerequisite first.

Thanks.

-- 
tejun


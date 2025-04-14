Return-Path: <linux-pci+bounces-25854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E95A88A58
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0219C188DDAF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7891A3BC0;
	Mon, 14 Apr 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6OVy/qS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0681A08AB;
	Mon, 14 Apr 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652977; cv=none; b=o9pJ9M7Bmf43LQsNP/mrRltDfgsqJGe5KQYmzgkabkqUNuEkGrIPD0tGVlSaFt5cajrjl10UE06EHYcwWMxMzYv3bJ0/Z8QsBXAV6jvUpCXKS4n52vvKPaFmaqYKqUeHL2sssfzjTAhXj8IW3BodJPmyDPHRScbeLzaJSEKNEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652977; c=relaxed/simple;
	bh=BAv6bnKoYxFp/fDbax9jwlawyZZT38TQ/mRQ3RBAkxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWlWhFz05bw1qJMjDA7dTJIIGKxwm9l+WB4gpDvovf6ejva7T1xzrhKRpilMNoO1Jb82p1KDuyU1fGRulFFOmix3PoqH90SQQRPSA6cKYgF+ynm36GpZVFro4R5FDVTfDvO+BkGVRvuqYBkVhRpM/XQFUShRVwfFGL9S8P+mSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6OVy/qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5743C4CEE5;
	Mon, 14 Apr 2025 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652977;
	bh=BAv6bnKoYxFp/fDbax9jwlawyZZT38TQ/mRQ3RBAkxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6OVy/qS73Ee/pRpyrjmYICjSMlsSAiY3qtxW0OGDWClpCjqmbb5VMCJHjGmXIAOz
	 8SBQlEPqAwmBKgcmh5EB5fL/RdKfXaNXeeS2K9JvKU9H9mBHbguFhI81vENWxE/Fy4
	 9lZOf9pwWCdqn2GEYg/DinUDp5znoVrRTD9c1pixcHAT9l69plLJDy3zpktYb4tI5I
	 RdyB8z9CfZvXhVVPh71edQDkm2HyYVqgiGR7s/Tnu00KyQsO1KKw9Y0RxUB6FmLPd3
	 2Fw+p2HYsOb49/3yhlogPA09VeJ4ugON0j1w9cbPwDAWA+Ag3LwpvrRwAnj/YSVgzs
	 rRwA2BLKr2TWg==
Date: Mon, 14 Apr 2025 07:49:35 -1000
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
Message-ID: <Z_1Kr71BMpXPoXS5@slm.duckdns.org>
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org>
 <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
 <Z_1H6KkIt0YnkeLB@slm.duckdns.org>
 <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>
 <Z_1KR_b0KEcqF4K8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_1KR_b0KEcqF4K8@slm.duckdns.org>

On Mon, Apr 14, 2025 at 07:47:51AM -1000, Tejun Heo wrote:
> On Mon, Apr 14, 2025 at 01:44:31PM -0400, Tamir Duberstein wrote:
> > On Mon, Apr 14, 2025 at 1:37 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Apr 14, 2025 at 07:34:51PM +0200, Miguel Ojeda wrote:
> > > > On Mon, Apr 14, 2025 at 7:24 PM Tejun Heo <tj@kernel.org> wrote:
> > > > >
> > > > > Acked-by: Tejun Heo <tj@kernel.org>
> > > > >
> > > > > Please let me know how you want it routed.
> > > >
> > > > If you would like to take it, then that would be nice. Otherwise, I
> > > > can also take it.
> > >
> > > Alright, applied to wq/for-6.16.
> > 
> > Looks like you took it without the prerequisite patch.
> 
> Ah, okay. Lemme track back and apply the prerequisite first.

Miguel, now that I thought a bit about it, I probably shouldn't be applying
patches that I don't understand enough to tell which one depends on what.
Can you please apply this series and the delayed_work one?

Thanks.

-- 
tejun


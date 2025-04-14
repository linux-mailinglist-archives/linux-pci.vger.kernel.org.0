Return-Path: <linux-pci+bounces-25849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04639A889B3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2461894F25
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624E289364;
	Mon, 14 Apr 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqq5er2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D327B515;
	Mon, 14 Apr 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651485; cv=none; b=RiZHpFmIcG1GRCpNe+Ftjj+WIla2YCx0iLbz/heKdbLEl0ax33b997k3LnBsIA03c6OI0TFfrjF7FFsheQknuPuCgj2B7T5m2+O7lthG5SMLg4J5mOPvM9/IJNUaxOs/h4vj7YDYAsJPN72aYiUZ0NCavWnT3+Kc5am/JarE2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651485; c=relaxed/simple;
	bh=H5Pm2+Q7bzJtJE7tv/B65F4x5mQmoZc0ss9nKzM8vs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIttXHiGuk8V5vf2rfBBNc+QosyiDwV7CepqnKvCq6G6Zlrdm61VlJq84oa69RjmhwA/a2wtT6eLlxofTUdwhVAYjYA4kDRTxheyKYChrvtQZaDDdmbnPEyUd4zD+hbqen3ZuugYaTJi7JsJ5xuep4en0QvCA3BUonF97HX8q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqq5er2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD37C4CEE2;
	Mon, 14 Apr 2025 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744651485;
	bh=H5Pm2+Q7bzJtJE7tv/B65F4x5mQmoZc0ss9nKzM8vs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gqq5er2FpBAgIWyvUJHE2xuiWDWk8NKr41tFVaJfQL8r2JYMoDKYNK7+3Qf4FmlUs
	 mfmv/IsizOMnK2QSwnSgaNL7NXgKb1Ly2VxSWzTRASJobP8by/VmJiq5gmyPW4Xt6C
	 Y6Fc0Vw6UyqIANqthEypgMY4m7jmsW81w7zB61VP7ekDL57t2tdNgx+DU5+k4bTp0H
	 sSufW07OINFkfOIbZGADbPaAxao+sZ9wxGV8e8NiUBuSOcFKNkIxZbQzcRUXXY6g/Q
	 Ll9bbg/7EoEL5B8kVb9eUXgBRR4XagA+yzuro9NUUjAnGmG0L7xA9+9+Cuvv2DkehY
	 ol6uY8Exj2f3g==
Date: Mon, 14 Apr 2025 07:24:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <Z_1E2z-l1xG--BSc@slm.duckdns.org>
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>

On Fri, Apr 11, 2025 at 04:14:35PM +0200, Alice Ryhl wrote:
> On Fri, Apr 11, 2025 at 4:08 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> > the interface of `HasWork` and replacing pointer arithmetic with
> > `container_of!`. Remove the provided implementation of
> > `HasWork::get_work_offset` without replacement; an implementation is
> > already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> > `HasWork::work_container_of` which was apparently necessary to access
> > `OFFSET` as `OFFSET` no longer exists.
> >
> > A similar API change was discussed on the hrtimer series[1].
> >
> > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Tested-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> Seems reasonable enough.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please let me know how you want it routed.

Thanks.

-- 
tejun


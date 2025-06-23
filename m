Return-Path: <linux-pci+bounces-30398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7CAE456D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF041896C7D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12AB250C06;
	Mon, 23 Jun 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZewjF5E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426724DCFD;
	Mon, 23 Jun 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686594; cv=none; b=gGs29YVFc8teuzeOzJyrK4NW1OwxPlIab0Ow24sR5mZTWsodVxF9D9rEeZrzHXGntAsRp2Zhi2hQTxZBeQSwqcKiifS0YjmmNsxU2n4Y1oFRqkyIeFzUKCcVLA64sCFj68BnTprUdh9lcsWx2XWzanm9SLWE84z5O9DM97OyX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686594; c=relaxed/simple;
	bh=tFNiRzAffr71bbPsV2DOGZh7VVU+ne3AoexZ2EclchI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcg/WeYFLTcz/CKYs7sdOtwcsBH0QYKiOeVTxOtmb/omEEfBsX2LU9UKuD0WRi4FR3Alhdfp/vD+ubVQnzs4RinGnCqqQXM16TZTD+JmF6A5oFjrbxio3s5p/8E/n/lmHpU4fDgPrC49XK33kqGzDVn/t1k6ffJGGcqhpKS04VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZewjF5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEAFC4CEEA;
	Mon, 23 Jun 2025 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750686594;
	bh=tFNiRzAffr71bbPsV2DOGZh7VVU+ne3AoexZ2EclchI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZewjF5EwXbcvf/YcaF9NBIxkGTj9JRj+m6co7EBnNxW6KgWCJDlim8XPDTP7k8LZ
	 zKXcwb2rC4sx8y6BUiagEQXxQvaSHZ8hywWHwjBg0Nbs5gTahkgne/e13pEqA3OulS
	 KKyR/yaiWk3VJG/rlK9eOdh3feNpHJwXRTCHXjDU4kPyOSJCBy54lFWOhq27rJjxSG
	 ysjX92wODTzeya3rYs6RtPAc2HGFShf/cg94LZ1iIYrvVvZ3Oy012XZFitZJE8FGab
	 Nhy+N9mipFS33VFX6jhzQywxl5wa4u6SlponpQaCOK4D5px8KYgPLC3e64FxjalYIc
	 Wtwp9S2L2+eOA==
Date: Mon, 23 Jun 2025 15:49:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
Message-ID: <aFlbe5zxPsxwl3zn@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
 <aFlCCsvXCSJeYaFQ@google.com>
 <aFlN7W5rMRcmE300@cassiopeiae>
 <DATYE858ERJP.9B9NY8NPMOM2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DATYE858ERJP.9B9NY8NPMOM2@kernel.org>

On Mon, Jun 23, 2025 at 03:40:05PM +0200, Benno Lossin wrote:
> On Mon Jun 23, 2025 at 2:51 PM CEST, Danilo Krummrich wrote:
> > On Mon, Jun 23, 2025 at 12:01:14PM +0000, Alice Ryhl wrote:
> >> On Sun, Jun 22, 2025 at 06:40:41PM +0200, Danilo Krummrich wrote:
> >> > +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
> >> > +where
> >> > +    P: ForeignOwnable,
> >> > +    for<'a> P::Borrowed<'a>: Release,
> >> 
> >> I think we need where P: ForeignOwnable + 'static too.
> >> 
> >> otherwise I can pass something with a reference that expires before the
> >> device is unbound and access it in the devm callback as a UAF.
> >
> > I can't really come up with an example for such a case, mind providing one? :)
> 
>     {
>         let local = MyLocalData { /* ... */ };
>         let data = Arc::new(Data { r: &local });
>         devres::register_release(dev, data)?;
>     }
>     // devres still holds onto `data`, but that points at `MyLocalData`
>     // which is on the stack and freed here...

Thanks for providing the example, I think I slightly misunderstood. Gonna add
the corresponding lifetime bound.


Return-Path: <linux-pci+bounces-36108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C68FB56FB7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 07:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E451897F21
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BD22D4DC;
	Mon, 15 Sep 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCXURiU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F045433BC;
	Mon, 15 Sep 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757914150; cv=none; b=bXGbySxigwHZN87luH+361pcZi7fmA2hzwZI7ePHjEWS0tMTm57VSSGirkWfxmo4yseGxIf+DB+LpWGdk+nHwX/TojhHjJjD78+hmOs7ZH3krTtdywXQ0M6+2h5rqeh+ZfaZVmME4mJImTSaa3b1TDByxWkurGUZjm5GP6ruL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757914150; c=relaxed/simple;
	bh=MhofeaPPLJqfw9BqspZSA9ud67tNldeVJD726oHMPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq1LPtGgcejFak0RNr9suhqPdub9AxoKbjpclXTbDpLwu+341Z92PwlPr12JYj91QuMziVeF/yHry+G1a5jmohY8SminSEWOIWmT9yyGA7Y4FikESae+5AZS1hcM7/eNP7Ux/ok0ZwUBnj3KmAJt4osz4Vz14XrMcSlxgqqBBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCXURiU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B48C4CEF1;
	Mon, 15 Sep 2025 05:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757914150;
	bh=MhofeaPPLJqfw9BqspZSA9ud67tNldeVJD726oHMPtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCXURiU9gPdcd/BYdwAVA5eicUJA3Tkp+hsm10Vpf4Whc7KDqk0htyDVg7pgMQOpS
	 awYv42wiWuBu4ZUrOGzSZTmmDtLMZg2srfJ//aaoiO8XVWAxlDZMfSBHPqy94cFwlA
	 NA0NPDR7doBwtzaWUxOj0HmAtyNcDOM/cIFonV0i3IdUWNPrK40fro11UpTiBo+pYq
	 JFsTJ2uY7tbWUXAWhEgCT05tNBQOeOkhwWndMcZVP8WmKbvifKsnyOAD4mj+LlVEKW
	 puk97q1pRDCXhUS2jwspR5HgY+u+lZd9OMeRIPn8EsTXKyzIT7NOb2g+vHeFMjbo4t
	 hlCXW0795h1sA==
Date: Mon, 15 Sep 2025 10:59:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: pci: fix incorrect platform references in doc
 comments
Message-ID: <26oqasrlptl5v4ymfkrlznltbwqx5rfi4dworhri3msme4wlmm@cclnphvwur6r>
References: <20250913172557.19074-1-sergeantsagara@protonmail.com>
 <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>

On Sat, Sep 13, 2025 at 09:08:46PM GMT, Miguel Ojeda wrote:
> On Sat, Sep 13, 2025 at 7:26 PM Rahul Rameshbabu
> <sergeantsagara@protonmail.com> wrote:
> >
> > Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
> > Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")
> 
> These do not point to the same set of stable releases -- one cannot be
> backported to 6.16. In these cases, it is best to split the fix into
> two.
> 
> And in the one that can be, you probably want to add Cc: stable so
> that Greg's bot doesn't detect it :)
> 

Why should a spelling fix be backported to stable? The stable kernel rules
explicitly states that these kind of fixes should *not* be backported:

  - No "trivial" fixes without benefit for users (spelling changes, whitespace
    cleanups, etc).

I will suggest to Cc: <stable+noautosel@kernel.org> to make the tools skip this
patch instead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


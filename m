Return-Path: <linux-pci+bounces-31547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6DAF9A65
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 20:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66503B36C3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79F1E7C1B;
	Fri,  4 Jul 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGkiGc0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9F2E36FA;
	Fri,  4 Jul 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653051; cv=none; b=rypyoiRiYL1bAqGp2uumZ1Bcxez/BPzoNdROlxfyLwnOwtqiTC4x8DyE7jPALHERV2wwe7qQ/L16ejaX6VT0kG2g4iUxCmFFkzxk8Ou+4S2za9Y48SDL5XVuBABzj8I6nn3llDuQ41WvjEqlQwCCmdLaCj82tXpbksw6vdcJWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653051; c=relaxed/simple;
	bh=IfQKl6aK7Ji/zfyaIUYCFb1Nkjh+cT3chZs+SL9tKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Av3OmJ42tT9saOzJ8alF23IzNGwRzek5qVoYcpsrBX8AaG5QATylLuquAqmG6emfK8oYd8jM6C8b8DRD1Ru5bFWVcLwzt6oy8F3vdgUCDjWb8w6yZ+1RC6NoXoea5FNE/KgmEggFhcr+6zS7NoKcb7mfGUMQaCSkN1mxTZw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGkiGc0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6477C4CEE3;
	Fri,  4 Jul 2025 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751653050;
	bh=IfQKl6aK7Ji/zfyaIUYCFb1Nkjh+cT3chZs+SL9tKgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGkiGc0YRC40jZhEs6JyGFJyPAN3xh69cgjfAN/OA9Bw8ctJ8SHoDwot3syAGo9PY
	 gmiRxE+nCcBNKHpdUfVkXmgS1+pnGGYB8A2SJNpjZB0elsQ5cymLPSrMHivitb88/C
	 jz5V4MFa4w3RNCY2v6orW1QAHlWgR4Z8o1UOSoeCDGktM8TZ39WI7XEf/JAbGkqwn3
	 SHdsVCUQWZIDNZKnTawOkf4eVUHfVhwhWhf321Y7H2AtCu7Kdo+Scluw3mSWTg6Fqe
	 YB5CZw2+UlIGSFEWFqnXv2xY4B/wxz4ngWc8XHjvwJVdrLuM88mqd29RAd2er8dRJv
	 eTShODfP1tdLg==
Date: Fri, 4 Jul 2025 20:17:23 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] rust: platform: add irq accessors
Message-ID: <aGgas0sqnMhaUZHq@cassiopeiae>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-5-74103bdc7c52@collabora.com>
 <aGeJGw3UQ0zeFYXm@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGeJGw3UQ0zeFYXm@google.com>

On Fri, Jul 04, 2025 at 07:56:11AM +0000, Alice Ryhl wrote:
> On Thu, Jul 03, 2025 at 04:30:03PM -0300, Daniel Almeida wrote:
> > These accessors can be used to retrieve a irq::Registration and
> > irq::ThreadedRegistration from a platform device by
> > index or name. Alternatively, drivers can retrieve an IrqRequest from a
> > bound platform device for later use.
> > 
> > These accessors ensure that only valid IRQ lines can ever be registered.
> > 
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> One question below. With that answered:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> > +    /// Returns an [`IrqRequest`] for the IRQ with the given name, if any.
> > +    pub fn request_irq_by_name(&self, name: &'static CStr) -> Result<IrqRequest<'_>> {
> 
> Does the name need to be static? That's surprising - isn't it just a
> lookup that needs to be valid during this call?

The string used to lookup the irq number is only used for comparison, and hence
doesn't need to have a static lifetime.


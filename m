Return-Path: <linux-pci+bounces-31548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42291AF9A74
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B0B7B90D2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C701E7C1B;
	Fri,  4 Jul 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tviPJdqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4C2E3708;
	Fri,  4 Jul 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653182; cv=none; b=aBteuglF7QQjgLf8vXJZ/bGTOZanKlW8lGuytZC834/+3WXBEg+3SkiiLn+j6QFpiRQAXXEh0v4orw0iTfpClTAwroqm+CpMZKpEEgM9j1ueIWWcYxd0GCxPvr+P6f8JpVBA8LVDqhZGBeiLseGzblGIt1JoqcEgXoqhm1KvGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653182; c=relaxed/simple;
	bh=Ctal528Rm8m5osfyTSMtY4d/DskqcF7qs/nH2Ixjgik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh/fAScFJXvGqloEQia3Ty3b1HoypvC68aTZJlr3mnuou8qz+YqRwB3hl7uk1T20DtCvdivWjT4zGPNODpPqvAPZsINH29tNIoRq7W1/51gwmo77RtBUuKXYIWaPuhSIJxffuUvTfESNUP/9Z8YdB2sgjlmGWyjSFIuypaJpsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tviPJdqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3D5C4CEE3;
	Fri,  4 Jul 2025 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751653181;
	bh=Ctal528Rm8m5osfyTSMtY4d/DskqcF7qs/nH2Ixjgik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tviPJdqpGQzYbt0QqJDFp0/CtF/W8MyJX6vdE5IG2QDyv1+xuch0FLfFFGnEv2Qno
	 EvVVmq1jFMKyM3EApuCnuaT/I1tcs9eVZeE72TzhXEmEWo36Nb2ems5tiuZm1hYQbU
	 v/TqXzyW8koWAGSKTSg5PBkjF3CrNkefrjp6piZ71wHgBvmCQb+8wfnL/k3b8n+rw2
	 RaBia8WEtuzG4ePnutlC1zi6Rje2W7dDf+Z6VNk0i5V2Y8hobUIZf6yJp1Swz+pzxd
	 5YE9jgvvBk8ZvhXbb2qxYjDW7N/z1bTle2wTqlWVV+AGqqiS9DGqN17A6E/hc89jTp
	 xOqZib8I4821g==
Date: Fri, 4 Jul 2025 20:19:35 +0200
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
Subject: Re: [PATCH v6 6/6] rust: pci: add irq accessors
Message-ID: <aGgbNyD3ryi3uxUZ@cassiopeiae>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-6-74103bdc7c52@collabora.com>
 <aGeJSElRKa5sNGbc@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGeJSElRKa5sNGbc@google.com>

On Fri, Jul 04, 2025 at 07:56:56AM +0000, Alice Ryhl wrote:
> On Thu, Jul 03, 2025 at 04:30:04PM -0300, Daniel Almeida wrote:
> > These accessors can be used to retrieve a irq::Registration or a
> > irq::ThreadedRegistration from a pci device. Alternatively, drivers can
> > retrieve an IrqRequest from a bound PCI device for later use.
> > 
> > These accessors ensure that only valid IRQ lines can ever be registered.
> > 
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> Same question as patch 5.

Here we don't do a lookup of the IRQ number by name, yet the API asks for the
name used for the IRQ registration, hence it needs a static lifetime, since the
pointer is directly stored in struct irqaction. It's accessed by trace events
for instance.

> With that answered:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>


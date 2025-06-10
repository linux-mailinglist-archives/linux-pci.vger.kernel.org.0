Return-Path: <linux-pci+bounces-29288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECCAD30F5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32CC189349A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA4283125;
	Tue, 10 Jun 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvntSdbN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058C280A5B;
	Tue, 10 Jun 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545519; cv=none; b=IjjyBOvHEZj2cbhPEU4uVBy5lRstQLcb/UKmPBg/CUmDZrsLRfSypsKhwDqzdzdXnchWsLE7ylME0g/t1ZF374VYI4iNUBh0/Cy5nev76NgM4Lh/eeWKUwZJWHanlckbS0JMBdKfvdp6LJiNAuznGEyJ3hHYI2+U78LEFFZHnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545519; c=relaxed/simple;
	bh=tIcchOMaFNPXY9DImmRAijW7ukKxm0xP3sOuKfsKPFA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=phIWtUXstyLjrU59dofE722nVPN6gg88gAE6vNcSmusi15p6LFWFwoSiUb/OigoN8kSSOw71XTJ8TStimOpimNQHLIZvUVDys2KMOqqBkBcxmqyq3A96pTZewhtPEaPodWjpJMoRjQ6bGypHwX0rcEzJEDA4XWFZLAytyZEDS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvntSdbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F046C4CEED;
	Tue, 10 Jun 2025 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749545519;
	bh=tIcchOMaFNPXY9DImmRAijW7ukKxm0xP3sOuKfsKPFA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cvntSdbNff1bASd5hfRl8MNG0J1HiARpZLXNso8Jt84qGplr1OQxTpDtygVCXMpDc
	 VCn2LXg98IvBmHoFrt4coTZ2wQ2Nk9yApGEZ4cqlhJcM/lLxVtwvOFZ2mgpXBuc7SL
	 IS70p6LEkoPY3P6NfiwEbkvVaYFVYRNCOulDaZm8rhfajbQVN8T00Cvf+IYrUVFOPn
	 zsn8/YGGINgF8cnx6np0Y6g0Q6JH47v9AdRVVnolHDHWc/yOyOXVIrc2dIddt4/bd4
	 GCTOe+JSm+SGMkNk3srSqC52I7mKbzvUoaIlRAeflJ1BZCsFK4VwMiIoNE/RoerWBT
	 X1kNMG8EkouCA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 10:51:52 +0200
Message-Id: <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>
Cc: "Vincent Guittot" <vincent.guittot@linaro.org>,
 <linux-block@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
From: "Benno Lossin" <lossin@kernel.org>
To: "Viresh Kumar" <viresh.kumar@linaro.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Yury
 Norov" <yury.norov@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ
 Weight" <russ.weight@linux.dev>, "Nishanth Menon" <nm@ti.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.20.1
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
In-Reply-To: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>

On Tue Jun 10, 2025 at 6:37 AM CEST, Viresh Kumar wrote:
> Use a consistent `# Examples` heading in rustdoc across the codebase.
>
> Some modules previously used `## Examples` or `# Example`, which deviates
> from the preferred `# Examples` style.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/block/mq.rs  |  2 +-
>  rust/kernel/clk.rs       |  6 +++---
>  rust/kernel/configfs.rs  |  2 +-
>  rust/kernel/cpufreq.rs   |  8 ++++----
>  rust/kernel/cpumask.rs   |  4 ++--
>  rust/kernel/devres.rs    |  4 ++--
>  rust/kernel/firmware.rs  |  4 ++--
>  rust/kernel/opp.rs       | 16 ++++++++--------
>  rust/kernel/pci.rs       |  4 ++--
>  rust/kernel/platform.rs  |  2 +-
>  rust/kernel/sync.rs      |  2 +-
>  rust/kernel/workqueue.rs |  2 +-
>  rust/pin-init/src/lib.rs |  2 +-
>  13 files changed, 29 insertions(+), 29 deletions(-)


> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index 9ab34036e6bc..c5f395b44ec8 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -953,7 +953,7 @@ macro_rules! try_init {
>  /// Asserts that a field on a struct using `#[pin_data]` is marked with =
`#[pin]` ie. that it is
>  /// structurally pinned.
>  ///
> -/// # Example
> +/// # Examples
>  ///
>  /// This will succeed:
>  /// ```

@Miguel, if you take this, then:

Acked-by: Benno Lossin <lossin@kernel.org>

For such a small change I don't mind upstreaming it myself, but if
Viresh wants to have a merged GitHub PR in pin-init, then we can take it
that route.

---
Cheers,
Benno


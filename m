Return-Path: <linux-pci+bounces-36055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673BB55695
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708051D624BC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B4033471C;
	Fri, 12 Sep 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtAGk5nL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1133009F0;
	Fri, 12 Sep 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703337; cv=none; b=JFqiRF6zLSDvtvTYK5QrXQMhqw67j89/d1cIIaiYHfYcOlLM92XMp42Ymj0bubA44G9l9zCZJUxc+I9UmL0yO6SZg9FDzXAF+pnnZg1L/6bjDDW2osQ44JCzIMWAqC7fyN+UntvCGGIEBdo6lbUGsm4HBoYUlsK4mc4UDdDTPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703337; c=relaxed/simple;
	bh=aKOcvQkDHyx/TzlTNSXydXtQ/XFWj3CNb7g5yIDhkA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=gutUibXXgqD85fseX533ApPOE/vF0F//MbM9k3IHYXA8B75xFz8KVKXuNc2ilFg9cJL7REaEJPdz3LOK5RUpkYvddvt7VeouR7mssLAnK6YW4Ktp66ev/Uq/IJ6zKCs/nZ2sXNh1desljS/+iumkDnZrt9/7U+TvlFtuS3c8dCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtAGk5nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37515C4CEF4;
	Fri, 12 Sep 2025 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757703337;
	bh=aKOcvQkDHyx/TzlTNSXydXtQ/XFWj3CNb7g5yIDhkA0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=NtAGk5nLdg1mlsNxa5FbcEjJ0BNLHJG1HLdMvM1p3ax8OujVOJjwEoR8LP28vlnVv
	 3ElAFqzBp7wHHrqrX5VRw+T1Cn5GGjp1SD5g2sDB8rdX3ec+Abxa6KOckSfxtTvUnl
	 WSy5NsicuxDR8fLSWcSELyQvlp5INIzPhsQstC1GtDOm1qZXriFnVttzMmDFpZjM2k
	 h+x2+bs0wZoIDO3+0W5DiVlwWdZK3n/ZCEigWlF1JWPEfPVWPM3GL0lMwvfzdSNRLN
	 GlSYtyG0H4dfEEa/uEEsrkzzkciZoW88nDFDwvYEQE5QywsTWzQaB4jexvG5EGrFH5
	 kkRovwXl2KqMQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 20:55:31 +0200
Message-Id: <DCR1TV2BQVSH.8QHNTN9F2XG6@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [GIT PULL] Rust pin-init for v6.18
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Dirk Behme"
 <dirk.behme@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Fiona
 Behrens" <me@kloenk.dev>, "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Alban Kurti" <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20250912174148.373530-1-lossin@kernel.org>
In-Reply-To: <20250912174148.373530-1-lossin@kernel.org>

On Fri Sep 12, 2025 at 7:41 PM CEST, Benno Lossin wrote:
> Please pull for v6.18 -- thanks!

Merged into drm-rust-next, thanks!


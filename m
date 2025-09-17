Return-Path: <linux-pci+bounces-36354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADBB7F2BC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B931B1C27F32
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD82F7459;
	Wed, 17 Sep 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt1ocSff"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728113A86C;
	Wed, 17 Sep 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114564; cv=none; b=AmdMYpN6xzmHDH6hLOQxw0HQCj3ysbwDagGZFAkdyzfds/j1lf1XhWG95T0qIqDVPeIxLUPYllbGxo+JtNzGIGSEfNqOdnxF4abhCjPeyHLmLhpdZW0Unp1CpaGCVGdeO7t2VfhBcIu7X86B8Uhqjvo0XQIYhp16DD/qwWYjJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114564; c=relaxed/simple;
	bh=THnRcutZv4XiTn35j8+Xf7nTvN7EYueZZXAc3eMk/Do=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=r78k3ZaceXfqzJ5CszQZs6TR7df1PGgQVBRi3faRClo31xwFct6eLWoKS2X8uAXknPehCZ+oIORtSUDKtQzEXWcZB5xnkeL6yv8umCbQ08Z3ov5q73Dz1xDBbFinnH21LbwfnrS5HswLjZns1k0ttqhoqW9elaKeG35ysoA/o0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt1ocSff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C21C4CEF0;
	Wed, 17 Sep 2025 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758114564;
	bh=THnRcutZv4XiTn35j8+Xf7nTvN7EYueZZXAc3eMk/Do=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Vt1ocSffog79pCDHzCQy+8/Cu5JjAuZQwGttr8KNCmnXpVfifLb1igMY7BP+E2cVl
	 9hvkr7PanCFrMfKpuZ0LXGgrHBAk9EwApDf5ug/BKoo50WD5Hi/z9oBp86Nwe08fTw
	 +eoumroIizpaft4fxkNp57FF9Ajofhd+vJdH4ldaI5Y7jdmjU+MrvLLKszReRhDHK6
	 EjU5WVPaU/9rd+0HUudt+87QwhbQ+NCRUgxoxkER4QO9fhPh/cnaLdN91bW4WQWj/N
	 k0VSX7ApEQNRrAWLp1wpjVxKYbfow6ndaKg8TvElbhIIDZeL1iB+unJv7Au9PvA4Oc
	 VhAH7klNOCibw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 15:09:17 +0200
Message-Id: <DCV3LHOHVWIF.HJSQRGECQ80O@kernel.org>
Subject: Re: [PATCH] rust: pci: fix incorrect platform reference in PCI
 driver unbind doc comment
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>
To: "Rahul Rameshbabu" <sergeantsagara@protonmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250914031901.9399-1-sergeantsagara@protonmail.com>
In-Reply-To: <20250914031901.9399-1-sergeantsagara@protonmail.com>

On Sun Sep 14, 2025 at 5:19 AM CEST, Rahul Rameshbabu wrote:
> Substitute 'platform' with 'pci'.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72msM5PT2mYKrX_RPXYtA4v=
apMRO=3DiSex1gQZqiXdpvvDA@mail.gmail.com/
> Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

Applied to driver-core-testing, thanks!


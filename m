Return-Path: <linux-pci+bounces-33882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A8B23843
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06962A5267
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1A829BD9A;
	Tue, 12 Aug 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0oJD0Zf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C07244660;
	Tue, 12 Aug 2025 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026484; cv=none; b=IwfVgX12FLzebKAWw6LeJ9YSv0HBH5MfITL8UzQflxMzjKrHwVRCi09osZjJdZvHLyEYkaGget9hhKxoqkCuA5APJmKoQRp7/ETQSnb/acRzTLs5bVgDMi1OtODcMKYJldBLE1UWd9ZlpH0WHDoYF+iPT7sEz/m3adnOtnjR4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026484; c=relaxed/simple;
	bh=D+gYZj1lBSNCCwoYxhFDp8oExLhgt2+HjzzPuX6D0Dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eh8Onhv2swPezZXuMSgkpZVsEsI776rL8kypxGHRXTurMT8J7I1762eSJX/L/cFwvjixbyYQi6qAHEwqmm+h4J0zpOpE0O3bpjOV0yaAy8U1gcwsC1iznLejNHNNQ4rP5XFCQpC5aEpqf6JEZQXnRVZXZ1UahffHmXPtngZ6wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0oJD0Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B429EC4CEF0;
	Tue, 12 Aug 2025 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755026483;
	bh=D+gYZj1lBSNCCwoYxhFDp8oExLhgt2+HjzzPuX6D0Dw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=U0oJD0ZfxmgPskdra+AZU38LN3OBGgNhc/JwSepreZpGGS0TG2PzRmTXsFoVdi0ca
	 OAqEhYFoGK4ltAgg3GTjlVJwwKBUSvCcmuE6p96ZIxvLTgSt6LIUMDR+E6XgjFuPyh
	 Igr8YlNVlV+h4oUcs1/EKpkkHlXBZzaAXvGESdeirHtgo0i6uZ+9Lf8Q5dE6pAfpZO
	 1wkZ/HYK7hbR+on9K/RgCyEuk/tttcAJ2WF0lGVBdD47U75EOyaNkxK+VyZfeHTCnb
	 E79WKBwHJomQjfn/vxfOPsd0ceCBFHSha+Rpt/Rdk+xtxR5bJztqh/lyP9CzvoVpTo
	 e0V38FSQTLzwQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 21:21:17 +0200
Message-Id: <DC0OYPGIYPZA.39IG8YRUZMOTO@kernel.org>
Subject: Re: [PATCH v9 0/7] rust: add support for request_irq
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Dirk Behme" <dirk.behme@de.bosch.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com> <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org> <6B887813-8FA6-4627-9527-76547508E66A@collabora.com>
In-Reply-To: <6B887813-8FA6-4627-9527-76547508E66A@collabora.com>

On Tue Aug 12, 2025 at 9:17 PM CEST, Daniel Almeida wrote:
> How? rustfmt doesn=E2=80=99t format this, so I assume that you just manua=
lly
> wrapped the lines in a suitable way?

Yes, exactly.


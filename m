Return-Path: <linux-pci+bounces-32832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF4B0F7DB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4789F7AA3F7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9552E40B;
	Wed, 23 Jul 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWN9n8dz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841F28DB3;
	Wed, 23 Jul 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287113; cv=none; b=W0TyaubvVtvRQZ0wazoCFknVxe0D+M3Z1++gIZ967QTiV8tUU8Zjprn5a+thICRgEYd6yj7H8gOhkgc5yzyWCbPyJG474O1mWukxuTpk+4cj+x8DYSdzk2Ti2I6jPf5XzNfvIzR1Nh0L0wkghpO59lHZ6C4pC9iFUqusSMhqGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287113; c=relaxed/simple;
	bh=LFpj4X2dKTpXjHbRdCpLUblx099sg56vVdV/ouh0JkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=H+dUPYi48+j3clJLiM/7Njh+pgBgKQswy+plPoeKXwLpSU/doxoQLwNQoiJQbchwfRVfHc9GUB8eeQcEDxq5N59ftIui+vw+kRtFHFl2pDNrUPjFBPSrgk9QHrkll0YmeaJFvy3gg5rqpFohs+5aOahhFgeMM0MBiWxkw7vbTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWN9n8dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD02C4CEE7;
	Wed, 23 Jul 2025 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287112;
	bh=LFpj4X2dKTpXjHbRdCpLUblx099sg56vVdV/ouh0JkY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=FWN9n8dzHxX1MoFTg8JFrSOsvN/BF4fY52YQPFwdR0AYaX0K/9pTBySIuFlprJAJv
	 7RpG2XTKz4uE7AmZ9k+A2hw1krN4Pcv37vfNoAZ3nDUg188jEeXOk8KvRLQVs4RR+e
	 qzuM+OhSDK99T/3Px9zZ9bp3Ok55cTWm9TbEq+qrQOvvkeyPR69bGJm6yTV2OT8QPK
	 hOR1CPwMlKSFFZ45i1cz4F5swaroTnbGSg4JeLIkZbdr5dDHNHQdcx95QB8fYCf2N5
	 1AB8HRuAQV4LqPM01h8RROI+Ry+WyRBmHsT82J94FTaMQ8JerRBRs2+wp339Y9bzAE
	 FzkjJlr+leqMg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 18:11:47 +0200
Message-Id: <DBJKEPR28MY1.1ISG6JYV3ZJK7@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aIBl6JPh4MQq-0gu@tardis-2.local> <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com> <aIDxFoQV_fRLjt3h@tardis-2.local> <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com> <aIEE4Tt7xtaX-9V9@tardis-2.local> <CF821F27-7F78-4B3E-AF62-887341EAA7BE@collabora.com>
In-Reply-To: <CF821F27-7F78-4B3E-AF62-887341EAA7BE@collabora.com>

On Wed Jul 23, 2025 at 6:07 PM CEST, Daniel Almeida wrote:
> On top of that, we can use the
> words "interior mutability" somewhere in the example as well to make it e=
ven
> clearer.

You *can* have this example and I encourage it, I think it is valuable. You=
 can
have spinlock or mutex for this purpose in threaded handler, no?


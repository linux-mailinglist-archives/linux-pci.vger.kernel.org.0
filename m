Return-Path: <linux-pci+bounces-32713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA9B0D799
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6361695F5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF862E090A;
	Tue, 22 Jul 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5wo7gFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3D23814A;
	Tue, 22 Jul 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181870; cv=none; b=GQe//jTxpGWSFtB7YnjvotfXlFansQzmDLRcOezIThRJppXYNrUPjEfFqwitZobNVZwMv28VZ6deGc4iKGBYk18+ytFP2280YxR/ChWdEASW2jWquJP8rWUD1bwLPVoE1HSadMYs8M6vkdulnJVhiUuNvRH4gtq9r1daHMZ6OMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181870; c=relaxed/simple;
	bh=JCaLeIkKYK9vcbF9x+dxX58Uyp9vdXBja1Yl/fWoVKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=BihDN9qqiJUeQe9ZbAp3yyrf8sGIX+qOkQycS1ytBUwXYT+1+AlHkDkadW61wygLgmfW4mykBQzNN6Cjr3wbWCuIhkbD8HFF9pH1t+vuNS1qWMhELjktG3rTJurlCb7mkpgzL2eszLWyzI9I6eZZ1oo1lRHSWJgbfxnTGZTXt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5wo7gFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBE2C4CEEB;
	Tue, 22 Jul 2025 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753181869;
	bh=JCaLeIkKYK9vcbF9x+dxX58Uyp9vdXBja1Yl/fWoVKQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=E5wo7gFeqU5eoDBAU65ptshD7sV+bSsePDzQdltC/n2smvy1hlcz+vAmBf+7MV95G
	 IMmi9coX+O3sBMRUtC8OMphvG/jQoQppTM6cXKJKn+V2oAduANUu8ajr74yv29O7P4
	 0RyafTOhC9kjR8gyKXEdPT+JcNLuoHtyAGSJEGmtXiyCm/u6Mez6VYJL2d3mPmASEH
	 V7RoSb1EN4RyGOXX5taSRMKmsCpPq+4hbRkb02qzaQqwi6meihFzvkwQa3y2bWXIiA
	 A8Zk3rZ8HlJAifGTlSG0hKWOyW6MQ/W0lHBGX7ytRl4bwkSJdqSLQ5AprAdnIvsIO5
	 0Zcz8TEqKyx8g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 12:57:44 +0200
Message-Id: <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
 <apopple@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
In-Reply-To: <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>

On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
> I think they're good, but we're pretty late in the cycle now. That should=
 be
> fine though, we can probably take them through the nova tree, or in the w=
orst
> case share a tag, if needed.
>
> Given that, it would probably be good to add the Guarantee section on as_=
raw(),
> as proposed by Benno, right away.
>
> @Benno: Any proposal on what this section should say?

At a minimum I'd say "The returned pointer is valid.", but that doesn't
really say for what it's valid... AFAIK you're mostly using this pointer
to pass it to the C side, in that case, how about:

    /// # Guarantees
    ///
    /// The returned pointer is valid for reads and writes from the C side =
for as long as `self` exists.

Maybe we need to change it a bit more, but let's just start with this.

(If you're also using the pointer from Rust, then we need to make
changes)

---
Cheers,
Benno


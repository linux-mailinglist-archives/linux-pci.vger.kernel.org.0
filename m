Return-Path: <linux-pci+bounces-31485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BEAF84C9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 02:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF22A1C81C3C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 00:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE46D17;
	Fri,  4 Jul 2025 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSqW9n/2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852731863E;
	Fri,  4 Jul 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751588383; cv=none; b=KhgDUlyeMnq1r/RU63HeKdTg8eTB+7BgsYkKF5+6gp/H6GZQGXGlyRPL0ykHUjCW3fl2rsl7nVpRyWwTL4ejZHS4C9ZsCYiFMzCrWfJWpSsnQyKRDf6ApMiWbO90OWKCaqC2MEoBwkDfaam2S+AEQGe/8WXFNBuroAvlZ6zIcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751588383; c=relaxed/simple;
	bh=kOWoraaFaGiycuTlpCm/u/Von6eUYH3jWTREcNQSXW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL+lvHq5y7a+8qG+KnopWEYCUgb97KBNOhUWG6dTdVoMTlPzPpmZwp6vFe1/7PXohULOoYoCxgYN6H7JcpmnPgQtgse032jqzCe+liwLR1uu5Cv6IYRF5fekndJybbY7tANGgECtbBjEmpbATn6+J2Whi2/ZCSm4lh46G8DqjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSqW9n/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FADC4CEE3;
	Fri,  4 Jul 2025 00:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751588382;
	bh=kOWoraaFaGiycuTlpCm/u/Von6eUYH3jWTREcNQSXW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSqW9n/2AluchfnGubEm6sj0PQnjnRbgsjUstbI/YaxMGT1oE5pn0PjeYxD6upycZ
	 RVCITtbQ+WnTE0zlZ+gjwABtrAFMlRcGdoNw5bLuwlvFu3xnSriua5UO7aAx8yrlpQ
	 dSSfKJVS7/4sZnncwvmt2bRavYh48iEW7i88Q5HMY1gHtLsn2yb0Vx8YIKrA5ykSGD
	 XLaZJYxtbPXvLjlxsNg9AFkeiOkcTfUWKlxSaL6VxRa2Gxon358ryOAqaYGu5p4ue2
	 6dgFIDClpqpEyGc/EQsxi21/eBtopgR2F2HJAplqjX39Tfpp4iyAupaqmBwKrlAnBN
	 JeuL/zuL7E/6Q==
Date: Fri, 4 Jul 2025 02:19:34 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, robh@kernel.org, saravanak@google.com,
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	david.m.ertman@intel.com, devicetree@vger.kernel.org,
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lossin@kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v1 1/3] rust: device_id: make DRIVER_DATA_OFFSET optional
Message-ID: <aGceFtc7MUx9utaj@pollux>
References: <20250623060951.118564-1-fujita.tomonori@gmail.com>
 <20250623060951.118564-2-fujita.tomonori@gmail.com>
 <64cec618-b883-4330-b1ba-5172f7790fe3@kernel.org>
 <20250704.084159.887748101305692803.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704.084159.887748101305692803.fujita.tomonori@gmail.com>

On Fri, Jul 04, 2025 at 08:41:59AM +0900, FUJITA Tomonori wrote:
> On Fri, 4 Jul 2025 00:15:19 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > On 6/23/25 8:09 AM, FUJITA Tomonori wrote:
> >> Enable support for device ID structures that do not contain
> >> context/data field (usually named `driver_data`), making the trait
> >> usable in a wider range of subsystems and buses.
> >> Several such structures are defined in
> >> include/linux/mod_devicetable.h.
> >> This refactoring is a preparation for enabling the PHY abstractions to
> >> use device_id trait.
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > 
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> 
> Thanks a lot!
> 
> Miguel suggested that splitting the RawDeviceId trait might lead to a
> cleaner design, and I also tried that approach [v2]. But just to
> confirm ― do you prefer the original v1 approach instead?

Sorry, I didn't catch v2.

From only looking at patch 1, I indeed prefer v1.

> https://lore.kernel.org/lkml/CANiq72k0sdUoBxVYghgh50+ZRV2gbDkgVjuZgJLtj=4s9852xg@mail.gmail.com/

Looking at this reply to patch 3, I can see why Miguel suggested it though.
Given that, I think splitting the trait is the correct thing to do. I'll reply
to v2.

> [v2]: https://lore.kernel.org/rust-for-linux/20250701141252.600113-1-fujita.tomonori@gmail.com/ 
> 
> Either way works for me.
> 
> Sorry Miguel, I forgot to fix the comment typo you pointed out in v1. I'll correct it in v3.


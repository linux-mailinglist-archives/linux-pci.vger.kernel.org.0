Return-Path: <linux-pci+bounces-27625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154BAB4E28
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B353B3297
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B34C6C;
	Tue, 13 May 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHeQbiTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282691F16B;
	Tue, 13 May 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125158; cv=none; b=RWYyMaaYnM+sMb3Ih4jeB9DyCr35ic98mUJPeZ/JptjasPULBunqIDVOANU2Sg4BuVLB8LtH48nFUbjG+DElVfAU/Gh/nbwqeEv9FnLWLIpJeuk8r+WvXC6b6IYrKLNU/iPsGEVMriCRo1AmvfrtyVQHX0sG8vD3Y+2547klXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125158; c=relaxed/simple;
	bh=q70TIRrGdpp6yg967Z9NaG3C82XUVJAKivW+wfIO/tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGf8BnWvW0wjf1Ok+mwwtzEEcJZp+6nejrv3Xi59cHZ02g/rUj7UI9BI08+nA+xP07byhogmi6XfP/84S404aIBOvV8DUHNSmW/kxjJSRzb+nU4CPplEi0wjmjKZL3x3FV7CFYmxjyTNBGwKE/BHRpvL+7P36+2hAX60uC8bPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHeQbiTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ED0C4CEE4;
	Tue, 13 May 2025 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747125157;
	bh=q70TIRrGdpp6yg967Z9NaG3C82XUVJAKivW+wfIO/tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHeQbiTn5XtYLW7+AfbL65SS3DvgOAZP2K+mt25BR8fhFkeRHeTTgjYJffT4uH6MD
	 b77UFscjVwRx6Us3pQDmBq7Qlm7hmUzpyno/WePUR5mYocp+jiIy1yP822oACfAtLu
	 eCx62UP6S4ZREJAEQ7HiCyZlntpUW/XMgRyni3i5wdrSUWNVntt+xDdzT2o1L6daS7
	 gauhQEePN4NFpabmrfMTUgA604cCtWtWOunaees9Vjj+r2UpJO+mqfARF6Ns1U3d7N
	 kL+2BBL7BNr2K3gOHn7g+X3PGFF+H4q7l33pTTUohTO9YOgw/Sz0Zm513FmUv68Om8
	 b1uHeAuC4Czuw==
Date: Tue, 13 May 2025 10:32:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, akpm@linux-foundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, me@kloenk.dev,
	fujita.tomonori@gmail.com, daniel.almeida@collabora.com,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/11] rust: add support for Port io
Message-ID: <aCMDnQCcAOt28ONM@pollux>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>

Hi Andrew,

On Thu, May 08, 2025 at 10:15:13PM -0500, Andrew Ballance wrote:
> currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l, q}
> functions and have no support for port io.this is a problem for pci::Bar
> because the pointer returned by pci_iomap is expected to accessed with
> the ioread/iowrite api [0].
> 
> this patch series splits the `Io` type into `Io`, `PortIo` and `MMIo`.and,
> updates pci::Bar, as suggested in the zulip[1], so that it is generic over
> Io and, a user can optionally give a compile time hint about the type of io. 
> 
> Link: https://docs.kernel.org/6.11/driver-api/pci/pci.html#c.pci_iomap [0]
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.60IoRaw.60.20and.20.60usize.60/near/514788730 [1]
> 
> Andrew Ballance (6):
>   rust: io: add new Io type
>   rust: io: add from_raw_cookie functions
>   rust: pci: make Bar generic over Io
>   samples: rust: rust_driver_pci: update to use new bar and io api
>   gpu: nova-core: update to use the new bar and io api
>   rust: devres: fix doctest
> 
> Fiona Behrens (5):
>   rust: helpers: io: use macro to generate io accessor functions
>   rust: io: Replace Io with MMIo using IoAccess trait
>   rust: io: implement Debug for IoRaw and add some doctests
>   rust: io: add PortIo
>   io: move PIO_OFFSET to linux/io.h

Thanks for sending out the patch series.

I gave it a quick shot and the series breaks the build starting with patch 2. I
see that you have fixup commits later in the series, however in the kernel we
don't allow patches to intermediately introduce build failures, build warnings,
bugs, etc., see also [1]. You should still try to break things down logically as
good as possible.

From the current structure of your patches it seems to me that structure-wise
you should be good by going through them one by one and fix them up; your later
patches should become "noops" then. But feel free to re-organize things if you
feel that's not the best approach.

Can you please fix this up and resend right away? This should make the
subsequent review much easier.

[1] https://docs.kernel.org/process/submitting-patches.html#separate-your-changes


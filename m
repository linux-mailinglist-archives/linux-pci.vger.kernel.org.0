Return-Path: <linux-pci+bounces-25677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA0A85E78
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB647B267C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7770165F1F;
	Fri, 11 Apr 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6WMXiA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2313635E;
	Fri, 11 Apr 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377331; cv=none; b=Rx38WG1jfOt6S70aasU0RyW++/+5p0MOelXJWrThYcBLGtC8L47pVEE8bEs3CIG8AhQr+OEqkJkNBvBJ9TqL7g8Dj63FR7KTpQ/wKaQQG6ZN9G3ZIKCGiRNOz/S1baHwA5c89ClUW+RtzMhafiy91RspfnTknOf+JlVrpDWZoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377331; c=relaxed/simple;
	bh=jOsxRtN1TJjjnP2fBR8fF4lx6r/eq4aGl9Ts/nJ9mWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzaNVgeDPD/v3f8CzvHJ00R6amwH4uCeLxi36aDvRLC5CACBPpsTgWNuSNongcy5Ml40Po+Vm/lgPbBWOMFbeCW+owInkzdwXX0oI23NyTTeJj0ucEEi7Gui6gfNGZ7ANLmucHoobLFQPEuk2DVNPyTerEabnquANe+4fEYmAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6WMXiA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E876C4CEE2;
	Fri, 11 Apr 2025 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377330;
	bh=jOsxRtN1TJjjnP2fBR8fF4lx6r/eq4aGl9Ts/nJ9mWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6WMXiA7jdr0HmW0WCnxgMKfDt/ihBPt4vDT9Yp8D1zQSwnJ4dhfscL4mN48WkM4H
	 QTcImc1rfMR4zQoFkdHtaf8NTNkTI3wAxyq1N7yHPPYssB/a2CyshPnNv5u7l1vBvk
	 M8olzwhWoNPgssPF1Fj3Wrk1pC27T9yOCiPiBE3E9TwitFOdRBn98A9k8zwoFhgi7e
	 8o/ykqQJKBCdghjg+Ok/FnqZbc+2ENC3bX7dVT+qx6JH1BeK4EOxteN1KsBtCVzzQX
	 Ey9COUTWINIar0r31EK9QHS28d+58gi+e77ZBMRzbWvz+BPf7+zHnavsuN+mrqhEwi
	 k7Dt7r2fZsq0A==
Date: Fri, 11 Apr 2025 15:15:25 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rust/revocable: add try_access_with() convenience
 method
Message-ID: <Z_kV7U0IcebUfGps@cassiopeiae>
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>

On Fri, Apr 11, 2025 at 09:09:37PM +0900, Alexandre Courbot wrote:
> This is a feature I found useful to have while writing Nova driver code
> that accessed registers alongside other operations. I would find myself
> quite confused about whether the guard was held or dropped at a given
> point of the code, and it felt like walking through a minefield; this
> pattern makes things safer and easier to read according to my experience
> writing nova-core code.

Any concerns taking this through the nova tree?


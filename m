Return-Path: <linux-pci+bounces-26950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC37A9F8C3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B013460BD1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA52820D0;
	Mon, 28 Apr 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpSB3HhO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFC1C54A2;
	Mon, 28 Apr 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865681; cv=none; b=t8L6i8aaiCh//a1n8oVtC8TmOU6LGrP8D9+CZOBor9FVyQmWNiuYAYZx4crNtEy8DZ0sTH3zxXFnaEK+gI0v0MGqEI7C+S970O3IarBnSWDx6QASU2eynBBCgnR3hhnv0JVQRjmn0RT0+ib+d1hJ7PWxEeJ+3kQXNJ2tkWA8srU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865681; c=relaxed/simple;
	bh=nWe2acnllWHIKhVKOoh1bAz75wVDtkbHDF4RfotxbKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tugk7PmH5n1VlEzA/RltUe1wl8kFRQntYsSl/OUkYRqC6v8t09of/aaKBfPwz+10oSGs6n3w3Wvz5Yud8VE7dN8CB78U6Ol/SPMqqAdrfbxlxP7CHeF21OFA0LQsRuHlggK5z0bFbJy5RoP5twxjUKg9Sc+hWOT/E8oAmJ8Z/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpSB3HhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D8C4CEE4;
	Mon, 28 Apr 2025 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865680;
	bh=nWe2acnllWHIKhVKOoh1bAz75wVDtkbHDF4RfotxbKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpSB3HhOxGqAewwSrBlHYZcLHaEJxK2bgPioZh98OPHCVEneNuxYyUdwLf3zkWoOa
	 0ApNCWTiw/fbl4t7opWq2okDod4aTMorL0t2daQhXvRf/UBQMxO95ygaelqdbsNksF
	 TKj15IpAiowv244dAdyzKvhkeFI/zw+rOnKCQ8dWbWrFjngXZGD/6o2GSNvOy7Qq90
	 QdyfdeKZQD6WW950+AjgmNONFkQMyfcufQWkwgWfbxmyECmYAFfBXh7cS8REAU2iAv
	 ncgH84/IfRzAGOfxJ4AkcA1Y3Zmouu0tw6zXNikEDxsSgFXaGpWuKuwdWOk5ABF2HK
	 rMGjDKXRkZVEA==
Date: Mon, 28 Apr 2025 20:41:13 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Devres optimization with bound devices
Message-ID: <aA_LyY2UEfCwJhfb@cassiopeiae>
References: <20250428140137.468709-1-dakr@kernel.org>
 <680fbd48.050a0220.398eb0.7d07@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680fbd48.050a0220.398eb0.7d07@mx.google.com>

On Mon, Apr 28, 2025 at 10:39:17AM -0700, Boqun Feng wrote:
> On Mon, Apr 28, 2025 at 04:00:26PM +0200, Danilo Krummrich wrote:
> > This patch series implements a direct accessor for the data stored within
> > a Devres container for cases where we can prove that we own a reference
> > to a Device<Bound> (i.e. a bound device) of the same device that was used
> > to create the corresponding Devres container.
> > 
> > Usually, when accessing the data stored within a Devres container, it is
> > not clear whether the data has been revoked already due to the device
> > being unbound and, hence, we have to try whether the access is possible
> > and subsequently keep holding the RCU read lock for the duration of the
> > access.
> > 
> > However, when we can prove that we hold a reference to Device<Bound>
> > matching the device the Devres container has been created with, we can
> > guarantee that the device is not unbound for the duration of the
> > lifetime of the Device<Bound> reference and, hence, it is not possible
> > for the data within the Devres container to be revoked.
> > 
> > Therefore, in this case, we can bypass the atomic check and the RCU read
> > lock, which is a great optimization and simplification for drivers.
> > 
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> 
> You would need to, however, change the titles for patch #2 and #3
> because there is no `Devres::access_with()` any more.

Thanks, good catch! Unless we need a v3 for something else, I'll fix it when I
apply the series.


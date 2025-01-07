Return-Path: <linux-pci+bounces-19392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF472A03C6E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F29D188724F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810CF1EE01F;
	Tue,  7 Jan 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsjMiP4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F91EE00C;
	Tue,  7 Jan 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245893; cv=none; b=UrzBUUFAWUzO6aWduwYg0oaGtyyQs5X66tFt/A1BnwdCe4M3IC76o8dZW93/DfaKfi2/9OAUy2WjvQaRrUR5CfgWsq8cgeoE13PGyX6WK4bmLvLfWpWX3L4914Zvn3UJnIoHm3yjMS9FMk8tY329J3Cu+LllI7Tl0mAvY1tA2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245893; c=relaxed/simple;
	bh=TqJwOrP5/RC18dItXzFdiYNBne5B9xR5wrRICvgaqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anyQJC5Kp0pHLkuvL5izHXz+UGUhe8Y7n7N6rO7njapPnWbcbO85G4kpo2qf/iymKWSsdjuy8Chmyfe98VwS0gihjyDgZ/VxYW80yQGbqHqXgYwGjfeceoaR6FSFgVV7jpoOptpw3UbWHPLSzJXvwy6SBowzEDuSbpY8JRoM6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsjMiP4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FC5C4CEE0;
	Tue,  7 Jan 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736245890;
	bh=TqJwOrP5/RC18dItXzFdiYNBne5B9xR5wrRICvgaqwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsjMiP4tKGPHcYtKQx7T9sNDyZdvr0hhmr0vtC3CZdlfEbYo69wgl/dvbU+BtBKR+
	 SmGQHtN0QRKdQNJ+Kfo4S+0Z/NnOGRvKc+K7jycORCirJVdZEOEut9vqVN6+FAsVFK
	 GMmKNJDBNOb7ikivuoMbMRu5Vb8hzXdjJpAUKuoA=
Date: Tue, 7 Jan 2025 11:31:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, bhelgaas@google.com, fujita.tomonori@gmail.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] rust: pci: do not depend on CONFIG_PCI_MSI
Message-ID: <2025010702-bonus-afar-1565@gregkh>
References: <20250103164655.96590-1-dakr@kernel.org>
 <20250103164655.96590-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103164655.96590-2-dakr@kernel.org>

On Fri, Jan 03, 2025 at 05:46:01PM +0100, Danilo Krummrich wrote:
> The PCI abstractions do not actually depend on CONFIG_PCI_MSI; it also
> breaks drivers that only depend on CONFIG_PCI, hence drop it.
> 
> While at it, move the module entry to its correct location.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501030744.4ucqC1cB-lkp@intel.com/
> Fixes: 3a9c09193657 ("rust: pci: add basic PCI device / driver abstractions")

Where did that git id come from?  It's
1bd8b6b2c5d38d9881d59928b986eacba40f9da8.  I'll go edit it by hand...

thanks,

greg k-h


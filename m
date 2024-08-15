Return-Path: <linux-pci+bounces-11708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A79538BB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C38283E81
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6DB1B14E9;
	Thu, 15 Aug 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8wFGc3T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB319E7E8
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741530; cv=none; b=Tb0iX7r9Efcv6exEcik3qSsf0KxVoPJw8P5ILJ1/mPIAcq8gIKh4E3rFkSR7tUwUkhSxqBtP2snGLZgyyc4sNHY5cJXlJJ7UrkCDqqWfFWLhXnLWsJyRWWJZoNALg2APPiFpLmReGdU5AvbVSCDFRGFNA0mdDc55uD7lERTu9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741530; c=relaxed/simple;
	bh=xL+VP9Vq+KMUtuv1h4mwfaAjYBM7g6y7rURkeP0bUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9V3ulXwwHhZPpiWvNWbO4LcWWkr/nqXnI+7l+8DEun4VT3mgKJvqamAf9P2aKdNcOXQ55GZRPSk1fT7T9EVSo4C9YGzLZa3iZwOpfaNP8kOeok+736bydsWHEBy4iDXYEZ5Y7iSvdw6eco9el7KPvxVLq2px8cqmDyEzFAdF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8wFGc3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB916C32786;
	Thu, 15 Aug 2024 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723741530;
	bh=xL+VP9Vq+KMUtuv1h4mwfaAjYBM7g6y7rURkeP0bUn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8wFGc3TCtH92NlvPuNoCXjctdm8KiYev5rkIWO3MGW86JxXfykveG6sGDMj1I+lQ
	 5rvw/dHRQHk4/Rt+a2x1EME2IPURXjZbEQqUNztmd0EcLZZocD5cGxHqGPWZouIhib
	 7Hncz+5Go7sN40GgnuNUeK0EHQHConXnXORSoD5krJkv5XqieErlTH3GRA0qJEXj87
	 dBrmuqwpx9yybA4S0G/cMykWn//6Oxtab8xfy+Vq8QM4lz2l+tC4ucxerGpx9FjoD0
	 ov0E7NTEWlXukKtwxh7mT58NvthIW5tqxKbNwqtJ9iDm90vZf8vL8L56vafCul5LET
	 AGVqmrJ15JqBw==
Date: Thu, 15 Aug 2024 11:05:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH RFC 8/8] pci: use finer grain locking for bus protection
Message-ID: <Zr41V_Zovv48yEvS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
 <20240722151936.1452299-9-kbusch@meta.com>
 <20240815162126.00006cb7@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815162126.00006cb7@Huawei.com>

On Thu, Aug 15, 2024 at 04:21:26PM +0100, Jonathan Cameron wrote:
> > The global rescan_remove lock has deadlocks during concurrent removals
> > because it is used within interrupt handlers. Use a bus specific lock
> > instead.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Looks reasonable to me. I'm not particularly confident on this one
> so more eyes (plus testing) would be good.

Thanks for the reviews!

For the hardware I have, it is limited to x86 and I tested concurrent
pcie native hotplugs and errors with PCIe switches. I could get that to
reliably deadlock or crash before, and those are fixed with this patch
set.

But indeed, there are many more paths using this common pci code than
what I could test. I am confident about the earlier patches from this
series, but I also feel this last patch ought to be tried on a more
diversified set of platforms.


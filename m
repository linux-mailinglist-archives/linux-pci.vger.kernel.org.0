Return-Path: <linux-pci+bounces-35504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469FB44D8E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20897A06315
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC220C029;
	Fri,  5 Sep 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvZL850A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC61EE7B7;
	Fri,  5 Sep 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050278; cv=none; b=TMjZ9ka5GeqY5CapGnH6a/mjqOCKnhfG7G5nSBDYD6r4spZZ78CtmzUqTGf03QZ8isNAtfnKo5DNyfRZDFlGbs6JEvJ305UoUBYUOV/nwoj7gHbgCEV/v1WgPRDrdP5w8cKtU8OuHCpLA5qMob/nxcCKW4dxDHaZ3z2idZrMZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050278; c=relaxed/simple;
	bh=B6p92QnrwLoUhy5ItBNmZqqaK+oJcT6N691xFQLsoXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWtPTekWO5H1EfWawMQRMP+yKZJxoIPQOZURRxx/MEscJQTc0cdSv2YTnb6OKB9/fDe7Q1201xnPaRWcTWzlxvvnVdliOmUUnkYbEYX+WCUBgWttEXlO4q1FrIrXjR8LKe7xTkqsMlvt2NbOakws+ymn2/82MBhQUwwYPAV9Tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvZL850A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79655C4CEF1;
	Fri,  5 Sep 2025 05:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757050274;
	bh=B6p92QnrwLoUhy5ItBNmZqqaK+oJcT6N691xFQLsoXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvZL850AUFquP8eX/EjGcP5UvZqUgEGiGHeDBebLxx5EyAoqDu+GNWtVIfvRJ1X4f
	 CXrBE6QStd3dgp+P+Fh9Lcd5/ksWKQ4Cv9Oloh/2nsAC72yZHoYH9+VNVEY+ZEjQtq
	 Jj23eg3Q5Szo/NjlVkUUQikx2xnjr5f3IzvoaRMtt3UMq6hD8LzpybgeeMTQixmR1o
	 0+hhq8ces5yOSvBqME2V9VNV0IZWd7REciw13t/WE67MGjh/QYmfnJj4Kq/zLUM9q0
	 SHsOIuIElfABiEI5oehqWLhfBUbWpqEQZ7zGzWtH8RCtUJvnWXvslBT4JSmP/X3869
	 timn6Upki0iDA==
Date: Thu, 4 Sep 2025 22:31:14 -0700
From: Kees Cook <kees@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bhelgaas@google.com, ojeda@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de,
	dan.carpenter@linaro.org, benjamin.copeland@linaro.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] drivers/pci: Fix FIELD_PREP compilation error with gcc-8
Message-ID: <202509042228.A2332756A5@keescook>
References: <20250828101237.1359212-1-anders.roxell@linaro.org>
 <202509032125.F41E71AF19@keescook>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509032125.F41E71AF19@keescook>

On Wed, Sep 03, 2025 at 09:29:40PM -0700, Kees Cook wrote:
> Thanks for examining this! It seems rather alarming -- why did it
> work before?

I've proposed an alternative:
https://lore.kernel.org/lkml/20250905052836.work.425-kees@kernel.org/

-- 
Kees Cook


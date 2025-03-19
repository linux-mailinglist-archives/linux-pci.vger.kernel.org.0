Return-Path: <linux-pci+bounces-24169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DBA69B0D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DF77AFAD9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894C214A8D;
	Wed, 19 Mar 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOgOFqBS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E966134B0;
	Wed, 19 Mar 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420466; cv=none; b=SjbTYs/D8tlhTXuSDPxvuYD0vU7W3H0ATMGuHhxplUSyFLp/j+AodR1iA59MEzDXqQsPHPIvKEHvO5yRCKcND9DFkK1xpyXkaMEGGxOIa3bXpRqvcCqjM6fOO5ZwL1hNuwwvvO6MiGFHfyp5wFkCcMW9byVLXFyrsOFCyYesOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420466; c=relaxed/simple;
	bh=1N3HPS6GdhIWRxi5K2p0IjzZ0vZUkK5sHUaKq5AGCZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SZk8t7XZSev6DrqJ3A0PrvN+RPkKCjaAZbqRepWapyMtQ8SCITPY2O6PhqBJV/QqgQiV3EdhoJfEhnj4Al0uTNyOHn1XOnUU8wDJPhYPzY3GV8z46E9hHNSrmYt8GyWybKanrquYcZ6drkIpZg+SDuYo0a8Sqr9kQ0YjQZhrDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOgOFqBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AA4C4CEE4;
	Wed, 19 Mar 2025 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742420465;
	bh=1N3HPS6GdhIWRxi5K2p0IjzZ0vZUkK5sHUaKq5AGCZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tOgOFqBSzkwDgLvaZ7TvtEwF9CMN6qTm+VDeCJiHQmouHp2pG06HnFA0zdUrmCdd+
	 id1kELJIDUyAo9OwA+zulS5RpK+dTdCm9K83Y3z7cKJoIJ0eSsrcg/l6+s0QxeQtif
	 QRM371Dox7dB5mTXPjcz2LSt9Laf3UmemFv91W68CtalUVloPI+T37CJL9xJ3ucIhT
	 bodyHDtGyUvCd28XjSEDcT/4YGlyxp7axKyR8cgL6ciEnLX+bH+c1y3ffo9sCpvq+Y
	 bKFKJ6znIroaNs6cweiwxNj1pQXT/qLIdx+gG1XvBsURaa6WBBjY6PNBLGgpoehRZZ
	 8sJsv6YYezu2A==
Date: Wed, 19 Mar 2025 16:41:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250319214104.GA1064058@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMciSVVu6qL6QV7KqLem2ZoRoW2T5a3s13EyKE-4SFGHDFfR4g@mail.gmail.com>

On Wed, Mar 19, 2025 at 08:07:55PM +0530, Naveen Kumar P wrote:
> ...
> I am reaching out to follow up on the PCI BAR0 reset issue and its
> potential connection to the ACPI errors observed in my system running
> Linux kernel 6.13.0+.
> ...

Trying to finish up the last bits for the upcoming v6.15 merge window,
will come back to this later.

Bjorn


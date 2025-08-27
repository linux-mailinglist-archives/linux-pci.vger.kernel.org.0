Return-Path: <linux-pci+bounces-34937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63EB38A3E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692321B239CD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DF2E7F32;
	Wed, 27 Aug 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJxVAz7z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9E2E1EF8;
	Wed, 27 Aug 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323354; cv=none; b=J5mBu0x2HBdMQUf3ORHbp3jMJ+vQpQyBZkgQe69+ekabOrXE7Kfwav0sgnbdYlA4mwfTVBSB+QTbYhbRsbrGhYd2EV+GMBlexkn6HniBS940GC/su/nSFVZUzMBh3htFuwvRb4mEHoWZm+dGs40JiV/ZmQGlHiejsGyjWFgAPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323354; c=relaxed/simple;
	bh=SJr3fUSj8KlK6TPxxNCOrQqv5Fz+mjuAW5MjX7hMj3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iJsfnjHbQskCGHI1QpcVHtvDps7k87BdH1Iq1lExhLtCBybt7lx9j2GfLodtNCHo4UGluotx+ObUBSo791GfGYCJdwQDCswfRcjx1f0iz5bufNiEz/MBFU9eOLzwyli/UPVzaORoGGgJEfAphOh2Na3jaLfl0LoggcdPG6TG6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJxVAz7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1294C4CEEB;
	Wed, 27 Aug 2025 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323351;
	bh=SJr3fUSj8KlK6TPxxNCOrQqv5Fz+mjuAW5MjX7hMj3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YJxVAz7z1OicMRG7IzdbGoVbWLn5TZgnUoLbnWlrBg+MpmA02GWlh58QppVMv4tc5
	 /+O64a0EBZVh/ZkehBnE+9SOf8hSodQkGgXdL5K+udlIvAL+v+OhdrnI7KToOLlrCb
	 Ln1gSt5QwY+koOsHLR9uYoTz28jUgkOmaE43/fjkXlOXU0T4E2iIOZWnMeR40YIEwP
	 ELgtH6pZqLusGRTD4dP0R8qWF414FgFo3+vwnPmpYE/M2VyoFzt3fIAVdshk4H+6OZ
	 AmrAeroxiZrwM6o5DDauQWcLogX7kAqBPUGm3ux2PYGCF8Z993LLpniVYtBmeMceCu
	 YGnbOG9Xqrgyg==
Date: Wed, 27 Aug 2025 14:35:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/pwrctrl: Fix device and OF node leaks
Message-ID: <20250827193550.GA898664@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>

On Mon, Jul 21, 2025 at 05:36:06PM +0200, Johan Hovold wrote:
> This series fixes some pwrctrl device and OF node leaks spotted while
> discussing the recent pwrctrl-related (ASPM and probe) regressions on
> Qualcomm platforms.
> 
> Johan
> 
> 
> Johan Hovold (3):
>   PCI/pwrctrl: Fix device leak at registration
>   PCI/pwrctrl: Fix device and OF node leak at bus scan
>   PCI/pwrctrl: Fix device leak at device stop
> 
>  drivers/pci/bus.c    | 14 +++++++++-----
>  drivers/pci/probe.c  | 19 ++++++++++++++++---
>  drivers/pci/remove.c |  2 ++
>  3 files changed, 27 insertions(+), 8 deletions(-)

Applied to pci/pwrctrl for v6.18, thanks, Johan!


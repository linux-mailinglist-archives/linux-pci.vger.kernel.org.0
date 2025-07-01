Return-Path: <linux-pci+bounces-31203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A68AF04F5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183F34E4059
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8E2EF2BE;
	Tue,  1 Jul 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoNLWaQV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A5281355;
	Tue,  1 Jul 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402129; cv=none; b=PYBep3KpWxbjIWMfwakAbsvELh2T0Ke5ukdVJAQa7p7LZ3xzJpd2eW+cWL0+lIq94WmI1hbNBYD5VMWMFNs7NMR0Y+j4JqqqvlZVh1bZjA1V9mfvKruDjeUAn0BoTGHITTrJ4wDyDhaRr4xTH8C2ywC54GQH27mCj7o/+UE4UcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402129; c=relaxed/simple;
	bh=I6JQFok9D5wKOjJaufxumgrPJ4Vt5SFOzuUQhLx/Q5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jn9hZaKUfIoKOqZl0atUn6FdU5mkvqj4cHaGKCi51KMum0AOMr8/8esf0RMenixqCNHax0+W+K7dYXVigaiaX8mFOWyDI7hYx8FQ7WnHeba9n6X5zSwjl+2XZRq8hesCteivltjADr+NwZdB7XuVGFiWjZJlx8XtMvJq1z5YPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoNLWaQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECCDC4CEEE;
	Tue,  1 Jul 2025 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751402128;
	bh=I6JQFok9D5wKOjJaufxumgrPJ4Vt5SFOzuUQhLx/Q5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DoNLWaQVMb95RqC3gJrE41oKtcZ1/5qtyH27rYyX5KkC8SwX0jmwxkPmHYFqJocdw
	 CfD4bjdVniIKo5XCFTyl0d0gX7TsUV91+cxje7kuDMsqUeunAsxQoXDCtLtqRz7GQL
	 0VYb/LgMWLogj/LdfVPJ6QpHJ2Y+Yn+ppX79dMODS0muPEXzogWTNlABnng6JLMUD8
	 wEy1xTqWfLprk5Uzhx8SSeTfBpHlpphyu0ACkhroJldDlgvPFGCRg8AthdLs5pEBXK
	 qYokL8ZKCtgvl5B6Gp58NSI4uR8j4Bq/hEn92faFgxvxWgzbjwBasUOmJUFav4Lzk1
	 XZ4KkiqLpdX2w==
Date: Tue, 1 Jul 2025 15:35:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250701203526.GA1849466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>

[+cc Bart]

On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> If devicetree describes power supplies related to a PCI device, we
> previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> not enabled.
> 
> When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> core will rescan the bus after turning on the power. However, if
> CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.

Separate from this patch, can we refine the comment in
pci_scan_device() to explain *why* we should skip scanning if a
pwrctrl device was created?  The current comment leaves me with two
questions:

  1) How do we know the pwrctrl device is currently off?  If it is
     already on, why should we defer enumerating the device?

  2) If the pwrctrl device is currently off, won't the Vendor ID read
     just fail like it does for every other non-existent device?  If
     so, why can't we just let that happen?

This behavior is from 2489eeb777af ("PCI/pwrctrl: Skip scanning for
the device further if pwrctrl device is created"), which just says
"there's no need to continue scanning."  Prior to 2489eeb777af, it
looks like we *did* what try to enumerate the device even if a pwrctrl
device was created, and 2489eeb777af doesn't mention a bug fix, so I
assume it's just an optimization.

Bjorn


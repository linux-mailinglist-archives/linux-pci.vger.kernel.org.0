Return-Path: <linux-pci+bounces-24392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60342A6C345
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F1B3B7B9C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4B2309B3;
	Fri, 21 Mar 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6rKnSo5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8423099C
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584506; cv=none; b=rhHbmQObK834wOw5V2cLyJAVyqTEmA3nFMqRjZQ1Er8zMZs2p4SLLrfuXGe1BO/tlf9UmZq7x27HOYIz0WEmnoeo0Fkg0oMwkPxNtCxN2XNGZZGd4Lb62XW3Un4PmW10cZCugV+zcK5kAS8V8GNNnYy6lyeBRt4GDDIhE+GH7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584506; c=relaxed/simple;
	bh=lJPk6iNyDlySCmTZPRj23rFY13kyjIGWM+MCOFReGPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KTOm3AgCD/PuO0tu9W9fYKDeABkJonqOBSeyqvKQQvHXhBfIQckyO9k4vPXtsGBn113ZFsNQO9coxwLDWOJDbdt9UT0hYQcnoSSa157JGnOhipf996mgeiXVrIu2t9SiuRHTe7vAUbylKy8vEp2YvgREpGDIujVX11/gXKeit44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6rKnSo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0012C4CEE3;
	Fri, 21 Mar 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742584506;
	bh=lJPk6iNyDlySCmTZPRj23rFY13kyjIGWM+MCOFReGPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F6rKnSo5kdxS/ygrNO4w0R/mwGBUSz69yjPloIo1bJ7U8stScCifnTZWoRhEApp3T
	 WuP/8Q/UE60EfOtCcS0Ym1Snk1AZ+XEm/aBoMymV/QZD2EAv0dhILncJqW0Kb5Nu5F
	 HgU2d34CxbmCZGcrm10XOK3pimEjmm+L7g3dFRkvSKLmvMGVvjyGMiJzaDdS7TPs+v
	 Dy8MFhdTFKWDGAEtpEaOSLOOfvNWvH+OrNSi5ZdOUIovtb8VG9Y8ejWNhMq+uLCLJE
	 vNfyylaM+p634U3jzjhrZAutEyG2QeCX9nEZB277w6iOwURZxZZv7Ls1B2gWUVtGK6
	 ATVqKQ4U8qtfA==
Date: Fri, 21 Mar 2025 14:15:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [Bug 219906] New: Kernel Oops in pcie_update_link_speed when
 hotplugging TB4 dock on x870e / kernel 6.14.0-rc7
Message-ID: <20250321191504.GA1139362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219906-41252@https.bugzilla.kernel.org/>

On Fri, Mar 21, 2025 at 06:30:40PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219906
> 
>             Bug ID: 219906
>            Summary: Kernel Oops in pcie_update_link_speed when hotplugging
>                     TB4 dock on x870e / kernel 6.14.0-rc7

> Created attachment 307878
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307878&action=edit
> dmesg output hotplugging dock
> 
> When connecting a Lenovo TB4 dock (40B0) using the USB4 port of an ASRock x870E
> Nova motherboard, Linux kernel 6.14.0-rc7 will Oops with a NULL pointer
> dereference. 
> 
> This is 100% reproducible on my system and happens immediately when plugging
> the USB4 cable into the docking station. Interestingly, USB devices connected
> to the docking station still work, but displays connected to it will not. Also,
> after the kernel Oops the system is in some corrupted state, as things like
> mkinitcpio will hang at the autodetect hook when enumerating udev devices, and
> when shutting down the system will get stuck indefinitely on hanging
> udev_worker processes.
> 
> When booting the machine while the dock is already attached, the kernel boots
> without any apparent problems, but displays connected to the dock will still
> not show any image. 
> 
> This dock has been working without any issue in combination with a different
> Linux laptop with USB4 and an AMD780M, a MacBook Pro, and a Windows 11 laptop.
> 
> Attached is the dmesg output after hot-plugging the dock.

Do you know whether this is a regression?  Does any kernel work
correctly on the system in question?


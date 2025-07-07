Return-Path: <linux-pci+bounces-31594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3FAFAB7B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 08:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B6A189DFED
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 06:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45F276025;
	Mon,  7 Jul 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSiBxsiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375B275867;
	Mon,  7 Jul 2025 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868715; cv=none; b=a/eRtN7mtTQH6Pg6M7x0/E3S7xdwos78ivQmcBMsc6fbKvQAnDdbBqE0ujxuTUVgUWhImMP3Yi9QrRnmHZfZqNECwYWYh724AznTroqtwZJBQsDeEdGdMNXqCZVHocYMUzwVWqV+KIY3GGuqsIRQjosPYbiynumeR/D1rGBeJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868715; c=relaxed/simple;
	bh=BhHwMHN6QVeyMz3R8ZAul9zte/ZMRxjS3q21gK4VnJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf9YexrVs0UZKemNzRGRLuhyXaWMMQCaF39gMAQ8fcQ3WwVwJIj1A+rqRuN58Jss1IL0UTi/P/UsecnVxys868cruceyLU/BQWj3rxD0TrAP2gTB7r6EF2JlWBzFl9BqlSbPCV++Ujf33eOD0MC9XnoHDZ6mXbbxPxA7Ps9hLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSiBxsiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC473C4CEE3;
	Mon,  7 Jul 2025 06:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751868714;
	bh=BhHwMHN6QVeyMz3R8ZAul9zte/ZMRxjS3q21gK4VnJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSiBxsiM2ebzmUyewq+3lPh5VFnFOFFxsVHZESehxMH/eqaaxlZzw3CmZmLZ5N1pF
	 wOB0znsBtopLgPzxavkiiOkzJbu6ZYorvKUwXAJtGujwSmdMGxSE9i7P3+l3C/reWt
	 dBBmgj1tyYmC9ZbUOxpaPfbx2Jk3UzYRp+tNGzNP3TohytnCoBACpXY6KXL1NJH4NK
	 KMh3Tqj9vJAdCpHjDNp3Z8oEFFYJChJL5ev5zkeGr0HjQFZu2+Ziw7OEg5cjrdRZ9s
	 1u9uSn8QiXTttri6ec3MPiEzgG1jaEpZs6ejl/AJbCfTJXUvfAEl4WOqqi8FVE877g
	 cBeYWWzBKzvKg==
Date: Mon, 7 Jul 2025 11:41:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Message-ID: <2cq6jeywii5fscozazz2epugh6zflcpfbo4ffhjt2lyk76cq4m@vg2jcsmlhtho>
References: <20250705195846.GA2011829@bhelgaas>
 <9D9D9375-1BD0-46EA-9E85-47A2D8325F98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D9D9375-1BD0-46EA-9E85-47A2D8325F98@gmail.com>

On Mon, Jul 07, 2025 at 04:31:22AM GMT, Bandhan Pramanik wrote:
> Hi Bjorn,
> 
> I have downloaded 6.16-rc4, and I have a bootable pendrive having the arch iso, but I really don't know how to rebuild the kernel on a bootable drive.
> 

You don't need to reinstall Arch for installing a custom kernel. Refer the Arch
linux wiki on how to install a custom kernel from source:

https://wiki.archlinux.org/title/Kernel/Arch_build_system
https://wiki.archlinux.org/title/Kernel/Traditional_compilation

- Mani

-- 
மணிவண்ணன் சதாசிவம்


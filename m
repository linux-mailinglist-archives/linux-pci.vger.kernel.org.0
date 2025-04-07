Return-Path: <linux-pci+bounces-25422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE236A7E8CB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881281767C6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A721ADB5;
	Mon,  7 Apr 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1wOH8m7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD46218AD2;
	Mon,  7 Apr 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047621; cv=none; b=dsFZ0eyUrdIywyAksJJNKvAHzCIDJsaxWqdzXXBavrFUY/ahvZAhYSarMxnQ1jGgS0zFxy6vfV/O31jvtmr8IuwC3JTbodApNEu9GZEbY0acttTy0JEAoadeqv9dhMX6rIBGtIxHX85uSXZ5jJL18OwSSCAVczWnsiQLIpycuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047621; c=relaxed/simple;
	bh=tQ+gxz2FgofmGnNH93gyzyXZ+xWZsAvyCBp1Nu5c3eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7LfgGK+ur9RkLDZ9C1GM/dMrtUde9obZ/HJaH/x13qD9Du7bThNwKxTnTp1/LvBiG35ajOT3Icshc1wV2L2L+VWYUB7Xjs3JOr5FkSOuoQOSg/zXluC00lM4ZY1NdjFRr9xHJSBU5fIdowaPAwn/v/fH3GCgzq5y+F9xmCQuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1wOH8m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A41C4CEDD;
	Mon,  7 Apr 2025 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047621;
	bh=tQ+gxz2FgofmGnNH93gyzyXZ+xWZsAvyCBp1Nu5c3eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1wOH8m7Ki5sYv4Rwf1fMyVSY7apMUCVHp11flzZ8AZHhMxiqeByoGGAF0Oagi+T7
	 wE5DESyZu4d2kGDN+AbeKQ0UKLEkPSG5G0viUvcDTTXaSz99df2/uowxwyYZObNpz2
	 1e+hEDkh/Wvf0v0AlWmnkHj+QGEYa0VsVZ9/B6guD50kUp9J8Th9jNl4gY3MnpN9C8
	 6DAbm90U8m5jcFXLBhyN3JUaLrwO8dkId+PBFLFvVGww84SJAwBD0Oim7qC3mdT5QR
	 uNILX5Xmmpp2Kga9gJXMhPKYkIhRhkVIdRoFkZWvYDHa8cF0CnoAthf8C5TOw3Km3H
	 +W2Cb1zWnOHPg==
Date: Mon, 7 Apr 2025 19:40:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] x86/PCI: Drop 'pci' suffix from intel_mid_pci.c
Message-ID: <Z_QOAPXsacHI6TZz@gmail.com>
References: <20250407070321.3761063-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407070321.3761063-1-andriy.shevchenko@linux.intel.com>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> CE4100 PCI specific code has no 'pci' suffix in the filename,
> intel_mid_pci.c is the only one that duplicates the folder
> name in its filename, drop that redundancy.
> 
> While at it, group the respective modules in the Makefile.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS                                   | 2 +-
>  arch/x86/pci/Makefile                         | 6 +++---
>  arch/x86/pci/{intel_mid_pci.c => intel_mid.c} | 0
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename arch/x86/pci/{intel_mid_pci.c => intel_mid.c} (100%)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo


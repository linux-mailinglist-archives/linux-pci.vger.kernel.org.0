Return-Path: <linux-pci+bounces-31942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A4B021EB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 18:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3352E1CA6272
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A22EF64B;
	Fri, 11 Jul 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOnM90aB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B32EF2B9;
	Fri, 11 Jul 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251807; cv=none; b=Cb/LjE9fy3bRaVm3UeWY3/+3MKmoVWwcriQYQ0t/ijCaPK8639GLJpJWepv95A2KQ45RIS/p3VQ/pPw4xkBOVcdbvu7z/envm/T54mp3SynS72T/LTuUsZswr4iG2qAoj17CP46WOsAef1/TITHZ/co2f0iTJolLDuEW80yGMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251807; c=relaxed/simple;
	bh=mGZlL1iSX7Cl9+ZNHxcW3xUugqjm/r6FYg5JEGbG2FI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I8MpfE+8pNCA7hC/Nwo+i0X65eT6WuQifb/TkO+FDz5GQS2oFcUrTyZ5dPrw+lWdYbLN0h7SZPeZkc1Z3q3F3HAcZZ1s53dqZ9m8Q67sFKXkKbWdi7/8sgFEih5SLPmDhVjDZqU4v36Eb5YS+g6zg+ANbuMrW71aMMb+ePQy1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOnM90aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A71C4CEED;
	Fri, 11 Jul 2025 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251807;
	bh=mGZlL1iSX7Cl9+ZNHxcW3xUugqjm/r6FYg5JEGbG2FI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bOnM90aB4RTarS4ISLl4d6OVG9eJKic6Ex+P0Bgy5IkdpG4vSmsAjxYAnfJK5uKQf
	 Yc3MYK1mgubqFJNI4dRhAa9zYRBeyDZjfRaiekC/XNLc+YVRGKfuWM2vU8BJaR9K9T
	 OM8QUcOcmitGbBhwhsqyzRn2xuMfUt1vsn6qcHBkGBYim028KEcq6YmUHvOHHCrJ+c
	 XdEhRMkb+SKSD3iefcLYdtX+zxFCBiceyVGtMHrprxIYYNaCEdH+EogvnkzQvomaWZ
	 Qfw0tegKCzaRyFI705znaC8d5YzSoDAamKZRIWFfJAQgSVe+dCl91ka7LWHtQkgHZA
	 qSBe+LEZwZicQ==
Date: Fri, 11 Jul 2025 11:36:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Message-ID: <20250711163645.GA2294895@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB546B0D-2209-4FA0-9DC9-A75C0BC9FA4F@gmail.com>

On Fri, Jul 11, 2025 at 09:34:43PM +0530, Bandhan Pramanik wrote:
> Hello,
> 
> I really couldn't find on the internet how to compile a single file
> now that I have compiled the whole kernel.
> 
> Any ways to do that?

If you apply the patch (cd to the linux/ directory, then "patch -p1 <
email-file"), then run whatever "make" command you used before, it
should rebuild that file and relink the whole kernel.

Bjorn


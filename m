Return-Path: <linux-pci+bounces-26710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3568A9B50F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C9A4A0FFB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32352288C97;
	Thu, 24 Apr 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgIHjTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B906288C8D
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514820; cv=none; b=pJcmYMYgEgYrvNkJsdioZdWQZYmQ7PAExw72qwp0N3BNut1u2Ysa9EwxPNbvm7eSJ4kYebubCnA7CHVmwBBXPjMCgGQJqYcaHU7KT8Lb2E5F+S8FKcYETme2LP7VbLaSOy2jSGPleBC0bIHxlCQj3NzS3OK0vnQV2d786WesXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514820; c=relaxed/simple;
	bh=lSAmH3o9l+YijFyYgO9p/QiakOUJlWFuINqV67O554A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r7gte0MQxRoUAOinYS9Jc7NPdAnij5PFeP9lhAQKrnwqQuthvWlMvImc1MPjR/noRRysnFcnoxW+duMvaHl5EtDKwFcopmHVZQk1Ubk9uclSaOhP2iC46Owks9dzHWYRjXdyoJyLUuQOI0ECD+eXQRG6PUwMFtuacHAvay9+rqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgIHjTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C358C4CEE3;
	Thu, 24 Apr 2025 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745514819;
	bh=lSAmH3o9l+YijFyYgO9p/QiakOUJlWFuINqV67O554A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aqgIHjTZ5HkZix6tSDr/mkZFfXc2lmtRoeAwKWSQEuWh2N4B2bWqoCUjFpCXp8GBE
	 pBiOQYS5wg4axYdg73n5UMtvi55gCcmH7u6YGofhMXITfA94Udq+AUadjsADJmQFnr
	 VeLDGgesxl8J0t2EccxpK1NfJ1AkEunwR+ocHjKP6yN2isbPnGCDMyvxRZZuYattMX
	 WaDuZG47KTzE9IJRLrA1IhxtF6ihrHwoKERcD4pE3uPRjWxdcliSDtwsVWuQt/kTzs
	 HR4YRTkGkBlu4C5+jzVK2hwxuX6g4KwD2B7R2O4xeUl4GZgc0o6K++tY16FUYQpKOn
	 LFMtDTkX9h2xw==
Date: Thu, 24 Apr 2025 12:13:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Problem with kernel rescan and realloc BAR resource for endponts
Message-ID: <20250424171337.GA492527@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTsD40J3PAv4LXit6oTmJmeZOVjN+FG-PN2Aj2+KyPFahA@mail.gmail.com>

On Thu, Apr 24, 2025 at 10:19:44PM +0530, Maverickk 78 wrote:
> Hello,
> 
> The command line parameter
> 
> pciehp.pciehp_force=1 pciehp.pciehp_debug=1 pcie_ports=native
> pci=nocrs pci=hpmemsize=256M,realloc pci=noacpi pci=realloc=on
> pci=nobios
> 
> 
> There are a couple of endpoints connected to downstream ports on a
> switch, and the endpoints are not visible during the BIOS (seabios)
> enumeration, but they are brought out of reset just before kernel
> starts pci scan.
> 
> Even though the kernel enumerates the endpoint with proper bdf and is
> able to read the config space but its not able to properly program the
> BAR register, the lspci lists as
> 
> 
> Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
> [size=32M]
> 
> 
> This is an emulation platform.

Can't really give any suggestions without seeing a complete dmesg log 
and output of "sudo lspci -vv".  This will give insight into how much
space the devices require and what space is available.

Bjorn


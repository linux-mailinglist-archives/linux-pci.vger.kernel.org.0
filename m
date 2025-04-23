Return-Path: <linux-pci+bounces-26617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C756A99A63
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 23:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E0A440AF2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340C29AB1B;
	Wed, 23 Apr 2025 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix8n/6h+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480E29AB0A;
	Wed, 23 Apr 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442658; cv=none; b=Ovojwipg1PzNkfU0SXw98K2l+Jt17/fIRghy12eesy/a9HN+jD+/ulODrF1ETSCMJ0Xhv8RTuf+FnRh/qw4/GQU17yuiB6Rc6gjaJxJiewUtnwaxksOHBOks3x54KP1QtSWCeDcBc1SAZtrBcfgqgSxWRWFxey0GYNdSLYs5t3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442658; c=relaxed/simple;
	bh=xmq6MkuqUF6TJZ/43UNV61lf7JZuVR8dHvGHTQZIEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VgLWI2hzTZsIrXXrPUcmQo2YD+K3+uKc/1i4GUKrqqK7HOeQdI2j/i5dH2Om87WMnQLS+Qsgdvs9L5D+cVyVMc3Ew4frtO3rocEzBytiVhsjwTf22Auafw5lE98PRdkCPDMKEiMxAkEvO40NiEz08x3xaO39DRmjSM9NstgM81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix8n/6h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022BEC4CEF3;
	Wed, 23 Apr 2025 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745442657;
	bh=xmq6MkuqUF6TJZ/43UNV61lf7JZuVR8dHvGHTQZIEPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ix8n/6h+1RXIvMwWGIAZiUGwYk5gjoZn8l90EBNpsKmpnnQTDPFLYGSzhPWNehXu+
	 u8CRhXA3WXO5Hfa8OMtYu9w6NHVRHUsPK2JGz6e/QV1wfoVQCF5hLMhLgtNtPU24Tx
	 G5eOFYksMTpY6uIo/RPz4E5u21mfAZ1EBZVGh9S/RAzFP1J6wEiMCiU0yrUAJxmzMH
	 kAhzQ5jWRgT0PYnk/wXf55+tLkUbbXMzFBGiDJEgPabU54vzTgyNsIGLeEvlEKH+gf
	 RcBi8SkzG+ETRi0/DQ4AZh+5d07C4aFOYfVe7uMNVpaociWZXlW/G215MrONfD4hei
	 tjto8d6xCfJUA==
Date: Wed, 23 Apr 2025 16:10:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/PM: Elevate PM usage during reset probing
Message-ID: <20250423211055.GA455833@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422230534.2295291-1-alex.williamson@redhat.com>

On Tue, Apr 22, 2025 at 05:05:30PM -0600, Alex Williamson wrote:
> I encountered a confusing scenario where a device reports NoSoftRst- and
> doesn't have any associated quirks to set PCI_DEV_FLAGS_NO_PM_RESET, but
> it refuses to probe for PM reset support using the sysfs reset_method
> attribute.  The reason turns out to be that we don't increment the usage
> count while probing, the driver has the device in D3, where this system
> seems to support D3cold, and the PM control register is read back as
> 0xffff.
> 
> The cleanup __free helper seems to be the cleanest solution here, versus
> refactoring to a common exit point or wrappers around reset_fn, but feel
> free to suggest otherwise.  I see a couple potential other use cases for
> this helper in the vfio code.
> 
> Please review.  Thanks,
> 
> Alex
> 
> Alex Williamson (2):
>   PM: runtime: Define pm_runtime_put cleanup helper
>   PCI: Increment PM usage counter when probing reset methods
> 
>  drivers/pci/pci-sysfs.c    | 3 +++
>  include/linux/pm_runtime.h | 2 ++
>  2 files changed, 5 insertions(+)

Applied to pci/pm for v6.16, thanks, Alex!


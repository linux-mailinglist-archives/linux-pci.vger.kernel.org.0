Return-Path: <linux-pci+bounces-24846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A62A731BE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E683ABE75
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B3213259;
	Thu, 27 Mar 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2CUlHLYm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wmy/qs0N"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4D20AF8B;
	Thu, 27 Mar 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077030; cv=none; b=e+BSh7lZuz5Eqs0OYfUBPHKSk8R5IM6HlzrA2YFFBOFjVFbh19qj5T6DHmBqkKx4iZt3bwquYuQjA/MewsQ8WyQ0+jXGoKX8HEqZZ1m4+Y8iBRrW+mQqCOJK/+qr1qKb/94qhuFejrtbqrjVW+CUsPJhWbuo2Rq+Tw9IiNl/fAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077030; c=relaxed/simple;
	bh=5hfLC1YzRrCnSz3zVHN/pjpVelGRCCdNDMqdXleTErQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2Tzp7vC7Nt8Jvr2KkTU/Hj/jpOqPIo8amJFRfzwfsUQDx5i1tNE5CRMjG3dqmzoIzMaiTWPt/xkiStMLQakdyeQmy9RjvYPF1KOW9NbxxafFlo3p8t0kFXRRhTr+VWHQJ8tB0igpllzKHG0xRfAnswsLF0MinEsAOtryhWyHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2CUlHLYm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wmy/qs0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743077026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hfLC1YzRrCnSz3zVHN/pjpVelGRCCdNDMqdXleTErQ=;
	b=2CUlHLYmmjHr8fA1hplaYjlX2Rrr8FAqj38qPquIDKCdbe75yEhV35v9E21QpEgQ1Llj4r
	h2L2DKGkRXV1sGbBkGJDMSGVNbSP29d1Bf6voVgtqQQ+fGNRAcMuIY3eDkqqrIXAuSVC0/
	p7EtCd9HTBFb15/sXq1HSnBk+87ARWybYmkZIgoJAk4kBIvu3wnWk271LFVjQNkuYl+fbU
	qY8DPXgkMlE77tRvgwt893msRjv9uc9SlrAa+tPGaWGGYyhmv8KpvzhnElV8sz0G/rStNk
	0exz6iv3SIkSnAGgiey1TUe5Gp3EV0L/nNkU3rbz1g6fVXWDAX8G4g8hTQIbqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743077026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hfLC1YzRrCnSz3zVHN/pjpVelGRCCdNDMqdXleTErQ=;
	b=Wmy/qs0NDbZZdF3X/u0ciYSLBcE9k5CgAgiLntMaDI2TaiBSlDSZB+tTcr6ztoP4fqJel6
	e3uYGfvHLgDArOCQ==
To: kernel test robot <oliver.sang@intel.com>, Roger Pau Monne
 <roger.pau@citrix.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Juergen Gross <jgross@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [linux-next:master] [PCI/MSI]  d9f2164238:
 Kernel_panic-not_syncing:Fatal_exception
In-Reply-To: <202503271537.b451d717-lkp@intel.com>
References: <202503271537.b451d717-lkp@intel.com>
Date: Thu, 27 Mar 2025 13:03:46 +0100
Message-ID: <87semyy925.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 27 2025 at 16:29, kernel test robot wrote:
> kernel test robot noticed "Kernel_panic-not_syncing:Fatal_exception" on:
>
> commit: d9f2164238d814d119e8c979a3579d1199e271bb ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Fixed upstream.

3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")


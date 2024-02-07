Return-Path: <linux-pci+bounces-3192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7F84C834
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4E1F247B9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B124B34;
	Wed,  7 Feb 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3G1QfT8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhM7AF90"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB7241E4;
	Wed,  7 Feb 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300121; cv=none; b=BKjirItVQgB4b1AoV0depQ0dFiCpEWa/dKPBkZxw1VETi3XdeX/bNl0zKmO35JkBriMPi2OB9fOpHG2ahSHGzwsPJmkYoaJdZNdy078dUVOSht8eRZTuteyo/i7KPsgWtq8OKj0qDui5TjkP879mBl1TVQisGsSDox6cSnMfDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300121; c=relaxed/simple;
	bh=4a3LJ2DJTK3sHdMmHCMcOYGiMGbS3fOhij5vzYAoMMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hybbz6tgODvAn46hZH8f8qJTj6Q6AMQLgtU45mVTlLFaQCer6KI8Mk1lfmr9F/YN8vlYWaiWL+8t8cB4OA8JeCZ3An6hXa34WisYrVa08+sxPTbBdcWLyIc4nqT5V7u06cl0aHjfM5Hd7wouN9phYP/GptBByuky9ZQ+2hI1uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I3G1QfT8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhM7AF90; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707300117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4a3LJ2DJTK3sHdMmHCMcOYGiMGbS3fOhij5vzYAoMMA=;
	b=I3G1QfT8bBmmK+PvqOKp7YPwaz81nhYiEX02wvRXCn5PyEMp/aRM/JiDAzFd0KF+HogVSI
	eCgoPAcRzlLTNbqOv6iUmons+it8VS+ahy/utWFzoBFM+AviGnvciy3vKkBqadRPXq+TV6
	DmIXtmI/kWopR3Fdp0V43ZtKF9/cA7aGgfYc1XGvVc44uDYj8/nxUQPYLzWcj4oEZtjRtm
	87MMle2O9H3Ud5lGNYgIwl0EJo9CPB8OxHRHp2VYUM5FnR0skAbj/1vDcwohQNh3oEMYdO
	wH3Jh8O/txPaezSMZb8KzbrObMXJfvr3i4rUoYJCfkUCQ4un3VSY3NLFT0Wj0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707300117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4a3LJ2DJTK3sHdMmHCMcOYGiMGbS3fOhij5vzYAoMMA=;
	b=lhM7AF90c2RKYSWwCA3HdyJCzpifTy9KtqnoZGWngB4D80yVMDSEUlgGg2Gph18xV1tUfh
	sTCLGPEArP7rORAQ==
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI/MSI: Fix MSI hwirq truncation
In-Reply-To: <cfa789a0-5433-4e17-957f-a3e021a97eed@nvidia.com>
References: <20240111052814.713016-1-vidyas@nvidia.com>
 <20240115135649.708536-1-vidyas@nvidia.com>
 <23c5fac1-ebf1-4e5d-9691-7b87060b0df3@nvidia.com>
 <0c9d7bab-1da7-4ac5-891a-62e28db8d60a@nvidia.com>
 <cfa789a0-5433-4e17-957f-a3e021a97eed@nvidia.com>
Date: Wed, 07 Feb 2024 11:01:55 +0100
Message-ID: <87v870mw30.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07 2024 at 12:29, Vidya Sagar wrote:
> Hi Thomas / Bjorn,
> Can you please guide me on getting this patch merged?

It's in my backlog...


Return-Path: <linux-pci+bounces-33749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81878B20C4C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1D416E58F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2D525743D;
	Mon, 11 Aug 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RsHVcYd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2Z17ISy"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC8253B42;
	Mon, 11 Aug 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923054; cv=none; b=lxxkjgmJCyirOXX43FBXRfVXio29VtEvhQsU9YuuesDzPVKDwoD3TRvg7eG+NuJA6pqFUxtu+QigwCrYnuCAFVjyoOdNSSIDqzOx/UhARtzUjnEEifCWxDqk8GJCG6XNa1063OkasJweqjdpF4m/SNGIamjq5BJCv7A7ium1/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923054; c=relaxed/simple;
	bh=npJxTmCQObhfaQ9R6Q2MSfW9iKV+RqpoFeaDp2s89gA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I88Mr2/lp/+mR0JDc7XDZ4pUDLRgepWddIt0hpsM8jKN+2nUlcPsnYLk6Wp08ezKvqyTOeAYPQcMzxP/yXgnXQsncC+koRlEhfcyAwrYxhtPxtR6Bloo0EXp3nXPXU7v/GOLcFy571y57NoR/7F87haomJVgm5xnymvyhh+V43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1RsHVcYd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2Z17ISy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754923051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npJxTmCQObhfaQ9R6Q2MSfW9iKV+RqpoFeaDp2s89gA=;
	b=1RsHVcYdUibc2dcytTc1YB/g2o9yrUk4OvX1i+HY/5DOt5hPLuOga5DLLJMlDX69dF2tnA
	u3Xr40csV9t3WiUm46AGF9mlo5L3nGfIY8unGUuUQRfEOz+oHWy2mHuQTYBxd7BfPf6obl
	Zek9YVwvAnJkXqzOX+jWcXh8xHBRuI863cZp2lZrpNjBX3d6TQ3hDV9muDsvb2iAPUJjp8
	Q9N1j9XZR6bqFXqZxkj4XzaLWXp6reByBT/QhSE+sYnfHA8xuODUNb4fjs1v0cYikC9Eou
	zQ8i/li2ZHyoRHN95PUa6dilZKKpcVHkcS+7UK8NEL7YIOtuZVsaTtm9/PhICQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754923051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npJxTmCQObhfaQ9R6Q2MSfW9iKV+RqpoFeaDp2s89gA=;
	b=r2Z17ISyzYQ9xNO8NYis3NVJzkT8hG+4ScdNM3qloxSrUsMaussaCA5CDfCi+aptcQ1w7N
	2xTISznjdEwojeCg==
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] genirq: Add irq_chip_(startup/shutdown)_parent
In-Reply-To: <20250807112326.748740-2-inochiama@gmail.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-2-inochiama@gmail.com>
Date: Mon, 11 Aug 2025 16:37:30 +0200
Message-ID: <87zfc57wlx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 19:23, Inochi Amaoto wrote:

Please use 'function()' notation for functions. See

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

I'm sure I pointed you to this documented at least three times in the
past. Do you think this was written for entertainment?

> Add helper irq_chip_startup_parent and irq_chip_shutdown_parent. The
> helper implement the default behavior in case irq_startup or irq_shutdown
> is not implemented for the parent interrupt chip, which will fallback
> to irq_chip_enable_parent or irq_chip_disable_parent if not available.

Also please use the documented structure for change logs. Starting with
'Add' is just wrong. See Documentation.



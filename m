Return-Path: <linux-pci+bounces-22587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598ABA4870D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CF9188E8D6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912EE1EFF88;
	Thu, 27 Feb 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6bbZFOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yAQlzV25"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D61E833D;
	Thu, 27 Feb 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678704; cv=none; b=E2K2CmH3DgJ7NQp7vLtPA0ffRZDVvJeKPlvMlCRveWkNVz7hkbX/ZmP4oWi1InV2Acio9UxiAcaBCzOkBMjXFen20v9o+1vzAyFtqtQc0oWjNyWN43/Vd4GoxI3kpU2ZXV4FnXFPE7+kgil+rZStvWrWvO7BY8muhWCZ08TYsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678704; c=relaxed/simple;
	bh=EW2C+zNivSWRf6zggxRtHjZ08tV8I/E9/Ike9Q+R6xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJrlWq4RLZC5bPO1MQnpEKd1kcy75lvU44rcDbjz7GvcOxoZ7FfadJHB6q70y/bLD1MXwI0/i5lrqtvorDzEucB91eURXzcAg4S0IllHIf7MqG5MYYARTPgxLSVS5uPDJaCALXRWo5yC1XvN2CZwRaOWZx4D/bgKUrIb860ctAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6bbZFOw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yAQlzV25; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740678700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nDBuln07X7WmCrCCbh6OZvVC56iNP5OzeOf6Zq5wdo=;
	b=w6bbZFOw4mj6JhB98tbqvrhURpEomxRjxBIn0s8G+4zePYPjUKUWAcAC00+0MPAeZhuuit
	6nCxm5wEiwZQ0T3Zwl+Um101KBFptEmdYrVfscywaG12TS+07iS6u1chvBvfIT8pqkRTkc
	g96NtOHoXd8s1RCU7C727XQTtWxKwlq43qSwAbgApvdkRs97FlxlOpIdxj0yNR1L1pOAIN
	7xU0/Z5KxxuI5qCi6x/qne9opbvLfjTM20Ggaobhe9xavCr/qVXRs4ixB66TQuXh0VPPK9
	oBtjenF1a3oEUTafeb3577Xn3FW8ZZ8eVmnaepDsW4hlFmrAN/hhJT8y7RGqlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740678700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nDBuln07X7WmCrCCbh6OZvVC56iNP5OzeOf6Zq5wdo=;
	b=yAQlzV25hKtffJarU3y/ilWPoMvHq1mjGtuztKdNY2rfNPqxrhEwGdrzMHYf+LqabLE9cl
	0Xk9nKxVz8GYhRBQ==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Hans Zhang
 <18255117159@163.com>
Cc: kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
 cassel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
In-Reply-To: <20250227163937.wv4hsucatyandde3@thinkpad>
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad>
Date: Thu, 27 Feb 2025 18:51:39 +0100
Message-ID: <877c5be0no.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 27 2025 at 22:09, Manivannan Sadhasivam wrote:
> On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
>> +	return sysfs_emit(
>> +		buf,
>> +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
>> +		is_msix ? "msix" : "msi", desc->msg.address_hi,
>> +		desc->msg.address_lo, desc->msg.data);
>
> Sysfs is an ABI. You cannot change the semantics of an attribute.

Correct. Aside of that this is debug information and has no business in
sysfs.

The obvious place to expose this is via the existing debugfs irq/*
mechanism. All it requires is to implement a debug_show() callback in
the MSI core code and assign it to domain ops::debug_show() on domain
creation, if it does not provide its own callback.

Thanks,

        tglx



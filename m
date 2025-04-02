Return-Path: <linux-pci+bounces-25137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5BA78A05
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731E33B0D35
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AE20FA98;
	Wed,  2 Apr 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKq9Z/o2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2z04E2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506162E337B;
	Wed,  2 Apr 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582790; cv=none; b=TM2+L8UyJwOr5wkfd70H05nOFGxOcdg4D8+Cn4lzt6TiG2XOWB+rH0iqpRkV1LGJVLak+wHwvKktXMKu+XUth2NTst+YjnUpEgXOnv47h/xAXpPEx9LpSi2y9LpZKNBxdPCTxTIUzwiMDGskpIw+6HBcOFM1e6asu4JDrlgXO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582790; c=relaxed/simple;
	bh=9RdmEKMlR3J74Bw7miAaMP+c5T/HCfd9hKyzL48T9vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWmqTQ68p41pDb6SXevlkjTmMK7KFg+nig8LfUTKIXBC+kq5XeadfhQSBwjmP6GESLjhjGKECT1qmAztOo5cQQ765qahHsScdiUdYEaP2eTH6PW6ZWMLWvXPvagwe3/QNCozgPG+3Wr0EGmUHaX7CVOCRzSCngsSuzOhS5KGB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKq9Z/o2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2z04E2H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743582787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ycd6Sun1D4/Zq6i9s2ydaNrJTyNiiTgXwcdoplGbSAk=;
	b=iKq9Z/o2OZ1MEi80gv35QnqOkCcpm/Jx+zguXmAA88IL1XXjMkpEgodcx0wJNO4MHcPJXm
	tu/8R3x/iVS/AarAsNsjfTLrcyialNoY2wcxO8ifZ5wMITf9DpvdJUwB4dKvYniRP+XbhG
	E9VdDT4IgN8BuQ5TIOwDjNmJYLcmwlaHOFvePV5VZ/3ukYr8IwFhLR3nGAt8Mp3ZbcXcOK
	6CnZFd7ZYiHNdr+MFv1eTVY5WaBgtOMo69XINQbCiZdRiZCWJNbzW16pwDju9Z4o5em2nG
	hwUS8DYkv1+58q8x3VkGVTI1vP/6dYeo9bxN+H5M+HubBAUNGLSLmwwRK27vyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743582787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ycd6Sun1D4/Zq6i9s2ydaNrJTyNiiTgXwcdoplGbSAk=;
	b=a2z04E2H6jB4CfFVyTMilY2wxfz1YtVCEjwQIXgaLs2cO0ziYV+shP3DvuvSKyQYR+yzeW
	1VZVf4Bh6D2dFtAg==
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <e83622773199665d39db5f724537d9dd@linux.ibm.com>
References: <87wmc9wg2z.ffs@tglx>
 <e83622773199665d39db5f724537d9dd@linux.ibm.com>
Date: Wed, 02 Apr 2025 10:33:05 +0200
Message-ID: <87cydvvu7y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 01 2025 at 15:14, Wen Xiong wrote:
> On 2025-03-28 06:27, Thomas Gleixner wrote:
>
>> You are completely missing the point. This is not a problem restricted
>> to PCI/MSI interrupts.
>> 
> Thanks for all suggestions! I will investigate more and check if we can 
> fix it in device driver.
>
> Looks several device drivers in kernel use two kernel APIs to set/clean 
> IRQ_NO_BALACING status for a given irq.
>
> irq_set_status_flags(irq, IRQ_NO_BALANCING);
> irq_clear_status_flags(irq, IRQ_NO_BALANCING);
>
> With these two APIs, device driver can decide if using kernel irq 
> balance or setting irq affinity by driver itself?
>
> So we can set/clear IRQ_NO_BALANCING during reset.

That's not sufficient. You are papering over the symptom. I explained
you that affinity setting is not the only way to wreckage this.

But feel free to ignore me and apply your bandaid fix as you see fit.

Thanks,

        tglx


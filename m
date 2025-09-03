Return-Path: <linux-pci+bounces-35363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6FB4180D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64492168111
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F832E717C;
	Wed,  3 Sep 2025 08:10:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C342EA177
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887021; cv=none; b=t5c3bG6ba1VVG1XaMD8Vccu0X4E1ZF+LNFXLkpWO7w8ST5+2ultsmkbiYhpbSIbR8E7Ef5uaYofiI8CyldUVjps/Hcg3krmI8En+c6sbFdczF+vk/VFe3RH+ADSpAoptPkik3EsGT1Aw1GoNpci55DEPHIU6d8kPINRjn10s3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887021; c=relaxed/simple;
	bh=Z9Noai9/LnxNARQhjgKfDtreigcJw8Sv40SZrvb8jRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX3wk0w2Uk0nOq7wwJSBEcu4NqOLbOXf8LguGufo9ThpzhvrTU7SlT5mPnkiWvIFN740oKzInDfWMHiV4ok7X5PG+QceFO/YL9xXkjuRGEhZe3QnHdcsTIgNwz/ozzddibQZVfLenfKlWBJEYPqGOjFrpEEuXOS6cPy9zNbz8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2B5E22C0163B;
	Wed,  3 Sep 2025 10:10:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F290A54C8E; Wed,  3 Sep 2025 10:10:10 +0200 (CEST)
Date: Wed, 3 Sep 2025 10:10:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Crystal Wood <crwood@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <aLf34pnRmk4ip7KS@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902224441.368483-1-crwood@redhat.com>

On Tue, Sep 02, 2025 at 05:44:41PM -0500, Crystal Wood wrote:
> On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threads,

My understanding is that if request_threaded_irq() is passed both a
non-NULL handler and a non-NULL thread_fn, the former runs in hardirq
context and the latter in kthread context.  Even on PREEMPT_RT.

So how can aer_irq() and aer_isr() ever both run in kthread context?
Am I missing something?

> at the same FIFO priority.  This can lead to the aer_isr thread starving
> the aer_irq thread, particularly if multi_error_valid causes a scan of
> all devices, and multiple errors are raised during the scan.

I'm not seeing aer_isr() waiting on a spinlock, so how can it be starved?

Thanks,

Lukas


Return-Path: <linux-pci+bounces-22717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C90A4B209
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7163A65B5
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52191E5B68;
	Sun,  2 Mar 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMesIqqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JAB/I43s"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115461E0B9C;
	Sun,  2 Mar 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740924822; cv=none; b=RLGJdcKEnSaZtONC0oRCPE+T2a72xXVJz5FxfZOGQHzPYZO3X7qdP1y9cMMlFIYB6fJu3OwtiptY0HL6U2T4ISOjhOq3jg5dz5EDV+MvzGwWrpWz9L9i6xcgRr8L5OKiwXv2Jyvpb//+xc8Rjr5j1/KXbDXWUI1qs/DrP5D0htQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740924822; c=relaxed/simple;
	bh=c9aOMXbCuUn+01PgPzDWGcg8tOpN18R3trxMFhnD7Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRw6fZPYRQS0YJy+EmjuT1vQzqfFPF54b1/161g3C4RhHOmVGIIz+J5skzDnfwAlsrmb0YjIubP9uzaZ/mqHDfA3Lz9Cduc6lHuiDDgRMEJ2u71FLkCIJSh4hC2srZp4Qwf9gnmek5dJCIV76Lu3kbe4X6Pb2Qi6r8Pxj+zft5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMesIqqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JAB/I43s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740924818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZslAGJtwANGdTqRhXjL6ifh1nXzfpEo8UaYcz63Pc0=;
	b=nMesIqqYZqv0A8TNSYSwzm3QCVzET60clWQ8n9zP9wuGfIZAA57af7C2zINkR8kbr4G776
	OhInp+DcAnu3ude1gV/Bo6Q1JBWtNBQDc0zLIg+6CP4LXVP9nQGnzgJWjW4qlFyPppb1+C
	/CNVjUl5aFrXE4byqLVZwLmjEca9mg3M8GRvKajqqlkP18uwNeJZwuB8rTMB0t1/IlPJLo
	UhzGKQ+qt+jFvv0MXvZD+/SEZoW+cYvjlBbDRF1ozHwJqSgULe7RbaWPRfZqQwx3F+67Gj
	SbdhW0xfuylMofEhHlJQO5jcG1hY6A6Aw6FdrU49obKQLf3TiTWePuk1xQ3jOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740924818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZslAGJtwANGdTqRhXjL6ifh1nXzfpEo8UaYcz63Pc0=;
	b=JAB/I43sCER7KQeHJw6I9n6JBtlAg4G7icXmy5ZPuUMVbSjB5lm9ZqLeT1XATxfLxofy9d
	AksPKzXhYG8c2gAA==
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Zhang
 <18255117159@163.com>, kernel test robot <lkp@intel.com>
Subject: Re: [v3] genirq/msi: Add the address and data that show MSI/MSIX
In-Reply-To: <20250302020328.296523-1-18255117159@163.com>
References: <20250302020328.296523-1-18255117159@163.com>
Date: Sun, 02 Mar 2025 15:13:37 +0100
Message-ID: <87ldtncyge.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 02 2025 at 10:03, Hans Zhang wrote:

Previous comments still apply.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503020812.PKZf7JBa-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202503020807.c3MhmbJh-lkp@intel.com/

That's wrong. You are not submitting this patch as a response to a
report from the test robot. Reported/Closes makes only sense for a patch
which fixes something existing, but not for a new feature or functionality.

Thanks,

        tglx


Return-Path: <linux-pci+bounces-32383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A33B08C04
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE2958750F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F229CB5A;
	Thu, 17 Jul 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nq0wp4NN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7aFULu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112829C34B;
	Thu, 17 Jul 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753145; cv=none; b=KuAizaUCUu1NpLk6rqmmcV/KuPBVRTFIRpDJHdkPZW2P1E8HF/VHPcGN1L7KnVeNNkTRx3fhbad5/pSvaOXbT5qqiibo+VbB03keYA+F/DqmVntat9PN8pIvq9p8PLBSNLT0vvTLN/bdpegv8afz4eEk6WWBQdyoDEpu7YLhLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753145; c=relaxed/simple;
	bh=aAk8DYNKUlmNPjRdPFs6AbSzFpHBcXI6XkG9QV3hQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uobb+3XGbmTwCE1IgDNcDoKz2w/UkBij53mdMCCqRXr8Scg75qmtkpB5CHck2biSVzwnPB2HB8Q9XxZmjTgpIQyI2O1M33LNhmExfW1ni61S8Q+sseDO5vebl+xbLIkl7XkmO1e0PUvu+41NKc0McswlgVea1ZumZPcSoKYUkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nq0wp4NN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7aFULu4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Jul 2025 13:52:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752753141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gqzx1dNhh4oohgrJbkjfGhdpKYJekodbtkmHaKEgPLc=;
	b=nq0wp4NNakQvwD0rEl7XXwrugao3MLbPoUs2aWKUGRD1AK7F7TudIFl3tKsHWpiPndDuZx
	QBb+QuDAzfUDJxQZCh+kUaE7FUO5xhbLWkjM2YN+EeqNjSrxBeYngB5UQwus1i/n1CCnUT
	QXbZ4wuWHY9D+02+WbmL+1zPmMcokhyR17s/TAOp8UancD8kzF5ph0HtQn/Zgzs13kKlLR
	RBI35r6yXM0LLvr8pmKwLIKggbShZuGyAHGTp/NLZoZkQRi9JK6sQD+UVwdIUNT8sRqbxV
	uTZ8x++l7s68p6o6J2bwOrFpGZ1x/rhJ5kiuU0H+zWAUBhwXt7FYv3v5MpZ/zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752753141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gqzx1dNhh4oohgrJbkjfGhdpKYJekodbtkmHaKEgPLc=;
	b=v7aFULu4dcHYCoHrygErDk8ktGX+YAmbWESEcLilL9wb93uavcMyKxOZo6HWn28fxbLD7t
	1bWTV+HNJTx7iZCA==
From: Nam Cao <namcao@linutronix.de>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI: vmd: repeated kfree of vmdirq
Message-ID: <20250717115220.jfvzVfuR@linutronix.de>
References: <013ea925-accc-4927-aca5-7fad4043377b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013ea925-accc-4927-aca5-7fad4043377b@gmail.com>

On Thu, Jul 17, 2025 at 12:48:02PM +0100, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis found an issue in the following commit in linux-next:
> 
> commit 2b96beffa42760513567919aa27eb72035f2db58
> Author: Nam Cao <namcao@linutronix.de>
> Date:   Thu Jun 26 16:48:06 2025 +0200
> 
>     PCI: vmd: Switch to msi_create_parent_irq_domain()
> 
> 
> The issue is as follows:
> 
> static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
> unsigned int nr_irqs)
> {
>         struct vmd_irq *vmdirq = irq_get_chip_data(virq);
> 
>         for (int i = 0; i < nr_irqs; ++i) {
>                 synchronize_srcu(&vmdirq->irq->srcu);
> 
>                 /* XXX: Potential optimization to rebalance */
>                 scoped_guard(raw_spinlock_irq, &list_lock)
>                         vmdirq->irq->count--;
> 
>                 kfree(vmdirq);
>         }
> }
> 
> The for-loop is repeatedly kfree'ing vmdirq which seems incorrect.

Thanks for the report. It has been resolved in PCI tree.

Best regards,
Nam


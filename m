Return-Path: <linux-pci+bounces-22637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF2A49849
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 12:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ED23B752E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B725D906;
	Fri, 28 Feb 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QPjqQHbA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GOeXJ35V"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDB849C;
	Fri, 28 Feb 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742003; cv=none; b=sHUD0A40/epXGTUcKCtjfjE1XYOsVwDqZms72JykDZ+gRhnCFfSkXfb1f4VXrYGkoZk/JHhGnWJpGXYKopSNTEoY474NOnM+Pt5ZHq6X5pxzgkymFYCbXNKoRdz8Q1TTl2nZZchV5WiXuqk3XqUY9P9CGJr5pCgyv+2jpHAEpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742003; c=relaxed/simple;
	bh=AXoSX+cZOIjr/cx5E/MJM5TCpZ5IGvKLD2m/ep6khUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVkmXkuoARSrF/bFVabVLDHYcmLLorQCRVpVajRG9e6gyS9CXiCUkLKEqT3pjVJrj8MfZj2ALqlKRsAVdmmoBfbVXS/Gx4KhIudYq8T4lDYFmgCTvODieGJc9NWeyHzwAnbbblO4uPUuetmr03dXeoTx20bkrItLWKvABeSskXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QPjqQHbA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GOeXJ35V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740742000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Et+SlYz6ovSf5xQTsL5N3DaesRKtvn9yuY1LQaCqx3Y=;
	b=QPjqQHbADUkR4H8ZPMbwor1YbyDdFdfRCMc6goNoI+4bwo/oGBxB94XrQYG/QKLopmA5or
	6Vs5Q3dVXJ7aRHNWjf7Xf0Ck7KjGMo3kpvDwn9cxZkwWfRLW07ZE8rcFpX+5CvMQXmLsSb
	dqkRJH15t2qOFSp162/uBQNkj7if6nZZZ7+k6fJcyCyoAZN00nv3q4YNfzliZE46ADsxk4
	XQVDotY9fMe9yMnN+RupMljn/W6fcRTxZBQnWdsipTkjndzYir/UuEvuBxJQgp2fWZcwWY
	10u940wn5hNcOIT6zrBFCMPh7gzaX6R9Nc9QBrgPnJb5QoAC2r96jXWi7gBIRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740742000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Et+SlYz6ovSf5xQTsL5N3DaesRKtvn9yuY1LQaCqx3Y=;
	b=GOeXJ35VIzmQq4zrS1xYViKTE/afu7dgZIRD/D2XD0t9J8NHxHMnimX75EstxB33HhuH2i
	r6qzZIYT6PG5fPDA==
To: Hans Zhang <18255117159@163.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
 cassel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
In-Reply-To: <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com>
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad> <877c5be0no.ffs@tglx>
 <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com>
Date: Fri, 28 Feb 2025 12:26:39 +0100
Message-ID: <874j0ee2ds.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 28 2025 at 17:04, Hans Zhang wrote:
> Is the following patch OK?

No.

>   static void
>   irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
>   {
> @@ -178,6 +199,7 @@ static int irq_debug_show(struct seq_file *m, void *p)
>          seq_printf(m, "node:     %d\n", irq_data_get_node(data));
>          irq_debug_show_masks(m, desc);
>          irq_debug_show_data(m, data, 0);
> +       irq_debug_show_msi_msix(m, data, 0);
>          raw_spin_unlock_irq(&desc->lock);
>          return 0;
>   }

This is just violating the layering and I told you what to do:

    "implement a debug_show() callback in the MSI core code and assign
     it to domain ops::debug_show() on domain creation, if it does not
     provide its own callback."

If you don't understand what I tell you, then please ask instead of
going off and hacking up something completely different.

Here is another hint:

     Look at msi_domain_ops_default and at msi_domain_update_dom_ops()

If you still have questions, feel free to ask.

Thanks,

        tglx




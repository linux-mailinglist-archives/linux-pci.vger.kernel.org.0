Return-Path: <linux-pci+bounces-22658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8DA4A139
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9790171825
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3B27002E;
	Fri, 28 Feb 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWCN2H5B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uE72Ymnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BE1F09B8;
	Fri, 28 Feb 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766449; cv=none; b=pbCbn55Rod8pzULP1EeUZbEXWBPwwzQYf/f2dGNGHeTunk2j4YBh2Q46UPJzwWEcG19W7eua+v1c4CTN4xzJfMBvWptpXIUsNx2sGRqSQ5jKqrKsIqjqVd4hrDvIHt3lvOCEFYv1l3FNnPowNaQ4Z1LyAI/C9AKqfvuLYj8Vx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766449; c=relaxed/simple;
	bh=ApjbMI3UMXaK0HDqUbTtI+NmigJsdTp/AtQknzdwLpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eX35TURXFgGHRmUMZA71SX+JwVYE9pNimGx8M9GMOPTfL4xJ2R1g1aa0FlHrK43VeJNW2mOtmQkf86S4bkucMaS7DPYC574KjiHdS3widniemsJvsHKDuMgQEOnWOm4KA8iZ6NhwPgGsqRBL23icfaQQ/pmiWTi+P3i1YKmTdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWCN2H5B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uE72Ymnp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740766444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJuRTH6j6N6i1eKbv8dqltSVcO11PyKBNmf/v8AxwZk=;
	b=AWCN2H5BcIxD93kLNrlnyFcDZn9ctGkxwZrEbM+7Jnkeo8NrOyyqGzrPh5Gs8MuqS2c8Ug
	poUW1QutUTbP+XC9FNNDzswpAgt0oOWOHg6BjXp0aa3Ez71FORsAWEx83cqvpk3Bz0LRXC
	Zmj1vml9Of8drnDq904St7X0v5Whi5pOGcXZyYB7bMfwwOX/tK0BfyPCvryI01K9Xtu4Ps
	I/bd372YHYXSFjq1x1G1sSSPddQqIOsPW7I1KOCFjcgbVX8/oQXmlkyYW7ZRhl3md98zjH
	0H2TJmIMmlLFAZQoe8GXGdW3wrgxtZ+k2k1yl0NlAHC5h0/yh9nh+wcpTy+rnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740766444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJuRTH6j6N6i1eKbv8dqltSVcO11PyKBNmf/v8AxwZk=;
	b=uE72YmnpiQ9JhYDH1VmzL5/RPkXR1Ld39wjJtdAzvA6HhtaBTpwDHVKXYJjOfRuvd3/6sf
	IJtFJUFSeZzwlKCA==
To: Hans Zhang <18255117159@163.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
 cassel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
In-Reply-To: <86d23e69-e6e5-476b-9582-28352852ea94@163.com>
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad> <877c5be0no.ffs@tglx>
 <251ce5c0-8c10-4b29-9ffb-592e908187fd@163.com> <874j0ee2ds.ffs@tglx>
 <86d23e69-e6e5-476b-9582-28352852ea94@163.com>
Date: Fri, 28 Feb 2025 19:14:04 +0100
Message-ID: <87v7suc4yb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 28 2025 at 23:17, Hans Zhang wrote:
> I'm very sorry that I didn't understand what you meant at the
> beginning.

No problem.

>
> +static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
> +                                 struct irq_data *irqd, int ind)
> +{
> +       struct msi_desc *desc;
> +       bool is_msix;
> +
> +       desc = irq_get_msi_desc(irqd->irq);
> +       if (!desc)
> +               return;
> +
> +       is_msix = desc->pci.msi_attrib.is_msix;
> +       seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
> +       seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "",
> +                  desc->msg.address_hi);

No need for these line breaks. You have 100 characters available.

> +       seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "",
> +                  desc->msg.address_lo);
> +       seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "",
> +                  desc->msg.data);
> +}
> +
>   static const struct irq_domain_ops msi_domain_ops = {
>          .alloc          = msi_domain_alloc,
>          .free           = msi_domain_free,
>          .activate       = msi_domain_activate,
>          .deactivate     = msi_domain_deactivate,
>          .translate      = msi_domain_translate,
> +       .debug_show     = msi_domain_debug_show,
>   };

Looks about right.

Thanks,

        tglx


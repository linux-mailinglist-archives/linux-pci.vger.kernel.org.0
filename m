Return-Path: <linux-pci+bounces-44708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5349D1CDC7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40068300F6AD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A437A49B;
	Wed, 14 Jan 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTe37hRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69037A489
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376114; cv=none; b=pGLFdFCFYSbmB+uKSZmjeUHFDGswvcC0qbffp8Zr8ea0hgKL68AfAdj1CnkplSUMdTlS4EmmzlpwiYNpgZNjQVEWSsLRivmMUuk0Mv380QB11jYWSL09HpVcuKe9ueNkolkdHy4mwSxQYVJFmlUiylyQYu2mKHRy9t2TtH8i/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376114; c=relaxed/simple;
	bh=fMLEQ8/JJC69SLmKJ1xDxuFLX1RU9ZDpt5RuOzpR6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9LTjqMNJsi0r4JHPUxB2PpVOgzlMKc+/v3b+orAW0OpWiSh7yGHiHFiqW3+GkYuSt2EjQN/T8yGmkcHaaN2cpJHf4DZBaH8wjeQ4yeaTEwHylG8e7rT6zhXxs5JxWd6RQIJ9Prpyg9FV15/uJTX66+0sNxsGdeDoCkcF1E1sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTe37hRx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d0788adaso55643415ad.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 23:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376104; x=1768980904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LB+Fpf/hm5KwNRdMi25ZsdFjip0k5ynYsh5UxdTJStE=;
        b=NTe37hRxV7nzDUQcA66bF2vkc3t1WdG0gVXTkUa1eT4vQjRpl7xD7HsoyrplwIDemX
         9VqvdLE+ThA9olrb0/uqu5H/g0ZUBmmyL4nxf7PwSMLDkqZkFvm3U/w30P09sRunsob5
         B47kxGVO8J5FiLmM88v0ugyyXUVCMDxO5H5tX4bFHs8I/aGFk8HxtqTWkM45SG2wel48
         ZOAT8BTdybRDyQgXLwWyWfEBcIhl03N4UIPIQU5C8gy6V1mCU6K4RKNSds4UB8iBkZkv
         KgIQZlpWYfyceZBVaHkYsGBeclF2gkXSYuPF9eNdqxb+6ccIr9GY5k8b3BwdBxHPWAi6
         XBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376104; x=1768980904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB+Fpf/hm5KwNRdMi25ZsdFjip0k5ynYsh5UxdTJStE=;
        b=tFDsM2YqiLOKcoBsR/Wkc/QaXxCrepm5k1wSyaIJ4gKv1keKJvFRuMedLP2jSpmv42
         dy1QfXWaS4zV7GnD+ihFnGx6IrXN0iz0a7HgJraE5ERGQFLiMpk5S+GCFjn4BlLD46LX
         Y35dtY5mM/NKqHTcS1QWyGvD5AFLSwUNPTrpVKqnW5fXRCdo5xLVAdKtGTEGUdasG6E2
         jGr81CKH7P6x2MprBssmqun6AP96wRSCR2ImS/3UYcPzDF261yrmtILXy1hhK/4EnMv9
         eakqtqyZZ4VoEQ5NOnUtWduhY6oFUicKnFYLnvwMj3nMfSayaumZc9FXrjDS57aQiqXI
         NiTg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDc91q7LDMPuz5ANogK5b1Vdi1We4ahdWV25hJV60eU2mM7LF0aIE3Ud3WM9jOapU+E88ULbjrIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZK0JgumLjZUtfeVFeZMs00Qevj5q1yFFKIxLuFDPBtaaBARx
	pOAlCpmSbKLefiK2C+MVNe0UliiEGvlyh3sXRXX4CluxCGejAZ/jOYP8
X-Gm-Gg: AY/fxX68FQKbAwh55/zz8HIt6TatNUFV4FQc1b2Wq6D35orUOx+/F1dKwol/GWtNqEy
	wUWXOARzMCAXzFybLY7k08YmqfOnxDwYMXchYPEl0F0g1ICqVniWmlaID0JdxplWdek74S8K7d+
	j8rBDwtlFEysX0BZLdz1/+T8vKIVk0az8F9DIl/h0DNR9vgAmuBQKqYY5Y76ZUFFJ3bM4qAvpHZ
	XXbcz/rc19zj/tQjhgnXpYNHHhhzA0smRNNrRQ5F8Cr87d4VWMLOqsbQcMveUgxethQnv6KV/eL
	aMJiAsL77RJ4hqNDZomYqQm/0G389fo5nsxiUB60aE8FhNK3l4Er6A3YccHIPRw5qJW6mqnC8QJ
	Zsibw6s/M++xssqUnKZfnjAmoXjVtyf9ITmks7DjuFRPLLBdwVLa9vO5PNWnDxlv5mTv6svn+Sz
	WAmDGa+1UmN40yi8kQfzzmgrFlXYE0
X-Received: by 2002:a17:902:da82:b0:2a0:c884:7f09 with SMTP id d9443c01a7336-2a599e098bfmr16494275ad.38.1768376103935;
        Tue, 13 Jan 2026 23:35:03 -0800 (PST)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35106914b1esm911374a91.1.2026.01.13.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:35:03 -0800 (PST)
Date: Wed, 14 Jan 2026 11:34:23 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] pci_read_bridge_bases: skip prefetch window if
 pref_window not set?
Message-ID: <aWdG/9N2C/7L5sFQ@DESKTOP-TIT0J8O.localdomain>
References: <aWTBrOzw73FLvsUb@DESKTOP-TIT0J8O.localdomain>
 <20260113210259.GA715789@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113210259.GA715789@bhelgaas>

On Tue, Jan 13, 2026 at 03:02:59PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 12, 2026 at 01:41:00PM +0400, Ahmed Naseef wrote:
> >   [  160.238227] mtk-pcie 1fb83000.pcie: EN7528: port1 link trained to Gen2
> 
> Can we look forward to a patch to add support for EN7528?

Definitely. Someone else is working on PCIe support for EN751221
(same SoC family). Once everything is consolidated, we plan to submit
a unified patch to drivers/pci/controller/pcie-mediatek.c.

> > PCI_PREF_MEMORY_LIMIT which both return 0x0000. This results in base = 0
> > and limit = 0. The condition "if (base <= limit)" evaluates to true
> > (since 0 <= 0), so a bogus prefetch window [mem 0x00000000-0x000fffff pref]
> > is created.
> 
> It's too bad we didn't log this in dmesg.  It looks like we claimed
> there was a [mem 0x28100000-0x282fffff pref] window.

Should I add logging for this as part of the patch? If so, could you
suggest where and what format would be appropriate?
> 
> > 
> >         pci_read_bridge_io(child->self, child->resource[0], false);
> >         pci_read_bridge_mmio(child->self, child->resource[1], false);
> > -       pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
> > +       if (dev->pref_window)
> > +               pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
> 
> This seems reasonable to me, but I wonder if we should put the test
> inside pci_read_bridge_mmio_pref() instead of relying on the caller to
> do the test?
> 
> Also, I suspect the IO window has a similar problem since it is also
> optional.  What do you think?
> 

You're right on both points. Updated patch below with checks inside
both functions:


---
From: Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH] PCI: Skip bridge window reads when window is not supported

pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
registers unconditionally. If the registers are hardwired to zero
(not implemented), both base and limit will be 0. Since (0 <= 0) is
true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
gets created.

pci_read_bridge_windows() already detects unsupported windows by
testing register writability and sets io_window/pref_window flags
accordingly. Check these flags at the start of pci_read_bridge_io()
and pci_read_bridge_mmio_pref() to skip reading registers when the
window is not supported.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -351,6 +351,9 @@ static void pci_read_bridge_io(struct pc
        unsigned long io_mask, io_granularity, base, limit;
        struct pci_bus_region region;

+       if (!dev->io_window)
+               return;
+
        io_mask = PCI_IO_RANGE_MASK;
        io_granularity = 0x1000;
        if (dev->io_window_1k) {
@@ -412,6 +415,9 @@ static void pci_read_bridge_mmio_pref(st
        pci_bus_addr_t base, limit;
        struct pci_bus_region region;

+       if (!dev->pref_window)
+               return;
+
        pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
        pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
        base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
		
		
Once you confirm, I will send this as a fresh patch.

Best regards,
Ahmed Naseef


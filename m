Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35203460944
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhK1TXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 14:23:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhK1TVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 14:21:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638127077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JUkgr1+1xpaGfU+RedPaRQmMTBII3kcX9LK2s6OBK4=;
        b=OwlJzKpXh6HUO0d3S226LkHX0VBEv/ZMGzpouZpDaknUBEWmnL8N2ToysfCkKrXjYYLOZt
        iVHuFafr0na37AQ6l9x85IxpDbPbsDoXGIi4PG8PTi0OhrcrYJoC+WaQfVt0vabA2eV+em
        Ng7psNOZAIZ6xyzx621ez74kPw534jLdfrViT1k8TelbaOpr2LqjSUYcbp1OmtUlpO8Rg4
        hfzXc9Jnehb8NHUubdd/cHrAjk8X0duzPRgkrYbGSvWuwrfUsk87VbsYQiNw3269IIlODP
        uCKRHXUM+mb3iSajZoLTXqvgYDA9blbP6Sp/JVA16AG7rVFKHfUjui+S06A1ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638127077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JUkgr1+1xpaGfU+RedPaRQmMTBII3kcX9LK2s6OBK4=;
        b=JXCAyg87l9Mmdgu7jORXkXxXfTo1i6k+92QcrgQ4LwuGTC1qebUkIJsKOUQq12BUqiQCat
        D/zS/UZaK15PW0BA==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [patch 03/10] genirq/msi: Make MSI descriptor alloc/free ready
 for range allocations
In-Reply-To: <8735ngs26o.wl-maz@kernel.org>
References: <20211126233124.618283684@linutronix.de>
 <20211127000918.664542907@linutronix.de> <8735ngs26o.wl-maz@kernel.org>
Date:   Sun, 28 Nov 2021 20:17:56 +0100
Message-ID: <87a6hof5sr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 28 2021 at 15:57, Marc Zyngier wrote:
> On Sat, 27 Nov 2021 01:24:34 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The issue seems to be originating in the previous patch, where the
> following line was added:
>
> +	struct msi_range range = { .first = 0, .last = UINT_MAX, .ndesc = nvec, };
>
> In that context, only 'ndesc' was used, and that was fine.
>
> However, in the current patch, ndesc use is removed, only first/last
> are considered, and UINT_MAX is... a lot of MSIs.
>
> This fixes it:
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index bef5b74a7268..a520bfd94a56 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -975,7 +975,7 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device
>   */
>  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
>  {
> -	struct msi_range range = { .first = 0, .last = UINT_MAX, .ndesc = nvec, };
> +	struct msi_range range = { .first = 0, .last = nvec - 1, .ndesc = nvec, };
>  	int ret;
>  
>  	msi_lock_descs(dev);
>
> However, it'd be good to clarify the use of range->ndesc.

Hrm. The stupid search should terminated nevertheless. Let me stare at
it again.

>> -static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
>> +static int msi_add_simple_msi_descs(struct device *dev, struct msi_range *range)
>
> nit: most of the functions changed in this patch need to have their
> documentation tidied up.

Duh, yes.

Thanks,

        tglx

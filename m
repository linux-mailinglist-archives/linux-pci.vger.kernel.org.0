Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3187E44AFC6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhKIO4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 09:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhKIO4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 09:56:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BE9C061764
        for <linux-pci@vger.kernel.org>; Tue,  9 Nov 2021 06:53:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636469604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ian5WC377Q5J1422EbugqDjUg/d1iF+4GVOSXbtW1CU=;
        b=S0B47+AyYzHjgDycjapB4jUsuSQ0WhoRfZvITzrkGuizXefOT+wd9cAU5qdWN1zEw4ix9Y
        uGXBel0gE53jodICP+wZoO+q+SrYEDvHe4iqrq4hEKOjQiQQBYV5UBVOdtiqTRONe3ejAJ
        k7Xb1R/1HV9KhBC4FiWdcAePziEmuzArHt5YMu6FDN7ablVcDN+0SoK1ludZdX/5r4Y0cK
        1MdSneRQ3oKuWhcM0AibpvQWsCbro+ucTHqMzJ5MavHDBiUMJqbUhIgpPFW56HpxiPl+0/
        4d+lHMPi4uYThCr602JP5QwSONLAT7qvgHxBuNteIbl5AmBnH3WYtcCYe2F4MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636469604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ian5WC377Q5J1422EbugqDjUg/d1iF+4GVOSXbtW1CU=;
        b=/mEresaFf1XyR7ByvtZXr21ZVKsmrxmOn1cj/DgnGshHlFf5urVL984K7Wz8zoHcUTn3qq
        pdi8sCHw5rUi7pAQ==
To:     Josef Johansson <josef@oderland.se>
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jgross@suse.com,
        linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org, Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI/MSI: Move non-mask check back into low level
 accessors
In-Reply-To: <87h7cs6cri.ffs@tglx>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx> <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
 <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se> <87k0ho6ctu.ffs@tglx>
 <87h7cs6cri.ffs@tglx>
Date:   Tue, 09 Nov 2021 15:53:23 +0100
Message-ID: <87pmr92xek.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04 2021 at 00:27, Thomas Gleixner wrote:
>  
> -		if (!entry->msi_attrib.is_virtual) {
> +		if (!entry->msi_attrib.can_mask) {

Groan. I'm a moron. This obviously needs to be

		if (entry->msi_attrib.can_mask) {

>  			addr = pci_msix_desc_addr(entry);
>  			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  		}

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4002A5A32
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgKCWmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:42:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCWmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 17:42:49 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604443368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxfvdBHnfbE+NLxg4nLzP/fWnawWLL9RQKr5XcFxvrk=;
        b=Ri0rriNmvG0PQzHx2g59t4aHDxB0PhOg1vuvKteN3D98F4FtA6lEr0WHo2k7HS78TqvaNH
        HKwqGYCjRpll2pox60moN8yp432lYiP++jXiForlldmrgnkz3W5DMkJHmCcmji5YmLCoqL
        tIvBCLh4A/1oKlwCKC7Get1oyYSs4C+IoxcuejDhluTvReY8CFcu8itT9PwwTt8vxEqY2+
        ePRph1BfJSJSicE5PwjGlga3IJllnbIV+NLVd6QqiWVfDq9SvH8h9IBurwwrgDcLe7zcN7
        OPVtDNuLxcGQ5AbMhEkpjUoLN5MY30JChj1pfFw+nF6aLZ+73Yuf0aPN1bGfqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604443368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxfvdBHnfbE+NLxg4nLzP/fWnawWLL9RQKr5XcFxvrk=;
        b=fj+tmdBqjOOtms5X6X6AE6xyzr/3mldXS+HGczzGVgHu+ze1SwQpK3Jt5eP+WDBJb5DXHe
        LSjErP9kA8uAl1Bw==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Thomas Krause <thomaskrause@posteo.de>,
        ath11k@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
In-Reply-To: <874km61732.fsf@nanos.tec.linutronix.de>
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
Date:   Tue, 03 Nov 2020 23:42:47 +0100
Message-ID: <87wnz2ysd4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03 2020 at 22:08, Thomas Gleixner wrote:
> On Tue, Nov 03 2020 at 10:08, Bjorn Helgaas wrote:
>>> > But it seems a little greedy if the device can't operate at all unless
>>> > it gets 32 vectors.  Are you sure that's a hard requirement?  Most
>>> > devices can work with fewer vectors, even if it reduces performance.
>
> Right, even most high end network cards work with one interrupt.
>
>>> This was my first reaction as well when I saw the code for the first
>>> time. And the reply I got is that the firmware needs all 32 vectors, it
>>> won't work with less.
>
> Great design.

Just to put more information to this:

Enforcing 32 vectors with MSI is beyond silly. Due to the limitations of
MSI all of these vectors will be affine to a single CPU unless irq
remapping is available and enabled.

So if irq remapping is not enabled, then what are the 32 vectors buying?
Exactly nothing because they just compete to be handled on the very same
CPU. If the design requires more than one vector, then this should be
done with MSI-X (which allows individual affinities and individual
masking).

That's known for 20 years and MSI-X exists for exactly that reason. But
hardware people still insist on implementing MSI (probably because it
saves 0.002$ per chip).

But there is also the firmware side. Enforcing the availability of 32
vectors on MSI is silly to begin with as explained above, but it's also
silly given the constraints of the x86 vector space. It takes just 6
devices having the same 32 vector requirement to exhaust it. Oh well...

Thanks,

        tglx









Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348602C4DC3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgKZDWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 22:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbgKZDWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 22:22:55 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32A9C0613D4;
        Wed, 25 Nov 2020 19:22:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ChNP64Xkcz9sVH;
        Thu, 26 Nov 2020 14:22:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606360970;
        bh=VD5TisT5ZeXiMTVV+mDfjwYZ697RK3H5XI2Uko5WKkQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MJHv2k+GKeIIexh6flzGS3pN64+Ne0G3xu1HEQevZlgqQAYfBoy6718zQWX00aK6k
         +VKWdlRnCxwm9B1iUBocNkhxMSi7ZSTovQiwl/GD4NfNZpE1Mg6ntG0Lc1WrYo5/79
         AWMeJ9mSdvIRqmbHCouDkIny1coi3HxENAksR+LmNkUoI2w8bKKQv+EX41YgCnoDJ9
         0RMWQsRAcP3PeCyg4fzzcJeMAukIJXu549Ea3ttEjdngP6X5CDFnNSo/BK4rUoW/Ix
         BPLOtEkITCp7TLQeWV21hmOfeGNGtLRZFwQT9y45O1BPX0bzhk4nany0UxTgeSbA/Y
         qRMypA7QEjKNA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
In-Reply-To: <20201125150932.1150619-3-lvivier@redhat.com>
References: <20201125150932.1150619-1-lvivier@redhat.com> <20201125150932.1150619-3-lvivier@redhat.com>
Date:   Thu, 26 Nov 2020 14:22:49 +1100
Message-ID: <87zh34yf7a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Laurent Vivier <lvivier@redhat.com> writes:
> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>
> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
> this is broken on pseries.
>
> The affinity is correctly computed in msi_desc but this is not applied
> to the system IRQs.
>
> It appears the affinity is correctly passed to rtas_setup_msi_irqs() but
> lost at this point and never passed to irq_domain_alloc_descs()
> (see commit 06ee6d571f0e ("genirq: Add affinity hint to irq allocation"))
> because irq_create_mapping() doesn't take an affinity parameter.
>
> As the previous patch has added the affinity parameter to
> irq_create_mapping() we can forward the affinity from rtas_setup_msi_irqs()
> to irq_domain_alloc_descs().
>
> With this change, the virtqueues are correctly dispatched between the CPUs
> on pseries.
>
> BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1702939
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  arch/powerpc/platforms/pseries/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 133f6adcb39c..b3ac2455faad 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  			return hwirq;
>  		}
>  
> -		virq = irq_create_mapping(NULL, hwirq);
> +		virq = irq_create_mapping_affinity(NULL, hwirq,
> +						   entry->affinity);
>  
>  		if (!virq) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
> -- 
> 2.28.0

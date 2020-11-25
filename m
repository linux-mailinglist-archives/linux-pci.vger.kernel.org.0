Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C12C44A4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgKYQGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 11:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgKYQGF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 11:06:05 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A88C061A4F
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 08:05:58 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so3076989edq.11
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sFDVHTtkdm3pyH75COND6ic4pQck9okc86/RtBFvaVI=;
        b=hMOkWMlqnjT5T3KheRXSvbIdWc0NiEKFzBE+kepT432F8AjcasejaLcbsYL3gRcK6J
         ktpTpW0CXLElE2ZL7r4kx+Sf/JXLCyemIYnO5j9/Gtw70XK0s4XXnBiaQW1OpYZgcm0q
         dGisF1IsRKDGTQLvcv56O+lvXfQSSNi1VCt5gnxq2iutLJThlpEoZzYNE2JMcFjo9gJ1
         qon852mKOuNW3HCJUF3xnnG6FWaC8o5Tn4RA6g/rPsz7N8e/gK1ml4P2l5sPsFQaq5Rt
         a9Tkd8knovVbgYgj9lrrk9Cc7sHyCadeUeHiOh3wMvr2n8O1sX2mb1g3YhHY5xXTyHGc
         RdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sFDVHTtkdm3pyH75COND6ic4pQck9okc86/RtBFvaVI=;
        b=QC0bSCddk9R3VrMab++QAx7vEAhmtUkuv6BMigUoYZn7JU0TV0NcQvoYdLWdJC1HjN
         g37EKB6prv+ssOoUrEd88fI0EAnTSPzqnfT1OcJS8IN25nrbAjUw73mCg9QUqAarqv0O
         sEgR/598N2g2mdGgaf+W75iqa8ftAN5vKrkemdm0svNq7iOV6XVTFPrHtFQy3u/cqPDV
         Ziqc0CRn9aLFlGQyCxWDYzA1up5uq8noOgwSSNCGXpYZ1jifng57dGbXFEQ3JrMG5Y4r
         I82/rKbPKEGm4OMYQ143O9363aH3wBnCH5Z1V2zYvGceAUVKLm16sKXsTz0oLrhb8f+3
         ht7Q==
X-Gm-Message-State: AOAM532J5d0F1ObWEQNKmsP4yiHMH5qvUqIza88YgaRYVcbXRfTOUKGG
        zr0vQ8OkOaF2kAiE6p18kBu9oxfUPm386MTvRF6YIw==
X-Google-Smtp-Source: ABdhPJy6ob6fmz+u3HhkWotLkhYtQfkABfyx5NZ0czbNVWC4DVmL/HNnVx5U7U6w0UNe2yt5Khw04Spvyi6e7OSzN8E=
X-Received: by 2002:a05:6402:22e3:: with SMTP id dn3mr4377399edb.136.1606320357550;
 Wed, 25 Nov 2020 08:05:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:3cc7:0:0:0:0:0 with HTTP; Wed, 25 Nov 2020 08:05:56
 -0800 (PST)
X-Originating-IP: [5.35.99.104]
In-Reply-To: <20201125150932.1150619-3-lvivier@redhat.com>
References: <20201125150932.1150619-1-lvivier@redhat.com> <20201125150932.1150619-3-lvivier@redhat.com>
From:   Denis Kirjanov <kda@linux-powerpc.org>
Date:   Wed, 25 Nov 2020 19:05:56 +0300
Message-ID: <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>
> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
> this is broken on pseries.

Please add "Fixes" tag.

Thanks!

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
>
> diff --git a/arch/powerpc/platforms/pseries/msi.c
> b/arch/powerpc/platforms/pseries/msi.c
> index 133f6adcb39c..b3ac2455faad 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int
> nvec_in, int type)
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
>
>

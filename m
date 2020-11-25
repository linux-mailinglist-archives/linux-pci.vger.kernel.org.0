Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76742C42A9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgKYPJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 10:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730000AbgKYPJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 10:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606316993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OF2J9jPc1enDRWyVFgsxR7bgb+tRz6aRbb/wZgWmBXg=;
        b=LBGjWeYTeq+9kTIKe/PZtIBQkqB8IqMGpLkpN9hFui590pDFSOn0LSOtBrOSckIU26eXfK
        7S7vkd5HLReAfSHOdlrBo5q/7Ep4RbAApy3RKO+W41ZnqsLbrz+KB7i/v+WenAb3putTkX
        9/34e14tjEvbdWu13rcGhA2t6B9vB6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-9xlcPGy-NJqV3T8cuBWyXw-1; Wed, 25 Nov 2020 10:09:48 -0500
X-MC-Unique: 9xlcPGy-NJqV3T8cuBWyXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434E710066FC;
        Wed, 25 Nov 2020 15:09:46 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05D435C1A3;
        Wed, 25 Nov 2020 15:09:42 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
Date:   Wed, 25 Nov 2020 16:09:32 +0100
Message-Id: <20201125150932.1150619-3-lvivier@redhat.com>
In-Reply-To: <20201125150932.1150619-1-lvivier@redhat.com>
References: <20201125150932.1150619-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With virtio multiqueue, normally each queue IRQ is mapped to a CPU.

But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
this is broken on pseries.

The affinity is correctly computed in msi_desc but this is not applied
to the system IRQs.

It appears the affinity is correctly passed to rtas_setup_msi_irqs() but
lost at this point and never passed to irq_domain_alloc_descs()
(see commit 06ee6d571f0e ("genirq: Add affinity hint to irq allocation"))
because irq_create_mapping() doesn't take an affinity parameter.

As the previous patch has added the affinity parameter to
irq_create_mapping() we can forward the affinity from rtas_setup_msi_irqs()
to irq_domain_alloc_descs().

With this change, the virtqueues are correctly dispatched between the CPUs
on pseries.

BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1702939
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 arch/powerpc/platforms/pseries/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 133f6adcb39c..b3ac2455faad 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 			return hwirq;
 		}
 
-		virq = irq_create_mapping(NULL, hwirq);
+		virq = irq_create_mapping_affinity(NULL, hwirq,
+						   entry->affinity);
 
 		if (!virq) {
 			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
-- 
2.28.0


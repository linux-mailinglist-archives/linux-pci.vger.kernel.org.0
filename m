Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42A2C5079
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbgKZI3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 03:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388864AbgKZI3T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 03:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saFRkzBjwNYVIzOFQ9gg9qkqgMtu8TL9hGt5bH7Do50=;
        b=PQ6AT20aBZVzAjAAGeFUePFhXmnSU5mVWuKW1+TXi6MTRFmyYKnJ4DK6w8RXv+zwPgaXqz
        rlL3AY2jC0Uv+tNVoah+JP75omq0B0xQhSb8IVcniL+rWNyuCFiq7hzdv0e0+6uO/wZiRv
        hH5SNhXIFKHCVgxtU1KHr8Vo5KhWnO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-TcFidZI_MIehiIoxx3YsYg-1; Thu, 26 Nov 2020 03:29:12 -0500
X-MC-Unique: TcFidZI_MIehiIoxx3YsYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C36AA10151E7;
        Thu, 26 Nov 2020 08:29:10 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 066E45C1B4;
        Thu, 26 Nov 2020 08:29:07 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 2/2] powerpc/pseries: Pass MSI affinity to irq_create_mapping()
Date:   Thu, 26 Nov 2020 09:28:52 +0100
Message-Id: <20201126082852.1178497-3-lvivier@redhat.com>
In-Reply-To: <20201126082852.1178497-1-lvivier@redhat.com>
References: <20201126082852.1178497-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With virtio multiqueue, normally each queue IRQ is mapped to a CPU.

Commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity") exposed
an existing shortcoming of the arch code by moving virtio_scsi to
the automatic IRQ affinity assignment.

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

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3D2C3EE9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 12:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKYLRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 06:17:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbgKYLRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 06:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606303037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zu/0xmXlaDABvq6r7zqamQ2WuJBTK7BYJVbbGKeJBKY=;
        b=AWFLdXJ7ofylgmVaCIuzg1eOlnNcU7213qJEP2vrGcXnTM0TMMxbcGhAtmZ1hHIHKW2+wI
        qNngsbcIh47ywXS0SpuisnTcguvitLM6oFEWiqIGvemCKkvKNF+jdXYWiZIk6C44N2EUoF
        sVZHPocM+3fS/GcdWaVpJLCICq5sOVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-UBfojiHJNpiYo2Nr2nIqkQ-1; Wed, 25 Nov 2020 06:17:13 -0500
X-MC-Unique: UBfojiHJNpiYo2Nr2nIqkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B4C1005D44;
        Wed, 25 Nov 2020 11:17:11 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452F3100AE32;
        Wed, 25 Nov 2020 11:17:08 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
Date:   Wed, 25 Nov 2020 12:16:57 +0100
Message-Id: <20201125111657.1141295-3-lvivier@redhat.com>
In-Reply-To: <20201125111657.1141295-1-lvivier@redhat.com>
References: <20201125111657.1141295-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
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


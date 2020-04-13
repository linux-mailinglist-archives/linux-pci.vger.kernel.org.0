Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2201A66C4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgDMNJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 09:09:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729762AbgDMNJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 09:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586783395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sJD8oGD7PYCy/FWovcDdMiLIk0TuWYP2CDrm3wgFKwY=;
        b=M50oA/cKRPRtcpDdbrT/6P8H8D46eWD1F/Dj4ayCXzGwyD+aqCzGd6gt0tpYfCIJgSiPSJ
        Xvra7Ut2kvsq84auNd1FxI538DVc/7i8yn1908eFTPOQtJclAO+OSGFgwPSGx80zwBrpHc
        iguy5a4ljKDoagtfResuXSaKJH7q110=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-DEwraSvuOcaIYwYW7ApPkQ-1; Mon, 13 Apr 2020 09:09:54 -0400
X-MC-Unique: DEwraSvuOcaIYwYW7ApPkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB4FC8017F3;
        Mon, 13 Apr 2020 13:09:52 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-27.ams2.redhat.com [10.36.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74D3760BE1;
        Mon, 13 Apr 2020 13:09:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] ACPI/PCI: pci_link: use extended_irq union member when setting ext-irq shareable
Date:   Mon, 13 Apr 2020 15:09:49 +0200
Message-Id: <20200413130949.302829-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
is correctly using resource->res.data.extended_irq.foo for most settings,
but for the shareable setting it so far has accidentally been using
resource->res.data.irq.shareable instead of
resource->res.data.extended_irq.shareable.

Note that the old code happens to also work because the shareable field
offset is the same for both the acpi_resource_irq and
acpi_resource_extended_irq structs.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Fix some spelling errors in the commit message pointed out by Bjorn
- Add Bjorn's Acked-by
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 00a6da2121be..ed3d2182cf2c 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -322,10 +322,10 @@ static int acpi_pci_link_set(struct acpi_pci_link *=
link, int irq)
 		resource->res.data.extended_irq.polarity =3D
 		    link->irq.polarity;
 		if (link->irq.triggering =3D=3D ACPI_EDGE_SENSITIVE)
-			resource->res.data.irq.shareable =3D
+			resource->res.data.extended_irq.shareable =3D
 			    ACPI_EXCLUSIVE;
 		else
-			resource->res.data.irq.shareable =3D ACPI_SHARED;
+			resource->res.data.extended_irq.shareable =3D ACPI_SHARED;
 		resource->res.data.extended_irq.interrupt_count =3D 1;
 		resource->res.data.extended_irq.interrupts[0] =3D irq;
 		/* ignore resource_source, it's optional */
--=20
2.26.0


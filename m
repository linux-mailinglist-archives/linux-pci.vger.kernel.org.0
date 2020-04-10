Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15141A46A1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDJNOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 09:14:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgDJNOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 09:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586524491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UgrYcoVu9FKjPVruinahWgmUMbCGqdc7Uj5CG/o/3e0=;
        b=BE9EH8I0b69cJWf6b5ek2piRbFy/Ap0GHI3HZY5x6NlU2+d91kU+Ugv+qQyL7Lm+HagYbS
        C3o74ylcZrk8oL0ZswTgktlfFIcKktH4DLfkUX14f5GJhU2+6WtshHIOS1DeUB6lePbcx8
        2FW6R21rZ68uYCsOgSO7hVTOd8pivK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-XHtnpSRtO6i9i5L_NmSftw-1; Fri, 10 Apr 2020 09:14:47 -0400
X-MC-Unique: XHtnpSRtO6i9i5L_NmSftw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8709D8017F3;
        Fri, 10 Apr 2020 13:14:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB5210027A9;
        Fri, 10 Apr 2020 13:14:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] ACPI/PCI: pci_link: use extended_irq union member when setting ext-irq shareable
Date:   Fri, 10 Apr 2020 15:14:42 +0200
Message-Id: <20200410131442.22842-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
is correctly using resource->res.data.extended_irq.foo for most settings,
but for the sharable setting it sofar has accidentally been using
resource->res.data.irq.shareable instead of
resource->res.data.extended_irq.shareable.

Note that the old code happens to also work because the sharable field
offset is the same for both the acpi_resource_irq and
acpi_resource_extended_irq structs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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


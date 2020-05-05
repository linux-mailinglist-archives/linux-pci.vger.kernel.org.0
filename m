Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4736B1C56A6
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgEENVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:21:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728892AbgEENVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 09:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXvOfYNLxP2n9KMtCvZ22eK9RVc3+f2D2Cb9gIn69YQ=;
        b=GhzSTl6tu9Qtq5m5onQdcqkbnZJ7qwFhqFE+cDV1xIgRMeAA/HMV+JZF6KAnvnwCmf+Osq
        y8z8kTZSnQ9XL44L+5czkATDLgKOH7pKW+Mo7Vz6SiVQNzbx5/chKdzWOyJkRtBiGqoasN
        61QC7m3ChM6zXvWKJmGZgIf2JQG345I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-i4ij7bCGNJOK2v75-TcwWg-1; Tue, 05 May 2020 09:21:42 -0400
X-MC-Unique: i4ij7bCGNJOK2v75-TcwWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1CCE8014D7;
        Tue,  5 May 2020 13:21:40 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E16D26060E;
        Tue,  5 May 2020 13:21:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/3] ACPI / utils: Add acpi_evaluate_reg() helper
Date:   Tue,  5 May 2020 15:21:26 +0200
Message-Id: <20200505132128.19476-2-hdegoede@redhat.com>
In-Reply-To: <20200505132128.19476-1-hdegoede@redhat.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With a recent fix to the pinctrl-cherryview driver we know have
2 drivers open-coding the parameter building / passing for calling
_REG on an ACPI handle.

Add a helper for this, so that these 2 drivers can be converted to this
helper.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/utils.c    | 25 +++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 804ac0df58ec..838b719ec7ce 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -605,6 +605,31 @@ acpi_status acpi_evaluate_lck(acpi_handle handle, in=
t lock)
 	return status;
 }
=20
+/**
+ * acpi_evaluate_reg: Evaluate _REG method to register OpRegion presence
+ * @handle: ACPI device handle
+ * @space_id: ACPI address space id to register OpRegion presence for
+ * @function: Parameter to pass to _REG one of ACPI_REG_CONNECT or
+ *            ACPI_REG_DISCONNECT
+ *
+ * Evaluate device's _REG method to register OpRegion presence.
+ */
+acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 funct=
ion)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object params[2];
+
+	params[0].type =3D ACPI_TYPE_INTEGER;
+	params[0].integer.value =3D space_id;
+	params[1].type =3D ACPI_TYPE_INTEGER;
+	params[1].integer.value =3D function;
+	arg_list.count =3D 2;
+	arg_list.pointer =3D params;
+
+	return acpi_evaluate_object(handle, "_REG", &arg_list, NULL);
+}
+EXPORT_SYMBOL(acpi_evaluate_reg);
+
 /**
  * acpi_evaluate_dsm - evaluate device's _DSM method
  * @handle: ACPI device handle
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a92bea7184a8..5afb6ceb284f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -44,6 +44,7 @@ acpi_status acpi_execute_simple_method(acpi_handle hand=
le, char *method,
 				       u64 arg);
 acpi_status acpi_evaluate_ej0(acpi_handle handle);
 acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
+acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 funct=
ion);
 bool acpi_ata_match(acpi_handle handle);
 bool acpi_bay_match(acpi_handle handle);
 bool acpi_dock_match(acpi_handle handle);
--=20
2.26.0


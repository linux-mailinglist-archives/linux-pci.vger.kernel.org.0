Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD461C8741
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgEGKt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 06:49:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgEGKt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 06:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588848567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8d5UnaBrJ94u+C+q660aZhujQBvIyXQp2TJsVImovW0=;
        b=ZZSowXstbjMaPV/rq6RCHfzW/VyivqVlR3DMzK9RfbJRVWJo294REpvRFXFxx5XaNPDxxl
        RFSCVtMx9RnHSElwfiy+lwpH2n/73fSp6QetFi3JYYxYCPbkWU0ALc4MKmqY+p+EwHIJeI
        hGioSFTBH0VXng/E9Y5KYF5lsfxdt88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-lz4kF447Oz2oW5jkCD2Ktg-1; Thu, 07 May 2020 06:49:24 -0400
X-MC-Unique: lz4kF447Oz2oW5jkCD2Ktg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2F51030985;
        Thu,  7 May 2020 10:49:22 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-120.ams2.redhat.com [10.36.115.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 872E960C81;
        Thu,  7 May 2020 10:49:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2 2/2] ACPI / hotplug / PCI: Use the new acpi_evaluate_reg() helper
Date:   Thu,  7 May 2020 12:49:17 +0200
Message-Id: <20200507104917.116589-2-hdegoede@redhat.com>
In-Reply-To: <20200507104917.116589-1-hdegoede@redhat.com>
References: <20200507104917.116589-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new acpi_evaluate_reg() helper in the acpiphp_glue.c code.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Leave comment about not caring about _REG errors in place
- Add Bjorn's Acked-by
- Add Andy's Reviewed-by
---
 drivers/pci/hotplug/acpiphp_glue.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b3869951c0eb..b4c92cee13f8 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -385,19 +385,12 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
 static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
-	union acpi_object params[2];
-	struct acpi_object_list arg_list;
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
-		arg_list.count = 2;
-		arg_list.pointer = params;
-		params[0].type = ACPI_TYPE_INTEGER;
-		params[0].integer.value = ACPI_ADR_SPACE_PCI_CONFIG;
-		params[1].type = ACPI_TYPE_INTEGER;
-		params[1].integer.value = 1;
 		/* _REG is optional, we don't care about if there is failure */
-		acpi_evaluate_object(func_to_handle(func), "_REG", &arg_list,
-				     NULL);
+		acpi_evaluate_reg(func_to_handle(func),
+				  ACPI_ADR_SPACE_PCI_CONFIG,
+				  ACPI_REG_CONNECT);
 	}
 }
 
-- 
2.26.0


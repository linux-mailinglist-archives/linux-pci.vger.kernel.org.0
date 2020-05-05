Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D611C56A9
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgEENVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728996AbgEENVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 09:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCVuo/wWVMtEixMAsPUx+ERNNUL83pR0CaQxlVIb/Cs=;
        b=LjVL7TA4UtgNses7tJTb39Bl5zIRHD6jmE0x2MWxp52t7b4ZQuSTeGFzWlPj2ZYAmD8nik
        ucDfXy69Hb3/uWSvWgxb4GJYcJhWSLJ7FeWqqFQFk0igzRgmTprIGFIoBgv3m+jbDpr2Uh
        YN7GCFVUiQVsloaN8FAyYVwie6ef9lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-irMXFVHKMEGlX47Pv6O8bg-1; Tue, 05 May 2020 09:21:46 -0400
X-MC-Unique: irMXFVHKMEGlX47Pv6O8bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5348014C1;
        Tue,  5 May 2020 13:21:45 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3787B6060E;
        Tue,  5 May 2020 13:21:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: cherryview: Use the new acpi_evaluate_reg() helper
Date:   Tue,  5 May 2020 15:21:28 +0200
Message-Id: <20200505132128.19476-4-hdegoede@redhat.com>
In-Reply-To: <20200505132128.19476-1-hdegoede@redhat.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new acpi_evaluate_reg() helper in the pinctrl-cherryview code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl=
/intel/pinctrl-cherryview.c
index 4817aec114d6..579bdfcfab8f 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1693,8 +1693,6 @@ static acpi_status chv_pinctrl_mmio_access_handler(=
u32 function,
=20
 static int chv_pinctrl_probe(struct platform_device *pdev)
 {
-	struct acpi_object_list input;
-	union acpi_object params[2];
 	struct chv_pinctrl *pctrl;
 	struct acpi_device *adev;
 	acpi_status status;
@@ -1765,13 +1763,8 @@ static int chv_pinctrl_probe(struct platform_devic=
e *pdev)
 	 * the GeneralPurposeIo OpRegion. Manually call _REG here so that
 	 * the DSDT-s GeneralPurposeIo availability checks will succeed.
 	 */
-	params[0].type =3D ACPI_TYPE_INTEGER;
-	params[0].integer.value =3D ACPI_ADR_SPACE_GPIO;
-	params[1].type =3D ACPI_TYPE_INTEGER;
-	params[1].integer.value =3D 1;
-	input.count =3D 2;
-	input.pointer =3D params;
-	acpi_evaluate_object(adev->handle, "_REG", &input, NULL);
+	acpi_evaluate_reg(adev->handle, ACPI_ADR_SPACE_GPIO,
+			  ACPI_REG_CONNECT);
=20
 	platform_set_drvdata(pdev, pctrl);
=20
--=20
2.26.0


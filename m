Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E821C20D0
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 00:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEAWlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 18:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgEAWlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 18:41:11 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711B02166E;
        Fri,  1 May 2020 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588372870;
        bh=vjj+7lcCDka5+E7zCuxC4C379fd2Pjk82c9vNNVco5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fx0X9R0xyePeIGrwhwsKCIbnTb6MJn46OqHb9tcSiMqLr9dr3G1mMbn67Jts0/gCR
         r0AjcdgcGs6nLhYlgBk7VE8Ymolh1d6IAGCPmVwaD1synztIwlX815LClHBtp6NDq1
         ULZSOHt/Hosh5AUU56IxWup9ju56yKijI3TsbCGM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] driver core: platform: Clarify that IRQ 0 is invalid
Date:   Fri,  1 May 2020 17:40:41 -0500
Message-Id: <20200501224042.141366-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200501224042.141366-1-helgaas@kernel.org>
References: <20200501224042.141366-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These interfaces return a negative error number or an IRQ:

  platform_get_irq()
  platform_get_irq_optional()
  platform_get_irq_byname()
  platform_get_irq_byname_optional()

The function comments suggest checking for error like this:

  irq = platform_get_irq(...);
  if (irq < 0)
    return irq;

which is what most callers (~900 of 1400) do, so it's implicit that IRQ 0
is invalid.  But some callers check for "irq <= 0", and it's not obvious
from the source that we never return an IRQ 0.

Make this more explicit by updating the comments to say that an IRQ number
is always non-zero and adding a WARN() if we ever do return zero.  If we do
return IRQ 0, it likely indicates a bug in the arch-specific parts of
platform_get_irq().

Relevant prior discussion at [1, 2].

[1] https://lore.kernel.org/r/Pine.LNX.4.64.0701250940220.25027@woody.linux-foundation.org/
[2] https://lore.kernel.org/r/Pine.LNX.4.64.0701252029570.25027@woody.linux-foundation.org/
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/platform.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 5255550b7c34..084cf1d23d3f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -152,23 +152,24 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  *		if (irq < 0)
  *			return irq;
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 {
+	int ret;
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
 		return -ENXIO;
-	return dev->archdata.irqs[num];
+	ret = dev->archdata.irqs[num];
+	goto out;
 #else
 	struct resource *r;
-	int ret;
 
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
-			return ret;
+			goto out;
 	}
 
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
@@ -176,7 +177,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		if (r && r->flags & IORESOURCE_DISABLED) {
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
 			if (ret)
-				return ret;
+				goto out;
 		}
 	}
 
@@ -190,13 +191,17 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			return -ENXIO;
+		if (!irqd) {
+			ret = -ENXIO;
+			goto out;
+		}
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	if (r)
-		return r->start;
+	if (r) {
+		ret = r->start;
+		goto out;
+	}
 
 	/*
 	 * For the index 0 interrupt, allow falling back to GpioInt
@@ -209,11 +214,14 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
 		/* Our callers expect -ENXIO for missing IRQs. */
 		if (ret >= 0 || ret == -EPROBE_DEFER)
-			return ret;
+			goto out;
 	}
 
-	return -ENXIO;
+	ret = -ENXIO;
 #endif
+out:
+	WARN(ret == 0, "0 is an invalid IRQ number\n");
+	return ret;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_optional);
 
@@ -231,7 +239,7 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
  *		if (irq < 0)
  *			return irq;
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
@@ -303,8 +311,10 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	if (r)
+	if (r) {
+		WARN(r->start == 0, "0 is an invalid IRQ number\n");
 		return r->start;
+	}
 
 	return -ENXIO;
 }
@@ -316,7 +326,7 @@ static int __platform_get_irq_byname(struct platform_device *dev,
  *
  * Get an IRQ like platform_get_irq(), but then by name rather then by index.
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq_byname(struct platform_device *dev, const char *name)
 {
@@ -338,7 +348,7 @@ EXPORT_SYMBOL_GPL(platform_get_irq_byname);
  * Get an optional IRQ by name like platform_get_irq_byname(). Except that it
  * does not print an error message if an IRQ can not be obtained.
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq_byname_optional(struct platform_device *dev,
 				     const char *name)
-- 
2.25.1


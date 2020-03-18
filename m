Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB918A805
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 23:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCRWWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 18:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCRWWl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 18:22:41 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6804D20714;
        Wed, 18 Mar 2020 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584570160;
        bh=Xz/0EvZI1ZYMODHoYRMl9J+dOM/tsbfHznYvsE+DY4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TeaROXeqtIiOuPZEJEeYWnIPHrh1Ask7srNIxIYhwTpKsUqP2jP8EVgIYJM33HfwF
         1jFMhhapjJedYXzGwqqv6NFwF3Nch7XWO1iNLYfMzXCjEK5TU34+g7gYssJdkFOM1b
         DGF8UtEi5MxA8pPt6Acsc8nHRD8W/OlpKBw98Rb4=
Date:   Wed, 18 Mar 2020 17:22:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Aman Sharma <amanharitsh123@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200318222238.GA247500@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kulbwyv.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 02:42:48PM +0100, Thomas Gleixner wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Fri, Mar 13, 2020 at 04:56:42PM -0500, Bjorn Helgaas wrote:
> >> On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
> >> > >   I think the best pattern is:
> >> > >
> >> > >     irq = platform_get_irq(pdev, i);
> >> > >     if (irq < 0)
> >> > >       return irq;
> >> > 
> >> > Careful. 0 is not a valid interrupt.
> >> 
> >> Should callers of platform_get_irq() check for a 0 return value?
> >> About 900 of them do not.
> 
> I don't know what I was looking at.
> 
> platform_get_irq() does the right thing already, so checking for irq < 0
> is sufficient.
> 
> Sorry for the confusion!

Thanks, I was indeed confused!  Maybe we could reduce future confusion
by strengthening the comments slightly, e.g.,

  - * Return: IRQ number on success, negative error number on failure.
  + * Return: non-zero IRQ number on success, negative error number on failure.

I don't want to push my luck, but it's pretty hard to prove that
platform_get_irq() never returns 0.  What would you think of something
like the following?

@@ -133,23 +133,24 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
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
@@ -157,7 +158,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		if (r && r->flags & IORESOURCE_DISABLED) {
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
 			if (ret)
-				return ret;
+				goto out;
 		}
 	}
 
@@ -171,13 +172,17 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
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
@@ -190,11 +195,14 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
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
 
@@ -212,7 +220,7 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
  *		if (irq < 0)
  *			return irq;
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
@@ -284,8 +292,10 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	if (r)
+	if (r) {
+		WARN(r->start == 0, "0 is an invalid IRQ number\n");
 		return r->start;
+	}
 
 	return -ENXIO;
 }
@@ -297,7 +307,7 @@ static int __platform_get_irq_byname(struct platform_device *dev,
  *
  * Get an IRQ like platform_get_irq(), but then by name rather then by index.
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq_byname(struct platform_device *dev, const char *name)
 {
@@ -319,7 +329,7 @@ EXPORT_SYMBOL_GPL(platform_get_irq_byname);
  * Get an optional IRQ by name like platform_get_irq_byname(). Except that it
  * does not print an error message if an IRQ can not be obtained.
  *
- * Return: IRQ number on success, negative error number on failure.
+ * Return: non-zero IRQ number on success, negative error number on failure.
  */
 int platform_get_irq_byname_optional(struct platform_device *dev,
 				     const char *name)

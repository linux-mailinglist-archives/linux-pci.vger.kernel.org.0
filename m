Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C934B18C25A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 22:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCSVfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 17:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCSVfP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 17:35:15 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671AB2076F;
        Thu, 19 Mar 2020 21:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584653714;
        bh=2lNHn4kRt+Z7xc10xfDSVFGeTLx4ykXDxtTBlKddkcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aAU0Lzpe/C5KZfK8/Ii55DZc8zab4TcDPmxQLV32qu9CRsUNGPgxeCAWcFk5pDbt0
         1iXpY9cEHttbqHPd7TNXcf8QUOOCdPuoY0ee07NSz5LaMC2Sfrg/etm6j2dSO8aQH8
         bLRoaPOvFgVe2/mNq5UVYju4nIV+U79eEJeqIaEc=
Date:   Thu, 19 Mar 2020 16:35:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Aman Sharma <amanharitsh123@gmail.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
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
Message-ID: <20200319213512.GA415@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dzgennw.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 19, 2020 at 09:47:47AM +0100, Thomas Gleixner wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Wed, Mar 18, 2020 at 02:42:48PM +0100, Thomas Gleixner wrote:
> >> Bjorn Helgaas <helgaas@kernel.org> writes:
> >> > On Fri, Mar 13, 2020 at 04:56:42PM -0500, Bjorn Helgaas wrote:
> >> >> On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
> >> >> > >   I think the best pattern is:
> >> >> > >
> >> >> > >     irq = platform_get_irq(pdev, i);
> >> >> > >     if (irq < 0)
> >> >> > >       return irq;
> >> >> > 
> >> >> > Careful. 0 is not a valid interrupt.
> >> >> 
> >> >> Should callers of platform_get_irq() check for a 0 return value?
> >> >> About 900 of them do not.
> >> 
> >> I don't know what I was looking at.
> >> 
> >> platform_get_irq() does the right thing already, so checking for irq < 0
> >> is sufficient.
> >> 
> >> Sorry for the confusion!
> >
> > Thanks, I was indeed confused!  Maybe we could reduce future confusion
> > by strengthening the comments slightly, e.g.,
> >
> >   - * Return: IRQ number on success, negative error number on failure.
> >   + * Return: non-zero IRQ number on success, negative error number on failure.
> >
> > I don't want to push my luck, but it's pretty hard to prove that
> > platform_get_irq() never returns 0.  What would you think of something
> > like the following?
> 
> No objections from my side.

OK, thanks!

Aman, my suggestion for you is to include the patch below as the first
patch in your series.  Then post a v2 of it, making sure to cc:
everybody who commented on the first version.

Bjorn


driver core: platform: Specify that IRQ 0 is invalid

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

Relevant prior discussion at [1,2].

[1] https://lore.kernel.org/lkml/Pine.LNX.4.64.0701250940220.25027@woody.linux-foundation.org/
[2] https://lore.kernel.org/lkml/Pine.LNX.4.64.0701252029570.25027@woody.linux-foundation.org/
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..50f3a5da89dc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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

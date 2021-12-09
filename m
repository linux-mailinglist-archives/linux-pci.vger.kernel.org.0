Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6953246F467
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 20:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhLIT7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 14:59:21 -0500
Received: from relay033.a.hostedemail.com ([64.99.140.33]:23070 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhLIT7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 14:59:21 -0500
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 31D9221F1F;
        Thu,  9 Dec 2021 19:55:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 3E7C020034;
        Thu,  9 Dec 2021 19:55:43 +0000 (UTC)
Message-ID: <47d32a2f648281c6a1731266d1a5d00da3d1a875.camel@perches.com>
Subject: Re: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when
 device is not available
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Date:   Thu, 09 Dec 2021 11:55:43 -0800
In-Reply-To: <YbJaFM0vlkdTwxUS@smile.fi.intel.com>
References: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
         <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
         <YbJaFM0vlkdTwxUS@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.77
X-Stat-Signature: rrpyq5s9awy8rzwdxincon313e1tpday
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3E7C020034
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18lfiLa3xBIXxq236PVxw1uEFaya51cAxo=
X-HE-Tag: 1639079743-612830
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-12-09 at 21:33 +0200, Andy Shevchenko wrote:
> On Thu, Dec 09, 2021 at 10:40:57AM -0800, Joe Perches wrote:
> > On Thu, 2021-12-09 at 20:27 +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > +#define pci_bus_printk(level, bus, devfn, fmt, arg...) \
> > > +	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
> > > +	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##arg)
> > 
> > I have a small preference for using ... and __VA_ARGS___
> 
> It contradicts what other macros in the pci.h do.
> So I will stick with current solution for the sake of consistency.

There's always this possibility.

And this: (cheers)
---
 include/linux/pci.h | 58 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ce26850470ef..1dc34f6eaeda7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2456,30 +2456,38 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 /* Provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-#define pci_printk(level, pdev, fmt, arg...) \
-	dev_printk(level, &(pdev)->dev, fmt, ##arg)
-
-#define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
-#define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
-#define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
-#define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
-#define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
-#define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
-#define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
-#define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
-
-#define pci_notice_ratelimited(pdev, fmt, arg...) \
-	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
-
-#define pci_info_ratelimited(pdev, fmt, arg...) \
-	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
-
-#define pci_WARN(pdev, condition, fmt, arg...) \
-	WARN(condition, "%s %s: " fmt, \
-	     dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
-
-#define pci_WARN_ONCE(pdev, condition, fmt, arg...) \
-	WARN_ONCE(condition, "%s %s: " fmt, \
-		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
+#define pci_printk(level, pdev, fmt, ...)				\
+	dev_printk(level, &(pdev)->dev, fmt, ##__VA_ARGS__)
+
+#define pci_emerg(pdev, fmt, ...)					\
+	dev_emerg(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_alert(pdev, fmt, ...)					\
+	dev_alert(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_crit(pdev, fmt, ...)					\
+	dev_crit(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_err(pdev, fmt, ...)						\
+	dev_err(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_warn(pdev, fmt, ...)					\
+	dev_warn(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_notice(pdev, fmt, ...)					\
+	dev_notice(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_info(pdev, fmt, ...)					\
+	dev_info(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_dbg(pdev, fmt, ...)						\
+	dev_dbg(&(pdev)->dev, fmt, ##__VA_ARGS__)
+
+#define pci_notice_ratelimited(pdev, fmt, ...)				\
+	dev_notice_ratelimited(&(pdev)->dev, fmt, ##__VA_ARGS__)
+#define pci_info_ratelimited(pdev, fmt, ...)				\
+	dev_info_ratelimited(&(pdev)->dev, fmt, ##__VA_ARGS__)
+
+#define pci_WARN(pdev, condition, fmt, ...)				\
+	WARN(condition, "%s %s: " fmt,					\
+	     dev_driver_string(&(pdev)->dev), pci_name(pdev),		\
+	     ##__VA_ARGS__)
+#define pci_WARN_ONCE(pdev, condition, fmt, ...)			\
+	WARN_ONCE(condition, "%s %s: " fmt,				\
+		  dev_driver_string(&(pdev)->dev), pci_name(pdev),	\
+		  ##__VA_ARGS__)
 
 #endif /* LINUX_PCI_H */



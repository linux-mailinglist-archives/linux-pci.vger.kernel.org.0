Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512BB6E205A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDNKLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjDNKLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 06:11:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9E198D
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467107; x=1713003107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uUazESwASyHtRrAyHARxFCblq/tMu5V0hnSLuz4naJk=;
  b=KtJAwqbdkDvOF7kOPJ28auqOt6dMuTky+NEOjnVU8uqWUUrUtZ9zXdWr
   XpJ5K/GQkKf4cOSb/FMeK+m4Mb1xcgQ/39GIybXnlHVg/CSrZB3V4UAhC
   wTQStXYG6s7FuiXmriiRZnK+Ecq/lLL5eaTjB6+Rvmi/aot0yrc7Nwigs
   G1HJDB9moaaFCN5Cno0zKCWKFY/ugfWq0F2KQ9hjrVfM5/Mz83nj68MHG
   3v80Y+eBYIFiMK4d4QZPWOEOksmU6uo5KW7hGRMsBwo4UzfaOdfaG4k3D
   fxUSSPGtH7+3eOhrYHjRj1YUKwQw7QcACOcOd6GyYLZ47c8xKi39sA5Og
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="347150096"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="347150096"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="813821470"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="813821470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2023 03:11:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B9D4334F; Fri, 14 Apr 2023 13:11:47 +0300 (EEST)
Date:   Fri, 14 Apr 2023 13:11:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Bail out early in
 pci_bridge_wait_for_secondary_bus() if link is not trained
Message-ID: <20230414101147.GA66750@black.fi.intel.com>
References: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
 <20230414074238.GA22973@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414074238.GA22973@wunner.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Apr 14, 2023 at 09:42:38AM +0200, Lukas Wunner wrote:
> On Thu, Apr 13, 2023 at 01:16:42PM +0300, Mika Westerberg wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5037,6 +5037,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Everything above is handling the delays mandated by the PCIe r6.0
> > +	 * sec 6.6.1.
> > +	 *
> > +	 * If the port supports active link reporting we now check one more
> > +	 * time if the link is active and if not bail out early with the
> > +	 * assumption that the device is not present anymore.
> > +	 */
> > +	if (dev->link_active_reporting) {
> > +		u16 status;
> > +
> > +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> > +		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > +			return -ENOTTY;
> > +	}
> > +
> >  	return pci_dev_wait(child, reset_type,
> >  			    PCIE_RESET_READY_POLL_MS - delay);
> >  }
> 
> Hm, shouldn't the added code live in the
> 
> 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)
> 
> branch?  For the else branch (Gen3+ devices with > 5 GT/s),
> we've already waited for the link to become active, so the
> additional check seems superfluous.  (But maybe I'm missing
> something.)

You are not missing anything ;-) Indeed it should belong there, and I
think we are also missing now the "optimization" for devices behind slow
link without active link reporting capabilities. That is we wait for the
1s instead of the whole 60s.

> I also note that this documentation change has been dropped
> vis-à-vis v1 of the patch, not sure if that's intentional:
> 
> -	* However, 100 ms is the minimum and the PCIe spec says the
> -	* software must allow at least 1s before it can determine that the
> -	* device that did not respond is a broken device. There is
> -	* evidence that 100 ms is not always enough, for example certain
> -	* Titan Ridge xHCI controller does not always respond to
> -	* configuration requests if we only wait for 100 ms (see
> -	* https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> +	* However, 100 ms is the minimum and the PCIe spec says the software
> +	* must allow at least 1s before it can determine that the device that
> +	* did not respond is a broken device. Also device can take longer than
> +	* that to respond if it indicates so through Request Retry Status
> +	* completions.

This is not intentional. I will add it back in the next version.

To summarize the v4 patch would look something like below. Only compile
tested but I will run real testing later today. I think it now includes
the 1s optimization and also checking of the active link reporting
support for the devices behind slow links. Let me know is I missed
something. 

It is getting rather complex unfortunately :(

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 61bf8a4b2099..f81a9e6aff84 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -64,6 +64,13 @@ struct pci_pme_device {
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
 
+/*
+ * Following exit from Conventional Reset, devices must be ready within 1 sec
+ * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
+ * Reset (PCIe r6.0 sec 5.8).
+ */
+#define PCI_RESET_WAIT 1000 /* msec */
+
 /*
  * Devices may extend the 1 sec period through Request Retry Status
  * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
@@ -5010,13 +5017,11 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	 * speeds (gen3) we need to wait first for the data link layer to
 	 * become active.
 	 *
-	 * However, 100 ms is the minimum and the PCIe spec says the
-	 * software must allow at least 1s before it can determine that the
-	 * device that did not respond is a broken device. There is
-	 * evidence that 100 ms is not always enough, for example certain
-	 * Titan Ridge xHCI controller does not always respond to
-	 * configuration requests if we only wait for 100 ms (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
+	 * However, 100 ms is the minimum and the PCIe spec says the software
+	 * must allow at least 1s before it can determine that the device that
+	 * did not respond is a broken device. Also device can take longer than
+	 * that to respond if it indicates so through Request Retry Status
+	 * completions.
 	 *
 	 * Therefore we wait for 100 ms and check for the device presence
 	 * until the timeout expires.
@@ -5027,30 +5032,29 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
-	} else {
-		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-			delay);
-		if (!pcie_wait_for_link_delay(dev, true, delay)) {
-			/* Did not train, no need to wait any further */
-			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
+
+		/*
+		 * If the port supports active link reporting we now check one
+		 * more time if the link is active and if not bail out early
+		 * with the assumption that the device is not present anymore.
+		 */
+		if (dev->link_active_reporting) {
+			u16 status;
+
+			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+			if (!(status & PCI_EXP_LNKSTA_DLLLA))
+				return -ENOTTY;
 		}
-	}
 
-	/*
-	 * Everything above is handling the delays mandated by the PCIe r6.0
-	 * sec 6.6.1.
-	 *
-	 * If the port supports active link reporting we now check one more
-	 * time if the link is active and if not bail out early with the
-	 * assumption that the device is not present anymore.
-	 */
-	if (dev->link_active_reporting) {
-		u16 status;
+		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
+	}
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
-			return -ENOTTY;
+	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+		delay);
+	if (!pcie_wait_for_link_delay(dev, true, delay)) {
+		/* Did not train, no need to wait any further */
+		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		return -ENOTTY;
 	}
 
 	return pci_dev_wait(child, reset_type,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 022da58afb33..f2d3aeab91f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -64,13 +64,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
-/*
- * Following exit from Conventional Reset, devices must be ready within 1 sec
- * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
- * Reset (PCIe r6.0 sec 5.8).
- */
-#define PCI_RESET_WAIT		1000	/* msec */
-
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);

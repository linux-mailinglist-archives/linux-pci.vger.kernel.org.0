Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9C6DED1E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDLIA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDLIAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 04:00:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08059E0
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681286420; x=1712822420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwIDHCdPflPzLgnaZMzuueubcNvMs1oYYaOW70jlIAM=;
  b=RXnbsXwEkZGyuda22RLCB08B4TAPJ0RybEIL3imonTE77T0HAfOBdQmb
   zHBcnkEUN6ts/d/GcbaUVrMO5Pro0RIDdIbpYCfDU3Iap/v2h2FpKAC/f
   1CFc9Hyku+mWNpzxFlBh8lHbgUy4U4paLK8jc96Yw7IBBYZQUgv7UKJYr
   +PGwGjtmEkP4IZjd0ZJhtpwVqfGLaiuoHs2OKKL6+XDgFR0StZaW+zyQK
   FFIiQbFjt695e4pGBx/cYJeOywS7vCE4DIhR84Z6jX9rlHuATeZS7Y8mb
   CcVjd5gplhf31JVdSnTx/Hd+7ALnu/Vlmmg26XdZhZnNoDvnKtN4Xvu17
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371684129"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="371684129"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 01:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="639127661"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="639127661"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2023 01:00:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B974714B; Wed, 12 Apr 2023 11:00:19 +0300 (EEST)
Date:   Wed, 12 Apr 2023 11:00:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI/PM: Resume/reset wait time change
Message-ID: <20230412080019.GE33314@black.fi.intel.com>
References: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
 <20230411224014.GA4185844@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411224014.GA4185844@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Apr 11, 2023 at 05:40:14PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 04, 2023 at 08:27:12AM +0300, Mika Westerberg wrote:
> > Hi all,
> > 
> > This series first increases the time we wait on resume path to
> > accommondate certain device, as reported in [1], and then "optimizes"
> > the timeout for slow links to avoid too long waits if a device is
> > disconnected during suspend.
> > 
> > Previous version can be found here:
> > 
> >   https://lore.kernel.org/linux-pci/20230321095031.65709-1-mika.westerberg@linux.intel.com/
> > 
> > Changes from the previous version:
> > 
> >   * Split the patch into two: one that increases the resume timeout (on
> >     all links, I was not able to figure out a simple way to limit this
> >     only for the fast links) and the one that decreases the timeout on
> >     slow links.
> > 
> >   * Use dev->link_active_reporting instead of speed to figure out slow
> >     vs. fast links.
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=216728
> > 
> > Mika Westerberg (2):
> >   PCI/PM: Increase wait time after resume
> 
> I applied the above to pci/reset for v6.4.

Thanks!

> >   PCI/PM: Decrease wait time for devices behind slow links
> 
> Part of this patch is removing the pci_bridge_wait_for_secondary_bus()
> timeout parameter, since all callers now supply the same value
> (PCIE_RESET_READY_POLL_MS).  I extracted that part out and applied it
> as well.
> 
> I'm hoping we can restructure the rest of this as mentioned in the
> thread.  If that's not possible, can you rebase what's left on top of
> this?
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset

Sure. The end result is below. I did not add the wait_for_link_active()
because we already have the pcie_wait_for_link_delay(), and the
msleep(100) really needs to be msleep(delay) because we extract that
'delay' from the device d3cold_delay which can be more than 100 ms. Let
me know what you think. I will send a proper patch tomorrow if no
objections.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b4f3b08f780..61bf8a4b2099 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5037,6 +5037,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		}
 	}
 
+	/*
+	 * Everything above is handling the delays mandated by the PCIe r6.0
+	 * sec 6.6.1.
+	 *
+	 * If the port supports active link reporting we now check one more
+	 * time if the link is active and if not bail out early with the
+	 * assumption that the device is not present anymore.
+	 */
+	if (dev->link_active_reporting) {
+		u16 status;
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+			return -ENOTTY;
+	}
+
 	return pci_dev_wait(child, reset_type,
 			    PCIE_RESET_READY_POLL_MS - delay);
 }



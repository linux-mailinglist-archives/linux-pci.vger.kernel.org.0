Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4E6EC5E2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjDXGCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjDXGBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:01:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCFA358E
        for <linux-pci@vger.kernel.org>; Sun, 23 Apr 2023 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682316057; x=1713852057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DvByYx9t6VfD4EzLKJUmtV7QIMTOTPgkHDodmdzRlzs=;
  b=BNYj7nQ3+LHexc10sj6Kr5jYM6d5AxPtgRBnSfHDq6tiMRlWMRziKzB3
   o/X8NuCXGtj+t0iyTqMVMTG4/77NrQm8tplCx2pAZlYLePufSK2qkIc3H
   SGUGRxxgAMWohDjNusf8rgxuKfZrlzmaZStEjJO7BVe6VkOloGk3KVxtl
   twuT2IET973aUjGB6cxbXfSIqnhDcF4mQ5OzPNPQWmNpZIVd2TH97+I1s
   +9Fk7To0A5AmYzDCPN1VSJws3zbshQOpqUoJ9o+e+if2QTw+yO1YrDU+u
   ApG8MwkZsBpHthMgnDNrpZFVDBAltEzeRgV18ddddaPA/gKp7AtqGV1Lt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="374313041"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="374313041"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 23:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="695622711"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="695622711"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2023 23:00:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A940B11D; Mon, 24 Apr 2023 09:00:55 +0300 (EEST)
Date:   Mon, 24 Apr 2023 09:00:55 +0300
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
Subject: Re: [PATCH v4] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Message-ID: <20230424060055.GS66750@black.fi.intel.com>
References: <20230418072808.10431-1-mika.westerberg@linux.intel.com>
 <20230421205114.GA24809@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230421205114.GA24809@wunner.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 10:51:14PM +0200, Lukas Wunner wrote:
> On Tue, Apr 18, 2023 at 10:28:08AM +0300, Mika Westerberg wrote:
> > With slow links (<= 5GT/s) active link reporting is not mandatory, so if
> > a device is disconnected during system sleep we might end up waiting for
> > it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
> > 6.6.1 mandates that the system software must wait for at least 1s before
> > it can determine the device as brokine device so use the minimum
>                                  ^^^^^^^
> 				 broken
> 
> 
> > @@ -5027,14 +5032,29 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> >  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> >  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> >  		msleep(delay);
> > -	} else {
> > -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> > -			delay);
> > -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > -			/* Did not train, no need to wait any further */
> > -			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> > -			return -ENOTTY;
> > +
> > +		/*
> > +		 * If the port supports active link reporting we now check
> > +		 * whether the link is active and if not bail out early with
> > +		 * the assumption that the device is not present anymore.
> > +		 */
> > +		if (dev->link_active_reporting) {
> > +			u16 status;
> > +
> > +			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> > +			if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > +				return -ENOTTY;
> >  		}
> > +
> > +		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
> > +	}
> 
> So above in the Gen1/Gen2 case (<= 5 GT/s), a delay of 100 msec is afforded
> and if the link isn't up by then, the function returns an error.
> 
> Doesn't that violate PCIe r6.0.1 sec 6.6.1 that states:
> 
>  "system software must allow at least 1.0 s following exit from a
>   Conventional Reset of a device, before determining that the device
>   is broken if it fails to return a Successful Completion status for
>   a valid Configuration Request.  This period is independent of how
>   quickly Link training completes."

Yes, it does :( Missed that last sentence.

> I think what we can do here is:
> 
> 		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> 			return 0;
> 
> 		if (!dev->link_active_reporting)
> 			return -ENOTTY;
> 
> 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> 		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> 			return -ENOTTY;
> 
> 		return pci_dev_wait(child, reset_type,
> 				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
> 
> In other words, if link active reporting is unsupported, we can only
> afford the 1 second prescribed by the spec and that's it.  If the
> subordinate device is still inaccessible after that, reset recovery
> failed.
> 
> If link active reporting is supported and the link is up, then we know
> the device is accessible but may need more time.  In that case the
> full 60 seconds are afforded.
> 
> Does that make sense?

Yes, it does, thanks! I will send an updated version with this (and the
typo) fixed after the merge window closes.

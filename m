Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372FE6D7892
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjDEJj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbjDEJjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 05:39:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757381B4
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680687586; x=1712223586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MZti92UgQvOfEHHOLbp4DJwzHE8YhTwVdFRllH7Gy5A=;
  b=dz1AwpR4mMD0+gxb01qjXLKs0k2yt3IU+0lAzYW3iXrnfDUcsB51N67g
   CB303OD/y1gY8YgQt8USZnWJ72X8X0rnTGf4f/64nOi6gJezrZKVmj8Nu
   WVNRZlGD2oCFODsxQFDF+Vy3RJIVB6xtCEgLgYc3aYDpQhZwPftUy8Y4J
   Rte75YtnybK7ueKU/gZOZcxi+op5g9CVluGV6br3uXb6aNdzWSzIfsDYf
   AB5Ueqh6k9LjA8l1xr6tpNvVgjbJU/NDnxnenPSCsJjYuSLiNPfHuBCAr
   rO49Eba5Cp0fXVAsvkdr8dIk6f162oJFQmggAMNN+njOf5bp+sjLq8Tgw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326444679"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326444679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 02:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775982205"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775982205"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 02:39:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9BAEA13A; Wed,  5 Apr 2023 12:39:29 +0300 (EEST)
Date:   Wed, 5 Apr 2023 12:39:29 +0300
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
Subject: Re: [PATCH v2 2/2] PCI/PM: Decrease wait time for devices behind
 slow links
Message-ID: <20230405093929.GR33314@black.fi.intel.com>
References: <20230404052714.51315-3-mika.westerberg@linux.intel.com>
 <20230404213655.GA3568295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404213655.GA3568295@bhelgaas>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Apr 04, 2023 at 04:36:55PM -0500, Bjorn Helgaas wrote:
> Hi Mika,
> 
> I need some help because I have a hard time applying sec 6.6.1.
> 
> On Tue, Apr 04, 2023 at 08:27:14AM +0300, Mika Westerberg wrote:
> > In order speed up reset and resume time of devices behind slow links,
> > decrease the wait time to 1s. This should give enough time for them to
> > respond.
> 
> Is there some spec language behind this?  In sec 6.6.1, I see that all
> devices "must be able to receive a Configuration Request and return a
> Successful Completion".
> 
> A preceding rule says devices with slow links must enter LTSSM Detect
> within 20ms, but I don't see a direct connection from that to a
> shorter wait time.

I think this (PCIe 5.0 p. 553):

"Following a Conventional Reset of a device, within 1.0 s the device
 must be able to receive a Configuration Request and return a Successful
 Completion if the Request is valid."

> > While doing this, instead of looking at the speed we check if
> > the port supports active link reporting.
> 
> Why check dev->link_active_reporting (i.e., PCI_EXP_LNKCAP_DLLLARC)
> instead of the link speed described by the spec?

This is what Sathyanarayanan suggested in the previous version comments.

> DLLLARC is required for fast links, but it's not prohibited for slower
> links and it's *required* for hotplug ports with slow links, so
> dev->link_active_reporting is not completely determined by link speed.
> 
> IIUC, the current code basically has these cases:
> 
>   1) All devices on secondary bus have zero D3cold delay:
>        return immediately; no delay at all
> 
>   2) Non-PCIe bridge:
>        sleep 1000ms
>        sleep  100ms (typical, depends on downstream devices)
> 
>   3) Speed <= 5 GT/s:
>        sleep 100ms (typical)
>        sleep up to 59.9s (typical) waiting for valid config read
> 
>   4) Speed > 5 GT/s (DLLLARC required):
>        sleep 20ms
>        sleep up to 1000ms waiting for DLLLA
>        sleep 100ms (typical)
>        sleep up to 59.9s (typical) waiting for valid config read
> 
> This patch changes cases 3) and 4) to:
> 
>   3) DLLLARC not supported:
>        sleep 100ms (typical)
>        sleep up to 1.0s (typical) waiting for valid config read
> 
>   4) DLLLARC supported:
>        no change in wait times, ~60s total
> 
> And testing dev->link_active_reporting instead of speed means slow
> hotplug ports (and possibly other slow ports that implement DLLLARC)
> that previously were in case 3) will now be in case 4).

Yes, and we do that because if the device gets unplugged while we were
in susppend we don't want to wait for the total 60s for it to become
ready. That's what the DLLLARC can tell us (for ports that support it).
For the ports that do not we want to give the device some time but not
to wait for that 60s so we wait for the 1s as the "minimum" requirement
from the spec before it can be determined "broken".

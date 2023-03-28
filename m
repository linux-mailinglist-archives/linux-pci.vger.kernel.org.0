Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265906CBA85
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC1J0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC1J0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 05:26:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FC5254
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679995606; x=1711531606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wxpr0lrBVHFn4kP8ssjA1G+iK64rwUmpuP+XcFiaqCc=;
  b=Oyh9m3+nW9onXNw4VLWo2R2ngZN2FIChUZ29JV51hSby7+Mh9bbt7QJ4
   c9VVV5/7KTWa7m1ci+FMaS1rzOksm0i5ml3gAedn28n39097pFyBE6Qma
   ju+EC6ghfQgrtMaDGyDYwhy2xwgdQNR/MwXx9UkmjEZZkaHOB/UznOwIZ
   Sy3nyphCtU9vqd4Y0fRACrJau+lud7dH7PmOgOZSpTkQ7myDDMrD3YTvA
   7qkl2o6lewTblOf5VRA4y8YFNvVDJdsZTD0IeXN5HrqJqZKcpn+oosAmC
   KPH0b7FnYYpew0fs6zkTMBprjH7FhGF5RKGsN3+AOikNO5O3ElyDszR0Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320169446"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="320169446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 02:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929793112"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="929793112"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 02:26:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C02B479C; Tue, 28 Mar 2023 12:26:43 +0300 (EEST)
Date:   Tue, 28 Mar 2023 12:26:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>, shuo.tan@linux.alibaba.com
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Message-ID: <20230328092643.GF33314@black.fi.intel.com>
References: <20230327094250.GC33314@black.fi.intel.com>
 <20230327144050.GA2835405@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230327144050.GA2835405@bhelgaas>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 09:40:50AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 27, 2023 at 12:42:50PM +0300, Mika Westerberg wrote:
> > On Sun, Mar 26, 2023 at 08:22:07AM +0200, Lukas Wunner wrote:
> > > On Wed, Mar 22, 2023 at 05:16:24PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Mar 21, 2023 at 11:50:31AM +0200, Mika Westerberg wrote:
> 
> > > > After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
> > > > timeouts of either:
> > > > 
> > > >   60s for reset (pci_bridge_secondary_bus_reset() or
> > > >       dpc_reset_link()), or
> > > > 
> > > >    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
> > > >       pci_pm_bridge_power_up_actions())
> > > > 
> > > > If I'm reading this right, the main changes of this patch are:
> > > > 
> > > >   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
> > > >     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
> > > >     we will wait a max of 1s for both resume and reset.
> > > > 
> > > >   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
> > > >     up and fail if it does not.  If the link did come up in 100ms, we
> > > >     previously waited up to 1s (resume) or 60s (reset).  Now we will
> > > >     wait up to 60s for both resume and reset.
> > > > 
> > > > So this *reduces* the time we wait for slow links after reset, and
> > > > *increases* the time for fast links after resume.  Right?
> > > 
> > > Good point.  So now the wait duration hinges on the link speed
> > > rather than reset versus resume.
> > > ...
> 
> > I can update the patch accordingly.
> 
> If you do an update, is it possible to split into two patches so one
> increases the time for resume for fast links and the other decreases
> the time for reset on slow links?  I'm thinking about potential debug
> efforts where it might be easier to untangle things if they are
> separate.

Yes, sure.

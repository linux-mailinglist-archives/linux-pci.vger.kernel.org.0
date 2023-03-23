Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CE6C697C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCWN2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCWN2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 09:28:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997CD7
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679578113; x=1711114113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xoZ6CwDxUrI0+RdrQwiHs019O7NFqHah/UHVIyTTljQ=;
  b=YCgqnOBzRg+DxWWodAEXCit7H0MFXeR4fud8uR9ZhmDfkOedbXk+GX0M
   hFgOlwrst5uBGd0lZxGoLFU3CZllF7QFot3sve/sRVQUFMN44sAVvYz/R
   b3tL9RuFnKRaNpdSJcctbpWa9hkfSHKT8xTsZ6bjl/BlPuV2cGFE/TCQm
   hxCLnai+CqqSMOa+BPQPCHoVqO3oQJoheok9w/Oe2jw3jxqq5TcO08cgI
   lqk7eLrLVs348UmEeSY6T7E6on1oXqI+Ry347wSqYX+vIBJK4HEEaZZNU
   XqCj0x8beuw6RS4oWZ4jmXYjrdcbT7P/a4CIpNme4a3vcG10CzFsVXLD5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425765479"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="425765479"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 06:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682310785"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="682310785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2023 06:28:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 37C2DD0; Thu, 23 Mar 2023 15:29:17 +0200 (EET)
Date:   Thu, 23 Mar 2023 15:29:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Message-ID: <20230323132917.GI62143@black.fi.intel.com>
References: <20230321095031.65709-1-mika.westerberg@linux.intel.com>
 <20230322221624.GA2497123@bhelgaas>
 <20230323094143.GF62143@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323094143.GF62143@black.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 11:41:43AM +0200, Mika Westerberg wrote:
> > After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
> > timeouts of either:
> > 
> >   60s for reset (pci_bridge_secondary_bus_reset() or
> >       dpc_reset_link()), or
> > 
> >    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
> >       pci_pm_bridge_power_up_actions())
> > 
> > If I'm reading this right, the main changes of this patch are:
> > 
> >   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
> >     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
> >     we will wait a max of 1s for both resume and reset.
> > 
> >   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
> >     up and fail if it does not.  If the link did come up in 100ms, we
> >     previously waited up to 1s (resume) or 60s (reset).  Now we will
> >     wait up to 60s for both resume and reset.
> > 
> > So this *reduces* the time we wait for slow links after reset, and
> > *increases* the time for fast links after resume.  Right?
> 
> Yes, this is correct.

The reason why "fast links" is that we use the active link reporting (as
it is available on such ports) to figure out whether the link trained or
not and if not we come out early because it is likely that the device is
not there anymore. When the link has been trained we know that the
device is still there so can wait for longer it to reply.

For the "slow links" this cannot be done so wait for 1s to avoid long
waits if the device is already gone. I'm not entirely sure if this is
fine for the reset path. I think it is but I hope Lukas/others correct
me if not.

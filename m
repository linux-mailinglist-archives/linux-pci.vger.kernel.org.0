Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C564814F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 12:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLILIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLILIT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 06:08:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C976186CD
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670584099; x=1702120099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJcAVWv+5ov0QpWm3n/1iYUifmF8kgETgiABcTw2AhA=;
  b=kV++OzfrVVLsf6rceHMXYXM/seIGFD44MnCLTls7wFT4qfUa1+6PAO34
   9K0nS3q+hbpvpY3xoycafZoDRaHMDrYstzcOoMY0qbWGAmS/jAtVdvyUQ
   py7cVpc7KBCu7hzst/kZMFTvIiW2aDeP1nPyjewrP3IukukhTnCeCkS3q
   bYsUqOtu0qv2N0iGt8xqwu1TlaXgEDCPod1eJikR71zGHpPW1pj+CZkkz
   ObgwIjEpMpx8M0yvhC65FRhwc1DBNkGX4j0RApGs5Utzt2LO1dH4Te85T
   /EJX2D8+JUT1JTg48vV9rPplFPwqtuUkE+XUr4bO98VeUNftbUwwTMmzR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="318589124"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="318589124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 03:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="625082504"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="625082504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2022 03:08:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5302F179; Fri,  9 Dec 2022 13:08:45 +0200 (EET)
Date:   Fri, 9 Dec 2022 13:08:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <Y5MXPc+e0bKDM/Md@black.fi.intel.com>
References: <20221129064812.GA1555@wunner.de>
 <20221129065242.07b5bcbf.alex.williamson@redhat.com>
 <Y4YgKaml6nh5cB9r@black.fi.intel.com>
 <20221129084646.0b22c80b.alex.williamson@redhat.com>
 <20221129160626.GA19822@wunner.de>
 <20221129091249.3b60dd58.alex.williamson@redhat.com>
 <20221130074347.GC8198@wunner.de>
 <Y4cM3qYnaHl3fQsU@black.fi.intel.com>
 <20221130084738.57281dac.alex.williamson@redhat.com>
 <Y4h2vkDMzpkojMT4@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4h2vkDMzpkojMT4@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Dec 01, 2022 at 11:41:18AM +0200, Mika Westerberg wrote:
> > Otherwise I think we'd need a log of all BIOS vs Linux resource
> > allocations from the root port down to see what might be the issue with
> > the rescan.  Thanks,
> 
> Sure, I will share dmesg from that system showing the initial allocation
> and the re-scan as soon as I get confirmation that there is nothing
> under embargo in there.

Sorry for the delay. Took some time to get all the confirmations.

I created a bug here:

https://bugzilla.kernel.org/show_bug.cgi?id=216795

I also attached relevant dmesg and lspci outputs. I have now access to
the system so I can do additional testing as needed.

Thanks!

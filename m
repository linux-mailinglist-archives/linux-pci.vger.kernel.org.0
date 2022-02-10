Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510CD4B0C0C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbiBJLOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 06:14:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiBJLOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 06:14:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C010CCA
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644491696; x=1676027696;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBPRSyhyR4MWqAybTeGLySCbhYmmr6xdI+ZMnIpDIUA=;
  b=DEMA6YrR39IK9FUabRulRl1vLfKi7w/nvzuEt4EFNrwrY0DudTEJr3PV
   QVSzk5MSKCmkPej/csnaGr+AOCnvPlEG01wzFOxf/zH4YdYUmT6tzoDlC
   bnFqhN6TJAyqrBt3Z5owmaMP7HBT85N85hVYO4EY96gAA0z0JldN3ekC7
   rrPiiKyFaGeN3MSgDyOo88XIiV2xepzBTOoh022y41svXJo8eU/50ekhg
   +we1KtL2kgo1aBQhkm9XuL/Yn0MkDYkikeOc35RFSV0kaOC0e1fHAGSc3
   8B+N7gRTUQc6LBYyZgStkxF3hVss5OqOPQI8FEi2NBka/lnCP9DBheDnr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="274016367"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="274016367"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:14:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="541565333"
Received: from bkucman-mobl.ger.corp.intel.com (HELO localhost) ([10.249.141.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:14:49 -0800
Date:   Thu, 10 Feb 2022 12:14:44 +0100
From:   Blazej Kucman <blazej.kucman@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220210121444.0000255f@linux.intel.com>
In-Reply-To: <20220209210218.GA587489@bhelgaas>
References: <20220209144102.0000143e@linux.intel.com>
        <20220209210218.GA587489@bhelgaas>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Feb 2022 15:02:18 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Feb 09, 2022 at 02:41:02PM +0100, Blazej Kucman wrote:
> > On Thu, 3 Feb 2022 09:58:04 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> 
> > > Why were you testing with "pci=nommconf"?  Do you think anybody
> > > uses that with VMD and NVMe?  
> > 
> > It was added long time ago when it was useful.  
> 
> I'm curious about why it was useful.  It suggests a possible MMCONFIG
> issue in firmware or in Linux.  If it was a Linux issue, ideally we
> would fix that.  If it's a firmware issue, ideally we would work
> around it or automatically turn on "pci=nommconf" so the user wouldn't
> have to figure that out.
> 

The parameter was added many years ago (project has more than 10 years)
and I don't know the reason. Probably it was useful on pre-production
platforms, for software validation. It was added to our
internal BKMs. It didn't cause any real issue in our workflow until now.

Unfortunately, I'm unable to answer more precisely.
We scheduled steps to remove it definitely from our work environment.

> > Bugzilla report can be closed if you don't consider it as
> > regression.  
> 
> OK, I closed it with the details.  I'm not entirely convinced that
> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") was the
> right thing, but I'll pursue that elsewhere.
> 
> Thanks for your patience in working through this, and sorry for the
> hassle it caused you.
> 
> Bjorn

Thanks,
Blazej

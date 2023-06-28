Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15AD740F81
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjF1LAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 07:00:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:51431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbjF1K7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 06:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687949985; x=1719485985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tba71738f/bOKcS0qbSUDtyWQOesP6UBOIdYFDph4Vs=;
  b=eLFtn7EubIiA/omf976Ky98T2WDAw1xLKNpSWN2PTraq2tWwsasI5JpD
   8cg9mRm3p01xDw1tVQtETer/SfSnqmj/2Mc6EOoLKL09sTKhdrkrG9iDo
   GS2ixy5XAJTW7ks2HvVUlokG86wqJiW/SU2TiaMo+6pkyR478wWMdszDt
   0lBnMC48Y5Z26AtQ2my4AuaRzRXYQBIRE3VkkI/jxhAbfFeOVcEoEFBb8
   GSI1K7ctYZ+JBP0G6Z/U6//jkDzghxD1sm9j3tXi8GkytIoc/Qtc/Ybsn
   m8FD1fsrrkWRg/9iy1NvX+E/OlUrW7RBt8xr4SRwJvr+sTznKUSjMxIMZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361855131"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361855131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 03:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694221240"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="694221240"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2023 03:59:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9BDCBE1; Wed, 28 Jun 2023 13:59:40 +0300 (EEST)
Date:   Wed, 28 Jun 2023 13:59:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <kernel@witt.link>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230628105940.GK14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Wed, Jun 28, 2023 at 12:24:06PM +0200, Thomas Witt wrote:
> On 28/06/2023 08:46, Mika Westerberg wrote:
> > @Thomas, is there any particular reason you have this option in the
> > command line? There is possibility that S3 is not even fully validated
> > if the system advertises S0 low power sleep instead.
> 
> In fact, there is: Entering suspend-to-ram without setting
> /sys/power/mem_sleep to "deep", my laptop consumes about the same power as
> it would idling online. The manufacturer suggests setting that commandline
> parameter:
> 
> <https://www.tuxedocomputers.com/en/Infos/Help-Support/Instructions/Fine-tuning-of-power-management-with-suspend-standby.tuxedo#>

Thanks for the clarification.

> I just retested your patch with setting mem_sleep to "s2idle", and it no
> longer triggers the loss of PCI devices. I guess that could be the indicator
> that Björn asked for.

I wonder if the patch actually helps here now because the reason we want
to add it back is that it allows the CPU to enter lower power states and
thus reducing the power consumption in S2idle too. Do you observe that
when you have the patch applied?

> I attached the output of dmidecode to the bugzilla entry mentioned above:
> <https://bugzilla.kernel.org/attachment.cgi?id=304494>

Thanks!

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F07423ED
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF2KYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2KYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 06:24:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE0187
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688034242; x=1719570242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Xi11TZEN672ulSSk95+H1QUcKmYZXEXirny1TMPUpc=;
  b=ZyID/msezoySSrf5CPEPhG8twLiB06GfC75ytr05iNLs1R3XsWmh9s9j
   7svWFTtvfpAueDb9667z/5j8sLZ8IctyeaviVfwVVSeuRkF1OSZ/+k8hw
   +3pnVHTqo257DF8uU+Dt5wbtwp6qxX4xKi+eKT6nkWE8QhaPtCdx4KxV/
   O+PpIc+TsKVtvwm3tmUkMNacPeWY+dKAWKcpmKIs1ZdmekmXDrrc8Ael8
   /1NPEk+Y//zTH58OGjufI/DrLshhnS6IrIvfYnf7dFzK2jseSrNN45LUu
   LRpncRWx0Y7h9GbkxdceldHJMuxnJ7pRxmSBO4K0QHLnrBxQRVvQMmqX8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360922868"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="360922868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 03:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720521304"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="720521304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2023 03:23:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B443358; Thu, 29 Jun 2023 13:23:58 +0300 (EEST)
Date:   Thu, 29 Jun 2023 13:23:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <thomas@witt.link>
Cc:     Thomas Witt <kernel@witt.link>, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20230629102358.GP14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 11:47:01AM +0200, Thomas Witt wrote:
> On 28/06/2023 12:59, Mika Westerberg wrote:
> > I wonder if the patch actually helps here now because the reason we want
> > to add it back is that it allows the CPU to enter lower power states and
> > thus reducing the power consumption in S2idle too. Do you observe that
> > when you have the patch applied?
> 
> No joy. I did not check what its actually doing, but the computer takes
> about 150mA over the charger at idle with screen off and 140mA in suspend.
> With mem_sleep set to "deep", it takes about 20mA in suspend. All with the
> battery at 100%, at 19.7V.
> 
> So I guess I want to keep the "deep" setting in my cmdline.

Okay thanks a lot for checking! Back to drawing board then...

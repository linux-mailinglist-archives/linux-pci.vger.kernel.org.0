Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE963356E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 07:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKVGml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 01:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKVGmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 01:42:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5016369
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669099357; x=1700635357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlGn0lSAv9F2GKdxS0kY7kX0REeyqVb3DzCbY7rRxF4=;
  b=hS+W3RAipAbzVmuPhBl+vcIu6tSCKPKwMt9KjZLPm0dHNP+bt3VVedGY
   ppRYQ0pEeOCNITlMwIDvO8uNVFNCQOwQHbiP8PfPVmfL/27uWaUHlKdBr
   6WPDdeaUks8+9rjNBkk11B8IfGVxGgbXfwyoLTkiqtOiUxAICVfL6aegc
   Z00KJPpxOr3TDS8M9yOiy0gS89x0G4kmKrblJBUYtG9Bf+Ye2Qyfdt9uU
   ueebC8ZqcldD/n2KIzWE06euydv/pgNCkOubzw5z+10jqB5dbjLZwUvmj
   JjQTgRtQ1zK6IcGabJyobvlvB9wxS+PQ6Qi4Po3xc9dFoMZN16eFQnpGC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="314895898"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="314895898"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 22:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="747224898"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="747224898"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 22:42:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 45195128; Tue, 22 Nov 2022 08:42:58 +0200 (EET)
Date:   Tue, 22 Nov 2022 08:42:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <Y3xvcvqgFbYMIIpl@black.fi.intel.com>
References: <Y3tlRIG99P/amO9Q@black.fi.intel.com>
 <20221121224548.GA138441@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121224548.GA138441@bhelgaas>
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

On Mon, Nov 21, 2022 at 04:45:48PM -0600, Bjorn Helgaas wrote:
> IIUC, the summary is this:
> 
>   00:02.0 bridge window [mem 0x10000000-0x102fffff] to [bus 01-02]
>   01:02.0 bridge window [mem 0x10000000-0x100fffff] to [bus 02]
>   01:03.0 NIC BAR [mem 0x10200000-0x1021ffff]
>   01:04.0 NIC BAR [mem 0x10220000-0x1023ffff]
>   02:05.0 NIC BAR [mem 0x10080000-0x1009ffff]
> 
> and it's the same with and without the current patch.
> 
> Are all these assignments done by BIOS, or did Linux update them?

> Did we exercise the same "distribute available resources" path as in
> the PCIe case?  I expect we *should*, because there really shouldn't
> be any PCI vs PCIe differences in how resources are handled.  This is
> why I'm not comfortable with assumptions here that depend on PCIe.
> 
> I can't tell from Jonathan's PCIe case whether we got a working config
> from BIOS or not because our logging of bridge windows is kind of
> poor.

This is ARM64 so there is no "BIOS" involved (something similar though).

It is the same "system" that Jonathan used where the regression happened
with the multifunction PCIe configuration with the exception that I'm
now using PCI devices instead of PCIe as you asked.

I'm not 100% sure if the all the same code paths are used here, though.

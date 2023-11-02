Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA717DFB24
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjKBUAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 16:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUA3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 16:00:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E1DC
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698955223; x=1730491223;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8GVW73EQM4rPWf1gIfM6yX9Bz8ntf0C0Byli6S7Ab8=;
  b=UIJG0EvJoRYhPt0mT6/tQfMKuMWRZkd3XwLCrjY2lqDfCws3pckr+Ulg
   04HnfaxKQKcITpI8/7YK0/Xj6xRM5MRUSkvGQ6ZcOOnRPRGR2bKvL8r0W
   n1E2LkgXGvtwZKUojnHgw8EgVOmJa6LU6h8XmqaxJOf6VU4ha846jJKX2
   H+Zma3dO8jFIc4/oUdIjJAdsB6nGYY1TyzTJJeTepelaf7QKZ1/LVC1C3
   DEAXWwYQlK45I5yucG8kVAvEa8ZYqVaX2h98MOcDq56rPWizmg2CFKmWb
   Sp/GacQKeJYb6WS9n2rOJgmcburLhgSIxj3F5nqaRkN7WIcFUV9jv9YEo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="455289035"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="455289035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 13:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="790520721"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="790520721"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 13:00:22 -0700
Message-ID: <07f6fc377b36b23a3efca23af67ea9331c2bf3b6.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Date:   Thu, 02 Nov 2023 13:07:03 -0700
In-Reply-To: <20231101222025.GA101237@bhelgaas>
References: <20231101222025.GA101237@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > rootports'
> > > > Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> > > > VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> > > > Check is_hotplug_bridge and enable or disable
> > > > native_pcie_hotplug
> > > > based on that value.
> > > > 
> > > > Currently VMD driver copies ACPI settings or platform
> > > > configurations
> > > > for Hotplug, AER, DPC, PM, etc and enables or disables these
> > > > features
> > > > on VMD bridge which is not correct in case of Hotplug.
> > > 
> > > This needs some background about why it's correct to copy the
> > > ACPI
> > > settings in the case of AER, DPC, PM, etc, but incorrect for
> > > hotplug.
> > > 
> > > > Also during the Guest boot up, ACPI settings along with VMD
> > > > UEFI
> > > > driver are not present in Guest BIOS which results in assigning
> > > > default values to Hotplug, AER, DPC, etc. As a result Hotplug
> > > > is
> > > > disabled on VMD in the Guest OS.
> > > > 
> > > > This patch will make sure that Hotplug is enabled properly in
> > > > Host
> > > > as well as in VM.
> > > 
> > > Did we come to some consensus about how or whether _OSC for the
> > > host
> > > bridge above the VMD device should apply to devices in the
> > > separate
> > > domain below the VMD?
> > 
> > We are not able to come to any consensus. Someone suggested to copy
> > either all _OSC flags or none. But logic behind that assumption is
> > that the VMD is a bridge device which is not completely true. VMD
> > is an
> > endpoint device and it owns its domain.
> 
> Do you want to facilitate a discussion in the PCI firmware SIG about
> this?  It seems like we may want a little text in the spec about how
> to handle this situation so platforms and OSes have the same
> expectations.
The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
author did not test in VM environment impact.
We can resolve the issue easily by 
#1 Revert the patch which means restoring VMD's original functionality
and author provide better fix.

or

#2 Allow the current change to re-enable VMD hotplug inside VMD driver.

There is a significant impact for our customers hotplug use cases which
forces us to apply the fix in out-of-box drivers for different OSs.

nirmal
> 
> Bjorn


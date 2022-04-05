Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF904F36E9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiDELJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349467AbiDEJtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 05:49:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5FFD1D;
        Tue,  5 Apr 2022 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649152006; x=1680688006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZf/S7rVd3q8yY5bhWH8nEyTLZa+T5GesGL7jfopFXY=;
  b=BxM8NniRHwZrdAKEyoRLdXzc21jdTLEM9ka8fp3n/zXnd+M+0StfBm+k
   eMR8T0cGhJ6qJ8HA3WOqarsQO+Hy9tneZ49D7KOIgc9Rm2Jy7uvHv8h0L
   BF02vZexaKVbpoWUnU6ip8r1JbXE29qYrUL9Ea/5rZA82O3NiUfdlr85o
   cqzzMdhU6wa6XufFvZRehT5+j3GQluyuMm4ryCsxoyJST4FZpe3NIfxzY
   VdNCAirZJJgpJlKc55AIb9I7T3fTn6peH5Dbutw/ygh7IlJvdbV1M2Y6Z
   Z/jB2NDvZkkn+ROUt+R+wCIYbD6eNe8Hp1J7GRPDvjQriQzhxoFg/3ZVa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="242851251"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242851251"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:46:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="651826968"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:46:43 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 12:46:40 +0300
Date:   Tue, 5 Apr 2022 12:46:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 0/3] ACPI: PCI: PM: Power up PCI devices with ACPI
 companions upfront
Message-ID: <YkwQAKcFU4CzYX5E@lahna>
References: <21439956.EfDdHjke4D@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21439956.EfDdHjke4D@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Mon, Apr 04, 2022 at 05:20:30PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are cases in which the power state of a PCI device depends on an ACPI
> power resource (or more of them) in such a way that when the given power
> resource is in the "off" state, the PCI device depending on it is in D3cold.
> 
> On some systems, the initial state of these power resources is "off", so the
> kernel should not access the config space of PCI devices depending on them,
> until the power resources in question are turned "on", but currently that is
> not respected during PCI device enumeration.  Namely, the PCI device
> enumeration code walks the entire bus and enumerates all of the devices it
> can find, including the ones whose initial power state in principle depends on
> the ACPI power resources in the "off" state.

I guess these devices do not have _PRE() method either.

> Apparently, most of the time, the config space of such devices is accessible
> regardless of the state of the ACPI power resource associated with the PCI
> device, so the device enumeration is successful, but there are two potential
> issues related to this behavior.  First off, even if the given PCI device
> is accessible when the ACPI power resource depended on by it is "off",
> changing its configuration may confuse the platform firmware and lead to
> problems when the ACPI power resource in question is turned "on".  Second,
> the PCI device may not be actually accessible at all when the ACPI power
> resource depended on by it is "off", in which case it won't be found during
> the PCI enumeration of devices.
> 
> This patch series addresses that problem by turning "on" all ACPI power
> resources depended on by PCI devices before attempting to access the config
> space of those devices for the first time.

Makes sense.

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

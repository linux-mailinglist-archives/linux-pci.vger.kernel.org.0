Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403476C4D6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 07:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHBFZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 01:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHBFZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 01:25:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EF8EE;
        Tue,  1 Aug 2023 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690953954; x=1722489954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SUYyiEFaOXroKQDsrvyWD1ilNyTYr4fVpzmSKVWFGCo=;
  b=iWz30P3aHgJ+eISBJX5FEIjlH4N+wXjVR0TOAk5ZRNLf5rwnquVXiSrF
   KuwTJuTpiIWo2Q2h9WeNRF4iqAbMEEl6KxIwgniPjz3a7uTfr0qpi9e5y
   9d6+9q+ipksxV62N50Pc9T1juj7r/G0V11kvXODLI+qb8f1F8PCjEGbb0
   4NxktdDuk03vqNMu8o2D8Pnf9KahjpteZ7aRKxE8xomx8KUx4WVsUnNQE
   OygD13h9CMMr+gn/20qxvsSJuII8vTlB8f1c+tuilXqmb3PQm9jrKm4ww
   wMm0VDMlSQo4CYzYe7NEUCE/ZlL9Ki/Exa0kyo/o0ecFaTMFyFXF4CWVP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372215666"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372215666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="758611562"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="758611562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2023 22:25:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7132213F; Wed,  2 Aug 2023 08:26:01 +0300 (EEST)
Date:   Wed, 2 Aug 2023 08:26:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Message-ID: <20230802052601.GM14638@black.fi.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
 <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Tue, Aug 01, 2023 at 10:17:11PM -0500, Mario Limonciello wrote:
> > Consequently, platform_pci_bridge_d3() will return false and the only
> > thing that may allow the port to go into D0 is the dmi_get_bios_year()
> > check at the end of pci_bridge_d3_possible().
> > 
> > However, that was added, because there are Intel platforms on which
> > Root Ports need to be programmed into D3hot on suspend (which allows
> > the whole platform to reduce power significantly) and there are no
> > ACPI device power management objects associated with them (Mika should
> > know the gory details related to this).  It looks like under Windows
> > the additional power reduction would not be possible on those systems,
> > but that would be a problem, wouldn't it?
> > 
> 
> I've been thinking on this today, and I at least have a hypothesis about
> this behavior.  Perhaps Windows is actually utilizing enabled PEP
> constraints to enforce what state device should be put into over Modern
> Standby cycles in the absence of ACPI objects.
> 
> In the case of one of my problematic system the PEP constraints for the root
> port are:
> 
> Package (0x04)
> {
> 	0x00,
> 	"\\_SB.PCI0.GP17",
> 	0x00,
> 	0x00
> },
> 
> That first 0x00 means the constraint isn't actually enabled for the root
> port.
> 
> Mika,
> 
> Could you get an acpidump from one of these problematic Intel systems so we
> can check the PEP constraints to see if this theory works? Or maybe you have
> some other ideas why this is different?

The patch adding this was merged in 2016 and unfortunately I don't have
any of the ACPI dumps from them available anymore (and do not recall the
details either). I think these were Apollo Lake-P based systems with the
initial runtime D3cold and S0ix support at the time.

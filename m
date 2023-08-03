Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D276EDC7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHCPPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbjHCPPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:15:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EC1713;
        Thu,  3 Aug 2023 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691075686; x=1722611686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQ71cFEQdSQQ+sgcBE2/3AzkL69DgqJAsfRaCidqc5U=;
  b=J74i/c465vh0o81QpjWLMWKvUNAmXPnjKUInvilEiK6zM6CEvzeySIap
   ulqAuKY9O3qrDO9kW+T4VNqF1owzQpZfO8Y5mb7GB7eO/0i85KBben36r
   234hJfbUYM6xIaAqQ1W60n/R6GSETtxdler7pcSv/e5ujYrsbXcVfn/BM
   SGSYWWbTxT86dScMKPZBVDJIMZw8kZFO0BMKnD2yUwcplpa7XmGBSemqf
   14qpsG+tTGrBGP6DL+ubn3r48O8N5Ng2oT2AjDha9mZdw8l1eECLptRUU
   sJ6x6ZlmdetDRRSBTtNca3Z1wnWDoPuI0FK1mXCktFSVGZt8ZnmzBwpob
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433751259"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="433751259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795008846"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="795008846"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2023 08:14:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B03713ED; Thu,  3 Aug 2023 18:14:54 +0300 (EEST)
Date:   Thu, 3 Aug 2023 18:14:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Message-ID: <20230803151454.GZ14638@black.fi.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
 <20230803050118.GV14638@black.fi.intel.com>
 <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 06:38:45AM -0500, Mario Limonciello wrote:
> On 8/3/23 00:01, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
> > > @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > >   		if (dmi_check_system(bridge_d3_blacklist))
> > >   			return false;
> > > -		/*
> > > -		 * It should be safe to put PCIe ports from 2015 or newer
> > > -		 * to D3.
> > > -		 */
> > > -		if (dmi_get_bios_year() >= 2015)
> > > +		/* the platform indicates in a device constraint that D3 is needed */
> > > +		if (platform_constraint_d3(bridge))
> > 
> > This for sure causes some sort of power regression on the Intel
> > platforms made after 2015. Why not check for the constraint and:
> > 
> Are you sure?  I saw it as an explanation of how Windows could put the
> systems into D3 when there is no other PM related ACPI objects.

I'm concerned if there are no PEP constraints on some of the affected
systems this now leaves root ports into D0 then, no?

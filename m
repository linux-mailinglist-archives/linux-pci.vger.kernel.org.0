Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA5750C57
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjGLPXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGLPXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 11:23:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295411B;
        Wed, 12 Jul 2023 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689175399; x=1720711399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dE7w3MuTua6J4lzSeULL0VUOQdinRgx4JKozShjUPmw=;
  b=Vn8EZek8h4l2d2CKPCkKkxv48VMJXv6DD8gkCSSqlV3z6e5+H65y6ozz
   XZ5UPEtZm2tM06HH9lnO9M8ptG06dmz8M7fYyeLa1GsZyFQvzKbF6U5GH
   hHst5BycKD+DKHPZk1z6E6nVLOiS6yY50YpgBXn9C7mCU1+PQUvdPs1RJ
   yl+rtKN8+6DgDVhYxcfUtZlew/fYnxYf87e7rAxA2kE0N62Puuc+dMdtH
   is9vW16KQlssbW+K42/RZxmzlrR+22In1qvGY4vxpju3A1qtIv5I7WoKJ
   Q6grLPxSMgEpBK8RSrYQ8PKPTe3PISB06UvRwFgdaP/+wwrbETxmSnquG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344518526"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="344518526"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791661462"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791661462"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 08:23:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbgK-002A8V-2t;
        Wed, 12 Jul 2023 18:23:08 +0300
Date:   Wed, 12 Jul 2023 18:23:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Message-ID: <ZK7FXIA+7GTDYK+Z@smile.fi.intel.com>
References: <20230711005325.1499-3-mario.limonciello@amd.com>
 <20230711221427.GA250962@bhelgaas>
 <CAJZ5v0hmDVkUz8QbE3Jx0kLqDfB6hEuQjhd_u8Kjj2hyZYpZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hmDVkUz8QbE3Jx0kLqDfB6hEuQjhd_u8Kjj2hyZYpZGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 01:48:11PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 12, 2023 at 12:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:

...

> > Tangent unrelated to *this* patch: I don't know how to think about the
> > pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
> > seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
> > claim *all* PCI devices, even external ones, are power manageable by
> > the platform, which doesn't seem right.
> 
> No, we don't.
> 
> This only means that PCI devices may be power manageable by the
> platform and so the platform code should be invoked to check that.
> AFAICS, intel_mid_pwr_get_lss_id(() will return an error for a device
> without platform PM support.

If it's a problem somewhere, we may even harden that by checking
the bus nr to be 0. The devices outside bus 0 for sure have not to
be affected by this code.

-- 
With Best Regards,
Andy Shevchenko



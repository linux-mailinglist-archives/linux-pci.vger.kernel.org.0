Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD67E9B60
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKMLt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 06:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMLt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 06:49:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A97D5A;
        Mon, 13 Nov 2023 03:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699876165; x=1731412165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pae47Braga+7iyIGcOCVAQGlVNcrshtlQuZZ9RChzDg=;
  b=YHGOtXQ0oNcYrVE1MwmmIdXJFZ6EXya7RFQMsRXFqizUkMcNsbqIDiJk
   mXYfRygwk3SrNiTE7MyvzxiPEiwa1b9TEHvO9xqU6TFTka6nRLxM0l08L
   vU7p1NKTpUs9CCTOsIv34vktPhXyQZaNykrG9GUrM6LnlDEwcHH8H/4fi
   UL2VH5F9txZl9NITreslzvPIOBDwU1k6+BNRyGJwWLZg3Ph2qpScNke1f
   aPgmlcAvt5vSnKfLTQxdz3guYgHkGBbQX6Db7kD9MPKoiRDaYBvIv3Svh
   YKf5wbQaRmiLmoBGmugNtbwDhO0aEy4IXjeNqWmkTntUCGyuQmULldmMd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394320421"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394320421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="1095726963"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095726963"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:49:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2VRM-0000000DXxO-2UUz;
        Mon, 13 Nov 2023 13:49:16 +0200
Date:   Mon, 13 Nov 2023 13:49:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <ZVINPKm_4Qvxw6qh@smile.fi.intel.com>
References: <20231030114218.2752236-1-andriy.shevchenko@linux.intel.com>
 <20231103184614.GA163110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103184614.GA163110@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 01:46:14PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 30, 2023 at 01:42:18PM +0200, Andy Shevchenko wrote:
> > Coverity complains that pointer in the pci_dev_for_each_resource()
> > may be wrong, i.e. mighe be used for the out-of-bounds read.
> > 
> > There is no actual issue right now, because we have another check
> > afterwards and the out-of-bounds read is not being performed. In any
> > case it's better code with this get fixed, hence the proposed change.
> > 
> > As Jonas pointed out "It probably makes the code slightly less
> > performant as res will now be checked for being not NULL (which will
> > always be true), but I doubt it will be significant (or in any hot
> > paths)."
> > 
> > Fixes: 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()")
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/r/20230509182122.GA1259567@bhelgaas
> > Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, Andy, I'll look at this soon after v6.7-rc1 (probably Nov 12).

Since it's anyway a non-critical issue, take your time. Based on the tags
it may be backported if needed, so business as usual.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



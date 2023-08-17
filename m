Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6877F413
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349945AbjHQKKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349950AbjHQKKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 06:10:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4272D61;
        Thu, 17 Aug 2023 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692267034; x=1723803034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WF6qHmrA49EIsPHIRj0qWWdYUfEfcmu1pgGm2RKaeN0=;
  b=QcGULlOj72sh6o5UtRm6XQXEXNJ1iYDTBH0qS1SHsJkKmrQoqvIyVVXt
   ef5bsHeV4KroDj2UdEArprgx8huFxFiuaE4dS5MMdgkWIV9UZ8os9ddFo
   PuwvhGDtCKqwui2Djr6Nxyjn0ZjRvivFahheVjJnXFkUYfWmcWAl751wN
   194kGEkwbLbVRzf+h/ioQsh470dLXEdPjAwIAVM/FQlz8DeQ+9BeDIQck
   FyNNnnPMZ0J72dpziCCqkAV65o+U8ZY9mB3NoyVQHI3DdfoP3uDcWI6YN
   ixy20N3h9df2KmdO3Sf2InEWqFsm9Zt8DIUNYy5ivS+AVnSFQaHKvvAxl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372768928"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="372768928"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908349051"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="908349051"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 03:10:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZxT-006c9Q-29;
        Thu, 17 Aug 2023 13:10:27 +0300
Date:   Thu, 17 Aug 2023 13:10:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v12 3/9] ACPI: x86: s2idle: Post-increment variables when
 getting constraints
Message-ID: <ZN3yE3V8Ni8uJMse@smile.fi.intel.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
 <20230816204143.66281-4-mario.limonciello@amd.com>
 <404044b2-8e7a-4420-9c10-b2ca75d7e3aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404044b2-8e7a-4420-9c10-b2ca75d7e3aa@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 07:42:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 8/16/2023 1:41 PM, Mario Limonciello wrote:

...

> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

It's not the first time your tag gets broken. Can you fix it?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15077FB3C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353350AbjHQPxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353346AbjHQPw4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 11:52:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C130D1;
        Thu, 17 Aug 2023 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692287575; x=1723823575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pyoYWpEbN8fAeydCcQAWOOE9Rlz6EBq69dDlZGJ2is=;
  b=m027MSZv/siKpF1arMcmDsjZ/jO6w0cCnTnZtR6PKJZ+o/2Ozn4Iq3FA
   QU8MDfOD4wt560z5fyhO1owKN0k7WJ0EhBn9RQN2Ejr7iVbRcTvauILBg
   LeYDYg0nVQHBz+jl4k4B7xOYkFjrNERHsxjxDr0MSly9tmIulLIXMK8q6
   lv0CaR8PapBTRsXGNv1zSt8Vkw1Iq98kqkVamaoEy8slTlP1TZ/0NpRg2
   D1b3i2MypnnzDbaEmTS6B4HjuGLwPZEtXf+yG/ZJCFDzxQFa8o9tqauRY
   hUoC67o72VrCarWjP2XUpZW5zEVYOQntkZvVZ4VapD6tOVs9Jxl3ul+Us
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370315140"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370315140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981233364"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981233364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 08:52:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWfIo-000jtM-1f;
        Thu, 17 Aug 2023 18:52:50 +0300
Date:   Thu, 17 Aug 2023 18:52:50 +0300
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
Message-ID: <ZN5CUqxW1ATR7QF8@smile.fi.intel.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
 <20230816204143.66281-4-mario.limonciello@amd.com>
 <404044b2-8e7a-4420-9c10-b2ca75d7e3aa@linux.intel.com>
 <ZN3yE3V8Ni8uJMse@smile.fi.intel.com>
 <78b8e5bc-9147-4c07-acfc-d653cfe2d1a1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b8e5bc-9147-4c07-acfc-d653cfe2d1a1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 08:28:09AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 8/17/2023 3:10 AM, Andy Shevchenko wrote:
> > On Wed, Aug 16, 2023 at 07:42:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> On 8/16/2023 1:41 PM, Mario Limonciello wrote:

...

> >> Reviewed-by: Kuppuswamy Sathyanarayanan
> >> <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > It's not the first time your tag gets broken. Can you fix it?
> > 
> 
> Sorry, changed the system recently and did not re-configure the email
> client settings. I hope it is fixed now.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Seems good to me, thank you!

-- 
With Best Regards,
Andy Shevchenko



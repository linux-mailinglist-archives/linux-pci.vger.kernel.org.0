Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670D4F7A63
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbiDGIxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 04:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiDGIxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 04:53:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAEB2ACD;
        Thu,  7 Apr 2022 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649321476; x=1680857476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvvRdha+qpxn4dQmcryB8CJAVWXcpexk0ryCTlfgnEM=;
  b=M7RcDyUJ8/zzkWPSzZUJ0vXtK90kP2GO9rH+/AGbzKUkk56Vi+KZz7GP
   EvZtKbhTCoJyz11aM/aK0h87S2XPr+ywhmka/zOJWGSiWOKTdgpLZbCh/
   20nShUHl+Mmf29NZdJFdx5Wa9tv/KAExK1o5ZEhS4s4Wa3vyrgIk6H8+s
   WDnyLZ/MOEqjuPUAtFsTBpd84WjsN7j7yYEidPsmEIv1Cm9B0ps+RFc4c
   lgmw5aPt4BUZ/u65q+HyjT2NqjjOfeZqyq7aeydFPfjmhNYugvRKx7kgj
   8t/my32LeBI1Ibx5nwdf0m7l57tD37Re+qSDZe+F4FOCwnlGPECtRTyJZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241860122"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241860122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:51:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="570963311"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:51:10 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Apr 2022 11:50:46 +0300
Date:   Thu, 7 Apr 2022 11:50:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: PM: Power up all devices during runtime resume
Message-ID: <Yk6l5riEX3WJLZfT@lahna>
References: <4412361.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4412361.LvFx2qVVIh@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 06, 2022 at 09:00:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, endpoint devices may not be powered up entirely during
> runtime resume that follows a D3hot -> D0 transition of the parent
> bridge.
> 
> Namely, even if the power state of an endpoint device, as indicated
> by its PCI_PM_CTRL register, is D0 after powering up its parent
> bridge, it may be still necessary to bring its ACPI companion into
> D0 and that should be done before accessing it.  However, the current
> code assumes that reading the PCI_PM_CTRL register is sufficient to
> establish the endpoint device's power state, which may lead to
> problems.
> 
> Address that by forcing a power-up of all PCI devices, including the
> platform firmware part of it, during runtime resume.
> 
> Link: https://lore.kernel.org/linux-pm/11967527.O9o76ZdvQC@kreacher
> Fixes: 5775b843a619 ("PCI: Restore config space on runtime resume despite being unbound")
> Reported-by: Abhishek Sahu <abhsahu@nvidia.com>
> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

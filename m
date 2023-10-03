Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7607B65B9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjJCJli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjJCJlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 05:41:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362559B;
        Tue,  3 Oct 2023 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696326094; x=1727862094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3HBmbH4u4NfbMBHXFNCryjhQYhNC51pfF+ukvqnyIQ=;
  b=F8Im1UQbp0L9tygyvSZCTbkpXdtGQZJyqmppyVy05wDGI8026X7aL7Cr
   zXkcmI9KDo5aCS4TDwTgjqk0FFfmG2vd5UPgBx7qmeeJJr6lJ/ef3Rpmv
   ksuT91Bil1U1pG70TxCBHqSS0hV504l9KLgjVNue1yUMgXLWR6iSCBJK0
   C31IhLnrHweuM7hzIA4KCX7vY2tfXL1JGC4RJKpu6C0i344ekFsmQDDXs
   X6V9lW4/LjEE1DiRVpkG4iYFzV8KrNzJqzPJTardW5P5bUZneIT4j7B/Y
   0x7rp32fzKForjAGREQ7H8m/wPTDVfO5Mh94RO0G4XdQJB0nK9bPfN3+4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362205220"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="362205220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744428301"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="744428301"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2023 02:41:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AA399194A; Tue,  3 Oct 2023 12:41:29 +0300 (EEST)
Date:   Tue, 3 Oct 2023 12:41:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003094129.GF3208943@black.fi.intel.com>
References: <20231002180906.82089-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002180906.82089-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> suspend.  This occurs because on some AMD platforms, even though the Root
> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> messages and generate wakeup interrupts from those states when amd-pmc has
> put the platform in a hardware sleep state.
> 
> Iain reported this on an AMD Rembrandt platform, but it also affects
> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
> generates the PME. To avoid this issue, disable D3 for the root port
> associated with USB4 controllers at suspend time.
> 
> Restore D3 support at resume so that it can be used by runtime suspend.
> The amd-pmc driver doesn't put the platform in a hardware sleep state for
> runtime suspend, so PMEs work as advertised.
> 
> Cc: stable@vger.kernel.org # 6.1.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Cc: stable@vger.kernel.org # 6.5.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Cc: stable@vger.kernel.org # 6.6.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

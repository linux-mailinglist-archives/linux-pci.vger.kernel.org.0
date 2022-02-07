Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351424AB57F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 08:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiBGHDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357576AbiBGGoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 01:44:10 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:44:10 PST
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D2C043186;
        Sun,  6 Feb 2022 22:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216250; x=1675752250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjr159qcmU+ae4vSTxa2jFhmRo7RXE82RnhWyfc7SDU=;
  b=Dly9fqcIGxAxJbV+IpmKFMxmvIJi/hx/XAcV4dF+WdIqMqplNiCbdrMt
   vle/pfamEhA+r0gtqWvl88/v/ixO9wxRSV7wGHUmchbg7KZU2m1/B/4FC
   7Kc9ejFNXTmqf+45ZF8JaaA4Q9Ghpi4EfSyL0GfqwTkW69cl48pSNlPCV
   4Cc3N+h3VMR4/wAEXRCfw6UBxcK1c5p/AAARJ9Ch0X4sH3fd1RX01QOHp
   +ZIcwIEgQFirtALa0n8Ap+hQFh7snDPfoYjBXPJmH3SZrgNy1RtMG+awn
   FyUDBVXI0JVne1koCFuhGjHjOmX7G+lK6YCtvLyxNwMO57XAjfAc/rSOL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229300725"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="229300725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="584743018"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:04 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Feb 2022 08:41:57 +0200
Date:   Mon, 7 Feb 2022 08:41:57 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Message-ID: <YgC/NQFN7yOffKv3@lahna>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204182820.130339-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Fri, Feb 04, 2022 at 12:28:18PM -0600, Mario Limonciello wrote:
> Various drivers in the kernel use `pci_is_thunderbolt_attached` to
> designate behaving differently from a device that is internally in
> the machine. This function relies upon the `is_thunderbolt` designation
> which checks for a specific capability only set on Intel controllers.
> 
> Non-Intel USB4 designs should also match this designation so that they
> can be treated the same regardless of the host they're connected to.

Not objecting this if really needed but since USB4 is supposed to be
transparent to the native (tunneled) protocol, I would rather try to
figure out if there is really need to change driver behaviour whether it
is connected over USB4 or plugged natively on the PCIe slot.

Can you elaborate a bit what kind of functionality needs this? Perhaps
we can figure a better alternative?

Thanks!

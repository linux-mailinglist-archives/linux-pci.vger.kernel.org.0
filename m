Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F157B65C1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjJCJoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjJCJoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 05:44:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE754A6;
        Tue,  3 Oct 2023 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696326251; x=1727862251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+SYu9zrGvFmbRhUEqLTgMR+wzzPFb8MNKSU4bv+UTw=;
  b=jE2Kd3jHVKwrFr/N2B4xdJGurzcfywMVKY/P4bfnFKcvj49pt8Tqo1L/
   7MXWCSQOKPjZcHjaiEMZmxWloZ1iT6A1cSJrAcLQanlxdtWzdPnGgX55K
   35LQLENnr6/a3Y78boPu8rOOd0/OAHHtGP4WLWF+jqeE3ByvUFxH8me70
   Mx1ZKC8IDXrJvvNKv5z3P4P+tWVk+PWsyMmL0uVUjO/29+UJcD30TWbgn
   2SSWUp5Du23oO7zU02ltgh2YiChukz4JnedeA4alfocmArsnT44PPf6X9
   05PJSO6bCBTL20jtkQODyHm98LvLxpH8R/WmNmdsq/VgttOnORRHXxutY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4398085"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="4398085"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754352145"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="754352145"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2023 02:44:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8A74218A0; Tue,  3 Oct 2023 12:44:07 +0300 (EEST)
Date:   Tue, 3 Oct 2023 12:44:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make d3cold_allowed sysfs attribute read only
Message-ID: <20231003094407.GG3208943@black.fi.intel.com>
References: <20231002181025.82746-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002181025.82746-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 01:10:25PM -0500, Mario Limonciello wrote:
> Before d3cold was stable userspace was allowed to influence the kernel's
> decision of whether to enable d3cold for a device by a sysfs file
> `d3cold_allowed`.  This potentially allows userspace to break the suspend
> for the system.
> 
> For debugging purposes `pci_port_pm=` can be used to control whether
> a PCI port will go into D3cold and runtime PM can be turned off by
> sysfs on PCI end points.
> 
> Change the sysfs attribute to read-only and simplify the internal kernel
> logic to avoid needing to store the userspace request.

I wonder if this ends up breaking some userspace apps? Not objecting
though, just wanted to mention ;-)

One thing we could do is to taint the kernel or log a warning if
userspace touches this but allow it to do so.

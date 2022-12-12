Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B16498EA
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLLGU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 01:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLGU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 01:20:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D7B1F9;
        Sun, 11 Dec 2022 22:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670826055; x=1702362055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BGA3bKvoLuXx98MJqwsoe6Ky+jzhPr21suEXFjXfC6I=;
  b=c8DSQrhY9cTT59vq2ShEXLcO5DcnZg411YdBELDfDeAmmy9njPMjhsQi
   ep9f/FVUwVYH2gb7AJzUL/IDWvq2xXwTBcDPg+J2WsuYz8HDKs51aJpno
   ZIRar/nMs11Sm4pCSlcZWQqpMnrGLHQIptkNvdIFUSGYvXLheDg+M/uYS
   kSMIq/v/J8p1bWmT8qsePMV0HxQLe1g3vvxRv7X6ssVFHH4YhfGzMIWSQ
   bBzEnHDALdR3b86Up7Lx7Me0kPUjTi+x0d/M5VSTAphuhVus0cRQ2UWyl
   02y/DTygW5pCjnWHgR1yd6tMpM7RHGGHhWAoIU/LQCBEvugkEgyBmCNYA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="315415837"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="315415837"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 22:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="716678314"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="716678314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2022 22:20:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A5081179; Mon, 12 Dec 2022 08:21:22 +0200 (EET)
Date:   Mon, 12 Dec 2022 08:21:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
Message-ID: <Y5bIYoaAiIKwybH2@black.fi.intel.com>
References: <20221210002922.1749403-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Dec 09, 2022 at 06:29:22PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously portdrv allowed the AER service for any device with an AER
> capability (assuming Linux had control of AER) even though the AER service
> driver only attaches to Root Port and RCECs.
> 
> Because get_port_device_capability() included AER for non-RP, non-RCEC
> devices, we tried to initialize the AER IRQ even though these devices
> don't generate AER interrupts.
> 
> Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
> GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
> failed, and portdrv failed to claim the switch port at all.  The GPU itself
> could be suspended, but the switch could not be put in a low-power state
> because it had no driver.
> 
> Don't allow the AER service on non-Root Port, non-Root Complex Event
> Collector devices.  This means we won't enable Bus Mastering if the device
> doesn't require MSI, the AER service will not appear in sysfs, and the AER
> service driver will not bind to the device.
> 
> Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
> Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I asked our GPU folks to try this out too. Hoping to get some results
during the week.

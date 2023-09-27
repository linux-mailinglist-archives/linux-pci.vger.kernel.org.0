Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A67B0736
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjI0OoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0OoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 10:44:08 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 07:44:07 PDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E2DF4
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695825848; x=1727361848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JJuDtfhaeluZJ5YMgiKri/7xCla6Gcv4O7Y6al6dREE=;
  b=fshqL/sRrrjT724afohDpvW1JJ+0u9gyzRbZvX7jy1cg5DfknKZ9hXAy
   LFBSsuABsej9OlTXhjklx35eC49uLFB1EXAmsc8shb1ntsW3lpXw5mLBI
   IRiQmxSsW3ls3RgOS7EDFE77oW8d0Nt/uxfKI93DevoMec18CpOxZWDnd
   qZ+t2XyeS/RRm/+YKCaBO5/zbJYhMvskhHHK+zKbVmwTLUjPMVsUkHsB8
   gSGSptL+QGuzFdmJ9aETeEpqJycP+vEuZFKQhUph0LuAMPtDWotvX4OBs
   eQMs40rI5FTL9mud2vtxUWvXD0vy/8GyuExvQp5uvjta+wFnsNgh2MIcT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="3373709"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="3373709"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742730310"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="742730310"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2023 07:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5FE86177; Wed, 27 Sep 2023 17:42:48 +0300 (EEST)
Date:   Wed, 27 Sep 2023 17:42:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927144248.GK3208943@black.fi.intel.com>
References: <20230927051602.GX3208943@black.fi.intel.com>
 <20230927115703.GA445616@bhelgaas>
 <20230927124732.GI3208943@black.fi.intel.com>
 <20230927143143.GA16217@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927143143.GA16217@wunner.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 04:31:43PM +0200, Lukas Wunner wrote:
> On Wed, Sep 27, 2023 at 03:47:32PM +0300, Mika Westerberg wrote:
> > This is not a Linux defect. The firmware is expected to create that
> > tunnel so regardless of the "delay" the devices are already back. This
> > is not happening.
> 
> I recall that newer chips can be switched over to software connection
> manager at runtime.
> 
> Can we determine that the ICM firmware failed to do what it should,
> kick it out and let the software connection manager take over?

No that's not possible. In Macs it was "partially" possible but even
there you lose all the PM and the like. I don't even want to speculate
what happens if you run the same on PCs.

There is an option to "force" this but I do not recommend this (pass
thunderbolt.start_icm=1 in the command line).

This is of course completely different with USB4 where software CM is
the only option.

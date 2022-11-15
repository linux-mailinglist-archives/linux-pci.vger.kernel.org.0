Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3B6296B5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiKOLEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 06:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiKOLDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 06:03:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BE25C77
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668510150; x=1700046150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/TjyVRHuxVhk181X3KXj7LTc8906wF39sKft6i1Xlg=;
  b=NUz6G78r6erCZODW3iNv/1KJ/jh17xzRkB1mjHxWQ4PWPzGmbsDQcfhe
   x8jJKA7d5nBCP2ciiw1aZc01hlokWPxMm+mr3WEubo8yXWEk/7x89pqjC
   t7EQhzGHwRGS21/qAkUN4gPUx5GAarzpVXnARL+4Jw146ZupV23BYYOU8
   akxVAbcNeoNZ8uHqusq0+/ZI2//wXyze36rlPJ9ee/9SsnFhk0hcGCz9q
   +tt+Iz79W/7v3ZahEvDn6YI64405joYTA5v9DRLdK+WbD8ntJNRuwdHSZ
   wqXmORyhdJP2Kd3JT+4279yr3G0vm6FZ0XRo/W6X/rfrwOOKSOr1cHRJi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374358695"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="374358695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 03:02:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638902039"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="638902039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2022 03:02:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E030C2F3; Tue, 15 Nov 2022 13:02:52 +0200 (EET)
Date:   Tue, 15 Nov 2022 13:02:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Albert Zhou <albert.zhou.50@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 0/2] add hotplug depedency info
Message-ID: <Y3Nx3FbnraLZOP0r@black.fi.intel.com>
References: <20221115105240.32638-1-albert.zhou.50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221115105240.32638-1-albert.zhou.50@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 09:52:38PM +1100, Albert Zhou wrote:
> v2->v3: Dependency comment made more precise and technical, as suggested
> by Mika Westerberg.
> 
> v1->v2: I added comments that PCIe cards with USB4 or Thunderbolt also
> require the hotplug feature. I also added the "default y if USB4" line
> to the relevant config options, as suggested by Lukas Wunner.
> 
> Albert Zhou (2):
>   pci: hotplug: add dependency info to Kconfig
>   pci: pcie: add dependency info to Kconfig

For both,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

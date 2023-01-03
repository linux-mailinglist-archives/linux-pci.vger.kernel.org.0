Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1050565BEAF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjACLJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 06:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjACLJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 06:09:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C6FAFD
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672744159; x=1704280159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VmlxNUEVzrxo146ySgp68w1j1ztUeghyznrO8vuMFIM=;
  b=jMSCYNZtlx3w8X4zZU9/sFqhmn6PlnQ02aCKaAx8DcVnC1nCvHqGKAIq
   h5y0njJBMv6Lx9ddZR0XTc3+N+cdXBot5SncdRlFbIVOJ47MmB7rD0wzo
   Q+3YvuMcH0R4E/Ff3dSGbdSTuXOXqiXyg5+MtLjlWuhNUmw0xeViOgSts
   Wp0mvf4vh866ZasSalaEzDCG8B7o1u3potXO0rCLJiAuiiiFGoGL6jTgt
   cPsDjAjHkTmxzyJ3qCORc8wxLD1zaTT7CmLM6hZhCKAQDNPgon0oXYpmK
   LwXNqvEAN7cb+c3CvkFRZx61lQt1p9WvmMUWMHiqD8iX5snamO0X0Dbgg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="309407058"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="309407058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 03:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="654757646"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="654757646"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2023 03:09:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 559B719E; Tue,  3 Jan 2023 13:09:48 +0200 (EET)
Date:   Tue, 3 Jan 2023 13:09:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH 0/3] PCI reset delay fixes
Message-ID: <Y7QM/NWXrLfvn0ey@black.fi.intel.com>
References: <cover.1672511016.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1672511016.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Sat, Dec 31, 2022 at 07:33:36PM +0100, Lukas Wunner wrote:
> When recovering from a DPC reset, we neglect to observe the delays
> prescribed by PCIe r6.0 sec 6.6.1 before accessing devices on the
> secondary bus.  As a result, devices which take a little longer to
> recover remain inaccessible because their config space is restored
> too early.
> 
> One affected device is Intel's Ponte Vecchio HPC GPU.  Ravi Kishore
> kindly tested that this series solves the issue.
> 
> 
> As a byproduct, the series fixes a similar delay issue for Secondary
> Bus Resets.  Sheng Bi proposed a patch last May, a variation of which
> is contained herein:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20220523171517.32407-1-windy.bi.enflame@gmail.com/
> 
> 
> A second byproduct of this series is an optimization for Secondary
> Bus Resets whereby the delay after reset is reduced on modern PCIe
> systems.  Yang Su and Stanislav Spassov proposed a patch in August
> which is subsumed by the present series:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/4315990a165dd019d970633713cf8e06e9b4c282.1660746147.git.yang.su@linux.alibaba.com/
> 
> 
> If the present series is accepted, the two above-linked patches
> can be closed in patchwork.  (For some reason, Sheng Bi's patch
> is in "New" state, but marked "Archived".)
> 
> Thanks!
> 
> 
> Lukas Wunner (3):
>   PCI/PM: Observe reset delay irrespective of bridge_d3
>   PCI: Unify delay handling for reset and resume
>   PCI/DPC: Await readiness of secondary bus after reset

All look good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

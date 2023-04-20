Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52736E9111
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjDTKyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjDTKxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 06:53:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029549038;
        Thu, 20 Apr 2023 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681987876; x=1713523876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KmE64Zj6fg+JjmPyFrX4JWdvnkdBVGIAbEnhh9TTANI=;
  b=ILpveA9qRgTW7jyGSvc2SfKqSYOe5SxSUwZ0ePC5NlNGc1Te2WheejfD
   Yt2WsYoltrDbrJcQkeB+bQ5ZaN+suNxG1OSluUpGPYKehoNAfQp/7MEJZ
   ZWhXuPqD1/l66SJrZCc5bYLe0rer21EN0Xv1Ne12lvHjOWe7z39c7YVTr
   ssv1k7XljsX8gRIld11qbXUS3p+aPqqhCrcW7HVMv9FFd1ZSaxRFnWJ6O
   LuYTjTDiiWlVmk2Gy0N1dITgeRJuo+Y04TvC3OS6ciUleuamMjj+RYjNs
   e2vgaPv07+NwmXpxRDffn7E7JXoo6lkqHWL3yvlTYbXxT9duvKriMmnDy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373596339"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="373596339"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803299501"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803299501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 03:50:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A04B721E7; Thu, 20 Apr 2023 13:50:13 +0300 (EEST)
Date:   Thu, 20 Apr 2023 13:50:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI/AER: Disable AER interrupt on suspend
Message-ID: <20230420105013.GN66750@black.fi.intel.com>
References: <20230420015830.309845-1-kai.heng.feng@canonical.com>
 <20230420015830.309845-3-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420015830.309845-3-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 09:58:29AM +0800, Kai-Heng Feng wrote:
> PCIe service that shares IRQ with PME may cause spurious wakeup on
> system suspend.
> 
> PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> much here to disable AER during system suspend.
> 
> This is very similar to previous attempts to suspend AER and DPC [1],
> but with a different reason.
> 
> [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.feng@canonical.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

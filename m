Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610F7882CE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjHYJBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjHYJBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:01:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A1CD2;
        Fri, 25 Aug 2023 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692954095; x=1724490095;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wt7Z9jwm6HYtpbqOcPwsAZgItQ7w8UhRblltQlxs1JU=;
  b=VRYKE4CkgjBrwmQZ6OE93a5hROwLJxqwhgaOiFfoNrw/Tve1QF5qWNg3
   7V+7YbXKL+J2ihs/q5g0Cgm7Zizlomo3QasmSE1uzrhPfJsqVKJN5tzdw
   9jQ9UPF85Hxe0uOxC6U7hmzTeNR6DmicA3/CKNxermoDchLa5kopaeFrM
   lSjqT8ODowrxNo5941F3ImoAmX3bCf1+kudyF9SlyO7JHVOad9txtcg4G
   B3KIfxx857pdmNBc518vSMop7J47fz5b9b0o5cngozUkHHG1O2LAC0l4c
   llyY9DXsJ6WxK/2CGTxBeyTm6i4sBH73gEGxOf4Oygu3L3woQd28ObK6s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354999053"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354999053"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="984039519"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="984039519"
Received: from enguerra-mobl.ger.corp.intel.com ([10.251.213.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:01:27 -0700
Date:   Fri, 25 Aug 2023 12:01:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/12] PCI: Miscellaneous cleanups
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
Message-ID: <bfdee8c-ed51-94ba-418-6f69c9c62@linux.intel.com>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-613642315-1692954088=:3206"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-613642315-1692954088=:3206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Aug 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Simplify some trivial things and fix some typos and formatting
> inconsistencies.
> 
> Most are based on v6.5-rc1 (actually on the current "misc" branch, so there
> may be minor conflicts).
> 
> The last ("Simplify pcie_capability_clear_and_set_word()") is based on the
> current "pcie-rmw" branch because it changes the same code as that branch
> does.
> 
> No functional change intended for any of this, except the printk changes
> ("%#08x" vs "%#010x").
> 
> Bjorn Helgaas (12):
>   PCI: mvebu: Remove unused struct mvebu_pcie.busn
>   PCI: Unexport pcie_port_bus_type
>   PCI: Remove unnecessary initializations
>   PCI: Fix printk field formatting
>   PCI: Use consistent put_user() pointer types
>   PCI/AER: Simplify AER_RECOVER_RING_SIZE definition
>   PCI: Simplify pci_pio_to_address()
>   PCI: Simplify pci_dev_driver()
>   PCI: Fix pci_bus_resetable(), pci_slot_resetable() name typos
>   PCI: Fix typos in docs and comments
>   PCI: Fix code formatting inconsistencies
>   PCI: Simplify pcie_capability_clear_and_set_word() control flow

I read through all these patches. For the whole series:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-613642315-1692954088=:3206--

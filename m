Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A007674B01
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjATEmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 23:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjATEmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 23:42:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E863669D
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189457; x=1705725457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iSft0IDwImYtFB9A86C4t0UO5RgaT9h4Ykpp4vaz2jM=;
  b=kQ8Nad8YigvctVA0trNcHgAykon1qKQqjZP2E4RPsjdxIqZzWVx8TC6+
   y7i6iI6VNSAJ5XP9kolSUMj/z+iJAP6udrIo5rXNSRChWwedQUhjaeQrp
   Pa0z5k+N9iMgyrbMSKAX56E/9iylxFWGeENT6zA3QQIXrp1F9oPWEdxxx
   cr+javvUZcGu+d1Y6znYCpHiSJG+3MK3wZMYF+UtKTqGTVsZRYWsp8LZP
   B/NwPZL6la0nQDhHBr04qrG58BxfwYsB3jNV8vqnTdmBwAdsHbLZxvnXO
   FYHN5db21ZT2wEppLE9Ei9WAqMVn+XjjkULu7jyiwiOrdyAt14DA5n39M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387534401"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387534401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 19:55:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="653223510"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="653223510"
Received: from bakersax-mobl.amr.corp.intel.com (HELO [10.209.33.66]) ([10.209.33.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 19:55:33 -0800
Message-ID: <e773b789-9ac1-eb45-b1ab-11fc93aede40@linux.intel.com>
Date:   Wed, 18 Jan 2023 19:55:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 0/9] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230118234612.272916-1-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230118234612.272916-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/18/23 3:46 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
> ths PCI core sets the Device Control bits that enable error reporting for
> PCIe devices.
> 
> This series removes redundant calls to pci_enable_pcie_error_reporting()
> that do the same thing from the AER driver and several NIC drivers.
> 
> There are several more drivers where this should be removed; I started with
> just the Intel drivers here.
> 
> Bjorn Helgaas (9):
>   PCI/AER: Remove redundant Device Control Error Reporting Enable
>   e1000e: Remove redundant pci_enable_pcie_error_reporting()
>   fm10k: Remove redundant pci_enable_pcie_error_reporting()
>   i40e: Remove redundant pci_enable_pcie_error_reporting()
>   iavf: Remove redundant pci_enable_pcie_error_reporting()
>   ice: Remove redundant pci_enable_pcie_error_reporting()
>   igb: Remove redundant pci_enable_pcie_error_reporting()
>   igc: Remove redundant pci_enable_pcie_error_reporting()
>   ixgbe: Remove redundant pci_enable_pcie_error_reporting()

It should be simpler to do in one patch. Any reason to split
it into multiple patches?

> 
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  7 ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  5 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 --
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 --
>  drivers/net/ethernet/intel/ice/ice_main.c     |  3 --
>  drivers/net/ethernet/intel/igb/igb_main.c     |  5 --
>  drivers/net/ethernet/intel/igc/igc_main.c     |  5 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 --
>  drivers/pci/pcie/aer.c                        | 48 -------------------
>  9 files changed, 87 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

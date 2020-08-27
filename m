Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D01E254CF3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH0SXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 14:23:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:30618 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgH0SXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Aug 2020 14:23:10 -0400
IronPort-SDR: OqdWtoJvHCp+yCu+HUM28FY9wO+YPDXSpmrsLqkn4+88XOQw188Cn2ItD93CR1+TYfEXAOxyyn
 6fbSJJTn74pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="156549283"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="156549283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 11:23:00 -0700
IronPort-SDR: jzuRTxtrC9WjUaNjQ3tT2P+/zIovQmjsSHpC1Q3xP2+AQ9BS0JuUQ3REE4NY6AaFYZb69CG3Hz
 QQ6s/MvnSSZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="475331231"
Received: from cjahne-mobl.amr.corp.intel.com (HELO [10.254.85.141]) ([10.254.85.141])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 11:22:59 -0700
Subject: Re: [PATCH v8 0/5] Simplify PCIe native ownership detection logic
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4a6d3ed0-e1e8-71e3-9d16-e2838115f8c5@linux.intel.com>
Date:   Thu, 27 Aug 2020 11:22:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/24/20 8:58 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, PCIe capabilities ownership status is detected by
> verifying the status of pcie_ports_native, pcie_ports_dpc_native
> and _OSC negotiated results (cached in  struct pci_host_bridge
> ->native_* members). But this logic can be simplified, and we can
> use only struct pci_host_bridge ->native_* members to detect it.
> 

Any comments on this patch set?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

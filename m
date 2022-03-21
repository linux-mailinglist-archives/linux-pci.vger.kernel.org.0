Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F964E249A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiCUKtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbiCUKtb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 06:49:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425E13D76;
        Mon, 21 Mar 2022 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647859686; x=1679395686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQ9KPzVkz3G/2nXFWvcX9d+QrLPKKuVLsDfgQyXtQvw=;
  b=Fqbnnp+l2ApcVrmI3GuQ3UR1ZOzu/cqn5xCMELKHvaNF5ersgser0YFD
   mTjfN48xPhKEteqYQ5yWVN6ooHBztTJh7Mp6V1PymfqtaaCY/IOZP5Pua
   y9OY2O/aT69hup80GJQ/tQpmfXSNfSFufU+OiTOm096yTV1kl7laqzZfJ
   hhyq9lJ642s6R+9x9WkWwGFfpyRA5nSAbnGXnc44wZSGYjRnJLAhfrvv3
   +GP8aStlemZ5H3y23USFLBT42XgFS8i7L6/01iDejlfh7iMV6NzX12CpJ
   8Xokl4ECUg3+WM/7cdtqgeMitZHAAR8uIEqHjleW6Os20cIDUXfuYWHMN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="244994805"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="244994805"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:48:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559814338"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:47:59 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:45:40 +0200
Date:   Mon, 21 Mar 2022 12:45:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
Message-ID: <YjhXVFr4JqKI93Ae@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320062907.3272903-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
> 
> No functional change intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

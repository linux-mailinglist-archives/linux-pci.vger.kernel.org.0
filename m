Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B954E24AF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 11:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbiCUKvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbiCUKvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 06:51:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A33CA7F;
        Mon, 21 Mar 2022 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647859806; x=1679395806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fliE/T1LCX93MwQ1Bnv434Gg30/vCZwgY+6LB+3NqUM=;
  b=TsGu0BRYZeiyiB8/6sY5MZXTLJ6ymjmqsG4vb53QTU+89QzWSAF6axs5
   64Z20+sFkAFPmbx5PxzUk2AX4dVjjOF5G/YWFFOeCzSfnCO0MjIXMD/X0
   hZSRhzBKbTOG2kfJ56+CU9NKpT9ZnVljX+LrZz8WYPh9txyURypo3VgXU
   fcyX/qwgaSymw5VC6n2cLz+zkwXhBkTopI1qSi9JdmMQLmX2/Ig6TFCJn
   M1WRvR9Q12BJWzcpY+NXwtJS21yldmweA/3pKzuX7wj9ZhJXLjcyk1YQO
   VwZRzc2cW+5EUnmKYspXm2O39RNJAg1L8JnPkKvT2WXu0I1xXb3UPaEJ2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257240841"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257240841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:50:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="500128970"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:50:00 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:48:48 +0200
Date:   Mon, 21 Mar 2022 12:48:48 +0200
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
Subject: Re: [PATCH v4 2/2] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <YjhYEN/ajM71wMn0@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
 <20220320062907.3272903-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320062907.3272903-2-rajatja@google.com>
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

On Sat, Mar 19, 2022 at 11:29:06PM -0700, Rajat Jain wrote:
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Support the "DmaProperty" with the same semantics. This is useful for
> internal PCI devices that do not hang off a PCIe rootport, but offer
> an attack surface for DMA attacks (e.g. internal network devices).
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

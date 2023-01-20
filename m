Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6B674C78
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 06:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjATFfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 00:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjATFfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 00:35:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FDF2B0B9;
        Thu, 19 Jan 2023 21:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674192685; x=1705728685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPwLT4AdfGFNjdbmHQTqlULNnRfeNCfvR5vyvMh1ppY=;
  b=nJQ1xKWNQ9gUpHunIYAqfJfcNUyYyAIvvfBysMIaMp0QyinPIGdlWWR8
   Fo53lVqCn7LDcbXWPA7klVFnGgfGy7hmP/c6Ix3eefHsz4E90oVLewxbt
   ZSFsjTRNQTVKaPep4/DsyrJX6L0M2mJwF0E6KGbjkRYjmoLSfomwpzkFj
   VuRclqGLld5P+vS2hHONi9H8erFUGqxSeaZ6UjlODA7lchVM0Gil0ELfu
   dFYNTlZ4FX5NBoYPrt493C9jqUMFVIBzFVbpCoXPiUw7dsuCylr2KEus1
   F6hRQ3/XYGPVTd4GFSptR18ckgYX7PWXvezZp4rXxkXsr0iaa8NAzDa9X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411739204"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="411739204"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 21:28:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989296124"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="989296124"
Received: from mtcooper-mobl.amr.corp.intel.com (HELO [10.212.132.108]) ([10.212.132.108])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 21:28:46 -0800
Message-ID: <a374e36b-2da2-c76c-717c-1381b171d75e@linux.intel.com>
Date:   Thu, 19 Jan 2023 21:28:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V10 0/4] Enable PCIe ASPM and LTR on select hardware
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230120031522.2304439-1-david.e.box@linux.intel.com>
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



On 1/19/23 7:15 PM, David E. Box wrote:
> This series adds a work around for enabling PCIe ASPM and for setting PCIe
> LTR values on VMD reserved root ports on select platforms. While
> configuration of these capabilities is usually done by BIOS, on these
> platforms these capabilities will not be configured because the ports are
> not visible to BIOS. This was part of an initial design that expected the
> driver to completely handle the ports, including power management. However
> on Linux those ports are still managed by the PCIe core, which has the
> expectation that they adhere to device standards including BIOS
> configuration, leading to this problem.
> 
> The target platforms are Tiger Lake, Alder Lake, and Raptor Lake though the
> latter has already implemented support for configuring the LTR values.
> Meteor Lake is expected add BIOS ASPM support, eliminating the future need
> for this work around.
> 
> Note, the driver programs the LTRs because BIOS would also normally do this
> for devices that do not set them by default. Without this, SoC power
> management would be blocked on those platform. This SoC specific value is
> the maximum latency required to allow the SoC to enter the deepest power
> state.
> 
> This patch addresses the following open bugzillas on VMD enabled laptops
> that cannot enter low power states.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717
> 

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> David E. Box (3):
>   PCI: vmd: Use PCI_VDEVICE in device list
>   PCI: vmd: Create feature grouping for client products
>   PCI: vmd: Add quirk to configure PCIe ASPM and LTR
> 
> Michael Bottini (1):
>   PCI/ASPM: Add pci_enable_link_state()
> 
>  drivers/pci/controller/vmd.c | 97 ++++++++++++++++++++++++++----------
>  drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
>  include/linux/pci.h          |  7 +++
>  3 files changed, 132 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

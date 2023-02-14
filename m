Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC8696BD6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBNRhu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNRht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:37:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7AFB
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676396268; x=1707932268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uHrq8+Sc+LphMvKVXld0eTLkhCj5ixyZb7Z4CvktiBQ=;
  b=a3QakpJZCt4g2z1JT6U9YMQUziuN8HDYiK6DaUTjjsLMREbX8VsnMGCr
   pIP3gDbrm6i4csZUoQwjTgxeZgbpXHBQXN1IoH5Ndh3fLYFgFy7xOnhfl
   a+sOT3Dl4uucGVPghd6VNIgc6OV8zIPN8y0EVXxlA2uq1r61v8hQB+A0F
   EqlwnfCEYu9XtGNP5i+MH0IN5G5I6vSsGrhDmhUkc+/CD6Bh9ICtrJJPU
   kzicIICv5182PEtoqGlYk5nWwhcVsfrc1fVgZthyuu/4E8Chj0svdqY6T
   H9GLBBfawMjhHfnChz8Bj5Q2PikDzZJmqk4/uDwiH1oMSZZJMguRCyfAw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332530049"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332530049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:37:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812121837"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812121837"
Received: from mmerajah-mobl1.amr.corp.intel.com (HELO [10.209.112.27]) ([10.209.112.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:37:47 -0800
Message-ID: <9d131247-8196-7979-d267-51325dff9281@linux.intel.com>
Date:   Tue, 14 Feb 2023 09:37:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
        lukas@wunner.de
References: <167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/23 8:48 AM, Dave Jiang wrote:
> With commit [1] upstream that enables AER reporting by default for all PCIe
> devices, the documentation for pcie_enable_pcie_error_reporting() is no

/s/pcie_enable_pcie_error_reporting/pci_enable_pcie_error_reporting

> longer necessary. Remove references to the helper function.

Before removing the documentation, are the references removed from the
code? I think Bjorn only cleaned up the net drivers.

> 
> [1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..a82802795a06 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>  errors because device specific errors will still get sent directly to
>  the device driver.
>  
> -Configure the AER capability structure
> ---------------------------------------
> -
> -AER aware drivers of PCI Express component need change the device
> -control registers to enable AER. They also could change AER registers,
> -including mask and severity registers. Helper function
> -pci_enable_pcie_error_reporting could be used to enable AER. See
> -section 3.3.
> -
>  Provide callbacks
>  -----------------
>  
> @@ -214,15 +205,6 @@ to mmio_enabled.
>  
>  helper functions
>  ----------------
> -::
> -
> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> -
> -pci_enable_pcie_error_reporting enables the device to send error
> -messages to root port when an error is detected. Note that devices
> -don't enable the error reporting by default, so device drivers need
> -call this function to enable it.
> -
>  ::
>  
>    int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

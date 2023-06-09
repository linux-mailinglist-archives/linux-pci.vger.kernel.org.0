Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39EC72A6BE
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 01:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjFIXbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 19:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjFIXbA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 19:31:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF044A2
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686353341; x=1717889341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9i1iB8QTmN+++Ljbt+NWvlOM54eMgN2tMAINqKmbbZ4=;
  b=WzH0S1Ayk8JrEDP4WxhOOingjQ1XSaSCHHjPN++tP0+sFYOYq+5ELLTY
   /XooXuvrM3hr1RxJamf/ZmE7C1TqzLvW8T0HptJ6bn6uhRUejWMLZuDa6
   NybWJeVZSw1bJDW9T4s69kVnI/wn9ut/dNaQ5OWslP6RzoT4Mw+565FEr
   JJU2DzvWPrMFlO2ZtUVqGhszKELt7Tio2w1RkIXlMflRcWhOI01NZvAFM
   wPKyqxByVxPAgFpBeuBnnlr3xzQ78vICi/6rTOgLmzRPy5bmEkn+6C/11
   BjzIO4/hzaO9et4SMjJCzd14+5I+k+ioKzYtRx3Ah9Hhe5bFR9X3hhb8z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="386073437"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="386073437"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710512403"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710512403"
Received: from morganhu-mobl.amr.corp.intel.com (HELO [10.212.133.89]) ([10.212.133.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:29:00 -0700
Message-ID: <e4bacb19-3baf-ffa2-4cd1-6db96aca4e23@linux.intel.com>
Date:   Fri, 9 Jun 2023 16:28:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] Documentation: PCI: Update cross references to
 .rst files
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609222500.1267795-1-helgaas@kernel.org>
 <20230609222500.1267795-4-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230609222500.1267795-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/23 3:24 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Change references to *.txt to *.rst to match the current filenames.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  Documentation/PCI/pci-error-recovery.rst | 2 +-
>  Documentation/PCI/pcieaer-howto.rst      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 9981d330da8f..c237596f67e3 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -364,7 +364,7 @@ Note, however, not all failures are truly "permanent". Some are
>  caused by over-heating, some by a poorly seated card. Many
>  PCI error events are caused by software bugs, e.g. DMA's to
>  wild addresses or bogus split transactions due to programming
> -errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
> +errors. See the discussion in Documentation/powerpc/eeh-pci-error-recovery.rst
>  for additional detail on real-life experience of the causes of
>  software errors.
>  
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index c98a229ea9f5..3f91d54af770 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -160,8 +160,8 @@ when performing error recovery actions.
>  Data struct pci_driver has a pointer, err_handler, to point to
>  pci_error_handlers who consists of a couple of callback function
>  pointers. AER driver follows the rules defined in
> -pci-error-recovery.txt except pci express specific parts (e.g.
> -reset_link). Pls. refer to pci-error-recovery.txt for detailed
> +pci-error-recovery.rst except pci express specific parts (e.g.
> +reset_link). Pls. refer to pci-error-recovery.rst for detailed
>  definitions of the callbacks.
>  
>  Below sections specify when to call the error callback functions.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

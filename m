Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8172D75D81C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jul 2023 02:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGVASX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 20:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGVASW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 20:18:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A772106;
        Fri, 21 Jul 2023 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689985101; x=1721521101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W2Ht8Q5lag/UKO8J7Y6PdiC/ZRU+wcdJRyA2rSC1AlE=;
  b=aouOYLBBRhhgiKRtPp6xhMn9zgUzss695Z+lV4QqEeO3aEBlM5FyJp1A
   8Lp7w3jvD/0V1EOk8Yo4tLG7Uq6XUXStECmdYb9GE+biUIzGDus0qPLPP
   Ol90xw7UBZDPUskMquCGwvZPgoyVsayIr4smU+hg0GH3BxiLXMHTLBAC9
   mOvw1Oe+nTXerGmEU7hsMmvNBDwdduHAtBnpN9PQVLw1zUnrkumfrsrwh
   kwDJpGEYkyUb/ym3uLkBXA0+CaD3nsOn3TgdpawzE17PM1PwofWmY0lGq
   AGVFYPKIc/tWSx2QZqa1XYaldtDBF9cgg4q8gHsfyo8uNSJc7s8KWPYe0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369808862"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="369808862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 17:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="719025138"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="719025138"
Received: from cthomas-mobl1.amr.corp.intel.com (HELO [10.209.99.41]) ([10.209.99.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 17:18:20 -0700
Message-ID: <0e4dc46f-a086-8b85-f94f-b3530d958209@linux.intel.com>
Date:   Fri, 21 Jul 2023 17:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/21/23 2:47 PM, Smita Koralahalli wrote:
> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> of AER should also own CXL Protocol Error Management as there is no
> explicit control of CXL Protocol error. And the CXL RAS Cap registers
> reported on Protocol errors should check for AER _OSC rather than CXL
> Memory Error Reporting Control _OSC.
> 
> The CXL Memory Error Reporting Control _OSC specifically highlights
> handling Memory Error Logging and Signaling Enhancements. These kinds of
> errors are reported through a device's mailbox and can be managed
> independently from CXL Protocol Errors.
> 
> This change fixes handling and reporting CXL Protocol Errors and RAS
> registers natively with native AER and FW-First CXL Memory Error Reporting
> Control.
> 
> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> 
> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Added fixes tag.
> 	Included what the patch fixes in commit message.
> ---
>  drivers/cxl/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..2323169b6e5f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  		return 0;
>  	}
>  
> -	/* BIOS has CXL error control */
> -	if (!host_bridge->native_cxl_error)
> -		return -ENXIO;
> +	/* BIOS has PCIe AER error control */
> +	if (!host_bridge->native_aer)
> +		return 0;

Why not directly use pcie_aer_is_native() here?

>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

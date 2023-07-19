Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4875A005
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGSUj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSUjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 16:39:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE73FD;
        Wed, 19 Jul 2023 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689799164; x=1721335164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/eyxXxZ9T5eaCw0tKETLUSNQkftiddWXSmwZU2ySHLo=;
  b=ZNrTSBNO6dUMuONqby5qnGSi2gJxrbYA6EMem0TG++Ez6rVFFSfgjx0h
   yDtgB7RRGFOENcmJkQuZoLlaksnKqD/1oc1Cy6Kn2qEFUIXQBaZPQ/pLZ
   RtxphSPFjyPvS02C7xrmNXUKenHpQumbrLdYWVy1bDV3fU6MaeroWIJY8
   GldlNd5ALO2+x2hdJmZrtsFcsdwpanI3XDruv8rfXPBsXLsa2adkd3hNt
   2L3iTApxaYoqNOoElJ1pJvt2VKDNwcZL42tWki98y85+jOm0njvS9nRMc
   6bZV0eRy1+RJ4OBLg19wx6KwN1S92CBH1UjDfj09PUEdWY6JeXlmF5Faa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346869278"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346869278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848172221"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848172221"
Received: from vijayakr-mobl2.amr.corp.intel.com (HELO [10.212.182.233]) ([10.212.182.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:39:23 -0700
Message-ID: <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
Date:   Wed, 19 Jul 2023 13:39:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] cxl/pci: Fix appropriate checking for _OSC while
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
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/19/23 12:23 PM, Smita Koralahalli wrote:
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

Does it fix any issue? If yes, please include that in the commit log.

Since you are removing some change, maybe it needs Fixes: tag?
> 
> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/pci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..44a21ab7add5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
> @@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  		return 0;
>  	}
>  
> -	/* BIOS has CXL error control */
> -	if (!host_bridge->native_cxl_error)
> -		return -ENXIO;
> +	/* BIOS has PCIe AER error control */
> +	if (!pcie_aer_is_native(pdev))
> +		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

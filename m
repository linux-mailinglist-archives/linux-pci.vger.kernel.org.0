Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944105ECCFC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiI0Te4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI0Tez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 15:34:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342966FA17;
        Tue, 27 Sep 2022 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664307294; x=1695843294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JZPmuA9NArT3KuyZCskF79bot+02uPrqjNJBcTvQL8E=;
  b=dYx6U3hoeiuGyLZV84V+IVZ0WUhV2NNGed5KNEMC2Y1Mct8+qYXO3QQY
   PeRAQsTZo5iW4Iy7Jsmdqlup2CGsghHTtFgcCoHnTtHE88xFWbj/RPI35
   FBaM1/Qa9Ei6Rx/RqWblyZumMCPnHLP6k9uHvY+absROXEtE7u7CP4HNC
   W8PHkBwvWcvX1Q3Zf2urj3wGjH9RA1okZ5e6afSUSEyTFdtIouLjkDQXr
   xXezgviIuev7znDHq2YaEJNZKRSXpJYBWW8fOQ9ZEBbRHMgthJOkrBgdy
   aNxLdAc0GdFibCXdnRzNkDyYRi+Fwg/204n1vg1Ll2jDq1xYrU/uN5fkw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363252337"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="363252337"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:34:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684110152"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="684110152"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:34:52 -0700
Message-ID: <caf2949a-e98d-e0a2-dc8a-af632d9b610a@linux.intel.com>
Date:   Tue, 27 Sep 2022 12:34:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/9] PCI/DPC: Use
 pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-3-chenzhuo.1@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220927153524.49172-3-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/27/22 8:35 AM, Zhuo Chen wrote:
> Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
> no functional changes.

Just say pci_aer_clear_uncorrect_error_status() clears both fatal and
non-fatal errors. So use it in place of pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status().

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/pci/pcie/dpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d..7942073fbb34 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
> -		pci_aer_clear_nonfatal_status(pdev);
> -		pci_aer_clear_fatal_status(pdev);
> +		pci_aer_clear_uncorrect_error_status(pdev);
>  	}
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB46A7A76
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 05:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCBEYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 23:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBEYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 23:24:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CB231CB;
        Wed,  1 Mar 2023 20:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677731053; x=1709267053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v5b7ljPO/DDlID9gofehMryLNcSPUQ8+e5skFkdCs8E=;
  b=gMpRGsh7Sa3bgmNFJ3OGvonhFMC/OMaJn68VxRCXdfptd3vrrovE9F/+
   Uy0CwOtp8Eypdm0JFlwUrnOEqR0OEQ6CnzTmDylMYqHd/HytnMZYyNPcJ
   14AEsDuhHRlEwaT21nlrfPZqznnJw+x+Uq7bnRFAbuA+kWAZjtbBmpVAR
   O13kdnaBUwWTtDR6gcWj40FivR62WbvGd1zsX65SWbS+dQ3NJvmsfH3HT
   niiYT0NHId63EH6/jkzm/1HdHqj5dSHmCstK9EvoU5/jB/AEH/7PSzi5M
   lXZXPdN/W1iFjy5KdHD0g7IB1jECe18JiXdFjox94XAxsgx3FP68PPeiR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420873168"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="420873168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 20:24:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817836706"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="817836706"
Received: from rmarti10-mobl2.amr.corp.intel.com (HELO [10.212.193.233]) ([10.212.193.233])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 20:24:11 -0800
Message-ID: <917b1d52-54c2-ea8b-5382-dbd8ce71a76c@linux.intel.com>
Date:   Wed, 1 Mar 2023 20:24:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] Add support to enable ATS on VFs independently
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
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



On 2/27/23 8:21 PM, Ganapatrao Kulkarni wrote:
> As discussed in [1], adding a helper function to configure the STU of an
> ATS capability. Function pci_ats_stu_configure() can be called to program
> the STU while enumerating the PF, to support scenarios like PF is not
> enabled with ATS, whereas VFs can enable it.
> 
> In SMMU-V3 driver, calling pci_ats_stu_configure() to confgiure the STU
> while enumerating a PF in passthrough mode.

It looks like you are fixing this issue only for your platform. Is there any
way to generically program PF STU? May be from pci_ats_init()?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D416F4E63
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjECBRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 21:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 21:17:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BF26A9
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683076652; x=1714612652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmHmFFe8wRBBKR5BT2kOJA1ftG8QxJsXeHsLaeG1+dk=;
  b=hAeWTo3iB8CGtIUcPwgpxTPBXJpMtiKHvP6Bppi7ofqvaQUgZbvxxxPy
   /OZXo08QEKWpq+LKNhYPB83SWGvdXbzQf0n7WoImdfRwfu/lkDGXdCUcO
   6vBtteE/DGORYM3FGXiuuWaBdYy+8fPbo4zyYra8R/hcII6jH6+rvobff
   XZcGJyIy4BYO6wIQGBXMR0QTNaDp/FEcoflZGuI32WH33oMGBcubPpKka
   dd7+XXMHDONopZyZCVzvjyHs1aQJ6PJVZgFSyZZozVrBh1zLiuFZmPbGT
   XggXP07znDwiL5gmHsgxn9vIFtgftzjDde4nOXROczKVZuqVbQDi0hRjv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337677927"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="337677927"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="726970866"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="726970866"
Received: from leeliche-mobl.amr.corp.intel.com (HELO [10.209.114.176]) ([10.209.114.176])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:17:31 -0700
Message-ID: <156efde9-06e5-bb5a-d9e3-8a29ade0a719@linux.intel.com>
Date:   Tue, 2 May 2023 18:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/5] PCI/ASPM: Set ASPM_STATE_L1 only when driver
 enables L1.0
Content-Language: en-US
To:     Ajay Agarwal <ajayagarwal@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
References: <20230502193140.1062470-1-ajayagarwal@google.com>
 <20230502193140.1062470-3-ajayagarwal@google.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230502193140.1062470-3-ajayagarwal@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/2/23 12:31 PM, Ajay Agarwal wrote:
> Currently the core driver sets ASPM_STATE_L1 as well as

I think you can use the term ASPM driver uniformly.

> ASPM_STATE_L1SS when the caller wants to enable just L1.0.

L1?

> This is incorrect. Fix this by setting the ASPM_STATE_L1 bit
> only when the caller wishes to enable L1.0.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---

Otherwise, looks fine.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changelog since v1:
>  - Break down the L1 and L1ss handling into separate patches
> 
>  drivers/pci/pcie/aspm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5765b226102a..4ad0bf5d5838 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1170,8 +1170,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_default |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		/* L1 PM substates require L1 */
> -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +		link->aspm_default |= ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_1)
>  		link->aspm_default |= ASPM_STATE_L1_1;
>  	if (state & PCIE_LINK_STATE_L1_2)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

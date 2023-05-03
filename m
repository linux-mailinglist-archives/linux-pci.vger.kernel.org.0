Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE266F4E6B
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 03:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjECBS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECBS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 21:18:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5563CC
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683076737; x=1714612737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gw9mL2ETr42+PY7CcT80Di5xtj0+zkx6pOvf/ECYiPQ=;
  b=autUOQr4daTDj8KPSv7nd3s7y9q/t+oeVua/kjkWmRJHGtjgntFrzU7Q
   acK212pRyzfQ/d15JfqRLsyTP2bMlesYDGRFY7s+pK4qJ2F/G9xt4pkV5
   WElRwDkS0rWf560NG9uDgLyk7LJWBO/J4yxq9kjWrbcBFDFIe92QtuY80
   80MvSReWWlf7LnYOZgq+d8mVqj07s/T53/k8sArKsLPYJStiJtGea+hU1
   P1A6fy+kk1544X/9FYIz/zPr/p8Ujxe9LoJ+5zIh9O7+tsConWXKr6Ge+
   +R5U+P/H0D56QH0Zba1HdCu5KFptTmdyTSfiwq3arfD4puBkHAqj96gcG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337678168"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="337678168"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="726970995"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="726970995"
Received: from leeliche-mobl.amr.corp.intel.com (HELO [10.209.114.176]) ([10.209.114.176])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 18:18:56 -0700
Message-ID: <7749ee33-04a4-e119-48fc-d78da77fe667@linux.intel.com>
Date:   Tue, 2 May 2023 18:18:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/5] PCI/ASPM: Set ASPM_STATE_L1 when driver enables
 L1ss
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
 <20230502193140.1062470-4-ajayagarwal@google.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230502193140.1062470-4-ajayagarwal@google.com>
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
> Currently the aspm driver does not set ASPM_STATE_L1 bit in
> aspm_default when the caller requests L1SS ASPM state. This will
> lead to pcie_config_aspm_link() not enabling the requested L1SS
> state. Set ASPM_STATE_L1 when driver enables L1ss.
> 

Is there a bug associated with this issue?

> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v1:
>  - Break down the L1 and L1ss handling into separate patches
> 
>  drivers/pci/pcie/aspm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 4ad0bf5d5838..7c9935f331f1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1171,14 +1171,15 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  		link->aspm_default |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
>  		link->aspm_default |= ASPM_STATE_L1;
> +	/* L1 PM substates require L1 */
>  	if (state & PCIE_LINK_STATE_L1_1)
> -		link->aspm_default |= ASPM_STATE_L1_1;
> +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_2)
> -		link->aspm_default |= ASPM_STATE_L1_2;
> +		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> -		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> -		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

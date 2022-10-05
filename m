Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBA5F4EB4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJEDaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 23:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJED3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 23:29:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B551FCC0;
        Tue,  4 Oct 2022 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664940422; x=1696476422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L88Tnrp5vXM4392Bx2LnQXLZbey71i4/QDMeVvLfusk=;
  b=MqQcKgaoLlEwx7UT30ZyWeJ+MeoPtLjCADuEyvtxbD+A4fa35CXR/9bQ
   g4BDJzSol1H3tpnNAI2IKTluWfO0zgU4opK94fUp5eF5s8JUBervy84wP
   PFg85EY1p2d4HI4sMTdAz1/BPSvuYm7bUjLhfwfWIX7aYYif8TWzMlWDR
   reqV1oqFPUXD+oP05q2wXNAYUibnYcwTBXGql550DEcWgM9OwS6ZXPPZE
   +n8hgW7OIWExfZeigHwRJIu+Xzhkb0tEuiWGCIY6sKRmHboMqgR+64iFb
   QiQ2uflB1r4GwcbqNOblrkM7D9ehA2ltrdNWHSt2PxvqOKqAvRN+3215c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="329491482"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="329491482"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 20:26:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="686820896"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="686820896"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO [10.209.113.68]) ([10.209.113.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 20:26:54 -0700
Message-ID: <5799dca0-5ad2-be44-ae79-e276bd7e0a8c@linux.intel.com>
Date:   Tue, 4 Oct 2022 20:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] PCI/ASPM: Ignore L1 PM Substates if device lacks
 capability
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20221005025809.2247547-1-helgaas@kernel.org>
 <20221005025809.2247547-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221005025809.2247547-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/4/22 7:58 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
> inadvertently removed a check for existence of the L1 PM Substates (L1SS)
> Capability before reading it.
> 
> If there is no L1SS Capability, this means we mistakenly read PCI_COMMAND
> and PCI_STATUS (config address 0x04) and interpret that as the PCI_L1SS_CAP
> register, so we may incorrectly configure L1SS.
> 
> Make sure the L1SS Capability exists before trying to read it.
> 
> Fixes: 187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 4535228e4a64..f12d117f44e0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -560,6 +560,9 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>  	u32 parent_l1ss_cap, child_l1ss_cap;
>  	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
>  
> +	if (!parent->l1ss || !child->l1ss)
> +		return;

I have noticed that l1ss state is initialized in pci_configure_ltr(). I am
wondering whether it is the right place? Are L1SS and LTR related?


> +
>  	/* Setup L1 substate */
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
>  			      &parent_l1ss_cap);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

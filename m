Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F25B4330
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIIXqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIIXqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:46:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E9F02AD;
        Fri,  9 Sep 2022 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662767212; x=1694303212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ToDeuTxEiQBJao6W3YvgsQtZgsof1y8sltEiA2cXt0=;
  b=WEwjRCuSQSKbgotdFt1FO4IK8cF5cOY/j0KHZWrAb1o9CXVFCyPoyIdL
   Yn2l52DlFAivQ1/2bsj4IB40zDItxgvvKYP1IYCw7DEJPuXlsUgL6zgg1
   YEBusa92Y5syMRBrxWFibK9MtAz3SnfLnCgMvLOhhZAD9AuAUN8TGSBHv
   IYC+w2uA2/zUqFavvq/Z14uB3uk4T6y3Dpf9MjtskwopDut5lHkxc8n29
   OJEzXMeJNXTs+tKvwff+GzahF9Izrcj4P504GBrDkzccNZTKBqZgUau5u
   ily8JwX9RVNvbDWojScVeBQQ7IGuoaFm04820MYFgz4cgh/2Sv+NFGb0D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296330288"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="296330288"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:46:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677365647"
Received: from gtpedreg-mobl.amr.corp.intel.com (HELO [10.209.57.19]) ([10.209.57.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:46:51 -0700
Message-ID: <f8249b66-0ee6-0b47-9ee1-86a96a27e7fa@linux.intel.com>
Date:   Fri, 9 Sep 2022 16:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/9] PCI/PTM: Preserve RsvdP bits in PTM Control
 register
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20220909202505.314195-1-helgaas@kernel.org>
 <20220909202505.314195-7-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909202505.314195-7-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/22 1:25 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Even though only the low 16 bits of PTM Control are currently defined, the
> register is 32 bits wide and the unused bits are RsvdP ("Reserved and
> Preserved"), so software must preserve the values of those bits when
> writing the register.
> 
> Update PTM Control reads and writes to use 32-bit accesses and preserve the
> reserved bits on writes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pcie/ptm.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index fc296b352fe2..5b8598b222b0 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -12,14 +12,14 @@
>  static void __pci_disable_ptm(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
> -	u16 ctrl;
> +	u32 ctrl;
>  
>  	if (!ptm)
>  		return;
>  
> -	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
>  	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> -	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
>  }
>  
>  /**
> @@ -41,7 +41,7 @@ void pci_save_ptm_state(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
>  	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> +	u32 *cap;
>  
>  	if (!ptm)
>  		return;
> @@ -50,15 +50,15 @@ void pci_save_ptm_state(struct pci_dev *dev)
>  	if (!save_state)
>  		return;
>  
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
>  }
>  
>  void pci_restore_ptm_state(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
>  	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> +	u32 *cap;
>  
>  	if (!ptm)
>  		return;
> @@ -67,8 +67,8 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>  	if (!save_state)
>  		return;
>  
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
>  }
>  
>  /*
> @@ -112,7 +112,7 @@ void pci_ptm_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->ptm_cap = ptm;
> -	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
> +	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
>  
>  	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
>  	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
> @@ -170,7 +170,10 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> -	ctrl = PCI_PTM_CTRL_ENABLE;
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
> +
> +	ctrl |= PCI_PTM_CTRL_ENABLE;
> +	ctrl &= ~PCI_PTM_GRANULARITY_MASK;
>  	ctrl |= dev->ptm_granularity << 8;
>  	if (dev->ptm_root)
>  		ctrl |= PCI_PTM_CTRL_ROOT;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

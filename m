Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AF5ABB7B
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIBX5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIBX5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:57:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645DDDA9A;
        Fri,  2 Sep 2022 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662163054; x=1693699054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6gAaOCMk8Z/d7uqTVGe/Hinra8KYs7C0oQAPXXXj8lU=;
  b=gURNjs14S8CgizsiKBgWglSv3CYHiRxv2Fvrzez6u/05JoXUYfc92lAc
   W7HPQ7ZwqshWG7pe3FD/4ED05asKvNuQZdy1nHKwDI7f+EYBnzDlp6eKj
   wwOquQ8dQd3gn6uEqMnbumWMGPVObdvZh3GnTuBUfZxhvoOhV86m8Ru5G
   +Jc89a7/0EtrUn8Bj4RrCNZxbcwRZSPogGzm8Z0X9arJNz5cwGHvYRfed
   bQxEwjJZp5nCPKswi4F39QIqY7IdVZhj+MNuQZ6JgkvCauUzwNV6cyqNs
   AIB3HjC1arbBfP7bPameCxK6crzWo4aU9xs9aCKhjW7dpTdeqdFvOpWIX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357824977"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="357824977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:57:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="755422714"
Received: from cgoff-mobl1.amr.corp.intel.com (HELO [10.209.53.13]) ([10.209.53.13])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:57:33 -0700
Message-ID: <17c2cba5-fcb3-1e02-b488-65f4dafe6367@linux.intel.com>
Date:   Fri, 2 Sep 2022 16:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] PCI/PTM: Preserve PTM Root Select
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
References: <20220902233543.390890-1-helgaas@kernel.org>
 <20220902233543.390890-2-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902233543.390890-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/2/22 4:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When disabling PTM, there's no need to clear the Root Select bit.  We
> disable PTM during suspend, and we want to re-enable it during resume.
> Clearing Root Select here makes re-enabling more complicated.
> 
> Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
> this Time Source is the PTM Root," so if PTM Enable is cleared, the value
> of Root Select should be irrelevant.
> 
> Preserve Root Select to simplify re-enabling PTM.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/ptm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..b6a417247ce3 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>  		return;
>  
>  	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> -	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> +	ctrl &= ~PCI_PTM_CTRL_ENABLE;
>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

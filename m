Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B15AB766
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 19:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiIBRYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiIBRYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 13:24:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E721151A2;
        Fri,  2 Sep 2022 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662139446; x=1693675446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DSWKIZICL0ryGmE0f8bau1LNf2o5POsf7uXeN32Zn08=;
  b=MJJemxq9gj+p5FLZoWNDp3SYFUWB7o18CrzSeMsn95blFaCCD713RgKf
   WvmVD756gjnn13Mvf58ZkyrD2mTpIq8+6aJPQsL8rOENKzu96DKyQg7SE
   IC4C/QOEvdDl8jmSkdu6np4OjPbpt2/33ideKrOzbaiPakLC6XwblVlJa
   J/DestAZpXYK7quu1ShCvPJ4TGMEFkxFSaJliVZBQ74tE6lBtqLhGjHMV
   MaPB0fbIx1tq/ZVNd4UG5+345dkvYF+VtPtLEeX0P3cPgazB3QiGpKiDw
   KvW5xWxp/Nqc3/91mPOPIj3B4q7FFCJfwEg0QATxLMgJN9cFspFEottry
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294771178"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="294771178"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:24:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674435558"
Received: from cthornbr-mobl.amr.corp.intel.com (HELO [10.251.3.254]) ([10.251.3.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:24:05 -0700
Message-ID: <b5618f97-deb6-c38e-2c2c-dbe1e4e1e496@linux.intel.com>
Date:   Fri, 2 Sep 2022 10:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] PCI/PTM: Preserve PTM Root Select
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
References: <20220902145835.344302-1-helgaas@kernel.org>
 <20220902145835.344302-2-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902145835.344302-2-helgaas@kernel.org>
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



On 9/2/22 7:58 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When disabling PTM, there's no need to clear the Root Select bit.  We
> disable PTM during suspend, and we want to re-enable it during resume.
> Clearing Root Select here makes re-enabling more complicated.

Currently, it looks like we disable PCI_PTM_CTRL_ROOT in pci_disable_ptm(),
but not enable it in pci_enable_ptm(). Do you know this did not trigger an
issue?

Also, you mentioned that it is complicated to enable it, can you add some
details?


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

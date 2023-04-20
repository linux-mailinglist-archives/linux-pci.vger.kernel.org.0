Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D726E9757
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 16:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjDTOjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDTOjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 10:39:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596511B;
        Thu, 20 Apr 2023 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682001543; x=1713537543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6cExS7IoeCdndXtN18tKJWcJfT4ILOBMtIjbdNVnnQ=;
  b=DtEwN5Oc94htF25WSBYFKlV5xOvahAgIl1PlCTN7N38EbUhCj6ySCB3h
   zxCD4XOvfRmJuP6Oj5oi11/8TbWgtybOyl+YZBjo7EtRIBonnGKMo98xv
   hksVJZiqKsRvmiMoiEX7EaBP74G6+70WwXMGrEMZd+gjqWKxlYA+Pb+ik
   70Mbo0vbnJa4Q150PV5FkjNOHxTDJAw1X14/cel3g5KqFFSMY3IPai9JZ
   l2E4k18ncuzkhIFv0oh7qK3qdMampfz2x5n7w5XBFAoHV872NdnwoMEur
   Bh2q0+2cbrP5hNGkfOZEsQTKvk2wVMME5XgNNXX+oEHdc/9EWp8WQhAEz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432030449"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="432030449"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="691935092"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691935092"
Received: from samuelra-mobl7.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:39:02 -0700
Message-ID: <e84eda25-dbe9-a108-c4d4-ee3fa746d9ca@linux.intel.com>
Date:   Thu, 20 Apr 2023 07:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/4] PCI: Keep AER status in pci_restore_state()
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230420125941.333675-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kai,

On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
> When AER is using the same IRQ as PME, AER interrupt is treated as a
> wakeup event and it can disrupt system suspend process.
> 
> If that happens, the system will report it's woken up by PME IRQ without
> indicating any AER error since AER status is cleared on resume.
> 
> So keep the AER status so users can know the system is woken up by AER
> instead of PME.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

Any history on why it is cleared before? Is it done to hide some resume
issues?

> v3:
>  - No change.
> 
> v2:
>  - New patch.
> 
>  drivers/pci/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7a67611dc5f4..71aead00fc20 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1778,7 +1778,6 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_dpc_state(dev);
>  	pci_restore_ptm_state(dev);
>  
> -	pci_aer_clear_status(dev);
>  	pci_restore_aer_state(dev);
>  
>  	pci_restore_config_space(dev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

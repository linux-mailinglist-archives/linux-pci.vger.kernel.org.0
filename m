Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A185AB769
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiIBRZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiIBRZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 13:25:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20A4BA45;
        Fri,  2 Sep 2022 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662139556; x=1693675556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8PnpdD07t1F9xEIN5xQAbzg3qh6AvWLc6Y0NYuKP/4I=;
  b=YW6EAlqT99cHaTRJz2E5DgULzA4/VZ5NV7MjnE/KlMXHoqhmCFIJhu8R
   sidr4Q1kA231vhvmYwotjItQfeVrx9KZ4mx4EPEAruDgARES5125PtZXH
   gQMTRLirlda4500m+aM7eZlciwld6aAZjNVBLlJ41/G3T06oHqRD7T2dO
   iFE9QR+z4J5Ob/98n7lEjm7NQrwC7rE23CCGdK+f1GSRsDh9DYlAAtAHm
   N8av1xOz/58fWB/kdvvCF/kkCtABGNFDSBJwYeNaTNKFk0y95wCTQJUqW
   BKfZHGTqVeOVgjDgF5NR29YiHfXy6+Cm9d2Wr/2F3M0CcVJog4L3ryASV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296037303"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296037303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:25:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674436293"
Received: from cthornbr-mobl.amr.corp.intel.com (HELO [10.251.3.254]) ([10.251.3.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:25:54 -0700
Message-ID: <be3a0ed4-c5d0-d4ba-79da-f346d9d7d08b@linux.intel.com>
Date:   Fri, 2 Sep 2022 10:25:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] PCI/PTM: Enable PTM when restoring state
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
 <20220902145835.344302-3-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220902145835.344302-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
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
> The suspend path may disable PTM before saving config state, which means
> the PCI_PTM_CTRL_ENABLE bit in the saved state may be cleared even though
> we want PTM to be enabled when resuming.

If suspend is disabling PTM separately, why not enable it during the resume
operation? Why club it with PTM state restoration?

> 
> If "dev->ptm_enabled" is set, it means PTM should be enabled, so make sure
> PCI_PTM_CTRL_ENABLE is set when restoring the PTM state.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b6a417247ce3..3115601a85ef 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -82,6 +82,14 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>  		return;
>  
>  	cap = (u16 *)&save_state->cap.data[0];
> +
> +	/*
> +	 * The suspend path may disable PTM before saving config state.
> +	 * Make sure PCI_PTM_CTRL_ENABLE is set if PTM should be enabled.
> +	 */
> +	if (dev->ptm_enabled)
> +		*cap |= PCI_PTM_CTRL_ENABLE;
> +
>  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF55803DB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGYSNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGYSNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 14:13:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA15DF4B;
        Mon, 25 Jul 2022 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658772815; x=1690308815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1W3K6HtndLxG/12lj9ntiMcXN03GrPr2INAm/PqZW0=;
  b=I8mvqZZnQb6BLS4RNVokv6c6Ho5GkbL9Julcnws03sVD/l4znFW0oJO8
   701hKDQbkDAEg8zDDmCK/OrefLnb5tmAOV0tP0FbS1zqaIijzvxQu8tub
   78dz13qfXfI5lcqnncKpY3cArKR4/vgUsJto6+L0mPDpZ0gpSY6yyBV+K
   tUYp3COea2JJQsZ+clabqadtWLwFSOYhDECdK9WCGnL2Pk6ShM90CHYS/
   ING5vUsrXSKxb6dNUdDNafTTMMM4OsBKBR4KUMdhtaEPG90mGtqwyMTwv
   axvJY6cVGiG73D5vW9swyLQhxp0KZad2oToimUn5IHv6wXDfY8YY7L/jU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="288521824"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="288521824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 11:13:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575153907"
Received: from mgarner-mobl.amr.corp.intel.com (HELO [10.209.39.177]) ([10.209.39.177])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 11:13:35 -0700
Message-ID: <dcb634c3-7671-9073-555f-e861088cfcd0@linux.intel.com>
Date:   Mon, 25 Jul 2022 11:13:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com
Cc:     lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220725160131.83687-1-chenzhuo.1@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220725160131.83687-1-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/25/22 9:01 AM, Zhuo Chen wrote:
> After commit 7d7cbeaba5b7 ("PCI/ERR: Clear status of the reporting
> device"), the AER status of the device that reported the error
> rather than the first downstream port is cleared. So the problem
> in commit aa344bc8b727 ("PCI/ERR: Clear AER status only when we
> control AER") is no longer existent, and we change to use
> pcie_aer_is_native() here.
Can you add the details of the problem you are referring to? Also
include details about how this problem relates to your commit.

IIUC, your commit replaces "host->native_aer || pcie_ports_native"
with pcie_aer_is_native(dev, correct? If so, add a note in commit
log that it has no functional changes.

> 
> pci_aer_clear_nonfatal_status() already has pcie_aer_is_native(),
> so we move pci_aer_clear_nonfatal_status() out of
> pcie_aer_is_native().
> 
> Replace statements that judge whether OS owns AER in
> get_port_device_capability() with pcie_aer_is_native().
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/pci/pcie/err.c          | 12 ++----------
>  drivers/pci/pcie/portdrv_core.c |  3 +--
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0c5a143025af..28339c741555 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -184,7 +184,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	int type = pci_pcie_type(dev);
>  	struct pci_dev *bridge;
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
>  	/*
>  	 * If the error was detected by a Root Port, Downstream Port, RCEC,
> @@ -237,16 +236,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(bridge, "broadcast resume message\n");
>  	pci_walk_bridge(bridge, report_resume, &status);
>  
> -	/*
> -	 * If we have native control of AER, clear error status in the device
> -	 * that detected the error.  If the platform retained control of AER,
> -	 * it is responsible for clearing this status.  In that case, the
> -	 * signaling device may not even be visible to the OS.
> -	 */
> -	if (host->native_aer || pcie_ports_native) {
> +	if (pcie_aer_is_native(dev))
>  		pcie_clear_device_status(dev);
> -		pci_aer_clear_nonfatal_status(dev);
> -	}
> +	pci_aer_clear_nonfatal_status(dev);
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 604feeb84ee4..98c18f4a01b2 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	if (pcie_aer_is_native(dev) && pci_aer_available()) {
>  		services |= PCIE_PORT_SERVICE_AER;
>  
>  		/*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

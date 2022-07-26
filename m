Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919A581682
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiGZPd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiGZPd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 11:33:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C32559A;
        Tue, 26 Jul 2022 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658849636; x=1690385636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5I+V662NLC2jjOM/6eWnzGMznOWDTJj0WWANyuaqAc4=;
  b=Xz4oAIg4vdP+FGGdi6Qwx2yhs+DuxWxZx411/NWoCZogaEtW7QfhuzIZ
   RbNTxSYLui933ppKUliJO+YdNhZGn9uDC43/teb141Dnmr0B1lXqqkSZP
   U5ycV5e7mK2+809Hu0U/2dFve5Qz6abpcOfalZWrJdEhShMm0Mp4wLT3f
   5zTEcGihwzeM6+NBISaVAm4ABzrmD9D1Bqxaa6cyu6TDcGjEQFj2YXusT
   pSs4M6fZJME82hjzgar28xBnkFBEbGI5fs91C62uKS9m0bcFNT7sytGy8
   NfuCJyrfZzukG9tG40kmL7UaBrJxOhmOZCWPRWBuSEEP7PDkWJi8OhYAW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271022219"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="271022219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="927378192"
Received: from arianrah-mobl2.amr.corp.intel.com (HELO [10.251.20.146]) ([10.251.20.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:33:54 -0700
Message-ID: <b41d1840-b726-2caa-5bc8-69c3aeb230cf@linux.intel.com>
Date:   Tue, 26 Jul 2022 08:33:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com
Cc:     lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220726020527.99816-1-chenzhuo.1@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220726020527.99816-1-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/25/22 7:05 PM, Zhuo Chen wrote:
> The AER status of the device that reported the error rather than
> the first downstream port is cleared after commit 7d7cbeaba5b7
> ("PCI/ERR: Clear status of the reporting device"). So "a bridge
> may not exist" which commit aa344bc8b727 ("PCI/ERR: Clear AER
> status only when we control AER") referring to is no longer
> existent, and we just use pcie_aer_is_native() in stead of
> "host->native_aer || pcie_ports_native".

IMO, above history is not required to justify using pcie_aer_is_native()
in place of "host->native_aer || pcie_ports_native".

> 
> pci_aer_clear_nonfatal_status() already has pcie_aer_is_native(),
> so we move pci_aer_clear_nonfatal_status() out of
> pcie_aer_is_native().

Moving it outside (pcie_aer_is_native()) does not optimize the
code. So I think it is better to leave it inside.

> 
> Replace statements that judge whether OS owns AER in
> get_port_device_capability() with pcie_aer_is_native(), which has
> no functional changes.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
> v2:
> - Add details and note in commit log
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

The above comment is still applicable. So I think you don't need to remove it.

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

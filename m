Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A24581E77
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiG0ECN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 00:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG0ECN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 00:02:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C311802;
        Tue, 26 Jul 2022 21:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658894532; x=1690430532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qPDH2zg55z0dq693EvtAztxxc5KcUkiwaVa+S6O66dg=;
  b=Joc5exCmymQ31lwx8fVmZyBiC6bQ2+lL/mUcXngtTdvZFkanEUIb3zEC
   oomW3sK/UeHsQ3h2BwoUEAY4yAAGAQ4QP0tp5YjJnNJIl6gz2r/JGMSVe
   EQch1gLr4mS4At0pCFUyZE62Xi/YJn80VBm9bhwUfRKKPrnHld1ngmtlh
   wiRRu2BWVfm3zIpGNJkuRPQcnNS1X3Sajdr2nufPmaj9KeoCwxxvvr+Kq
   KC1SZvOV0bg00uLJVTa2x973f21gFgKxCKwL5xetjghlNPYS1iwfSJCwU
   gHS77Lqc+M7teRTz/bhUXKjQM1Wtkvb9fg8nv0mZ2+HSzYAqXpqvaVKqa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288899601"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="288899601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 21:02:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="927631462"
Received: from arianrah-mobl2.amr.corp.intel.com (HELO [10.251.20.146]) ([10.251.20.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 21:02:11 -0700
Message-ID: <b5c746db-f6a0-d89e-6db5-e4a206c9237a@linux.intel.com>
Date:   Tue, 26 Jul 2022 21:02:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com
Cc:     lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
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



On 7/26/22 8:53 PM, Zhuo Chen wrote:
> Use pcie_aer_is_native() in place of "host->native_aer ||
> pcie_ports_native" to judge whether OS has native control of AER
> in pcie_do_recovery().
> 
> Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
> get_port_device_capability() with pcie_aer_is_native(), which has no
> functional changes.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---

Patch looks better now. It looks like following two changes
can also be replaced with pcie_aer_is_native() check.

drivers/pci/pcie/aer.c:1407:	if ((host->native_aer || pcie_ports_native) && aer) {
drivers/pci/pcie/aer.c:1426:	if ((host->native_aer || pcie_ports_native) && aer) {



> Changelog:
> v3:
> - Simplify why we use pcie_aer_is_native().
> - Revert modification of pci_aer_clear_nonfatal_status() and comments.
> v2:
> - Add details and note in commit log.
> ---
>  drivers/pci/pcie/err.c          | 3 +--
>  drivers/pci/pcie/portdrv_core.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0c5a143025af..121a53338e44 100644
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
> @@ -243,7 +242,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 * it is responsible for clearing this status.  In that case, the
>  	 * signaling device may not even be visible to the OS.
>  	 */
> -	if (host->native_aer || pcie_ports_native) {
> +	if (pcie_aer_is_native(dev)) {
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
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

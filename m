Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D654274C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiFHG4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 02:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbiFHGFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 02:05:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D382AE3
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 22:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654664681; x=1686200681;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hOvb8EnSwhwz1MQxZk+3Gaho/Oq120JSHbvTq7OuOuA=;
  b=b7vgHpwnutgO2Z0C4Ge8JOcSgV+jcOktL2Jdv98WjfVgZ7L/lUtWiaS5
   VtEsbbcx2Qg6DR4SnAUtPMVafuC7L742WzEkq2/p3oKnhvRletk8nWObq
   Bia7tp6b1DJ4Tk/9Lckf09rXqYz3qmyfdxWd26gag1CPsrLijLnNjGwnU
   QMA2SysGCao+e6VBCPGUNcm8lInXTCleUN6rHO1Sykp/IJfAdq7/xyU7p
   AVY9slBQtJtsbHR6eBViE9M//2rBLGnRrhezx6AEPgg9YiIFf7Ie6P3Zu
   ahLThnNNlL/rVm1IZvp+7p5PzhFT66RcXaboewo/fH1pei+i7q/qCRKdF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="259898305"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="259898305"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 22:02:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="759318766"
Received: from jmferrel-mobl1.amr.corp.intel.com (HELO [10.209.73.187]) ([10.209.73.187])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 22:02:33 -0700
Message-ID: <7830b6ca-a653-867f-813e-be980bad8141@linux.intel.com>
Date:   Tue, 7 Jun 2022 22:02:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH] PCI/ERR: handle disconnected devices in
 report_error_detected
To:     Christoph Hellwig <hch@lst.de>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        kbusch@kernel.org
References: <20220601074024.3481035-1-hch@lst.de>
Content-Language: en-US
In-Reply-To: <20220601074024.3481035-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/1/22 12:40 AM, Christoph Hellwig wrote:
> When a device is already unplugged by pciehp by the time that the AER
> handler is invoked, the PCIe device will lready be in the

/s/lready/already

> pci_channel_io_perm_failure state.  In that case we should simply
> return PCI_ERS_RESULT_DISCONNECT instead of trying to do a state
> transition that will fail.
> 
> Also untangle the state transition failure from the lack of methods to
> improve the debugging output in case it will happen ever again.

Otherwise, it looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/pci/pcie/err.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0c5a143025af4..59c90d04a609a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -55,10 +55,14 @@ static int report_error_detected(struct pci_dev *dev,
>   
>   	device_lock(&dev->dev);
>   	pdrv = dev->driver;
> -	if (!pci_dev_set_io_state(dev, state) ||
> -		!pdrv ||
> -		!pdrv->err_handler ||
> -		!pdrv->err_handler->error_detected) {
> +	if (pci_dev_is_disconnected(dev)) {
> +		vote = PCI_ERS_RESULT_DISCONNECT;
> +	} else if (!pci_dev_set_io_state(dev, state)) {
> +		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
> +			dev->error_state, state);
> +		vote = PCI_ERS_RESULT_NONE;
> +	} else if (!pdrv || !pdrv->err_handler ||
> +		   !pdrv->err_handler->error_detected) {
>   		/*
>   		 * If any device in the subtree does not have an error_detected
>   		 * callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

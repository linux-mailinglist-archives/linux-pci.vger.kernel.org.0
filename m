Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83F7C513C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjJKLMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjJKLMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:12:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307928F;
        Wed, 11 Oct 2023 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022725; x=1728558725;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jPIy1MHT8CauY6fC3x5500c2jjdrHnqJ1dSekrvSM9A=;
  b=AWdNh5w5OXEaRWM2rUzIPPHMWcE7ZJDPS9tXFuY3OVX1UMWO99NiXrAl
   ohWwzm2HmK8lQ1IibWxPbMgniQVc4HmqY1DLh+31oqNyulbJ8sUdMoUah
   qjmxih9Rmb7q4tuHXop4kH9VDMatjJsdMymaSf4J/lCb1bZqvXTfZfy2Q
   wEJ7tKY1GUvHljEZBnjGWJtigil1INtkKZmKdfwZpMAONVB7HMyEaI7MS
   /ep9Y/6s+LiQSJzKQVX11oCt04ajuTi8OqoPSU08xyojUY3sDQNGCieDF
   HDGdOlIPeH6MC3xUv0/ngiIOmcGCwh0ZlDPBoyMEPsuqroBemOY1cU2UD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387478973"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387478973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703689784"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703689784"
Received: from opipikin-mobl2.ger.corp.intel.com (HELO sdodaev-mobl.ger.corp.intel.com) ([10.252.57.154])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:01:19 -0700
Date:   Wed, 11 Oct 2023 14:01:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-7-helgaas@kernel.org>
Message-ID: <dc2ef6fc-e7a7-33db-6fe5-875c7cd338a@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-7-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/dpc.c        | 9 +++++----
>  drivers/pci/quirks.c          | 2 +-
>  include/uapi/linux/pci_regs.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3ceed8e3de41..6e551f34ec63 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -8,6 +8,7 @@
>  
>  #define dev_fmt(fmt) "DPC: " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/aer.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> @@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  
>  	/* Get First Error Pointer */
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
> -	first_error = (dpc_status & 0x1f00) >> 8;
> +	first_error = FIELD_GET(PCI_EXP_DPC_STATUS_FIRST_ERR, dpc_status);
>  
>  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
>  		if ((status & ~mask) & (1 << i))
> @@ -270,8 +271,8 @@ void dpc_process_error(struct pci_dev *pdev)
>  	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
>  		 status, source);
>  
> -	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
> -	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> +	reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN, status);
> +	ext_reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT, status);
>  	pci_warn(pdev, "%s detected\n",
>  		 (reason == 0) ? "unmasked uncorrectable error" :
>  		 (reason == 1) ? "ERR_NONFATAL" :

BTW, it seems we're doing overlapping work here with many of these 
patches. It takes some time to think these through one by one, I don't 
just autorun through them with coccinelle so I've not posted my changes
yet.

I went to a different direction here and named all the reasons too with 
defines and used & to get the reason in order to be able to compare with 
the named reasons.

You also missed convering one 0xfff4 to use define (although I suspect it 
never was your goal to go beyond FIELD_GET() here).
 
> @@ -338,7 +339,7 @@ void pci_dpc_init(struct pci_dev *pdev)
>  	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
>  	if (!pdev->dpc_rp_log_size) {
>  		pdev->dpc_rp_log_size =
> -			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
>  		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
>  			pci_err(pdev, "RP PIO log size %u is invalid\n",
>  				pdev->dpc_rp_log_size);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..a9fdc2e3f110 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6154,7 +6154,7 @@ static void dpc_log_size(struct pci_dev *dev)
>  	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
>  		return;
>  
> -	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
> +	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
>  		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
>  		dev->dpc_rp_log_size = 4;
>  	}
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 833e5fb40ea5..e97a06b50f95 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1046,6 +1046,7 @@
>  #define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
>  #define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
>  #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
> +#define  PCI_EXP_DPC_STATUS_FIRST_ERR	    0x1f00 /* RP PIO First Error Ptr */

If you prefer consistency, there already FEP used for "First 
Error Pointer" used in another define.

>  #define PCI_EXP_DPC_SOURCE_ID		 0x0A	/* DPC Source Identifier */



-- 
 i.


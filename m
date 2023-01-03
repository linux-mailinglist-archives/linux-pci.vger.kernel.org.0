Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6065C7B6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjACTuA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjACTt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:49:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB713FBA
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672775398; x=1704311398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oo6+HSjkOxOVD/4gHIxl+LZxsT3YxEEMqL5bto5RVyo=;
  b=DSkeTxNzMJmVAj+nDC6kBnl0iq97KwgNs63g4MrqXwua/fyMaFdHSBG6
   ZhXEVn6S0sV122AxbdI43psFXQ6pHwav3wVDK218KmaN7mrU3VNutbwAa
   CFY4EYe8NSTcNV4b1MOngS5lYUvxzWVQ/SpsvcN2DT0Qj0ofIpTwhchTo
   0lAioms7wmZ25z4SrGy02Ep4T5rxRIhq3+aBFAdFrGoeEbCT1sI2TNe7Z
   je9byhB5QBIPOMGISSJSUMhTZy1gXi9apwf+dAG/vfSeQTzGMNgAQ+Ndf
   0/y1JoUStZkf6wsxRNWM6rQw4NJSzQ4stQMWbaGreyyips4I1xkPH7/dS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="348963784"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="348963784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:49:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654908356"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654908356"
Received: from jjha-mobl1.amr.corp.intel.com (HELO [10.209.61.244]) ([10.209.61.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:49:57 -0800
Message-ID: <430c314c-50ed-d0ed-e15e-1b3278286c83@linux.intel.com>
Date:   Tue, 3 Jan 2023 11:49:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
References: <cover.1672511016.git.lukas@wunner.de>
 <a2ff8481c3f08458dcd2b4028a838730e965c72f.1672511017.git.lukas@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <a2ff8481c3f08458dcd2b4028a838730e965c72f.1672511017.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI,

On 12/31/22 10:33 AM, Lukas Wunner wrote:
> We're calling pci_bridge_wait_for_secondary_bus() after performing a
> Secondary Bus Reset, but neglect to do the same after coming out of a
> DPC-induced Hot Reset.  As a result, we're not observing the delays
> prescribed by PCIe r6.0 sec 6.6.1 and may access devices on the
> secondary bus before they're ready.  Fix it.

Please remove "we" usage. Otherwise, looks good.

> 
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/pci.c      | 3 ---
>  drivers/pci/pci.h      | 3 +++
>  drivers/pci/pcie/dpc.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0b49243a908..19fe0ef0e583 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -167,9 +167,6 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>  
> -/* Time to wait after a reset for device to become responsive */
> -#define PCIE_RESET_READY_POLL_MS 60000
> -
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
>   * @bus: pointer to PCI bus structure to search
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 40758248dd80..b72fd888379b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -7,6 +7,9 @@
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>  #define MAX_NR_DEVFNS 256
>  
> +/* Time to wait after a reset for device to become responsive */
> +#define PCIE_RESET_READY_POLL_MS 60000
> +
>  #define PCI_FIND_CAP_TTL	48
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f5ffea17c7f8..a5d7c69b764e 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -170,8 +170,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);
>  
> -	if (!pcie_wait_for_link(pdev, true)) {
> -		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
> +	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC",
> +					      PCIE_RESET_READY_POLL_MS)) {
>  		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  		ret = PCI_ERS_RESULT_DISCONNECT;
>  	} else {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

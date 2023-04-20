Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACD6E97B8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjDTOx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDTOx0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 10:53:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC414EDE;
        Thu, 20 Apr 2023 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682002402; x=1713538402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o/3VG858q4YbnM1I++jrLu1F3Cew6aaRH5Qeb4OT78Q=;
  b=TSEUYmem78P5tAztsA1Ahseb7foYdls9ncHPqq8wBKurX7Y1eZZy6swB
   YLhI++x4TGk/whOvC6WpMMlaQxLnQ5KIWUOTsjjsXsXvHgiHPbTQcDiRJ
   CRYf/YlUciSVo7sPkBoUUaOpjynf3FY4ERAI0DCz/HsHiiGGJtXbxF0ZL
   9R8W6Ptr5xgNP0Wrhcg5VFMjmVzpcherr4zD2KoPvcBDYkcV96yNFrWEV
   OXPlmtDfnqX/ZtsEpBa2yqJsv84gfiX4bildvOjBou5RzrpNakYjL0Z85
   oooZb8rnIo0FML4BNoxq/pDY0OOBHd10dwYaoC/Rd9a8wo02kpBlx0M/V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="373658541"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="373658541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="642165231"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="642165231"
Received: from samuelra-mobl7.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:53:22 -0700
Message-ID: <f1409ba9-5370-1e0d-8b6c-e9782505937f@linux.intel.com>
Date:   Thu, 20 Apr 2023 07:53:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/4] PCI/AER: Disable AER interrupt on suspend
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <20230420125941.333675-3-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230420125941.333675-3-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
> PCIe service that shares IRQ with PME may cause spurious wakeup on
> system suspend.
> 
> PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> much here to disable AER during system suspend.
> 
> This is very similar to previous attempts to suspend AER and DPC [1],
> but with a different reason.
> 
> [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.feng@canonical.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

In Patch #1, you skip clearing AER errors in the resume path, right? So if we disable
interrupts here, will AER driver not be notified on resume path error?

> v3:
>  - No change.
> 
> v2:
>  - Only disable AER IRQ.
>  - No more check on PME IRQ#.
>  - Use helper.
> 
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1420e1f27105..9c07fdbeb52d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	aer_disable_irq(pdev);
> +
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +	struct pci_dev *pdev = rpc->rpd;
> +
> +	aer_enable_irq(pdev);
> +
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver = {
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> +	.suspend	= aer_suspend,
> +	.resume		= aer_resume,
>  	.remove		= aer_remove,
>  };
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

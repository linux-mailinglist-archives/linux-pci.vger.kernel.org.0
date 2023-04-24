Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE46ED8F1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 01:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjDXXrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 19:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjDXXrU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 19:47:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB111A;
        Mon, 24 Apr 2023 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682380038; x=1713916038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aK/On8LhJ5PZbxxIOlfLlJ0Lc3VgGWOJ7H6mrKcUX3I=;
  b=GA/JyIl4Q4VwDeUhfroMYs1R3KnLPcgqwr/gphnKS8dXhNYw0i2656vg
   zZcfk251isd6XFFdKz8af7xFLA5TjbLn10HHPtxHfTqDaZ1Vo6qMsQlcE
   9IvzgASnpHfg4rJOaYq1vaWPh79fTIVJarLOPltPar3lKXCPmQo2UyzMk
   XGaDfODVKWMUqvGf/YhNS8KlJltydV8Hk8TVCalN8jxSOuzc9UHbl5m9i
   AMjosnGUlopTxBMYEOMLsSsSTXHXMit8fgiX94ywm1mQytOceqnTGOyuf
   yazSDApG6pCPt7y6qxAOkAKYWqBhvtOnwLZxD3dHJLG1FNITBkrUVEbED
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="335499666"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="335499666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782611127"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782611127"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.251.8.47]) ([10.251.8.47])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:47:13 -0700
Message-ID: <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
Date:   Mon, 24 Apr 2023 16:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424055249.460381-1-kai.heng.feng@canonical.com>
 <20230424055249.460381-2-kai.heng.feng@canonical.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230424055249.460381-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/23/23 10:52 PM, Kai-Heng Feng wrote:
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

IIUC, you encounter AER errors during the suspend/resume process, which
results in AER IRQ. Because AER and PME share an IRQ, it is regarded as a
spurious wake-up IRQ. So to fix it, you want to disable AER reporting,
right?

It looks like it is harmless to disable the AER during the suspend/resume
path. But, I am wondering why we get these errors? Did you check what errors
you get during the suspend/resume path? Are these errors valid?


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

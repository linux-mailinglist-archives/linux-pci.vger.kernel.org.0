Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66D4ECD5C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiC3Tmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiC3Tml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:42:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CCAE77;
        Wed, 30 Mar 2022 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648669255; x=1680205255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hhnn1DKnMB2M/y2bDdb4qAmNYodHX20Vw2Rm29bwANA=;
  b=TvpRBfnCV3EE90lSt0gJGENne0PqKUsBXKJoGceldpm9wlFjB5hh9sR0
   LWb+/0zXpBdo+zQenQq3Z2YhSlpMYO55c5p9aGiW7h31LRRE2Nb/quEpy
   Dy7RFjW+Z5uZ4E7x/B/bSJDB5AXToM0xN29yoMMpQAQ3vqglfzpSHro9u
   DUE58J6ma5zz2HAuUonFXUZojhvePv6hThljFrDqDyCIw5e+MpCfjWSh9
   a/id9A4jDitMFaO6dCVLavzw8+oA2KvXTcDsUBcq80FGWC1YpcrgnWrGP
   H89KmgdlXlBcRf8FrNouCKmgSUmT6NRVdCjzIVTich71WK/ftetWUYRuq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322812330"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322812330"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:40:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639844560"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO [10.209.123.221]) ([10.209.123.221])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:40:34 -0700
Message-ID: <009c9c14-7669-9750-a787-1d220414423e@linux.intel.com>
Date:   Wed, 30 Mar 2022 12:40:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        baolu.lu@linux.intel.com, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329083130.817316-1-kai.heng.feng@canonical.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220329083130.817316-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/29/22 1:31 AM, Kai-Heng Feng wrote:
> On some Intel AlderLake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:
> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed

Include details about in which platform you have seen it and whether
this is a generic power issue?

> 
> So disable AER service to avoid the noises from turning power rails
> on/off when the device is in low power states (D3hot and D3cold), as
> PCIe spec "5.2 Link State Power Management" states that TLP and DLLP

Also include PCIe specification version number.

> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> with aux power) and L3 (D3cold).
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>   - Remove reference to ACS.
>   - Wording change.
> 
> v2:
>   - Wording change.
> 
>   drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b270..e4e9d4a3098d7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
>   	return 0;
>   }
>   
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_disable_rootport(rpc);
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_enable_rootport(rpc);
> +	return 0;
> +}
> +
>   /**
>    * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>    * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   }
>   
>   static struct pcie_port_service_driver aerdriver = {
> -	.name		= "aer",
> -	.port_type	= PCIE_ANY_PORT,
> -	.service	= PCIE_PORT_SERVICE_AER,
> -
> -	.probe		= aer_probe,
> -	.remove		= aer_remove,
> +	.name			= "aer",
> +	.port_type		= PCIE_ANY_PORT,
> +	.service		= PCIE_PORT_SERVICE_AER,
> +	.probe			= aer_probe,
> +	.suspend		= aer_suspend,
> +	.resume			= aer_resume,
> +	.runtime_suspend	= aer_suspend,
> +	.runtime_resume		= aer_resume,
> +	.remove			= aer_remove,
>   };
>   
>   /**

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

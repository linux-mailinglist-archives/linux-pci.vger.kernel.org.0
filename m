Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A26E0FEB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDMOZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDMOZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:25:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF059EF3
        for <linux-pci@vger.kernel.org>; Thu, 13 Apr 2023 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681395911; x=1712931911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H19uVlVDoJGJGJkr8hqIqfEdu3UaUqA3i18T0xiIelI=;
  b=TqaehIbKVrGvh2qf8GN+ye0y+jx0yECWisC4sWeSrrrsAXEJ7TANxv+X
   mF9KSwaB4p+4XGs5xUd5N8AI1/i3bNetW3OlkFSlkyDrszlR9fVncDowf
   erYB21z6OCviqDxn/tcCgoZ7HjEzid3YmO78I4MB91TCZlfb5rVjZ1kqm
   Co2R8LlhG8yP4Yk2j376ucVTf/PJkiaQIcWEcOWi1WRIU5FZy3gXg/nj0
   Me5Bgnh1TdUC6/izt5tuMtNVmAVF+Y4ts20icuLR5EXyDEE/1ojwjMqK5
   3dGu0kSfKbRkis/CZXWXIkyxTikWeqSHvzIdrXfkiaX/Q7QhuZqL4pLY/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346899780"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="346899780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 07:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="778793317"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="778793317"
Received: from dalong-mobl1.amr.corp.intel.com (HELO [10.212.221.189]) ([10.212.221.189])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 07:16:47 -0700
Message-ID: <4a294f9d-6395-b8de-eb36-46c636876c8e@linux.intel.com>
Date:   Thu, 13 Apr 2023 07:16:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3] PCI/PM: Bail out early in
 pci_bridge_wait_for_secondary_bus() if link is not trained
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
References: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/13/23 3:16 AM, Mika Westerberg wrote:
> If the Root/Downstream Port supports active link reporting we can check
> if the link is trained before waiting for the device to respond. If the
> link is not trained, there is no point waiting for the whole ~60s so
> bail out early in that case.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> As discussed in the email thread of the previous version here:
> 
>   https://lore.kernel.org/linux-pci/20230404052714.51315-1-mika.westerberg@linux.intel.com/
> 
> This adds the last change on top of
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset
> 
> 
>  drivers/pci/pci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b4f3b08f780..61bf8a4b2099 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5037,6 +5037,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		}
>  	}
>  
> +	/*
> +	 * Everything above is handling the delays mandated by the PCIe r6.0
> +	 * sec 6.6.1.
> +	 *
> +	 * If the port supports active link reporting we now check one more
> +	 * time if the link is active and if not bail out early with the
> +	 * assumption that the device is not present anymore.
> +	 */
> +	if (dev->link_active_reporting) {
> +		u16 status;
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> +		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOTTY;
> +	}
> +
>  	return pci_dev_wait(child, reset_type,
>  			    PCIE_RESET_READY_POLL_MS - delay);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

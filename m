Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355D7C5219
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjJKLbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:31:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394FA9E;
        Wed, 11 Oct 2023 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697023892; x=1728559892;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tc2GTbB6TPVOtjQtQGLDwNIU7QxEvFYwzp/6Wj8WpUY=;
  b=NpGw/FcWM1czY7i2uyxtAPO+vYI3Q9G+WAf0VQLBwvfiZvTR/lm91h4R
   cDyaM4a4XJwUpSiT1JXuy4b/IaE0ZsciIHMWo+D5fOu5RXUpQVqVg5Jrx
   DQcVZRgnMJ/m/gu+tFk+Uhb1z7eQInzisUxonAeHMC2snFTdN6zg8OOsL
   VtCoPOB6wojvLr60RPxnwsISLhmMvNIZ23mcew1Ip4Dkpu2j2lWRPFhtH
   jHkWdf4n7+n3c46RygYXyzBm1/h0q9rB7FV6OQBpVwNXKYS9qz0FhUDY5
   d/5S7Ev0xtIg04X2AXhzNeqd4LMuhHFJsQviR+XHm4fdLPcrfkd/dpGam
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374977739"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="374977739"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747415504"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="747415504"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:31:30 -0700
Date:   Wed, 11 Oct 2023 14:31:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmoy Das <nirmoy.das@amd.com>
Subject: Re: [PATCH 02/10] PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse
 quirk
In-Reply-To: <20231010204436.1000644-3-helgaas@kernel.org>
Message-ID: <778c462-8d72-6b48-fcb0-8939bde292d@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-679470042-1697023892=:1977"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-679470042-1697023892=:1977
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Separate because this isn't as trivial as the other FIELD_GET() changes.
> 
> See 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT
> Pulse")
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 848c9ee65d7f..5dc6e7cdfb71 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3751,14 +3751,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  		return 0;
>  
>  	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> -	cap &= PCI_REBAR_CAP_SIZES;
> +	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
>  
>  	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>  	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> -	    bar == 0 && cap == 0x7000)
> -		cap = 0x3f000;
> +	    bar == 0 && cap == 0x700)
> +		return 0x3f00;
>  
> -	return cap >> 4;
> +	return cap;
>  }
>  EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-679470042-1697023892=:1977--

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4532E207
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 07:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEGMl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 5 Mar 2021 01:12:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:27758 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCEGMk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 01:12:40 -0500
IronPort-SDR: FNxpkIOH3nFIXm6Og9i8PCbgx/HenRYa9xCs8PkE1KA06ApSoLQ0zQEvyXWLO70cwHIDpiLq9B
 mOFc/7kn8z4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="175209077"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="175209077"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 22:12:40 -0800
IronPort-SDR: ZfcXcgfo3INW0TpmgzYUaWfSm95uw/OHtr75iij2tRkjF8VCavOOLEe8IwLGJ76uDPbCZXccPO
 v/dOkRGbtn1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="518942639"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 04 Mar 2021 22:12:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 22:12:39 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 22:12:38 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.013;
 Fri, 5 Mar 2021 14:12:36 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Topic: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Thread-Index: AQHXCLh6LEG1CfkjwEO3CLgkzlZ+yap0+zLA
Date:   Fri, 5 Mar 2021 06:12:36 +0000
Message-ID: <bd90aee237e44aef9953a86c53b77dfc@intel.com>
References: <4a0bf3a852ed47deb072890319fb39ec@intel.com>
 <20210222011717.43266-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20210222011717.43266-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Do you have any comments on this patch? If need any changes, please let me know. 
Thanks!

-Qiuxu

> -----Original Message-----
> From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Sent: Monday, February 22, 2021 9:17 AM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Krzysztof Wilczyñski <kw@linux.com>; Kelley,
> Sean V <sean.v.kelley@intel.com>; Luck, Tony <tony.luck@intel.com>; Jin, Wen
> <wen.jin@intel.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC association
> 
> Function rcec_assoc_rciep() incorrectly used "rciep->devfn" (a single byte
> encoding the device and function number) as the device number to check
> whether the corresponding bit was set in the RCiEPBitmap of the RCEC (Root
> Complex Event Collector) while enumerating over each bit of the RCiEPBitmap.
> 
> As per the PCI Express Base Specification, Revision 5.0, Version 1.0, Section
> 7.9.10.2, "Association Bitmap for RCiEPs", p. 935, only needs to use a device
> number to check whether the corresponding bit was set in the RCiEPBitmap.
> 
> Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value of
> "rciep->devfn" to a device number to ensure that the RCiEP devices associated
> with the RCEC are linked when the RCEC is enumerated.
> 
> Fixes: 507b460f8144 ("PCI/ERR: Add pcie_link_rcec() to associate RCiEPs")
> Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
> Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> v2->v3:
>  Drop "[ Krzysztof: Update commit message. ]" from the commit message
> 
>  drivers/pci/pcie/rcec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c index
> 2c5c552994e4..d0bcd141ac9c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -32,7 +32,7 @@ static bool rcec_assoc_rciep(struct pci_dev *rcec, struct
> pci_dev *rciep)
> 
>  	/* Same bus, so check bitmap */
>  	for_each_set_bit(devn, &bitmap, 32)
> -		if (devn == rciep->devfn)
> +		if (devn == PCI_SLOT(rciep->devfn))
>  			return true;
> 
>  	return false;
> --
> 2.17.1


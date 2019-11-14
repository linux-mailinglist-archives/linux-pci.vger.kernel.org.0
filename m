Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5441BFBE76
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 04:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNDwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 22:52:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:41327 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfKNDwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 22:52:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 19:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="257337629"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Nov 2019 19:52:02 -0800
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id B39A858049A;
        Wed, 13 Nov 2019 19:51:59 -0800 (PST)
Subject: Re: [PATCH v6 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1573613534.git.eswara.kota@linux.intel.com>
 <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
 <CH2PR12MB40074C910983FF97DDCF8478DA760@CH2PR12MB4007.namprd12.prod.outlook.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <ec2e7ef1-b549-f8f7-d5f3-908c534bbd4f@linux.intel.com>
Date:   Thu, 14 Nov 2019 11:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB40074C910983FF97DDCF8478DA760@CH2PR12MB4007.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/13/2019 5:59 PM, Gustavo Pimentel wrote:
> On Wed, Nov 13, 2019 at 7:21:21, Dilip Kota <eswara.kota@linux.intel.com>
> wrote:
>
[...]
> +static struct platform_driver intel_pcie_driver = {
> +	.probe = intel_pcie_probe,
> +	.remove = intel_pcie_remove,
> +	.driver = {
> +		.name = "intel-gw-pcie",
> +		.of_match_table = of_intel_pcie_match,
> +		.pm = &intel_pcie_pm_ops,
> +	},
> +};
> +builtin_platform_driver(intel_pcie_driver);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 29d6e93fd15e..548e22e07a52 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -673,6 +673,7 @@
>   #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>   #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>   #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>   #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
>   #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> -- 
> 2.11.0
>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Thanks for reviewing the patch.

Regards,
Dilip
>
>

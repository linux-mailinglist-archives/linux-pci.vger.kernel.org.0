Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB21A8FA9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392369AbgDOAUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:20:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:34323 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392367AbgDOAUl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:20:41 -0400
IronPort-SDR: RxkoZ8DNMzGpRswodU4IRJwgR6y7SnTMpaOAqP3e/+sbk1cwC3yS7zwcnearylw2Lb4u22EwKo
 K/1E1jEHR/9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 17:20:37 -0700
IronPort-SDR: I2x/gidc78O01nNuUEiMNqDfrI3QPGn5DYslsgbkT1bBP8sz6su/QxdNckTJU9ll5nFgitewiU
 Nn5uE+n2yp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="271568319"
Received: from swwoldee-mobl1.amr.corp.intel.com (HELO [10.251.15.118]) ([10.251.15.118])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2020 17:20:36 -0700
Subject: Re: [PATCH 3/4] PCI/AER: Don't select CONFIG_PCIEAER by default
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
References: <20200415001244.144623-1-helgaas@kernel.org>
 <20200415001244.144623-4-helgaas@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4af2f1b4-3032-5295-0668-9230e4b9012c@linux.intel.com>
Date:   Tue, 14 Apr 2020 17:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200415001244.144623-4-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/14/20 5:12 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCIe Advanced Error Reporting (AER) is optional and there's no need for it
> to be selected by default.
> 
> Remove the "default y" for CONFIG_PCIEAER.
Makes sense.
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell Currey <ruscur@russell.cc>
> Cc: Sam Bobroff <sbobroff@linux.ibm.com>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pcie/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 66386811cfde..9cd31331aee9 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -25,7 +25,6 @@ config PCIEAER
>   	bool "PCI Express Advanced Error Reporting support"
>   	depends on PCIEPORTBUS
>   	select RAS
> -	default y
>   	help
>   	  This enables PCI Express Root Port Advanced Error Reporting
>   	  (AER) driver support. Error reporting messages sent to Root
> 

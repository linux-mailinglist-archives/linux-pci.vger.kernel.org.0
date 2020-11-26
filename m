Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6852C4D0E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 03:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgKZCCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 21:02:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:40978 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbgKZCCK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 21:02:10 -0500
IronPort-SDR: wpxKuMiYxuQRMSyV5ySwm6toV4lQRDkjCpybJiyGSu3lVpl6x0fYlEgLfDiiEu1/oponqfq9ve
 5pgq6RQ33/LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="152060017"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="152060017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:02:01 -0800
IronPort-SDR: OZxVFdAySamU+GOkt0uNGXrqfVFPrfRyB4hmD4jkGc7VBy4bbgHAM2auozmDyWGJTYO7247UYr
 wV7+0BlB3BYw==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333220732"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:02:00 -0800
Subject: Re: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
References: <20201126011816.711106-1-helgaas@kernel.org>
 <20201126011816.711106-2-helgaas@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <45dc5ef5-bfb4-6c0b-88c7-55a904f82965@linux.intel.com>
Date:   Wed, 25 Nov 2020 18:01:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126011816.711106-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Downstream Ports may support DPC regardless of whether they support AER
> (see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> depends on the AER Capability.
> 
> dpc_probe() previously failed if:
> 
>    !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
>    !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
> 
> so it succeeded if:
> 
>    pcie_aer_is_native() || pcie_ports_dpc_native
> 
> Fail dpc_probe() if the device has no AER Capability.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Olof Johansson <olof@lixom.net>
> ---
>   drivers/pci/pcie/dpc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..ed0dbc43d018 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
>   	int status;
>   	u16 ctl, cap;
>   
> +	if (!pdev->aer_cap)
> +		return -ENOTSUPP;
Don't we check aer_cap support in drivers/pci/pcie/portdrv_core.c ?

We don't enable DPC service, if AER service is not enabled. And AER
service is only enabled if AER capability is supported.

So dpc_probe() should not happen if AER capability is not supported?

206 static int get_port_device_capability(struct pci_dev *dev)
...
...
251         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
252             host->native_dpc &&
253             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
254                 services |= PCIE_PORT_SERVICE_DPC;
255

> +
>   	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
>   		return -ENOTSUPP;
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

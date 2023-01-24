Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50304679221
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjAXHi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjAXHiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:38:55 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 23:38:45 PST
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D43EFCD;
        Mon, 23 Jan 2023 23:38:45 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4P1JMh2Hqbz9sSb;
        Tue, 24 Jan 2023 08:22:40 +0100 (CET)
Message-ID: <85e3080a-3d7b-6071-eb08-91248d2de804@denx.de>
Date:   Tue, 24 Jan 2023 08:22:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230118234612.272916-1-helgaas@kernel.org>
 <20230118234612.272916-2-helgaas@kernel.org>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20230118234612.272916-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/19/23 00:46, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The following bits in the PCIe Device Control register enable sending of
> ERR_COR, ERR_NONFATAL, or ERR_FATAL Messages (or reporting internally in
> the case of Root Ports):
> 
>    Correctable Error Reporting Enable
>    Non-Fatal Error Reporting Enable
>    Fatal Error Reporting Enable
>    Unsupported Request Reporting Enable
> 
> These enable bits are set by pci_enable_pcie_error_reporting(), and since
> f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"), we
> do that in this path during enumeration:
> 
>    pci_init_capabilities
>      pci_aer_init
>        pci_enable_pcie_error_reporting
> 
> Previously, the AER service driver also traversed the hierarchy when
> claiming a Root Port, enabling error reporting for downstream devices, but
> this is redundant.
> 
> Remove the code that enables this error reporting in the AER .probe() path.
> Also remove similar code that disables error reporting in the AER .remove()
> path.
> 
> Note that these Device Control Reporting Enable bits do not control
> interrupt generation.  That's done by the similarly-named bits in the AER
> Root Error Command register, which are still set by aer_probe() and cleared
> by aer_remove(), since the AER service driver handles those interrupts.
> See PCIe r6.0, sec 6.2.6.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/pci/pcie/aer.c | 48 ------------------------------------------
>   1 file changed, 48 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 625f7b2cafe4..b7b69e0c778c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1224,42 +1224,6 @@ static irqreturn_t aer_irq(int irq, void *context)
>   	return IRQ_WAKE_THREAD;
>   }
>   
> -static int set_device_error_reporting(struct pci_dev *dev, void *data)
> -{
> -	bool enable = *((bool *)data);
> -	int type = pci_pcie_type(dev);
> -
> -	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> -	    (type == PCI_EXP_TYPE_RC_EC) ||
> -	    (type == PCI_EXP_TYPE_UPSTREAM) ||
> -	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
> -		if (enable)
> -			pci_enable_pcie_error_reporting(dev);
> -		else
> -			pci_disable_pcie_error_reporting(dev);
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * set_downstream_devices_error_reporting - enable/disable the error reporting  bits on the root port and its downstream ports.
> - * @dev: pointer to root port's pci_dev data structure
> - * @enable: true = enable error reporting, false = disable error reporting.
> - */
> -static void set_downstream_devices_error_reporting(struct pci_dev *dev,
> -						   bool enable)
> -{
> -	set_device_error_reporting(dev, &enable);
> -
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> -		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
> -	else if (dev->subordinate)
> -		pci_walk_bus(dev->subordinate, set_device_error_reporting,
> -			     &enable);
> -
> -}
> -
>   /**
>    * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>    * @rpc: pointer to a Root Port data structure
> @@ -1289,12 +1253,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>   	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>   	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>   
> -	/*
> -	 * Enable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, true);
> -
>   	/* Enable Root Port's interrupt in response to error messages */
>   	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> @@ -1313,12 +1271,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>   	int aer = pdev->aer_cap;
>   	u32 reg32;
>   
> -	/*
> -	 * Disable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, false);
> -
>   	/* Disable Root's interrupt in response to error messages */
>   	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

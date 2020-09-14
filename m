Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73DA26835C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgINEGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 00:06:35 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:60919 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgINEGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 00:06:35 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 68B8C3000118B;
        Mon, 14 Sep 2020 06:06:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 47DB9372AB; Mon, 14 Sep 2020 06:06:25 +0200 (CEST)
Date:   Mon, 14 Sep 2020 06:06:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>, oohall@gmail.com,
        rafael.j.wysocki@intel.com, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
Message-ID: <20200914040625.GA20033@wunner.de>
References: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 04:29:10AM +0800, Tiezhu Yang wrote:
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -143,6 +144,28 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	}
>  
>  	pcie_port_device_remove(dev);
> +	pci_disable_device(dev);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +	if (pci_bridge_d3_possible(dev)) {
> +		pm_runtime_forbid(&dev->dev);
> +		pm_runtime_get_noresume(&dev->dev);
> +		pm_runtime_dont_use_autosuspend(&dev->dev);
> +	}
> +
> +	pcie_port_device_remove(dev);
> +
> +	/*
> +	 * If this is a kexec reboot, turn off Bus Master bit on the
> +	 * device to tell it to not continue to do DMA. Don't touch
> +	 * devices in D3cold or unknown states.
> +	 * If it is not a kexec reboot, firmware will hit the PCI
> +	 * devices with big hammer and stop their DMA any way.
> +	 */
> +	if (kexec_in_progress && (dev->current_state <= PCI_D3hot))
> +		pci_disable_device(dev);

The last portion of this function is already executed afterwards by
pci_device_shutdown().  You don't need to duplicate it here:

device_shutdown()
  dev->bus->shutdown() == pci_device_shutdown()
    drv->shutdown() == pcie_portdrv_shutdown()
      pci_disable_device()
    pci_disable_device()

Thanks,

Lukas

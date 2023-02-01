Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA59686DC0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 19:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBASRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 13:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBASRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 13:17:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004FE761FA
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 10:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D068618FB
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 18:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5157C4339C;
        Wed,  1 Feb 2023 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675275458;
        bh=/gZ7DyEeWp6tjvdKDcTTa8gBVM3ajfrb2jCmlY3p2lM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l2mPm5Nqx1XWWxT+4Crefdb1yHRVrloeYxyPKc3dwDlKtRqv7spUz0h8t5/F5kFqa
         VxZpe+CnGUHv9hliMfBM2Tmgphlhvef41AYn9125b6zv1DUa5aKwdLUgBqgcyF6X+H
         uZF/YmGONVxFF5UkQ07GmKCk5HchFm8AsCcUuqDcRMBXmwL8sSE8YMnDW7T+Xa2Kh2
         zxmsoC8jfLqdxcPMrL8GQ//2IhD14WR88G7+w14uMOPhvBIaq6Psv8fMzBOtnY6WAu
         fHkKfGy9H54u5mllQ9/TaYxQkK5qn/yJXwcw3jB7F6C5NXuWVw6H9qcYu3ACzBy9Q7
         jUiRvYP9Got3g==
Date:   Wed, 1 Feb 2023 12:17:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 1/2] PCI: Omit pci_disable_device() in .shutdown()
Message-ID: <20230201181736.GA1879841@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201043018.778499-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 12:30:17PM +0800, Huacai Chen wrote:
> This patch has a long story.
> 
> After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during
> shutdown") we observe poweroff/reboot failures on systems with LS7A
> chipset.
> 
> We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in
> do_pci_disable_device(), it can work well. The hardware engineer says
> that the root cause is that CPU is still accessing PCIe devices while
> poweroff/reboot, and if we disable the Bus Master Bit at this time, the
> PCIe controller doesn't forward requests to downstream devices, and also
> does not send TIMEOUT to CPU, which causes CPU wait forever (hardware
> deadlock).
> 
> To be clear, the sequence is like this:
> 
>   - CPU issues MMIO read to device below Root Port
> 
>   - LS7A Root Port fails to forward transaction to secondary bus
>     because of LS7A Bus Master defect
> 
>   - CPU hangs waiting for response to MMIO read
> 
> Then how is userspace able to use a device after the device is removed?
> 
> To give more details, let's take the graphics driver (e.g. amdgpu) as
> an example. The userspace programs call printf() to display "shutting
> down xxx service" during shutdown/reboot, or the kernel calls printk()
> to display something during shutdown/reboot. These can happen at any
> time, even after we call pcie_port_device_remove() to disable the pcie
> port on the graphic card.
> 
> The call stack is: printk() --> call_console_drivers() --> con->write()
> --> vt_console_print() --> fbcon_putcs()
> 
> This scenario happens because userspace programs (or the kernel itself)
> don't know whether a device is 'usable', they just use it, at any time.
> 
> This hardware behavior is a PCIe protocol violation (Bus Master should
> not be involved in CPU MMIO transactions), and it will be fixed in new
> revisions of hardware (add timeout mechanism for CPU read request,
> whether or not Bus Master bit is cleared).
> 
> On some x86 platforms, radeon/amdgpu devices can cause similar problems
> [1][2].
> 
> Once before I add a quirk to solve the LS7A problem but looks ugly.
> After long time discussions, Bjorn Helgaas suggest simply remove the
> pci_disable_device() in pcie_portdrv_shutdown() and this patch do it
> exactly.
> 
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 2cc2e60bcb39..46fad0d813b2 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }
>  
>  /**
> @@ -727,6 +726,19 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	}
>  
>  	pcie_port_device_remove(dev);
> +
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

Thanks!  I guess you verified that this actually *does* call all the
port service .remove() methods, right?  aer_remove(), dpc_remove(),
etc?

I *assume* that happens via the device_unregister() done in
remove_iter(), but there's a LOT of code in the middle.

>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -777,7 +789,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 2.39.0
> 
